# Changelog — Web de Pluxow (pluxow.com)

Registro cronológico de cambios, funcionalidades y mejoras en el sitio web de Pluxow.

---

## 10 de Marzo 2026 — Chat widget con IA en la landing

### Descripción
Se integró un chat widget flotante en la página de inicio que conecta a los visitantes con el asistente de IA de Pluxow. El chatbot responde consultas frecuentes, califica leads y deriva a contacto humano cuando es necesario. Soporta múltiples idiomas mediante detección automática y selector manual.

**Archivos involucrados:** `index.html`

---

## 28 de Abril 2026 — Panel de administración `/admin`

### Descripción
Se implementó un panel de administración interno accesible en `/admin` que permite al equipo de Pluxow editar el wording de la web sin tocar código. Los cambios se persisten en `content.json` vía GitHub API y se reflejan en el sitio en tiempo real. Incluye vista previa en vivo con panel dividido.

**Archivos involucrados:** `admin/`, `content.json`

---

## 3 de Mayo 2026 — Flyer Scanner: herramienta de generación de leads

### Descripción
Se creó `flyer-scan.html`, una herramienta interna de prospección comercial para el equipo de Pluxow. El flujo es el siguiente:

1. El usuario sube una foto de un flyer publicitario de un negocio prospecto.
2. Claude Haiku analiza la imagen con visión y extrae datos del negocio: nombre, rubro, email, teléfono, Instagram, website y descripción.
3. Si hay website, se scrapea para obtener contexto adicional.
4. Gemini 2.5 Flash genera un mensaje de primer contacto personalizado, con el tono de Pluxow, pain points específicos del negocio y propuesta de llamada gratuita.
5. Se devuelven links de acción listos para usar: `wa.me/`, `mailto:` o perfil de Instagram con el mensaje pre-cargado.

La herramienta está protegida por contraseña y tiene página con gate de acceso.

**Archivos involucrados:** `flyer-scan.html`, `n8n-flyer-scanner-workflow.json`
**Infraestructura:** Workflow en n8n (`Pluxow — Flyer Scanner`, ID `mX3IAcPUQAxjSK40`)
**Modelos IA:** Claude Haiku 4.5 (visión) + Gemini 2.5 Flash (redacción)

---

## 10 de Mayo 2026 — Sección Casos de Éxito en la landing

### Descripción
Se agregó una nueva sección "Casos de Éxito" en la página de inicio, entre la sección de resultados y el formulario de contacto. Muestra 6 proyectos reales implementados por Pluxow en distintos sectores, cada uno con badge de sector, título, descripción y tags de tecnologías utilizadas.

**Casos incluidos:**
- **Salud · Kinesiología** — Ecosistema de atención autónoma: chatbot 24/7, agenda digital y pagos automáticos.
- **Salud · Policonsultorio** — CRM de pacientes con check-in por QR y app post-consulta para el paciente.
- **Salud · Clínica** — Procesamiento de partes quirúrgicos con IA y volcado automático a Google Sheets.
- **Industrial · Maquinaria** — Business Intelligence con dashboards de KPIs y bot de web scraping de divisas.
- **Sports Tech** — Plataforma de analítica deportiva en tiempo real con app móvil de alta performance.
- **Media & Entertainment** — Ecosistema de marketing inteligente con agente de IA generativa que aprende el estilo del artista y automatiza publicaciones en redes sociales.

**Archivos involucrados:** `index.html`

---

## 10 de Mayo 2026 — Traducción de Casos de Éxito al inglés y portugués

### Descripción
Se agregaron traducciones completas de la sección "Casos de Éxito" para los idiomas inglés (EN) y portugués (PT), integrándolas al sistema i18n existente. Se crearon 35 claves de traducción por idioma cubriendo el label de sección, título, intro, y para cada uno de los 6 casos: badge de sector, título, descripción y tags. Las claves se actualizaron tanto en `content.json` (fuente primaria) como en el fallback JS del propio `index.html`. Los tags puramente técnicos (CRM, BI, Web Scraping, Analytics, Google Sheets) se mantuvieron como texto estático para no inflar innecesariamente el sistema de traducciones.

**Archivos involucrados:** `index.html`, `content.json`
