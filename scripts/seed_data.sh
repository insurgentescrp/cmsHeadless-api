#!/bin/bash
set -e

API="http://localhost:3000/api"
source /tmp/ct_ids.sh

create_entry() {
  local ct_name="$1"
  local json="$2"

  >&2 echo "  -> Creating entry in '$ct_name'"
  local response=$(curl -s "$API/$ct_name" \
    -H "Content-Type: application/json" \
    -d "$json")

  local id=$(echo "$response" | jq -r '.data.id // empty')
  if [ -z "$id" ]; then
    >&2 echo "  ERROR: $response"
    exit 1
  fi
  echo "$id"
  sleep 0.2
}

echo "=== 1. Creating categories ==="

cat_destacada=$(create_entry "categories" "$(jq -n \
  --arg name "Destacada" \
  --arg slug "destacada" \
  --arg desc "Noticias destacadas del día" \
  '{name: $name, slug: $slug, description: $desc}')")
echo "     Destacada: $cat_destacada"

cat_investigacion=$(create_entry "categories" "$(jq -n \
  --arg name "Investigación" \
  --arg slug "investigacion" \
  --arg desc "Reportajes de investigación" \
  '{name: $name, slug: $slug, description: $desc}')")
echo "     Investigación: $cat_investigacion"

cat_analisis=$(create_entry "categories" "$(jq -n \
  --arg name "Análisis" \
  --arg slug "analisis" \
  --arg desc "Artículos de análisis y opinión" \
  '{name: $name, slug: $slug, description: $desc}')")
echo "     Análisis: $cat_analisis"

cat_nacional=$(create_entry "categories" "$(jq -n \
  --arg name "Nacional" \
  --arg slug "nacional" \
  --arg desc "Noticias nacionales" \
  '{name: $name, slug: $slug, description: $desc}')")
echo "     Nacional: $cat_nacional"

cat_internacional=$(create_entry "categories" "$(jq -n \
  --arg name "Internacional" \
  --arg slug "internacional" \
  --arg desc "Noticias internacionales" \
  '{name: $name, slug: $slug, description: $desc}')")
echo "     Internacional: $cat_internacional"

cat_opinion=$(create_entry "categories" "$(jq -n \
  --arg name "Opinión" \
  --arg slug "opinion" \
  --arg desc "Columnas de opinión" \
  '{name: $name, slug: $slug, description: $desc}')")
echo "     Opinión: $cat_opinion"

echo ""
echo "=== 2. Creating sample posts ==="

create_entry "posts" "$(jq -n \
  --arg title "El congreso aprueba la nueva ley de reforma fiscal" \
  --arg summary "Con 180 votos a favor, el congreso dio luz verde a la reforma fiscal que promete simplificar el sistema tributario." \
  --arg content "<p>En una sesión histórica, el congreso aprobó la nueva ley de reforma fiscal que busca simplificar el sistema tributario y reducir la carga impositiva a las clases medias y bajas.</p><p>La ley, que fue impulsada por el partido de gobierno, contó con el apoyo de varias bancadas y entrará en vigencia a partir del próximo año fiscal.</p>" \
  --arg image "https://picsum.photos/seed/reforma/1200/600" \
  --argjson categories "[\"$cat_nacional\", \"$cat_destacada\"]" \
  --argjson tags '["reforma fiscal", "congreso", "ley"]' \
  --arg author "María García" \
  --arg status "published" \
  --arg date "2026-05-24" \
  '{title: $title, summary: $summary, content: $content, featured_image: $image, categories: $categories, tags: $tags, author: $author, status: $status, published_at: $date}')"
echo "     Post 1: OK"

