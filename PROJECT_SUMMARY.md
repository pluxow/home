# Pluxow — Resumen del Proyecto Web

## Empresa
- **Nombre:** Pluxow
- **Web:** pluxow.com (GitHub Pages + CNAME)
- **Tagline:** Business Strategy & Technology
- **Propósito:** Ayudar a empresas a automatizar procesos operativos y administrativos (mercado global)

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
- Formulario integrado con **Formspree** → `hello@pluxow.com`
- Sistema i18n propio en JS (objeto de traducciones + `data-i18n` attributes)

## Estructura del Proyecto
```
home/
├── index.html           # Toda la web (HTML + CSS + JS embebido)
├── image copy.png       # Logo/ícono
├── PROJECT_SUMMARY.md   # Este archivo
└── CNAME                # → pluxow.com
```

## Secciones de la Web (single-page)
1. **Navbar** — Logo, links a Servicios / Proceso / Contacto, CTA + switcher ES | EN | PT
2. **Hero** — Headline + logo grande (2 columnas), propuesta de valor, 2 CTAs
3. **Quiénes somos** (`#nosotros`) — Posicionamiento como aliados estratégicos, 3 pills
4. **Problemas** — 3 pain points globales
5. **Servicios** (`#servicios`) — 6 servicios ofrecidos
6. **Proceso** (`#proceso`) — Metodología de 4 pasos
7. **Resultados** — Métricas: -70% tiempo, +3x reportes, 3 proyectos ganados, <4 semanas MVP
8. **Contacto** (`#contacto`) — Formulario con Formspree
9. **Footer** — Empresa, tagline (sin referencia a Argentina)

## Servicios Ofrecidos
- Dashboards y reportes automáticos
- Chatbots con IA
- Automatización financiera y administrativa (global, sin AFIP/ARCA)
- Automatización de flujos de trabajo
- Agentes de lectura de documentos (IA)
- Consultoría en estrategia digital

## Dropdown del Formulario
- Dashboards y reportes
- Chatbots con IA / Atención al cliente
- Facturación y administración
- Automatización de flujos de trabajo
- Lectura y procesamiento de documentos
- CRM
- Consultoría en estrategia digital
- No sé, necesito un diagnóstico

## Contexto Relevante
- Mercado objetivo: global (se eliminaron referencias a Argentina/AFIP/ARCA)
- Slogan: "Inteligencia operativa para empresas que quieren crecer."
- Sub: "Rediseñamos tus procesos para hacerlos más ágiles, eficientes y preparados para escalar."
- Posicionamiento: aliados estratégicos, no una herramienta
- Diferencial: implementación rápida (MVP en <4 semanas)
- Diseño minimalista: paleta crema (#F4F0E8) + tinta oscura (#111111)
- 3 idiomas: ES (default), EN, PT

## Notas Técnicas
- Todo el CSS y JS está embebido dentro de `index.html` (no hay archivos separados)
- i18n: atributos `data-i18n` (textContent), `data-i18n-html` (innerHTML), `data-i18n-ph` (placeholder)
- Formspree requiere verificación de email en `hello@pluxow.com` al primer envío
- Diseño responsive con CSS Grid y Flexbox; logo hero se oculta en mobile (<720px)
