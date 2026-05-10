# Arquitectura Supabase — Pluxow

## Concepto base

Un solo proyecto Supabase para todos los clientes: **`pluxow-clients`**

Cada cliente tiene su propio **schema** (carpeta aislada con sus propias tablas).
Los schemas no se ven entre sí. Dos clientes pueden tener tablas con el mismo nombre sin conflicto.

```
pluxow-clients (proyecto Supabase)
├── schema: kinesicpro        ← clínica de kinesiología
├── schema: diseñador_juan    ← cliente diseñador (tablas distintas)
└── schema: cliente_n         ← cualquier cliente futuro
```

---

## Convención de nombres

| Elemento | Convención | Ejemplo |
|---|---|---|
| Schema | lowercase, sin espacios, sin guiones | `kinesicpro` |
| Tablas | snake_case, plural | `conversaciones`, `turnos` |
| Columnas | snake_case | `fecha_hora`, `obra_social` |
| FK | `{tabla_singular}_id` | `paciente_id`, `profesional_id` |

---

## Tablas base (presentes en casi todo cliente)

Estas tablas son comunes a proyectos con bot de WhatsApp:

### `conversaciones`
Requerida por el workflow de n8n. El bot lee y escribe aquí para saber si está en modo bot o humano.

| Columna | Tipo | Descripción |
|---|---|---|
| id | uuid (PK) | |
| telefono | text (unique) | Número de WhatsApp del contacto |
| nombre_perfil | text | Nombre de perfil de WhatsApp |
| modo | text | `'bot'` o `'humano'` |
| ultimo_mensaje | text | Preview del último mensaje |
| updated_at | timestamptz | Se actualiza con cada mensaje |
| created_at | timestamptz | |

### `mensajes`
Historial de mensajes de cada conversación.

| Columna | Tipo | Descripción |
|---|---|---|
| id | uuid (PK) | |
| conversacion_id | uuid (FK → conversaciones) | |
| contenido | text | |
| direccion | text | `'entrante'` o `'saliente'` |
| created_at | timestamptz | |

---

## Tablas específicas por cliente

Se definen caso a caso según el negocio. Ejemplos:

- **Clínica (kinesicpro):** `pacientes`, `profesionales`, `turnos`, `señas`
- **Diseñador:** `clientes`, `proyectos`, `presupuestos`
- **Restaurante:** `reservas`, `mesas`, `menu`

---

## Cómo conectar desde n8n

En los nodos HTTP Request de Supabase, agregar el header:

```
Content-Profile: {schema_del_cliente}
Accept-Profile: {schema_del_cliente}
```

Ejemplo para KinesicPro:
```
GET https://{proyecto}.supabase.co/rest/v1/conversaciones?telefono=eq.549...
Headers:
  apikey: SUPABASE_SERVICE_KEY
  Authorization: Bearer SUPABASE_SERVICE_KEY
  Accept-Profile: kinesicpro
```

Para escritura (POST/PATCH):
```
Headers:
  Content-Profile: kinesicpro
```

---

## Cómo conectar desde el CRM (Next.js)

```ts
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
  { db: { schema: 'kinesicpro' } }
)
```

Para Realtime (inbox en vivo):
```ts
supabase
  .channel('conversaciones')
  .on('postgres_changes', {
    event: '*',
    schema: 'kinesicpro',
    table: 'conversaciones'
  }, (payload) => { /* actualizar estado */ })
  .subscribe()
```

---

## Row Level Security (RLS)

Activar RLS en todas las tablas. Para el CRM admin (usa service role key en server-side):
- La service role key bypasea RLS → solo usarla en n8n y server components de Next.js
- La anon key en el frontend → con policies que restrinjan por rol si es necesario

---

## Checklist: agregar un cliente nuevo

- [ ] Crear schema en Supabase: `CREATE SCHEMA {nombre};`
- [ ] Correr el SQL base (`conversaciones` + `mensajes`)
- [ ] Agregar tablas específicas del cliente
- [ ] Activar RLS en cada tabla
- [ ] En n8n: agregar headers `Accept-Profile` / `Content-Profile` en todos los nodos Supabase
- [ ] En el CRM: configurar `db: { schema: '{nombre}' }` en el cliente de Supabase
- [ ] Variables de entorno: el proyecto Supabase es el mismo, solo cambia el schema

---

## Variables de entorno (compartidas para todos los clientes)

```env
NEXT_PUBLIC_SUPABASE_URL=https://{proyecto}.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=...
SUPABASE_SERVICE_KEY=...   # solo server-side / n8n
```
