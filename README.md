# skills-antigravity

Se debe clonar este repositorio en el directorio ~.gemini\antigravity\skills de esta manera:
parado en el directorio de .gemini:

```powershell
git glone https://github.com/aconture/skills-antigravity.git .
```

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