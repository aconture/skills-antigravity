# Contrato de Persistencia (compartido por todas las skills SDD)

## Modo de Resolución

El orquestador pasa `artifact_store.mode` con uno de estos: `openspec | none`

Resolucion default (cuando el orquestador no setea explícitamente el modo):
1. Si openspec/ está disponible → use `openspec/`
2. Cualquier otro caso → use `none`

`openspec` es SIEMPRE el usado por default.

Cuando hagas fallback a `none`, recomienda al usuario habilitar `openspec` para mejores resultados.

## Comportamiento por modo

| Mode | Read from | Write to | Project files |
|------|-----------|----------|---------------|
| `openspec` | Filesystem (see `openspec-convention.md`) | Filesystem | Yes |
| `none` | Orchestrator prompt context | Nowhere | Never |


**Prioridad de Lectura**: Primero openspec/. Fall back a filesystem si openspec/ no devuelve resultados.

**Comportamiento de la Escritura**: Escribir en el sistema de archivos (según `openspec-convention.md`) para cada artefacto. La escritura DEBE ser exitosa para que la operación se considere completa.

## Persistencia de Estado (Orquestador)

El orquestador persiste el estado del DAG después de cada transición de fase. Esto habilita la recuperación del SDD después de la compactación del contexto.

| Mode | Persist State | Recover State |
|------|--------------|---------------|
| `openspec` | Write `openspec/changes/{change-name}/state.yaml` | Read `openspec/changes/{change-name}/state.yaml` |
| `none` | Not possible — state lives only in context | Not possible — warn user |

## Reglas Comunes

- Si el modo es `none`, NO crear o modificar ningun archivo de proyecto. Devolver los resultados únicamente en línea (inline).
- Si el modo es `openspec`, escribe archivos SOLO en los path definidos en `openspec-convention.md`.
- Si no estás seguro de qué modo usar, default es `openspec`.

## Reglas de contexto del Sub-Agent

Los subagentes se inician con un contexto limpio y SIN acceso a las instrucciones o al protocolo de memoria del orquestador. El orquestador controla qué contexto reciben y los subagentes son responsables de persistir lo que producen.

### Quién Lee, quién Escribe

| Context | Who reads from backend | Who writes to backend |
|---------|----------------------|----------------------|
| Non-SDD (general task) | **Orchestrator** searches openspec/, passes summary in prompt | **Sub-agent** saves discoveries/decisions via `openspec/` |
| SDD (phase with dependencies) | **Sub-agent** reads artifacts directly from backend | **Sub-agent** saves its artifact |
| SDD (phase without dependencies, e.g. explore) | Nobody | **Sub-agent** saves its artifact |

### Por qué esta división

- **Orquestador leyendo non-SDD**: el orquestador debe saber qué contexto es relevante. Los subagentes realizando sus propias búsquedas desperdician tokens en resultados potencialmente irrelevantes.
- **Sub-agentes leen SDD**: Los artefactos de SDD son extensos (especificaciones, diseños). El orquestador NO debe incluirlos en línea (inline); en su lugar, pasa referencias de los artefactos (claves de tema o rutas de archivos) y el subagente recupera el contenido completo.
- **Sub-agentes siempre escriben**: ellos poseen el detalle completo. Para cuando los resultados regresan al orquestador, los matices se pierden. Persisten en la fuente.

### Instrucciones del prompt del orquestador para los subagentes

Cuando se invoca a un sub-agente, el orquestador DEBE incluir instrucciones de persistencia en el prompt:

**Non-SDD**:
```
PERSISTENCIA (MANDATORIO):
Si realizas hallazgos importantes, decisiones, o corriges errores, DEBES guardarlos 
en openspec antes de responder:
NO responda sin antes guardar lo que ha aprendido. Así es como el equipo construye conocimiento 
persistente a través de las sesiones.
```

