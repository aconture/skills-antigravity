---
name: thisProject-changelog
description: >
  Manages changelog entries for thisProject components following keepachangelog.com format.
  Trigger: When creating, modifying, deleting features, or solving fixes.
license: Apache-2.0
metadata:
  author: AGCC
  version: "1.0"
  auto_invoke:
    - "Add changelog entry for a feature"
    - "Update CHANGELOG.txt"
    - "Review changelog format and conventions"
allowed-tools: Read, Edit, Write, Glob, Grep, Bash
---

## Changelog Locations
There is one only CHANGELOG.txt, located at the root of the project.

## Format Rules (keepachangelog.com)

### Section Order (ALWAYS this order)

```markdown
## [X.Y.Z] ({thisProject} vA.B.C) OR ({thisProject} UNRELEASED)

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security
```

### Emoji Prefixes (REQUIRED for ALL components)

| Section | Emoji | Usage |
|---------|-------|-------|
| Added | `### 🚀 Added` | New features, checks, endpoints |
| Changed | `### 🔄 Changed` | Modifications to existing functionality |
| Deprecated | `### ⚠️ Deprecated` | Features marked for removal |
| Removed | `### ❌ Removed` | Deleted features |
| Fixed | `### 🐞 Fixed` | Bug fixes |
| Security | `### 🔐 Security` | Security patches, CVE fixes |

### Entry Format

```markdown

**Rules:**
- **ADD NEW ENTRIES AT THE TOP of each section** (before next section header or `---`)
- **Blank line after section header** before first entry
- **Blank line between sections**
- Be specific: what changed, not why (that's in the PR)
- No period at the end
- Do NOT start with redundant verbs (section header already provides the action)
- **CRITICAL: Preserve section order** — when adding a new section to the UNRELEASED block, insert it in the correct position relative to existing sections (Added → Changed → Deprecated → Removed → Fixed → Security). Never append a new section at the top or bottom without checking order
- no debe exceder las 2 líneas
- debe incluir las nuevas funciones, modificaciones o fix 
- deben ser legibles por el usuario, con una descripción simple.


### Semantic Versioning Rules

thisProject follows [semver.org](https://semver.org/):

| Change Type | Version Bump | Example |
|-------------|--------------|---------|
| Bug fixes, patches | PATCH (x.y.**Z**) | 1.16.1 → 1.16.2 |
| New features (backwards compatible) | MINOR (x.**Y**.0) | 1.16.2 → 1.17.0 |
| Breaking changes, removals | MAJOR (**X**.0.0) | 1.17.0 → 2.0.0 |

**CRITICAL:** `### ❌ Removed` entries MUST only appear in MAJOR version releases. Removing features is a breaking change.

### Released Versions Are Immutable

**NEVER modify already released versions.** Once a version is released (has a Prowler version tag like `v5.16.0`), its changelog section is frozen.



## Adding a Changelog Entry

### Step 1: Determine Affected Component(s)

### Step 2: Determine Change Type

| Change | Section |
|--------|---------|
| New feature, check, endpoint | 🚀 Added |
| Behavior change, refactor | 🔄 Changed |
| Bug fix | 🐞 Fixed |
| CVE patch, security improvement | 🔐 Security |
| Feature removal | ❌ Removed |
| Deprecation notice | ⚠️ Deprecated |

### Step 3: Add Entry at TOP of Appropriate Section

**CRITICAL:** Add new entries at the TOP of each section, NOT at the bottom.


## Examples

### Good Entries

```markdown
### 🚀 Added
- Search bar when adding a provider

### 🐞 Fixed
- OCI update credentials form failing silently due to missing provider

### 🔐 Security
- Node.js from 20.x to 24.13.0 LTS, patching 8 CVEs
```

### Bad Entries

```markdown
# BAD - Wrong section order (Fixed before Added)
### 🐞 Fixed
- Some bug fix

### 🚀 Added
- Some new feature
- Fixed bug.                              # Too vague, has period
- Added new feature for users             # Missing PR link, redundant verb
- Add search bar [(#123)]                 # Redundant verb (section already says "Added")
- This PR adds a cool new thing (#123)    # Wrong link format, conversational
```

## Migration Note
- Si se encuentra un archivo Changelog.txt en el root, incorporarlo al nuevo CHANGELOG.txt con los lineamientos de este SKILL.md


## Resources

- **Templates**: See [assets/](assets/) for entry templates
- **keepachangelog.com**: https://keepachangelog.com/en/1.1.0/