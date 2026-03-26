---
name: notebooklm-code
description: Concatena todos los archivos de código fuente Python (*.py) del espacio de trabajo (raíz y subdirectorios), excluyendo carpetas específicas, para facilitar su análisis en NotebookLM.
 trigger: "cuando se solicite compilar o generar el código fuente para subir a notebooklm, o al usar el comando /notebooklm-code"
 tools: [powershell, terminal]
 license: Apache-2.0 metadata: author: AGCC version: "1.0"
---

# Skill: notebooklm-code
Cuando usar esta Skill
Para realizar una revisión integral del código del proyecto en NotebookLM.
Cuando se necesite una visión consolidada del estado actual de la implementación de lógica en Python.
Para generar un artefacto de contexto técnico que incluya la estructura de directorios y el contenido de los scripts.

## Funcionalidad 1: Concatenar Documentos (`*.py`)
Consolida todos los archivos*.py* del proyecto actual.
Para ejecutar esta funcionalidad, el agente debe usar la ruta absoluta de la skill global:
```powershell
powershell -ExecutionPolicy Bypass -File "$HOME\.gemini\antigravity\skills\notebooklm-code\scripts\concat-code.ps1"
```

## Restricciones y Guía
Ámbito: Global. Esta skill debe estar disponible para todos los proyectos abiertos en Antigravity

## Permisos: Se requiere acceso a la terminal y ejecución de scripts de PowerShell

## Critical Patterns 
- Los scripts deben referenciar siempre el directorio de trabajo actual (Get-Location) para leer los archivos del proyecto.
- Recursividad: Debe buscar archivos en todos los subdirectorios del workspace.
- Exclusiones: No debe procesar archivos dentro de .agent, docs, ni directorios de entorno virtual o control de versiones definidos en la lista de exclusión que se encuentra en el script. Al ejecutar esta skill debes indicar al requirente los directorios que se están excluyendo.
- Trazabilidad: Cada bloque de código en el archivo resultante debe estar encabezado por la ruta relativa del archivo original para mantener el contexto.