create_entry "posts" "$(jq -n \
  --arg title "Los mercados reaccionan positivamente al anuncio del banco central" \
  --arg summary "Las bolsas asiáticas y europeas cerraron al alza tras la decisión del banco central de mantener las tasas de interés." \
  --arg content "<p>Los mercados financieros globales reaccionaron con optimismo al anuncio del banco central de mantener las tasas de interés en su nivel actual, disipando los temores de un endurecimiento monetario.</p><p>El índice S&P 500 subió un 1.2%, mientras que el Euro Stoxx 50 avanzó un 0.8% en la sesión de hoy.</p>" \
  --arg image "https://picsum.photos/seed/mercados/1200/600" \
  --argjson categories "[\"$cat_nacional\", \"$cat_internacional\"]" \
  --argjson tags '["mercados", "banco central", "tasas"]' \
  --arg author "Carlos Mendoza" \
  --arg status "published" \
  --arg date "2026-05-25" \
  '{title: $title, summary: $summary, content: $content, featured_image: $image, categories: $categories, tags: $tags, author: $author, status: $status, published_at: $date}')"
echo "     Post 2: OK"

create_entry "posts" "$(jq -n \
  --arg title "Selección nacional clasifica al mundial tras vencer a su rival" \
  --arg summary "Con un gol agónico en el minuto 89, la selección nacional selló su pase al mundial después de 12 años de ausencia." \
  --arg content "<p>La selección nacional logró la hazaña de clasificar al mundial tras vencer 2-1 a su rival en un partido lleno de emociones.</p><p>El gol del triunfo llegó en el minuto 89 gracias a un remate de cabeza que desató la locura en las gradas y en todo el país.</p>" \
  --arg image "https://picsum.photos/seed/futbol/1200/600" \
  --argjson categories "[\"$cat_nacional\", \"$cat_destacada\"]" \
  --argjson tags '["selección", "mundial", "clasificación"]' \
  --arg author "Pedro Ramírez" \
  --arg status "published" \
  --arg date "2026-05-23" \
  '{title: $title, summary: $summary, content: $content, featured_image: $image, categories: $categories, tags: $tags, author: $author, status: $status, published_at: $date}')"
echo "     Post 3: OK"

create_entry "posts" "$(jq -n \
  --arg title "Nueva exposición de arte contemporáneo abre sus puertas en el museo nacional" \
  --arg summary "La muestra reúne obras de 30 artistas latinoamericanos y estará abierta al público hasta septiembre." \
  --arg content "<p>El museo nacional inauguró hoy una ambiciosa exposición de arte contemporáneo que reúne obras de 30 artistas de toda Latinoamérica.</p><p>La exposición, titulada 'Nuevas miradas', explora temas como la identidad, la migración y el cambio climático a través de diversas disciplinas artísticas.</p>" \
  --arg image "https://picsum.photos/seed/arte/1200/600" \
  --argjson categories "[\"$cat_nacional\", \"$cat_analisis\"]" \
  --argjson tags '["arte", "exposición", "cultura"]' \
  --arg author "Ana Torres" \
  --arg status "published" \
  --arg date "2026-05-22" \
  '{title: $title, summary: $summary, content: $content, featured_image: $image, categories: $categories, tags: $tags, author: $author, status: $status, published_at: $date}')"
echo "     Post 4: OK"

create_entry "posts" "$(jq -n \
  --arg title "Startup local desarrolla inteligencia artificial para diagnóstico médico temprano" \
  --arg summary "La herramienta basada en IA promete detectar enfermedades en etapas tempranas con una precisión del 95%." \
  --arg content "<p>Una startup local ha desarrollado un sistema de inteligencia artificial capaz de detectar enfermedades en etapas tempranas mediante el análisis de imágenes médicas.</p><p>La herramienta, que ya fue probada en varios hospitales, alcanzó una precisión del 95% en la detección de anomalías, superando los métodos tradicionales.</p>" \
  --arg image "https://picsum.photos/seed/ia/1200/600" \
  --argjson categories "[\"$cat_nacional\", \"$cat_investigacion\"]" \
  --argjson tags '["IA", "startup", "salud", "diagnóstico"]' \
  --arg author "Laura Vega" \
  --arg status "published" \
  --arg date "2026-05-21" \
  '{title: $title, summary: $summary, content: $content, featured_image: $image, categories: $categories, tags: $tags, author: $author, status: $status, published_at: $date}')"
echo "     Post 5: OK"

