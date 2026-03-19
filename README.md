# 🌌 Antigravity Skills & Agents

Bienvenido al repositorio central de **Skills y Agentes** para Antigravity. Este proyecto es el "cerebro procedural" que permite a los asistentes de IA trabajar de forma estructurada, profesional y determinista mediante la metodología **Spec-Driven Development (SDD)**.

---

## 🚀 ¿Qué es esto?

Este repositorio no contiene código de una aplicación final, sino **capacidades** y **roles** que los agentes de IA (como Antigravity) pueden cargar bajo demanda. 

En lugar de confiar solo en la "intuición" del modelo (vibe coding), este sistema utiliza:
1.  **Skills**: Unidades de conocimiento que enseñan a la IA *cómo* hacer tareas específicas (ej: documentar, inicializar un proyecto, validar código).
2.  **Agentes especializados**: Roles con objetivos claros (Analista, Arquitecto, Generador, QA, Documentador).
3.  **Metodología SDD**: Un flujo de trabajo basado en especificaciones antes de escribir código.

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
    - Copia `~/sdd-examples/sdd-orchestrator.md` a `~/.gemini/GEMINI.md`.

---
## 🧠 Conceptos Clave

### 1. El Orquestador vs. Sub-Agentes
El **Orquestador** (tú hablas con él) es un coordinador. No "ensucia" su memoria con detalles técnicos. Cuando necesita trabajar, delega la tarea a un **Sub-Agente** especializado que carga solo las **Skills** necesarias para esa tarea. Esto mantiene el contexto limpio y evita errores.

### 2. Spec-Driven Development (SDD)
Es nuestro estándar de calidad. El flujo de trabajo es:
`Explorar` ➔ `Proponer` ➔ `Especificar` ➔ `Diseñar` ➔ `Implementar` ➔ `Verificar` ➔ `Archivar`.

### 3. El Registro de Skills (`.atl/skill-registry.md`)
Es el mapa que los agentes consultan para saber qué herramientas tienen disponibles en cada momento.

---

## 🤝 Contribuyendo

Si quieres añadir una nueva habilidad o mejorar un agente:
1.  Crea una carpeta en el directorio correspondiente.
2.  Define su comportamiento en un archivo `SKILL.md` o `AGENTS.md`.
3.  Asegúrate de que incluya el YAML frontmatter con los `triggers` adecuados.

---

> "Construir sin un plan es simplemente vibe coding con pasos extra. Aquí, planificamos." 
> — *El Equipo de Agentes SDD*
