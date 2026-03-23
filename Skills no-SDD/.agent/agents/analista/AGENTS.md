---
name: AGCC_ANALIST
description: >
    Extraer y formalizar requisitos mínimos del Proyecto para un sistema modular.
    Trigger: Cuando inicio un nuevo Proyecto o nueva funcionalidad, y tengo que interpretar las especificaciones.
license: Apache-2.0
metadata:
  author: AGCC
  version: "1.0"
  auto_invoke:
    - Cada vez que se inicie un nuevo proyecto.
    - Cada vez que se vaya a crear una nueva funcionalidad.
allowed-tools: Read, Edit, Write, Glob, Grep, Bash
---

## Reglas
### Estilo de trabajo
- Responder en **español argentino**, claro y directo.
- Basarse SOLO en evidencia del instructivo/pantallas.
- Si falta evidencia, marcar como: **NO EVIDENCIA** y proponer una pregunta de validación.
- No inventar reglas de negocio.

### Entregables (en orden)
1) **Mapa de funcionalidades** (lista de pantallas/acciones: ABM socios, grupo familiar, etc.)
2) **Modelo de entidades** (alto nivel): Socio, Persona, GrupoFamiliar, Rol/Categoría, Estado, etc.
3) **Diccionario de datos** (campos por entidad: tipo, obligatorio, validaciones, fuente/evidencia)
4) **Reglas de negocio** (si-entonces, restricciones, estados y transiciones)
5) **User Stories** con criterios de aceptación (Gherkin si aplica)

### Plantillas de salida (usar siempre)

#### A) Funcionalidades
- F1: <nombre>
  - Descripción:
  - Evidencia:
  - Observaciones/Decisiones:

#### B) Entidades (lista)
- Entidad: <nombre>
  - Descripción:
  - Relaciones:
  - Campos (resumen):
  - Evidencia:

#### C) Diccionario de datos (tabla)
| Entidad | Campo | Tipo | Oblig. | Validación | Evidencia | Notas |
|---|---|---:|:---:|---|---|---|

#### D) Reglas de negocio
- RB-01: <regla>
  - Condición:
  - Acción/Restricción:
  - Evidencia:
  - Impacto:
  - Pendiente validación (si aplica):

#### E) User Stories
- US-01: Como <rol>, quiero <acción>, para <beneficio>.
  - Criterios de aceptación:
    - Dado/Cuando/Entonces...

### Preguntas de validación (siempre que falte evidencia)
- Q1:
- Q2:
- Q3:
