---
name: notebooklm-docs
description: 
  Concatena la documentación de un proyecto o workspace (.md en el directorio /docs) y la configuración de los agentes (directorio .agent) para NotebookLM.
trigger: "cuando se solicite compilar o generar documentación para subir a notebooklm, o al usar el comando /notebooklm-docs"
tools: [powershell, terminal]
---

# Skill: notebooklm-docs (Global)
Esta habilidad global permite consolidar archivos Markdown de documentación y configuraciones de agentes del repositorio actual en archivos únicos (`docs.md` y `.agent.md`) para facilitar su carga en NotebookLM.

## Funcionalidad 1: Concatenar Documentos (`docs.md`)
Consolida todos los archivos Markdown ubicados en el directorio `.\docs\` del proyecto actual.
Para ejecutar esta funcionalidad, el agente debe usar la ruta absoluta de la skill global:
```powershell
powershell -ExecutionPolicy Bypass -File "$HOME\.gemini\antigravity\skills\notebooklm-docs\scripts\concat.ps1"
```

## Funcionalidad 2: Concatenar Configuración .agent (`.agent.md`)
Consolida todos los archivos dentro de la carpeta .agent del repositorio actual. Para ejecutar esta funcionalidad, el agente debe usar la ruta absoluta de la skill global:

```powershell
powershell -ExecutionPolicy Bypass -File "$HOME\.gemini\antigravity\skills\notebooklm-docs\scripts\concat-agent.ps1"
```

## Restricciones y Guía
Ámbito: Global. Esta skill debe estar disponible para todos los proyectos abiertos en Antigravity

## Permisos: Se requiere acceso a la terminal y ejecución de scripts de PowerShell

## Rutas: 
Los scripts deben referenciar siempre el directorio de trabajo actual (Get-Location) para leer los archivos del proyecto.