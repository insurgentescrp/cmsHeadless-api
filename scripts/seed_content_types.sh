#!/bin/bash
set -e

API="http://localhost:3000/api"
CT_ENDPOINT="$API/content-types"

# Files to store IDs
CT_IDS="/tmp/ct_ids.sh"

echo "#!/bin/bash" > $CT_IDS
echo "" >> $CT_IDS

create_ct() {
  local name="$1"
  local display="$2"
  local desc="$3"
  local is_single="$4"

  echo "==> Creating content type: $name"
  local response=$(curl -s "$CT_ENDPOINT" \
    -H "Content-Type: application/json" \
    -d "{
      \"name\": \"$name\",
      \"displayName\": \"$display\",
      \"description\": \"$desc\",
      \"isSingle\": $is_single
    }")

  local id=$(echo "$response" | jq -r '.data.id // empty')

  if [ -z "$id" ]; then
    echo "ERROR creating $name: $response"
    exit 1
  fi

  echo "${name}_id=$id" >> $CT_IDS
  echo "  -> ID: $id"
  sleep 0.2
}

# 1. Colecciones
create_ct "categories" "Categorías" "Categorías para clasificar contenido" false
create_ct "posts" "Posts" "Noticias y artículos" false

# 2. Main sections (isSingle)
create_ct "featured_news" "Noticias destacadas" "Sección de noticias destacadas del homepage" true
create_ct "categories_section" "Categorías" "Sección de categorías del homepage" true
create_ct "latest_news" "Últimas noticias" "Sección de últimas noticias" true
create_ct "videos" "Videos" "Sección de videos" true
create_ct "newsletter" "Newsletter" "Sección de newsletter del homepage" true
create_ct "footer" "Footer" "Pie de página" true

# 3. Sidebar sections (isSingle)
create_ct "sidebar_featured_image" "Imagen destacada" "Imagen destacada del sidebar" true
create_ct "sidebar_latest_investigation" "Última investigación" "Última investigación del sidebar" true
create_ct "sidebar_tweets" "Tweets destacados" "Tweets destacados del sidebar" true
create_ct "facebook_feed" "Facebook Feed" "Feed de Facebook del sidebar" true
create_ct "downloads" "Descargas" "Sección de descargas del sidebar" true
create_ct "sidebar_newsletter" "Newsletter sidebar" "Newsletter del sidebar" true
create_ct "internal_advertising" "Publicidad interna" "Publicidad interna del sidebar" true

echo ""
echo "=== ALL CONTENT TYPES CREATED ==="
echo "IDs saved to $CT_IDS"
cat $CT_IDS
