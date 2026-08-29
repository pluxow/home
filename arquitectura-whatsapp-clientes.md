# Arquitectura WhatsApp — Multi-cliente

## Contexto

Hoy Pluxow tiene 2 clientes casi en producción compartiendo **una única app de Meta y el mismo número de teléfono**. Ese setup no escala a lo que viene:

- Un cliente va a necesitar **WhatsApp coexistence** (chatbot que convive con la app de WhatsApp Business que el cliente ya usa).
- El otro cliente necesita algo más simple: un número que solo le manda notificaciones a él, con **su propia facturación**.

Coexistence en particular **requiere un número dedicado a ese negocio** — no se puede compartir con otro cliente. Conclusión: cada cliente necesita su **propio número + su propia WABA** (WhatsApp Business Account), no el modelo compartido actual.

## Modelo de cuentas nuevo de Meta (rollout H2 2026)

Meta separó la vieja WABA en dos partes:

- **WAAC** — contiene el número de teléfono y la identidad del negocio.
- **Messaging Account** — contiene plantillas, throughput y **facturación**.

Un mismo número ahora puede compartirse entre varias integraciones, con la facturación aislada por Messaging Account. Es una feature pensada para partners grandes/agregadores — para Pluxow con 2-3 clientes, más simple seguir el modelo clásico de **1 WABA = 1 número = 1 cliente**.

## Estructura recomendada por cliente

| | Cliente chatbot (coexistence) | Cliente notificaciones |
|---|---|---|
| Número | El que el cliente ya usa en la app de WhatsApp Business | Número nuevo dedicado |
| Requisito previo | La app debe llevar 2-3 semanas de uso activo antes de integrar | Ninguno |
| Límite técnico | Throughput fijo de **5 mensajes/segundo** vía API (menor al estándar de Cloud API) | Sin esta limitación |
| Alta | Vía Embedded Signup (coexistence) | Vía Embedded Signup (Cloud API directo) |

## Modelo de facturación: Tech Provider

Meta distingue dos modelos para partners/agencias:

- **Tech Provider** (recomendado para Pluxow): el cliente carga **su propia tarjeta** en la facturación de su WABA en Meta Business Suite. Meta le cobra el consumo de mensajería **directamente a él**. Pluxow factura aparte su servicio (desarrollo/mantenimiento), sin intermediar la plata de WhatsApp.
- **Solution Partner**: Pluxow tiene línea de crédito con Meta, paga el consumo agregado de todos los clientes y después les factura. Más control, pero más carga administrativa y riesgo de flujo de caja.

## Dueño del Business Manager

Recomendado: que cada WABA quede bajo el **Business Manager del propio cliente**, no el de Pluxow. Pluxow se suma como partner con permisos de administración vía Embedded Signup.

Ventaja: si el cliente deja de trabajar con Pluxow, se lleva su número, historial y reputación sin fricción — el activo es de él.

## Deadline a tener en cuenta

**Embedded Signup v2 y v3 se deprecan el 15 de octubre de 2026** → migrar a **v4**.

Después de esa fecha, la mayoría de las integraciones se auto-actualizan solas a v4 sin problema. **Pero si se usa el feature type `coex` (coexistence) hay que migrar manualmente antes del 15 de octubre** — si no, se auto-actualiza igual pero coexistence deja de funcionar y cae al flujo estándar de Embedded Signup. Esto afecta directo al cliente del chatbot con coexistence: no alcanza con "no tocar nada", hay que migrar ese feature específico a mano.

## Direct Send — alternativa a las plantillas para mensajes de utilidad

Lanzado en agosto 2026. Permite enviar mensajes de **utilidad y autenticación** con texto libre/dinámico ("fully hydrated"), directo por el endpoint `/messages` de Cloud API, **sin crear ni esperar aprobación de plantilla**.

Resuelve justo la limitación de hoy: las plantillas de utilidad (ej. recordatorio de estado de un lead) tienen formato fijo — texto y variables pre-aprobadas por Meta, cualquier cambio de redacción exige volver a mandar la plantilla a revisión. Con Direct Send se manda el texto final ya armado, sin ese paso.

- **Cómo habilitarlo**: si la integración es directa con la WhatsApp Business Platform (no a través de un BSP intermediario), se puede empezar directo revisando la [documentación oficial](https://developers.facebook.com/documentation/business-messaging/whatsapp/direct-send/) (nota: ese dominio está bloqueado para fetch automático, hay que abrirlo manualmente en el navegador). Si se trabaja a través de un partner/BSP, hay que pedirle a ese partner que lo habilite.
- **Ojo con el contenido**: sigue teniendo que ser genuinamente contenido de **utilidad** (transaccional, sobre algo ya acordado con el usuario) — Meta no pre-aprueba el texto, pero si se detecta que se manda contenido de marketing disfrazado de utilidad de forma persistente, **se pierde el acceso a Direct Send**.
- **Beneficio extra de costo**: al no haber plantilla, no hay riesgo de que Meta "recategorice" el mensaje a una categoría más cara (ej. de utilidad a marketing) — el costo queda más predecible.
- Sigue siendo beta/rollout gradual — confirmar elegibilidad de la WABA antes de asumir que está disponible.

## Checklist: dar de alta un cliente nuevo de WhatsApp

- [ ] Confirmar si necesita coexistence (número ya en uso, 2-3 semanas de antigüedad) o número nuevo dedicado
- [ ] Dar de alta la WABA vía Embedded Signup **v4**, bajo el Business Manager del cliente
- [ ] Pedirle al cliente que cargue su propia tarjeta en la facturación de su WABA (modelo Tech Provider)
- [ ] Si es coexistence: avisar sobre el límite de 5 mensajes/segundo al dimensionar el chatbot, y migrar manualmente a Embedded Signup v4 antes del 15/10/2026
- [ ] Separar la app de Meta / integración por cliente (no reusar la app compartida actual)
- [ ] Si el cliente manda mensajes de utilidad con formato rígido (recordatorios, confirmaciones), evaluar **Direct Send** en vez de plantillas

## Fuentes

- [WhatsApp Account Model Evolution: WAAC y Messaging Account Split — UnifyPort](https://www.unifyport.ai/blog/whatsapp-account-model-evolution-waac-messaging-account/)
- [WhatsApp Tech Provider Embedded Signup — Telnyx](https://developers.telnyx.com/docs/messaging/whatsapp/embedded-signup/tech-provider)
- [WhatsApp Business Solution Providers: Partner Tiers (2026) — WuSeller](https://www.wuseller.com/whatsapp-business-knowledge-hub/whatsapp-business-solution-providers-partner-tiers-2026/)
- [What is WhatsApp Business App Coexistence? — YCloud](https://www.ycloud.com/blog/whatsapp-business-app-coexistence-meta-update)
- Mail original de Meta: "We are updating our business terms of service, effective September 23, 2026" (6 ago 2026, `no-reply@messaging.metamail.com`)
- Mail original de Meta: "What's new in WhatsApp for Business — August 2026" (27 ago 2026, `no-reply@messaging.metamail.com`) — deadline de coexistence en Embedded Signup v4 y anuncio de Direct Send
- [Direct Send messages — Meta for Developers](https://developers.facebook.com/documentation/business-messaging/whatsapp/direct-send) (bloqueado para fetch automático, abrir manual)
- [Direct Send API — video oficial de Meta](https://developers.meta.com/resources/videos/whatsapp-direct-send-api/)