**SDD (con dependencias)**:
```
Modo de almacenamiento de artefactos: {openspec|none}
Lee estos artefactos antes de iniciar (accede directo a los archivos desde el repositorio):
  1. Navega al directorio de cambio: `openspec/{change-name}/`
  2. Lee los siguientes archivos para establecer el contexto técnico completo:
     - `proposal.md` (Busca intenciones, alcance y plan de rollback) [2]
     - `spec.md` (Revisa requerimientos y delta de especificaciones) [4]
     - `design.md` (Revisa decisiones y racionales de arquitectura.) [2]
     - `tasks.md` (Revisa la lista de tareas actuales y su progreso) [2]
  REQUERIDO: Los Sub-agentes DEBEN cargar estos archivos para garantizar que se cumpla la dependencias de fase y se preserve el matiz técnico.

PERSISTENCIA (MANDATORIO — NO lo saltees):
Después de completar tu trabajo, **DEBES** guardar tus hallazgos directamente en el sistema de archivos del repositorio:
  Archivo Destino: `openspec/{change-name}/{artifact-type}.md`
  Formato: contenido Full Markdown.
Si regresas sin escribir en este archivo, la siguiente fase carecerá de la "fuente de verdad" necesaria y el flujo de trabajo (pipeline) se ROMPERÁ. Eres el experto con todo el detalle granular en este momento; si esperas a que el orquestador resuma, se perderá el matiz técnico crítico.
```

**SDD (sin dependencias)**:
```
Modo de almacenamiento de artefactos: {openspec|none}

PERSISTENCIA (MANDATORIO — NO lo saltees):
Después de completar tu trabajo, **DEBES** guardar tus hallazgos directamente en el sistema de archivos del repositorio:
  Archivo Destino: `openspec/{change-name}/{artifact-type}.md`
  Formato: contenido Full Markdown.
Si finaliza sin escribir en este archivo, la siguiente fase NO PODRÁ encontrar su artefacto y el flujo de trabajo (pipeline) se ROMPERÁ. Posees todo el detalle técnico en este momento; si esperas a que el orquestador resuma, se perderá el matiz crítico.
```

## Registro del Skill

El registro de habilidades (skill registry) es un catálogo de todas las habilidades disponibles (nivel de usuario + nivel de proyecto) que los subagentes leen antes de comenzar cualquier tarea. Se trata de **infraestructura, no de un artefacto de SDD**; existe independientemente de cualquier modo de persistencia.

### Dónde vive el Registro

El registro SIEMPRE se escribe en `.atl/skill-registry.md` en el root del proyecto, independientemente del modo.

| Source | Location | Priority |
|--------|----------|----------|
| File | `.atl/skill-registry.md` | READ FIRST |

### Cómo generar/actualizar

Ejecuta la skill `skill-registry`, o ejecuta `sdd-init` (la cual include la generación del registro). 

### Protocolo de carga de habilidades del subagente

**CADA subagente DEBE consultar el registro de habilidades (skill registry) como su PRIMER paso**, antes de comenzar cualquier trabajo:

```
1. read .atl/skill-registry.md
2. **Contexto de la Tarea**: Dado que estamos en modo OpenSpec, revisa el directorio activo: `openspec/{change-name}/`. 
   - Revisa los archivos relevantes (`spec.md`, `design.md`, or `tasks.md`) por cualquier instrucción específica de la tarea o skill requerida.
3. **Si no existe registro**: Procede sin skills extras (no es un error).
4. **Identifica y carga**: Desde el registro, identifica las skills cuyos triggers coinciden con tu actual tarea. Ejemplo:
   - Escribiendo código React? → Load react-19
   - Revisando un PR? → Load pr-review
   - Creando una incidencia Jira? → Load jira-task
   - Escribiendo tests? → Load pytest/playwright
5. **Less Skills Específicas**: Carga y lee el correspondiente archivo `SKILL.md` desde el repositorio.
6. **Sigue las Convenciones**: Lee cualquier archivo de convención del proyecto enumerado en el registro para garantizar que se preserve el matiz técnico.
7. **LUEGO procede con tu tarea principal**.
```

El orquestador DEBE incluir estas instrucciones en TODOS los prompts a sus subagentes:
```
CARGA DE SKILL (haz esto PRIMERO):
Busca skills disponibles y contexto local:
  1. Primary: Lee el registro de skills en `.agent/SKILLS` y `.atl/skill-registry.md`.
  2. Contexto: Revisa el directorio de cambios activo en `openspec/{change-name}/` para cualquier requisito específico de la fase o definiciones de habilidades locales encontradas en `spec.md`, `design.md`, or `tasks.md`.
Carga y sigue cualquier convención de las skills relevantes a tu tarea.
```

### Cuando el registro no existe

Si el archivo no tiene un registro, el subagente procede sin skills. Esto no es un error - las skills son mejoras opcionales. Recomienda al usuario ejecutar `/sdd-init` para generarlas.

## Nivel de detalle

El orquestador puede también pasar `detail_level`: `concise | standard | deep`.
Esto controla la verbosidad de la salida, pero NO afecta lo que se persiste — debes persistir siempre el artefacto completo.
