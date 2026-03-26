# Guía para el repositorio

## Cómo usar esta guía

- Comienza aquí para entender las normas que aplican al proyecto. VisMaximo es un monorepo con distintos componentes.
- Los componentes están alojados en .agent.
- Cada componente tiene un archivo `AGENTS.md` o `SKILL.md` con lineamientos específicos (e.g., `.agent/skills/Skill-X/SKILL.md`, `.agent/agents/AGENT-X/AGENTS.md`).
- Si hay confilcto de definiciones, la documentacion del proyecto sobrescribe esta guía.

## Workflow de actividades
- Debes seguir estrictamente este orden de actividades cada vez que actúes, como si fuera un DAG.
- Cada actividad tendrá un resultado que será usado como input de la siguiente actividad.

### Cuando se desarrolla una nueva funcionalidad o modificación de funcionalidad existente
| Actividad | Agente |
|-------|------------|
| Analisis y Diseño | `AGCC_ANALIST` |
| Documentacion | `AGCC_DOC` |
| Arquitectura | `AGCC_ARQS` |
| Determinación de las tareas | `AGCC_ANALIST` |
| Generación del código | `AGCC_GEN` |
| Revisión de código | `AGCC_REV_QA` |
| Tests | `AGCC_REV_QA` |
| Documentacion | `AGCC_DOC` |

### Cuando se desarrolla un fix
| Actividad | Agente |
|-------|------------|
| Analisis y Diseño | `AGCC_ANALIST` |
| Determinación de las tareas | `AGCC_ANALIST` |
| Generación del código | `AGCC_GEN` |
| Revisión de código | `AGCC_REV_QA` |
| Tests | `AGCC_REV_QA` |
| Documentacion | `AGCC_DOC` |


## Agentes disponibles
Usa estos agentes:
| Agente | Descripción | URL |
|-------|-------------|-----|
| `AGCC_ANALIST` | Analiza los requerimientos, identifica las tareas necesarias | [AGENTS.md](.agent/AGENTS/analista/AGENTS.md) |
| `AGCC_ARQS` | Arquitecto de Software | [AGENTS.md](.agent/AGENTS/arquitecto/AGENTS.md) |
| `AGCC_DOC` | Documenta cambios relevantes en el proyecto | [AGENTS.md](.agent/AGENTS/documentador/AGENTS.md) |
| `AGCC_GEN` | Genera el código del proyecto | [AGENTS.md](.agent/AGENTS/generador/AGENTS.md) |
| `AGCC_REV_QA` | Valida el código, genera y ejecuta tests | [AGENTS.md](.agent/AGENTS/qa/AGENTS.md) |

## Skills Disponibles
Usa estas skills on-demand:

### Skills Genéricas (Cualquier proyecto)
| Skill | Description | URL |
|-------|-------------|-----|
| `Skill-creator` | Crear nuevas Skills para el agente de IA | [SKILL.md](.agent/SKILLS/Skill-creator/SKILL.md) |
| `thisProject-changelog` | Actualiza el CHANGELOG.txt | [SKILL.md](.agent/SKILLS/thisProject-changelog/SKILL.md) |
| `notebooklm-docs` | Compila los archivos *.md del directorio /docs para notebooklm | [SKILL.md](.agent/SKILLS/notebooklm-docs/SKILL.md) |
| `notebooklm-code` | Compila los archivos *.py para notebooklm | [SKILL.md](.agent/SKILLS/notebooklm-code/SKILL.md) |

### Auto-invoke Skills
Cuando realices estas acciones, SIEMPRE invoca ANTES la correspondiente SKILL:

| Action | Skill |
|--------|-------|
| Crear nuevas Skills | `Skill-creator` |
| Actualizar el changelog | `thisProject-changelog` |
| Compilar documentos para Notebooklm | `notebooklm-docs` |