create_entry "posts" "$(jq -n \
  --arg title "Cumbre climática mundial alcanza acuerdo histórico para reducir emisiones" \
  --arg summary "Más de 190 países firmaron un compromiso vinculante para reducir las emisiones de carbono en un 50% para 2035." \
  --arg content "<p>La cumbre climática mundial celebrada en Ginebra concluyó con un acuerdo histórico: más de 190 países se comprometieron a reducir las emisiones de carbono en un 50% para 2035.</p><p>El acuerdo, calificado como 'sin precedentes' por expertos, incluye mecanismos de verificación y sanciones para los países que no cumplan sus metas.</p>" \
  --arg image "https://picsum.photos/seed/clima/1200/600" \
  --argjson categories "[\"$cat_internacional\", \"$cat_investigacion\", \"$cat_destacada\"]" \
  --argjson tags '["clima", "acuerdo", "emisiones", "cumbre"]' \
  --arg author "Roberto Díaz" \
  --arg status "published" \
  --arg date "2026-05-20" \
  '{title: $title, summary: $summary, content: $content, featured_image: $image, categories: $categories, tags: $tags, author: $author, status: $status, published_at: $date}')"
echo "     Post 6: OK"

create_entry "posts" "$(jq -n \
  --arg title "Análisis: El futuro de la educación digital en América Latina" \
  --arg summary "Expertos debaten sobre los desafíos y oportunidades de la transformación digital en el sector educativo." \
  --arg content "<p>La educación digital en América Latina ha experimentado un crecimiento exponencial en los últimos años, pero aún enfrenta desafíos significativos en términos de acceso y calidad.</p><p>En este artículo de opinión, analizamos las tendencias y los retos que definen el futuro del aprendizaje en la región.</p>" \
  --arg image "https://picsum.photos/seed/educacion/1200/600" \
  --argjson categories "[\"$cat_analisis\", \"$cat_opinion\"]" \
  --argjson tags '["educación", "digital", "América Latina"]' \
  --arg author "Sofía Martínez" \
  --arg status "published" \
  --arg date "2026-05-19" \
  '{title: $title, summary: $summary, content: $content, featured_image: $image, categories: $categories, tags: $tags, author: $author, status: $status, published_at: $date}')"
echo "     Post 7: OK"

create_entry "posts" "$(jq -n \
  --arg title "Investigación revela el impacto de la contaminación en la salud infantil" \
  --arg summary "Un estudio a largo plazo demuestra que los niños expuestos a altos niveles de contaminación tienen mayor riesgo de desarrollar enfermedades respiratorias crónicas." \
  --arg content "<p>Una investigación de cinco años realizada por la universidad nacional reveló datos alarmantes sobre el impacto de la contaminación ambiental en la salud de los niños.</p><p>El estudio, que siguió a más de 10,000 niños en cinco ciudades, encontró que aquellos expuestos a altos niveles de contaminación tienen un 40% más de probabilidades de desarrollar asma y otras enfermedades respiratorias crónicas.</p>" \
  --arg image "https://picsum.photos/seed/contaminacion/1200/600" \
  --argjson categories "[\"$cat_investigacion\", \"$cat_nacional\"]" \
  --argjson tags '["investigación", "contaminación", "salud infantil"]' \
  --arg author "Dr. Miguel Ángel Ruiz" \
  --arg status "published" \
  --arg date "2026-05-18" \
  '{title: $title, summary: $summary, content: $content, featured_image: $image, categories: $categories, tags: $tags, author: $author, status: $status, published_at: $date}')"
echo "     Post 8: OK"

echo ""
echo "=== 3. Creating homepage section entries ==="

create_entry "featured_news" "$(jq -n \
  --arg title "Noticias destacadas" \
  --argjson posts '[]' \
  '{title: $title, posts: $posts}')"
echo "     Featured news: OK"

create_entry "categories_section" "$(jq -n \
  --arg title "Categorías" \
  --argjson categories '[]' \
  '{title: $title, categories: $categories}')"
echo "     Categories section: OK"

create_entry "latest_news" "$(jq -n \
  --arg title "Últimas noticias" \
  --argjson count 6 \
  '{title: $title, count: $count}')"
