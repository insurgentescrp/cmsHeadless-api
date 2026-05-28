#!/bin/bash
set -e

API="http://localhost:3000/api"
FIELD_ENDPOINT="$API/fields"

source /tmp/ct_ids.sh

create_field() {
  local ct_id="$1"
  local name="$2"
  local display="$3"
  local type="$4"
  local required="$5"     # true/false
  local is_list="$6"      # true/false
  local default_val="$7"  # JSON null or string
  local options="$8"      # JSON null or object
  local relation_ct_id="$9"
  local position="${10:-0}"

  # Build JSON safely
  local json=$(cat <<EOF
{
  "contentTypeId": "$ct_id",
  "name": "$name",
  "displayName": "$display",
  "fieldType": "$type",
  "isRequired": $required,
  "isList": $is_list,
  "defaultValue": $default_val,
  "options": $options,
  "relationContentTypeId": $( [ -n "$relation_ct_id" ] && echo "\"$relation_ct_id\"" || echo "null" ),
  "position": $position
}
EOF
)

  echo "  -> $name ($display)"
  local response=$(curl -s "$FIELD_ENDPOINT" \
    -H "Content-Type: application/json" \
    -d "$json")

  local id=$(echo "$response" | jq -r '.data.id // empty')
  if [ -z "$id" ]; then
    echo "  ERROR creating field '$name': $response"
    exit 1
  fi
  sleep 0.15
}

echo "=== Creating fields ==="

# ========================
# 1. categories
# ========================
echo "[categories]"
create_field "$categories_id" "name" "Nombre" "string" true false "null" "null" "" 0
create_field "$categories_id" "slug" "Slug" "string" true false "null" "null" "" 1
create_field "$categories_id" "description" "Descripción" "text" false false "null" "null" "" 2

# ========================
# 2. posts
# ========================
echo "[posts]"
create_field "$posts_id" "title" "Título" "string" true false "null" "null" "" 0
create_field "$posts_id" "summary" "Resumen" "text" false false "null" "null" "" 1
create_field "$posts_id" "content" "Contenido" "richtext" true false "null" "null" "" 2
create_field "$posts_id" "featured_image" "Imagen destacada" "image" false false "null" "null" "" 3
create_field "$posts_id" "categories" "Categorías" "relation" false true "null" "null" "$categories_id" 4
create_field "$posts_id" "tags" "Etiquetas" "string" false true "null" "null" "" 5
create_field "$posts_id" "author" "Autor" "string" false false "null" "null" "" 6
create_field "$posts_id" "status" "Estado" "string" true false '"draft"' '{"values":["draft","published","archived"]}' "" 7
create_field "$posts_id" "published_at" "Fecha de publicación" "date" false false "null" "null" "" 8

# ========================
# 3. featured_news
# ========================
echo "[featured_news]"
create_field "$featured_news_id" "title" "Título" "string" true false "null" "null" "" 0
create_field "$featured_news_id" "posts" "Noticias destacadas" "relation" true true "null" "null" "$posts_id" 1

# ========================
# 5. categories_section
# ========================
echo "[categories_section]"
create_field "$categories_section_id" "title" "Título" "string" true false "null" "null" "" 0
create_field "$categories_section_id" "categories" "Categorías" "relation" false true "null" "null" "$categories_id" 1

# ========================
# 6. latest_news
# ========================
echo "[latest_news]"
create_field "$latest_news_id" "title" "Título" "string" true false "null" "null" "" 0
create_field "$latest_news_id" "count" "Cantidad de noticias" "number" false false "null" "null" "" 1

# ========================
# 7. videos
# ========================
echo "[videos]"
create_field "$videos_id" "title" "Título" "string" true false "null" "null" "" 0
create_field "$videos_id" "description" "Descripción" "richtext" false false "null" "null" "" 1

# ========================
# 8. newsletter
# ========================
echo "[newsletter]"
create_field "$newsletter_id" "title" "Título" "string" false false "null" "null" "" 0
create_field "$newsletter_id" "description" "Descripción" "text" false false "null" "null" "" 1
create_field "$newsletter_id" "placeholder" "Placeholder del input" "string" false false "null" "null" "" 2
create_field "$newsletter_id" "button_text" "Texto del botón" "string" false false "null" "null" "" 3

# ========================
# 9. footer
# ========================
echo "[footer]"
create_field "$footer_id" "content" "Contenido" "richtext" true false "null" "null" "" 0
create_field "$footer_id" "widget_1" "Widget 1 - Logo y presentación" "text" true false "null" "null" "" 1
create_field "$footer_id" "widget_2_heading" "Widget 2 - Título del menú" "string" true false "null" "null" "" 2

# ========================
# 10. sidebar_featured_image
# ========================
echo "[sidebar_featured_image]"
create_field "$sidebar_featured_image_id" "image" "Imagen" "image" true false "null" "null" "" 0
create_field "$sidebar_featured_image_id" "link" "Enlace" "string" false false "null" "null" "" 1
create_field "$sidebar_featured_image_id" "caption" "Texto alternativo" "string" false false "null" "null" "" 2

# ========================
# 11. sidebar_latest_investigation
# ========================
echo "[sidebar_latest_investigation]"
create_field "$sidebar_latest_investigation_id" "title" "Título" "string" true false "null" "null" "" 0
create_field "$sidebar_latest_investigation_id" "posts" "Investigaciones" "relation" false true "null" "null" "$posts_id" 1

# ========================
# 12. sidebar_tweets
# ========================
echo "[sidebar_tweets]"
create_field "$sidebar_tweets_id" "title" "Título" "string" true false "null" "null" "" 0
create_field "$sidebar_tweets_id" "embed_codes" "Códigos embebidos" "text" true true "null" "null" "" 1

# ========================
# 13. facebook_feed
# ========================
echo "[facebook_feed]"
create_field "$facebook_feed_id" "embed_code" "Código embebido" "text" true false "null" "null" "" 0

# ========================
# 14. downloads
# ========================
echo "[downloads]"
create_field "$downloads_id" "title" "Título" "string" true false "null" "null" "" 0
create_field "$downloads_id" "content" "Contenido" "richtext" false false "null" "null" "" 1

# ========================
# 15. sidebar_newsletter
# ========================
echo "[sidebar_newsletter]"
create_field "$sidebar_newsletter_id" "title" "Título" "string" false false "null" "null" "" 0
create_field "$sidebar_newsletter_id" "description" "Descripción" "text" false false "null" "null" "" 1
create_field "$sidebar_newsletter_id" "placeholder" "Placeholder del input" "string" false false "null" "null" "" 2
create_field "$sidebar_newsletter_id" "button_text" "Texto del botón" "string" false false "null" "null" "" 3

# ========================
# 16. internal_advertising
# ========================
echo "[internal_advertising]"
create_field "$internal_advertising_id" "image" "Imagen" "image" true false "null" "null" "" 0
create_field "$internal_advertising_id" "link" "Enlace" "string" true false "null" "null" "" 1
create_field "$internal_advertising_id" "alt_text" "Texto alternativo" "string" false false "null" "null" "" 2

echo ""
echo "=== ALL FIELDS CREATED SUCCESSFULLY ==="
