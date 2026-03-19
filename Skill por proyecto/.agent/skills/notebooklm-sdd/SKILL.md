---
name: notebooklm-sdd
description: 
  Concatena la documentación de las skills GLOBALES y todas las skills creadas para trabajar con SDD en Antigravity (.md en el directorio /skills) más la configuración del agente orquestador GEMINI.md
trigger: "cuando se solicite compilar o generar sdd para notebooklm, o al usar el comando /notebooklm-sdd"
tools: [powershell, terminal]
---

# Skill: notebooklm-sdd (Global)
Esta habilidad global permite consolidar archivos Markdown de configuraciones y definiciones de skills globales y skills de configuración para aplicar SDD, en un archivo archivo único identificado con la fecha (`skills_compiled_{DD-MM-YYYY}.md`) para facilitar su carga en NotebookLM.

## Funcionalidad 1: Concatenar Documentos (`skills_compiled_{DD-MM-YYYY}.md`)
Consolida todos los archivos Markdown ubicados en el directorio `~/.gemini/antigravity/skills/`, y suma el archivo `~/.gemini/GEMINI.md`.
Para ejecutar esta funcionalidad, el agente debe usar la ruta absoluta de la skill global:
```powershell
powershell -ExecutionPolicy Bypass -File "$HOME\.gemini\antigravity\skills\notebooklm-sdd\scripts\concat.ps1"
```

## Restricciones y Guía
Ámbito: Global. Esta skill debe estar disponible para todos los proyectos abiertos en Antigravity

## Permisos
Se requiere acceso a la terminal y ejecución de scripts de PowerShell

## Contrato de salida
Al finalizar, muestrame el path del directorio del archivo que has generado y el nombre del archivo, y la lista de archivos que has compilado