echo "     Latest news: OK"

create_entry "videos" "$(jq -n \
  --arg title "Videos destacados" \
  --arg desc "<p>Los videos más relevantes de la semana</p>" \
  '{title: $title, description: $desc}')"
echo "     Videos: OK"

create_entry "newsletter" "$(jq -n \
  --arg title "Suscríbete a nuestro newsletter" \
  --arg desc "Recibe las noticias más importantes cada semana en tu correo" \
  --arg placeholder "Tu correo electrónico" \
  --arg btn "Suscribirme" \
  '{title: $title, description: $desc, placeholder: $placeholder, button_text: $btn}')"
echo "     Newsletter: OK"

create_entry "footer" "$(jq -n \
  --arg content "<p>&copy; 2026 CMS Noticias. Todos los derechos reservados.</p>" \
  --arg w1 "Tu fuente confiable de información nacional e internacional. Comprometidos con la verdad y el periodismo independiente." \
  --arg w2h "Secciones" \
  '{content: $content, widget_1: $w1, widget_2_heading: $w2h}')"
echo "     Footer: OK"

echo ""
echo "=== 4. Creating sidebar section entries ==="

create_entry "sidebar_featured_image" "$(jq -n \
  --arg image "https://picsum.photos/seed/sidebar/400/300" \
  --arg link "/investigacion/contaminacion" \
  --arg caption "Impacto de la contaminación en la salud infantil" \
  '{image: $image, link: $link, caption: $caption}')"
echo "     Sidebar featured image: OK"

create_entry "sidebar_latest_investigation" "$(jq -n \
  --arg title "Última investigación" \
  --argjson posts '[]' \
  '{title: $title, posts: $posts}')"
echo "     Sidebar latest investigation: OK"

create_entry "sidebar_tweets" "$(jq -n \
  --arg title "Tweets destacados" \
  --argjson codes '["<a class=\"twitter-timeline\" href=\"https://twitter.com/example\">Tweets</a><script async src=\"https://platform.twitter.com/widgets.js\"></script>", "<a class=\"twitter-timeline\" href=\"https://twitter.com/example2\">Tweets</a><script async src=\"https://platform.twitter.com/widgets.js\"></script>"]' \
  '{title: $title, embed_codes: $codes}')"
echo "     Sidebar tweets: OK"

create_entry "facebook_feed" "$(jq -n \
  --arg code "<div class=\"fb-page\" data-href=\"https://www.facebook.com/cmsnoticias\" data-tabs=\"timeline\"></div><div id=\"fb-root\"></div><script async defer crossorigin=\"anonymous\" src=\"https://connect.facebook.net/es_LA/sdk.js#xfbml=1&version=v22.0\"></script>" \
  '{embed_code: $code}')"
echo "     Facebook feed: OK"

create_entry "downloads" "$(jq -n \
  --arg title "Descargas" \
  --arg content "<ul><li><a href=\"/downloads/informe-anual-2025.pdf\">Informe Anual 2025</a></li><li><a href=\"/downloads/plan-estrategico.pdf\">Plan Estratégico</a></li><li><a href=\"/downloads/presentacion-corporativa.pdf\">Presentación Corporativa</a></li></ul>" \
  '{title: $title, content: $content}')"
echo "     Downloads: OK"

create_entry "sidebar_newsletter" "$(jq -n \
  --arg title "Newsletter semanal" \
  --arg desc "Lo mejor de la semana en tu bandeja de entrada" \
  --arg placeholder "Ingresa tu email" \
  --arg btn "Suscribir" \
  '{title: $title, description: $desc, placeholder: $placeholder, button_text: $btn}')"
echo "     Sidebar newsletter: OK"

create_entry "internal_advertising" "$(jq -n \
  --arg image "https://picsum.photos/seed/ad/400/300" \
  --arg link "https://example.com" \
  --arg alt "Publicidad - Conoce nuestros servicios" \
  '{image: $image, link: $link, alt_text: $alt}')"
echo "     Internal advertising: OK"

echo ""
echo "=== SEED DATA CREATED SUCCESSFULLY ==="
