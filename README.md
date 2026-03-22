# 🌌 Antigravity Skills & Agents

Bienvenido al repositorio central de **Skills y Agentes** para Antigravity. Este proyecto es el "cerebro procedural" que permite a los asistentes de IA trabajar de forma estructurada, profesional y determinista mediante la metodología **Spec-Driven Development (SDD)**.

---

## 🚀 ¿Qué es esto?

Este repositorio no contiene código de una aplicación final, sino **capacidades** y **roles** que los agentes de IA pueden cargar bajo demanda. 

Específicamente está ajustado para Antigravity, pero puede modificarse fácilmente para cualquier otro IDE agéntico.

Es una adaptación de [Agent Teams Lite](https://github.com/Gentleman-Programming/agent-teams-lite.git) de [Gentleman-Programming](https://github.com/Gentleman-Programming)

En lugar de confiar solo en la "intuición" del modelo (vibe coding), este sistema utiliza:
1.  **Skills**: Unidades de conocimiento que enseñan a la IA *cómo* hacer tareas específicas (ej: documentar, inicializar un proyecto, validar código).
2.  **Agentes especializados**: Roles con objetivos claros (Analista, Arquitecto, Generador, QA, Documentador).
3.  **Metodología SDD**: Un flujo de trabajo basado en especificaciones antes de escribir código.

Estas herramientas harán el coding más determinístico.

---

## 📂 Estructura del Repositorio

| Directorio | Descripción |
| :--- | :--- |
| `Skill globales/` | Habilidades transversales aplicables a cualquier proyecto (como el núcleo de SDD). |
| `Skill por proyecto/` | Habilidades y agentes configurados para necesidades específicas de desarrollo. |
| `.agent/` | Definiciones técnicas de agentes y reglas de comportamiento. |

---

## 🛠️ Cómo empezar (Quick Start)

Para que Antigravity reconozca estas capacidades, el repositorio debe estar clonado en la ruta de skills del sistema:

1.  Navega a tu directorio de configuración de Antigravity (usualmente `~/.gemini/antigravity/skills`).

2.  Clona este repositorio:
    ```powershell
    git clone https://github.com/aconture/skills-antigravity.git .
    ```
3.  Configura el orquestador copiando el archivo de ejemplo:
    - Copia `~/sdd-examples/sdd-orchestrator.md` a `~/.gemini/GEMINI.md` 

4. En caso de que quieras tener repositorio en un workspace: Copia `~/sdd-examples/sdd-orchestrator.md` a `/.agent/rules/sdd-orchestrator.md` del workspace.
Copia AGENTS.md al root del workspace.

---
## 🧠 Conceptos Clave

### 1. El Orquestador vs. Sub-Agentes
El **Orquestador** (tú hablas con él) es un coordinador. No "ensucia" su memoria con detalles técnicos. Cuando necesita trabajar, delega la tarea a un **Sub-Agente** especializado que carga solo las **Skills** necesarias para esa tarea. Esto mantiene el contexto limpio y evita errores.

### 2. Spec-Driven Development (SDD)
Es nuestro estándar de calidad. El flujo de trabajo es:
`Explorar` ➔ `Proponer` ➔ `Especificar` ➔ `Diseñar` ➔ `Implementar` ➔ `Verificar` ➔ `Archivar`.

#### Uso de SDD:
La Gestión de SDD se realiza invocando desde el prompt de esta manera:

`sdd-init`: Inicializa el entorno de desarrollo guiado por especificaciones.

`sdd-explore`: Investiga ideas o la base de código antes de proponer cambios.

`sdd-propose`: Crea propuestas con el alcance y enfoque de un cambio.

`sdd-spec`: Escribe especificaciones técnicas detalladas (historias de usuario, criterios de aceptación).

`sdd-design`: Define la arquitectura y decisiones técnicas.

`sdd-tasks`: Desglosa el trabajo en una lista de tareas de implementación.

`sdd-apply`: Ejecuta la implementación real del código.

`sdd-verify`: Valida que la implementación cumpla con lo especificado.

`sdd-archive`: Consolida los cambios y archiva la tarea finalizada.

### 3. El Registro de Skills (`.atl/skill-registry.md`)
Es el mapa que los agentes consultan para saber qué herramientas tienen disponibles en cada momento.

Se popula automáticamente.

---

## 🤝 Contribuyendo

Si quieres añadir una nueva habilidad o mejorar un agente:
1.  Crea una carpeta en el directorio correspondiente.
2.  Define su comportamiento en un archivo `SKILL.md` o `AGENTS.md`.
3.  Asegúrate de que incluya el YAML frontmatter con los `triggers` adecuados.

---

> "Construir sin un plan es simplemente vibe coding con pasos extra. Aquí, planificamos." 
> — *El Equipo de Agentes SDD*
