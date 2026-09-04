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

**En beta** (agosto 2026, sujeto a aceptar los términos de la beta — puede cambiar). Permite enviar mensajes de **utilidad y autenticación** sin pre-crear ni gestionar plantillas a mano: Meta las genera automáticamente detrás de escena.

Resuelve la limitación de hoy: las plantillas de utilidad (ej. recordatorio de estado de un lead) tienen texto y variables fijas, pre-aprobadas por Meta — cualquier cambio de redacción exige volver a mandar la plantilla a revisión. Con Direct Send se manda el texto final directo y Meta se encarga del resto.

**Cómo funciona técnicamente** (según la documentación oficial de Meta):

- Se usa el mismo endpoint `/<WHATSAPP_BUSINESS_PHONE_NUMBER_ID>/messages` de siempre, mandando el mensaje como texto libre (`"type": "text"`) y agregando un campo `"category": "utility"` (o `authentication`) — no se referencia ningún nombre de plantilla.
- Meta intenta matchear el texto contra plantillas ya generadas automáticamente:
  - Si matchea una existente → se manda con esa plantilla.
  - Si no matchea ninguna → se manda igual usando una plantilla "de fallback" que Meta agrega automáticamente al onboardear la WABA a Direct Send (así el mensaje siempre sale), y en paralelo Meta crea una plantilla nueva a partir de ese texto (con PII redactada y el idioma auto-detectado) para que los próximos mensajes similares matcheen ahí.
- Si importa poder atribuir mensajes a una plantilla específica (para reporting/tracking), se puede pasar un nombre de plantilla en el request y Direct Send crea la plantilla con ese nombre exacto — ver "Business-named templates" en la doc oficial.

- **Cómo habilitarlo**: hay que onboardear la WABA a Direct Send primero (ver "Get started with Direct Send — onboarding prerequisites" en la doc oficial). Si la integración es directa con la WhatsApp Business Platform se hace desde ahí; si se trabaja a través de un BSP, hay que pedirle a ese partner que lo habilite.
- **Ojo con el contenido**: sigue teniendo que ser genuinamente contenido de **utilidad** (transaccional, sobre algo ya acordado con el usuario). Si se detecta contenido de marketing disfrazado de utilidad de forma persistente, se pierde el acceso.
- **Beneficio extra de costo**: al no depender de una plantilla fija, hay menos riesgo de que Meta "recategorice" el mensaje a una categoría más cara — el costo queda más predecible.
- Revisar también "Supported features and limits" y "Supported message types" de la doc oficial antes de integrarlo — formatos e idiomas soportados pueden tener restricciones propias de la beta.

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
- [Direct Send messages — Meta for Developers](https://developers.facebook.com/documentation/business-messaging/whatsapp/direct-send) (contenido pegado por Lea directamente, ese dominio está bloqueado para fetch automático)
- [Direct Send API — video oficial de Meta](https://developers.meta.com/resources/videos/whatsapp-direct-send-api/)
