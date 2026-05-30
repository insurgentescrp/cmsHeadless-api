#!/bin/bash
set -e

API="${API:-http://localhost:3000/api}"
DB_URL="${DATABASE_URL:-postgresql://cms:mi4v-aee3-5939@localhost:5432/cms}"

EMAIL="${ADMIN_EMAIL:-admin@cms.com}"
PASSWORD="${ADMIN_PASSWORD:-123456}"
USERNAME="${ADMIN_USERNAME:-admin}"

echo "=== Creating superuser ==="

RESPONSE=$(curl -s "$API/auth/register" \
  -H "Content-Type: application/json" \
  -d "{
    \"username\": \"$USERNAME\",
    \"email\": \"$EMAIL\",
    \"password\": \"$PASSWORD\"
  }")

USER_ID=$(echo "$RESPONSE" | jq -r '.data.user.id // empty')

if [ -z "$USER_ID" ]; then
  echo "ERROR: $RESPONSE"
  exit 1
fi

echo "  User created: $EMAIL ($USER_ID)"

echo "  Promoting to superuser..."
psql "$DB_URL" -c "UPDATE users SET is_superuser = true WHERE id = '$USER_ID';" > /dev/null

echo "  ✓ Superuser ready"
echo ""
echo "=== Login credentials ==="
echo "  Email:    $EMAIL"
echo "  Password: $PASSWORD"
echo "========================="
