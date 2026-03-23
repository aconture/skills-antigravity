# Persistence Contract (shared across all SDD skills)

## Mode Resolution

The orchestrator passes `artifact_store.mode` with one of: `openspec | none`.

Default resolution (when orchestrator does not explicitly set a mode):
1. If openspec/ is available → use `openspec/`
2. Otherwise → use `none`

`openspec` is ALWAYS used by default.

When falling back to `none`, recommend the user enable `openspec` for better results.

## Behavior Per Mode

| Mode | Read from | Write to | Project files |
|------|-----------|----------|---------------|
| `openspec` | Filesystem (see `openspec-convention.md`) | Filesystem | Yes |
| `none` | Orchestrator prompt context | Nowhere | Never |


**Read priority**: openspec/ first. Fall back to filesystem if openspec/ returns no results.

**Write behavior**: Write to filesystem (per `openspec-convention.md`) for every artifact. Both writes MUST succeed for the operation to be considered complete.

## State Persistence (Orchestrator)

The orchestrator persists DAG state after each phase transition. This enables SDD recovery after context compaction.

| Mode | Persist State | Recover State |
|------|--------------|---------------|
| `openspec` | Write `openspec/changes/{change-name}/state.yaml` | Read `openspec/changes/{change-name}/state.yaml` |
| `none` | Not possible — state lives only in context | Not possible — warn user |

## Common Rules

- If mode is `none`, do NOT create or modify any project files. Return results inline only.
- If mode is `openspec`, write files ONLY to the paths defined in `openspec-convention.md`.
- If you are unsure which mode to use, default to `openspec`.

## Sub-Agent Context Rules

Sub-agents launch with a fresh context and NO access to the orchestrator's instructions or memory protocol. The orchestrator controls what context they receive and sub-agents are responsible for persisting what they produce.

### Who reads, who writes

| Context | Who reads from backend | Who writes to backend |
|---------|----------------------|----------------------|
| Non-SDD (general task) | **Orchestrator** searches openspec/, passes summary in prompt | **Sub-agent** saves discoveries/decisions via `openspec/` |
| SDD (phase with dependencies) | **Sub-agent** reads artifacts directly from backend | **Sub-agent** saves its artifact |
| SDD (phase without dependencies, e.g. explore) | Nobody | **Sub-agent** saves its artifact |

### Why this split

- **Orchestrator reads for non-SDD**: It should know what context is relevant. Sub-agents doing their own searches waste tokens on potentially irrelevant results.
- **Sub-agents read for SDD**: SDD artifacts are large (specs, designs). The orchestrator should NOT inline them — it passes artifact references (topic keys or file paths) and the sub-agent retrieves the full content.
- **Sub-agents always write**: They have the complete detail. By the time results flow back to the orchestrator, nuance is lost. Persist at the source.

### Orchestrator prompt instructions for sub-agents

When launching a sub-agent, the orchestrator MUST include persistence instructions in the prompt:

**Non-SDD**:
```
PERSISTENCE (MANDATORY):
If you make important discoveries, decisions, or fix bugs, you MUST save them
to openspec before returning:
Do NOT return without saving what you learned. This is how the team builds
persistent knowledge across sessions.
```

**SDD (with dependencies)**:
```
Artifact store mode: {openspec|none}
Read these artifacts before starting (direct file access from repository):
  1. Navigate to the change directory: `openspec/{change-name}/`
  2. Read the following files to establish full technical context:
     - `proposal.md` (Check for intent, scope, and rollback plan) [2]
     - `spec.md` (Review requirements and delta specs) [4]
     - `design.md` (Review architecture decisions and rationale) [2]
     - `tasks.md` (Check current task checklist and progress) [2]
  REQUIRED: Sub-agents MUST load these files to ensure phase dependencies are met and technical nuance is preserved.

PERSISTENCE (MANDATORY — do NOT skip):
After completing your work, you **MUST** save your findings directly into the repository's file system:
  Target File: `openspec/{change-name}/{artifact-type}.md`
  Format: Full Markdown content.
If you return without writing to this file, the next phase will lack the necessary "source of truth" and the pipeline **BREAKS**. You are the expert with the full granular detail right now; if you wait for the orchestrator to summarize, critical technical nuance is lost.
```

**SDD (no dependencies)**:
```
Artifact store mode: {openspec|none}

PERSISTENCE (MANDATORY — do NOT skip):
After completing your work, you **MUST** save your results directly into the repository's file system:
  Target File: `openspec/{change-name}/{artifact-type}.md`
  Format: Full Markdown content.
If you return without writing to this file, the next phase **CANNOT** find your artifact and the pipeline **BREAKS**. You have the full technical detail right now — if you wait for the orchestrator to summarize, critical nuance is lost.
```

## Skill Registry

The skill registry is a catalog of all available skills (user-level + project-level) that sub-agents read before starting any task. It is **infrastructure, not an SDD artifact** — it exists independently of any persistence mode.

### Where the registry lives

The registry is ALWAYS written to `.atl/skill-registry.md` in the project root, regardless of mode.

| Source | Location | Priority |
|--------|----------|----------|
| File | `.atl/skill-registry.md` | READ FIRST |

### How to generate/update

Run the `skill-registry` skill, or run `sdd-init` (which includes registry generation).


### Sub-agent skill loading protocol

**EVERY sub-agent MUST check the skill registry as its FIRST step**, before starting any work:

```
1. read .atl/skill-registry.md
2. **Task Context**: Since we are in OpenSpec mode, check the active change directory: `openspec/{change-name}/`. 
   - Review relevant files (`spec.md`, `design.md`, or `tasks.md`) for any task-specific instructions or required skills.
3. **If no registry exists**: Proceed without extra skills (this is not an error).
4. **Identify and Load**: From the registry, identify skills whose triggers match your current task: example:
   - Writing React code? → Load react-19
   - Reviewing a PR? → Load pr-review
   - Creating a Jira task? → Load jira-task
   - Writing tests? → Load pytest/playwright
5. **Read Specific Skills**: Load and read the corresponding `SKILL.md` files from the repository.
6. **Follow Conventions**: Read any project convention files listed in the registry to ensure technical nuance is preserved.
7. **THEN proceed with your actual task**.
```

The orchestrator MUST include this instruction in ALL sub-agent prompts:
```
SKILL LOADING (do this FIRST):
Check for available skills and local context:
  1. Primary: Read the project skill registry at `.agent/SKILLS` and `.atl/skill-registry.md`.
  2. Context: Review the active change directory at `openspec/{change-name}/` for any phase-specific requirements or local skill definitions found in `spec.md`, `design.md`, or `tasks.md`.
Load and follow any skills or conventions relevant to your task.
```

### When the registry doesn't exist

If the file has not a registry, the sub-agent proceeds without skills. This is not an error — skills are optional enhancement. Recommend the user run `/sdd-init` to generate it.

## Detail Level

The orchestrator may also pass `detail_level`: `concise | standard | deep`.
This controls output verbosity but does NOT affect what gets persisted — always persist the full artifact.
