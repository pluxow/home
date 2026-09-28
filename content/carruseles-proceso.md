# Carruseles de Instagram — Estrategia y proceso

## Objetivo
Generar clientes para Pluxow a través de contenido en carrusel en Instagram.

## Audiencia
Dueños/gerentes de pymes (no técnicos) que deciden sobre automatización e IA en su negocio.

## Cadencia
1 carrusel por semana.

## Pilares de contenido
1. **Procesos rotos → arreglados** — mini-casos "así perdías tiempo/plata antes vs. cómo se soluciona con automatización". El más directo a generación de leads.
2. **IA explicada simple** — desmitificar conceptos (chatbots, agentes, dashboards) sin jerga técnica.
3. **Mitos y errores comunes** — creencias sobre automatización/IA que le cuestan plata a una pyme.
4. **Detrás de escena / autoridad** — metodología de Pluxow, resultados reales, cómo trabajamos.
5. **Tips accionables** — checklists o señales de que hay que automatizar algo.

## Fuentes de research
Newsletters a revisar para sacar tono y temas (adaptados siempre a la audiencia pyme, nunca copiados literal):

| Fuente | Para qué sirve |
|---|---|
| Franco Sarli (`coach@francosarli.com`) | Referencia de tono natural / conversacional, aunque el rubro sea otro (nutrición) |
| Alaimo Labs (`hola@alaimolabs.com`) | Ideas de contenido sobre IA y producto |
| Supabase (`welcome@supabase.com`) | Novedades técnicas para adaptar a la audiencia pyme |
| Claude / Anthropic (`no-reply@email.claude.com`) | Ideas sobre IA, mismo criterio que Supabase |
| Harvard Business Review vía LinkedIn (`newsletters-noreply@linkedin.com`) | Citar de autoridad: "un artículo de Harvard dice que…" — sirve para cualquier pilar |

También: búsqueda web de tendencias del sector cuando el banco de ideas de newsletters no alcanza.

## Proceso end-to-end

1. **Research** — leer las últimas ediciones de las fuentes de arriba + búsqueda de tendencias. Salida: banco de ideas crudas, tageadas por pilar.
2. **Validación de la idea** — antes de pasar a diseño, revisar: ¿le sirve al buyer persona (dueño/gerente de pyme)? ¿empuja hacia una acción concreta (contactar a Pluxow)? ¿no es contenido genérico que cualquiera podría postear? La aprueba Lea.
3. **Diseño** — armar el carrusel en `admin/carousels.html`: elegir pilar, combinar slides de portada / contenido / cierre-CTA (entre 3 y 10 según el contenido), editar texto directo sobre el diseño.
4. **Exportación** — botón "Exportar .zip" genera los JPGs a 1080×1350 (resolución nativa de Instagram) listos para publicar.
5. **Revisión final** — Lea revisa el `.zip` (copy, diseño, CTA, errores) antes de subir.
6. **Publicación** — manual, directo en Instagram.

## Herramienta
`admin/carousels.html` — editor standalone (sin backend), mismo sistema de diseño que el resto del sitio de Pluxow. Ver también `PROJECT_SUMMARY.md` para el contexto general del proyecto web.

## Referencias de copywriting
`copywriting-breakthrough-advertising.md` — marco de persuasión (niveles de consciencia, madurez de mercado, tácticas de escritura) a tener en cuenta en el paso de Diseño, al momento de escribir el guion de cada slide.
