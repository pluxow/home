# Pluxow — Resumen del Proyecto Web

## Empresa
- **Nombre:** Pluxow
- **Web:** pluxow.com (GitHub Pages + CNAME)
- **Tagline:** Business Strategy & Technology
- **Propósito:** Ayudar a PyMEs argentinas a automatizar procesos administrativos y operativos

## Equipo
| Nombre | Rol |
|--------|-----|
| Alejo  | CEO |
| Carolina | CMO |
| Lea (usuario) | CTO |

## Stack Técnico
- HTML5 + CSS3 + JS vanilla — todo en un único `index.html`
- Sin frameworks ni dependencias externas
- Google Fonts: DM Sans + DM Serif Display
- Hosting: GitHub Pages con dominio custom `pluxow.com`
- Sin backend — formulario de contacto es estático (solo feedback visual)

## Estructura del Proyecto
```
home/
├── index.html        # Toda la web (HTML + CSS + JS embebido)
├── image copy.png    # Logo/ícono
└── CNAME             # → pluxow.com
```

## Secciones de la Web (single-page)
1. **Navbar** — Logo, links a Servicios / Proceso / Contacto, CTA
2. **Hero** — Headline principal, propuesta de valor, 2 CTAs
3. **Problemas** — 3 pain points de las PyMEs objetivo
4. **Servicios** (`#servicios`) — 6 servicios ofrecidos
5. **Proceso** (`#proceso`) — Metodología de 4 pasos
6. **Resultados** — Métricas clave (-70% tiempo, +3x reportes, 0 errores, <4 semanas MVP)
7. **Contacto** (`#contacto`) — Formulario estático
8. **Footer** — Empresa, tagline, Argentina

## Servicios Ofrecidos
- Dashboards e informes automáticos
- Chatbots con IA
- Facturación electrónica (ARCA/AFIP)
- Automatización de flujos de trabajo
- Agentes de lectura de documentos (IA)
- Consultoría de estrategia digital

## Contexto Relevante
- Mercado objetivo: PyMEs en Argentina
- Diferencial: implementación rápida (MVP en <4 semanas)
- Servicios específicos para Argentina (AFIP/ARCA)
- Diseño minimalista: paleta crema (#F4F0E8) + tinta oscura (#111111)
- Idioma: español

## Notas Técnicas
- Todo el CSS y JS está embebido dentro de `index.html` (no hay archivos separados)
- El formulario no tiene backend real — cualquier integración requiere agregar un servicio externo (Formspree, n8n, etc.)
- Diseño responsive con CSS Grid y Flexbox
