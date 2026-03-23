### **Convenciones para Mensajes de Commit**

Este documento establece las directrices para la redacción de mensajes de commit, con el fin de mantener la claridad, la trazabilidad y la coherencia en el historial de versiones del proyecto.

#### **1. Tipos de Commit**

Los prefijos en el mensaje del commit **indican explícitamente la naturaleza del cambio** realizado en el código. Utiliza los siguientes tipos:

*   **feat**: Una **nueva funcionalidad** [Referencia: `### 🚀 Added` en `CHANGELOG.txt`].
*   **fix**: Corrección de un **error (bug)** [Referencia: `### 🐞 Fixed` en `CHANGELOG.txt`].
*   **docs**: Cambios realizados **exclusivamente en la documentación** [Referencia: `thisproject-docs` skill para la documentación].
*   **style**: Cambios que **no afectan el significado del código** (ej. espacios, formato, puntos y coma).
*   **refactor**: Cambio de código que **no corrige un error ni añade una funcionalidad** [Referencia: `### 🔄 Changed` en `CHANGELOG.txt` puede incluir refactorizaciones que modifican funcionalidad existente].
*   **test**: Adición de pruebas que faltaban o corrección de pruebas existentes [Referencia: La `sdd-verify` skill se encarga de la validación y ejecución de pruebas].
*   **chore**: Actualizaciones de tareas de construcción, configuración de herramientas o librerías (ej. actualizar el `.gitignore`).

#### **2. Reglas de Oro (The Seven Rules)**

Independientemente del prefijo, existen **siete reglas clásicas** para redactar mensajes de commit que **deben seguirse estrictamente** para garantizar la legibilidad y la comprensión del historial:

1.  **Separar el sujeto del cuerpo** con una línea en blanco (cuando el commit sea largo) [Referencia: `Entry Format` en `thisProject-changelog`].
2.  **Limitar el sujeto a 50 caracteres**.
3.  **Capitalizar la primera letra de la descripción** en el sujeto.
4.  **No terminar el sujeto con un punto**.
5.  **Usar el modo imperativo en el sujeto** (ej. "Add feature" en lugar de "Added feature").
6.  **Envolver el cuerpo a los 72 caracteres**.
7.  **Usar el cuerpo para explicar el *qué* y el *porqué*** del cambio, no el *cómo*.
