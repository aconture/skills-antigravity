# 🤖 Arquitectura de Agentes y Gestión de Skills

Este repositorio utiliza una arquitectura de **Spec-Driven Development (SDD)** basada en el patrón de orquestación de **Agent Teams Lite**, diseñada para maximizar la eficiencia del contexto y garantizar resultados deterministas a través de sub-agentes especializados.

El repositorio tiene dos funcionalidades:

## skills
Skills globales para usar en Antigravity. Almacenando en el path correcto, también pueden usarse en otros agentes.

## Antigravity Agent Teams

Esquema de agentes SDD que son invocados como skills, adaptado de https://github.com/Gentleman-Programming/agent-teams-lite.git para usar estrictamente en Antigravity (si querés algo agnóstico, andá al repo de agent-teams-lite)

## Estructura de directorios:
Ver REDME.md de este repositorio

## 🧠 El Orquestador (`GEMINI.md` / `sdd-orchestrator.md`)
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


*Built with Agent Teams Lite — Because building without a plan is just vibe coding with extra steps.*