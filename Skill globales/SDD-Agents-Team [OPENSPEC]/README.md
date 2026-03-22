# skills-antigravity

Se debe clonar este repositorio en el directorio ~.gemini\antigravity\skills de esta manera:
parado en el directorio de .gemini:

```powershell
git glone https://github.com/aconture/skills-antigravity.git .
```

# 🤖 Arquitectura de Agentes y Gestión de Skills

Este repositorio utiliza una arquitectura de **Spec-Driven Development (SDD)** basada en el patrón de orquestación de **Agent Teams Lite**, diseñada para maximizar la eficiencia del contexto y garantizar resultados deterministas a través de sub-agentes especializados.

El repositorio tiene dos funcionalidades:

## skills
Skills globales para usar en Antigravity. Almacenando en el path correcto, también pueden usarse en otros agentes.

## Antigravity Agent Teams

Esquema de agentes SDD que son invocados como skills, adaptado de https://github.com/Gentleman-Programming/agent-teams-lite.git para usar estrictamente en Antigravity (si querés algo agnóstico, andá al repo de agent-teams-lite)

## Estructura de directorios:
El archivo `~/sdd-examples/sdd-orchestrator.md` se debe copiar a `~/.gemini/GEMINI.md`, con esto Antigravity comenzará a reconocer el orquestador como una regla.

Archivos de convenciones: `~/.gemini/antigravity/skills/_shared/` (global) o `.agent/skills/_shared/` (workspace) provee full reference documentation (sub-agents tienen sus propias instrucciones — archivos de convención son suplementarios):
- `persistence-contract.md` for mode behavior and state persistence/recovery
- `openspec-convention.md` for file layout when mode is `openspec`


## 🧠 El Orquestador (`GEMINI.md` / `CLAUDE.md`)
El orquestador actúa como un **COORDINADOR**, no como un ejecutor. Su función principal es mantener un hilo de conversación ligero con el usuario y delegar todas las tareas técnicas (lectura/escritura de código, análisis, tests) a sub-agentes o fases basadas en skills.
- **Regla de Oro:** Nunca realiza trabajo real inline para evitar el ruido cognitivo y la pérdida de estado por compactación de contexto.

## 📋 Registro de Habilidades (`.atl/skill-registry.md`)
Es la **infraestructura central** que conecta al orquestador con el conocimiento procedural del repositorio. 
- **Función:** Actúa como un catálogo dinámico que mapea **Triggers (Disparadores) | Nombre de la Skill | Ruta Absoluta**.
- **Protocolo:** Todo sub-agente debe consultar este registro como su **primer paso obligatorio** para identificar qué habilidades son relevantes para su tarea actual.

## 🛠️ Skills Especializadas (`SKILL.md`)
Las habilidades son unidades de conocimiento encapsulado que permiten a los agentes ejecutar tareas complejas siguiendo metodologías específicas.
- **Anatomía:** Cada archivo `SKILL.md` combina metadatos (YAML frontmatter) con instrucciones técnicas en Markdown.
- **Carga Bajo Demanda:** Solo se cargan las habilidades que coinciden con el disparador de la tarea, manteniendo la ventana de contexto del sub-agente limpia y enfocada.

## 🔄 Protocolo de Ejecución
1. **Delegación:** El orquestador identifica una necesidad técnica y lanza un sub-agente con un contexto fresco.
2. **Descubrimiento:** El sub-agente lee el `.atl/skill-registry.md` para "aprender" las reglas del proyecto.
3. **Ejecución:** El sub-agente carga las skills necesarias (ej. `sdd-init`, `sdd-spec`) y realiza la tarea.
4. **Persistencia:** Los resultados y descubrimientos se guardan directamente en el backend de archivos (**OpenSpec**) para asegurar que la "fuente de verdad" sea compartida entre fases.

---

### Openspec para Antigravity

**1. Copy skills:**

```bash
# Global (available across all projects)
./scripts/install.sh  # Choose Antigravity option

# Or manually (global)
cp -r skills/sdd-* ~/.gemini/antigravity/skills/

# Workspace-specific (per project)
mkdir -p .agent/skills
cp -r skills/sdd-* .agent/skills/
```

**2. Add orchestrator instructions:**

Add the SDD orchestrator as a global rule in `~/.gemini/GEMINI.md`, or create a workspace rule in `.agent/rules/sdd-orchestrator.md`.

See [`examples/antigravity/sdd-orchestrator.md`](examples/antigravity/sdd-orchestrator.md) for the rule content.

**3. Verify:**

Open Antigravity and type `/sdd-init` in the agent panel.

> **Note:** Antigravity uses `.agent/skills/` and `.agent/rules/` for workspace config, and `~/.gemini/antigravity/skills/` for global. It does NOT use `.vscode/` paths.

---
*Built with Agent Teams Lite — Because building without a plan is just vibe coding with extra steps.*