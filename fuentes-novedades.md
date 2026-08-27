# Fuentes de novedades — chequeo semanal

Lista de remitentes que reviso cuando Lea pregunta "qué novedades hay". Sirve para no depender de la memoria de una conversación puntual — si se pierde el contexto de la sesión, esta lista queda.

## Cómo se usa

Por cada remitente, buscar en Gmail (`lcouretot@gmail.com`) con `from:{dominio} newer_than:7d` (o `after:YYYY/MM/DD` desde el último chequeo). Abrir el contenido completo de lo que parezca sustancial (pricing, deprecaciones, breaking changes, alertas de cuenta) y descartar lo que sea marketing genérico (webinars, newsletters de producto sin acción concreta).

Clasificar cada novedad relevante en uno de estos baldes:
- **Clientes** — afecta directamente un servicio que Pluxow le da a un cliente (WhatsApp, dashboards, automatizaciones).
- **Negocio** — afecta el desarrollo/infraestructura propia de Pluxow, o es interesante para decisiones internas.
- **Contenido** — insumo para pensar carruseles (no es "novedad" en el sentido de acción requerida).

## Fuentes

| Remitente | Qué manda | Balde |
|---|---|---|
| `no-reply@messaging.metamail.com` | WhatsApp Business Platform / Meta — pricing, deprecaciones, cambios de API, features nuevas | Clientes + Negocio |
| `welcome@supabase.com` | Newsletter mensual "Supa Update" — changelog de producto | Negocio |
| `ant.wilson@supabase.com` (u otros `@supabase.com`) | Alertas puntuales de proyecto (ej. pausa por inactividad) | Clientes/Negocio — **revisar rápido, suelen ser urgentes** |
| `ship@info.vercel.com` | "What's new in Vercel" — features de producto | Negocio |
| `hello@info.n8n.io` | Anuncios de versión y producto de n8n | Clientes + Negocio |
| `CloudPlatform-noreply@google.com` | Avisos de deprecación/producto de Google Cloud (cuenta personal de Lea) | Negocio — confirmar con Lea antes de asumir impacto en un cliente |
| `noreply-cloudshell@google.com` | Avisos de inactividad de Cloud Shell (limpieza de directorio home) | Negocio, baja prioridad |
| `em@em1.cloudflare.com` | Newsletter de producto/marketing de Cloudflare (Workers AI, AI Gateway, eventos) | Negocio |
| `coach@francosarli.com` | Newsletter de copywriting/marketing de Franco Sarli | Contenido |
| `hola@alaimolabs.com` | Newsletter sobre IA aplicada a producto | Contenido |

## Notas

- `notifications@vercel.com` (alertas de deploy fallido) es ruido operativo interno, no una "novedad" de proveedor — se menciona aparte solo si hay un patrón raro (ej. muchos fallos seguidos en un proyecto en producción).
- Cuando aparezca un remitente nuevo para trackear, sumarlo a esta tabla.
