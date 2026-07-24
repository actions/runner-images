---
name: onboarding
description: 'Interactive, guided onboarding for the actions/runner-images repository. Use when a user wants to start onboarding, onboard, ramp up, get started, take a repo tour, learn the codebase or architecture, understand how runner images are built, or explore the project step by step. Trigger phrases: "Start onboarding", "onboard me", "give me a tour", "help me get started", "explain this repo", "where do I begin".'
argument-hint: '[optional: a topic to jump to, e.g. "build system" or "adding a tool"]'
---

# Onboarding: actions/runner-images

Guide a newcomer through this repository interactively. You (the agent) act as a mentor:
explain one step at a time, point to **real files in this repo**, pause for a checkpoint
question, and only continue when the user is ready. Support both a structured path and
free-form exploration.

> [!IMPORTANT]
> Treat `.github/copilot-instructions.md` (the repository "brain") as your source of truth
> for architecture, the repository map, and key workflows. Link to it and to `README.md`,
> `CONTRIBUTING.md`, and `docs/` instead of inventing details. Never fabricate tool versions
> or paths — open the actual file to confirm.

## When to Use

- The user says "Start onboarding" (or similar) and wants a guided introduction.
- A new contributor wants to learn what the repo does and how to make a change.
- Someone wants a tour of the architecture, folder structure, or build system.
- The user wants free exploration ("just let me ask questions about the repo").

## How This Works

This is a conversation, not a lecture. Follow these rules throughout:

1. **One step at a time.** Present a single stage, then stop and ask the checkpoint question.
   Wait for the user before moving on.
2. **Show, don't tell.** Prefer opening real files (`view`, `grep`) over generic prose.
   Reference exact paths so the user can follow along.
3. **Adapt to the user.** Early on, learn their goal and tailor depth and ordering.
4. **Let them steer.** They can jump to any stage, skip ahead, go back, or switch to free
   exploration at any time. Offer the menu whenever they seem unsure.
5. **Keep it light.** Short paragraphs, lists, and concrete next actions. No walls of text.

## Step 0 — Kickoff

Start by greeting the user and explaining that this is an interactive, step-by-step guide.
Then ask one question to learn their goal:

> What best describes your goal today?
>
> 1. Contribute a change (add or update a tool on an image)
> 2. Understand the architecture and build system
> 3. Build a custom image for my own use
> 4. Just explore — I'll ask questions (free exploration)
> 5. Follow a resolved issue and its merged PR from GitHub (real-world examples)

Use the answer to choose ordering and depth, then share the full onboarding path below so they know
what's coming and can jump around. Begin at Step 1 unless they ask for a specific stage:

1. What this repository is
2. The build system (the big picture)
3. Repository map (where everything lives)
4. How an image is defined
5. The core workflow: adding or updating a tool
6. Code style and conventions
7. Validation and CI
8. Submitting your change
9. Hands-on: trace a tool end to end
10. Where to get help + wrap-up

> **Checkpoint:** "Which goal fits best, and shall I start with Step 1 or jump somewhere specific?"

## Step 1 — What this repository is

Explain in your own words, then point to the source:

- This repo holds the **source used to build the VM images** for GitHub-hosted runners
  (Actions) and Microsoft-hosted agents (Azure Pipelines).
- Images exist for **Ubuntu**, **Windows**, and **macOS**, across several versions and
  architectures (x64/arm64).
- Open `README.md` -> **About** and **Available Images** to show the supported labels
  (e.g. `ubuntu-latest`, `windows-2025`, `macos-15`).

> **Checkpoint:** "Does the purpose make sense? Want to see the full image list, or move on to
> how these images are actually built?"

## Step 2 — The build system (the big picture)

Give the big picture before details:

- **Windows and Ubuntu** images are built with **Packer** (HCL2 templates) on **Azure**.
- **macOS** images are also built with **Packer**, but use the **Anka** builder (`*.anka.pkr.hcl`)
  for virtualization instead of Azure (and macOS CI does not yet accept external contributions —
  see `CONTRIBUTING.md`).
- The flow: a Packer template provisions a temporary Azure VM -> runs **install scripts** one by
  one -> runs **validation tests** -> captures a **managed image** -> generates the image's
  software **README**. If any step fails, the build aborts and resources are cleaned up.
- Read the top of `docs/create-image-and-azure-resources.md` for the authoritative description.

> **Checkpoint:** "Clear on the Packer -> Azure -> image flow? Ready to see where each piece lives
> in the repo?"

## Step 3 — Repository map (where everything lives)

Walk the key directories from the brain (`.github/copilot-instructions.md` -> Repository map).
Open folders as you go so the structure feels real:

- `images/<os>/` contains the files that define each image. `ubuntu`, `windows`, and `macos`
  are Packer-based images. `ubuntu-slim` is a Docker-based image with a `Dockerfile` and tests.
- `helpers/` has repo-level orchestration scripts (for example `GenerateResourcesAndImage.ps1`).
- `docs/` contains build and topic documentation.
- `schemas/` holds JSON schemas, such as the toolset schema.
- `.github/workflows/` contains CI workflows (per-image builds, linting, tests, schema/version checks).
- `.vscode/` suggests editor extensions and settings.

> **Checkpoint:** Want me to open one image folder and show how it is organized?

## Step 4 — How an image is defined

Choose a platform (Ubuntu is easiest for new contributors). Look inside `images/ubuntu/`:

- `templates/` — the Packer (HCL2) template wiring the build together.
- `toolsets/toolset-*.json` — declarative **version pinning** for tools (validated by
  `schemas/toolset-schema.json`).
- `scripts/build/` — the **install scripts** that run on the VM (e.g. open a small one like
  `images/ubuntu/scripts/build/install-github-cli.sh`).
- `scripts/tests/` — **Pester v5** tests (`*.Tests.ps1`) that verify a tool was installed
  correctly.
- `scripts/helpers/` — shared helpers (Ubuntu: `install.sh`, `os.sh`, `etc-environment.sh`;
  Windows: `ImageHelpers.psm1`, `InstallHelpers.ps1`, ...).
- `scripts/docs-gen/Generate-SoftwareReport.ps1` — generates the image's `*-Readme.md`
  software list.

> **Checkpoint:** "Shall we follow one real tool through build -> test -> report, or first cover the
> standard workflow for adding a tool?"

## Step 5 — The core workflow: adding or updating a tool

This is the most common contribution. A tool change usually needs an install path and a validation
path, and the remaining pieces depend on how the tool is packaged and versioned. Summarize, then
link `CONTRIBUTING.md` -> **Adding a new tool to an image**:

1. **Install script** in `images/<os>/scripts/build/` — keep it thin, reuse helpers, and avoid
   re-implementing downloads or version resolution when an existing helper already handles it.
2. **Validation test** in `images/<os>/scripts/tests/` — Pester `*.Tests.ps1`; keep it simple,
   non-mutating, and aligned with the real install behavior. Register it at the end of the install
   script: `invoke_tests "<TestFile>" "<TestName>"` in Bash scripts (Ubuntu/macOS), or
   `Invoke-PesterTests -TestFile "<name>" [-TestName "<name>"]` in PowerShell scripts (Windows).
3. **Software report** — update `images/<os>/scripts/docs-gen/Generate-SoftwareReport.ps1` only when
   the tool is user-facing in the generated README. Tool-cache/action-consumed tools may not need a
   software report entry.
4. **Versioning** — if the tool is statically pinned, add the version in the relevant
   `toolsets/toolset-*.json`; if the version is resolved dynamically at build time (for example via
   a compatibility matrix), do not invent a toolset entry just to mirror the install logic.

Platform notes:

- Windows usually uses Chocolatey and module helpers like `ImageHelpers`.
- Ubuntu uses APT, pipx, and shared `install.sh` helpers.
- macOS uses Homebrew. Note that macOS builds may not accept external PRs.

Local conventions and good practices:

- Prefer small, compatibility-safe changes over broad runtime changes.
- If a version or download fails, stop and return an error (fail fast) instead of silently shipping a bad build.
- Check downloads with checksums when available.
- Keep tests aligned with what the install script changes.
- Ensure your install script is included and ordered correctly in the Packer template.

Tip: remind the user to open an issue and get approval **before** adding a new tool, and to check
it against the **Preinstallation Policy** in `README.md`.

> **Checkpoint:** "Want to see a concrete example of these three pieces for an existing tool?"

## Step 6 — Code style and conventions

Point to `CONTRIBUTING.md` -> **Code style guide** and highlight what matters most:

- **Bash:** `#!/bin/bash -e`, standard file header, 4-space indents, lowercase vars / UPPER
  constants, `[[ ]]`, `$()`, long options, reuse helpers.
- **PowerShell:** standard header, `Verb-Noun` PascalCase functions, 4-space indents, OTBS braces,
  no aliases, verify exit codes.
- **Editor setup:** `.vscode/extensions.json` recommends ShellCheck, PowerShell, markdownlint,
  Code Spell Checker, HCL — suggest installing them.

> **Checkpoint:** "Comfortable with the style rules, or want examples from a real script?"

## Step 7 — Validation and CI

Show how changes are verified, opening `.github/workflows/`:

- **Per-image build** workflows (e.g. `ubuntu2404.yml`, `windows2025.yml`).
- **`linter.yml`** and **`powershell-tests.yml`** — linting and PS module tests.
- **`check-pinned-versions.yml`** and **`validate-json-schema.yml`** — toolset hygiene.
- Locally, validation runs through **Pester**, invoked via `invoke_tests` (Bash, Ubuntu/macOS) or
  `Invoke-PesterTests` (PowerShell, Windows). The most useful tests are the ones that exercise the
  real install behavior on the VM and fail loudly when the tool is missing or broken.

> **Checkpoint:** "Want to peek at one workflow file, or move on to how changes get submitted?"

## Step 8 — Follow a resolved issue and merged PR (optional path)

If the user selected option 5, switch to a GitHub-backed walkthrough using real repository history.
Only use this path for resolved issues that have a linked or clearly associated merged PR.
Do not invent or speculate about tickets; pull them from GitHub and ground the explanation in the
actual issue body, labels, timeline, and PR diff.

Use this pattern:

1. Find a resolved issue in this repository that matches a real contribution pattern (bug fix,
   compatibility change, or new tool).
2. Pull the linked merged PR and inspect the diff, touched files, and validation notes.
3. Walk through the report -> root cause -> fix -> validation flow using the actual files in the
   repo.
4. Connect the ticket back to the repo conventions already covered: helper reuse, tests, build
   registration, and docs/toolset updates when relevant.

> **Checkpoint:** "Would you like to see one resolved issue and its merged PR now, or return to the
> standard onboarding path?"

## Step 9 — Submitting your change

Summarize `CONTRIBUTING.md` -> **Submitting a pull request** and `.github/pull_request_template.md`:

1. (New tool) Open an issue and get approval first.
2. Fork, branch, make the change (install + test + software report).
3. Validate by building/testing the image.
4. Open a focused PR with a clear description; follow PR etiquette.

> **Checkpoint:** "Ready to try a small hands-on exercise to make this concrete?"

## Step 10 — Hands-on: trace a tool end to end

Offer to do this together. Pick a tool the user names (or suggest one), then use `grep`/`view` to
show its real pieces:

1. Find the **install script** in `images/<os>/scripts/build/`.
2. Find its **Pester test** in `images/<os>/scripts/tests/`.
3. Find its entry in **`Generate-SoftwareReport.ps1`**.
4. If versioned, find it in a **`toolset-*.json`**.

This connects Steps 4-5 to real code and gives the user a repeatable investigation pattern.

> **Checkpoint:** "Which tool should we trace? (e.g. Node.js, Go, the GitHub CLI)"

## Step 11 — Where to get help + wrap-up

- **Issues / tool requests:** use the templates under `.github/ISSUE_TEMPLATE/`.
- **Discussions and questions:** see `README.md` -> **How to Interact with the Repo**.
- Recap what was covered, confirm the user's next step, and remind them they can re-run this skill
  or switch to free exploration anytime.

> **Checkpoint:** "Anything you'd like to revisit, or a specific area to go deeper on?"

## Free Exploration Mode

If the user just wants to ask questions (Step 0 option 4, or any time they ask):

- Answer using the **brain** (`.github/copilot-instructions.md`), `README.md`, `CONTRIBUTING.md`,
  `docs/`, and the actual files — open them with `grep`/`view` to ground every answer.
- After answering, suggest 2-3 related threads they might explore next.
- Offer to drop back into the guided path at any relevant stage.

## Facilitation Checklist (for the agent)

- Ask the Step 0 goal question before diving in; tailor ordering and depth to the answer.
- Present exactly one stage per turn and end with a checkpoint question.
- Open real files in this repo rather than describing them abstractly.
- Confirm understanding before advancing; let the user jump, skip, or revisit freely.
- Keep responses short and scannable; avoid dumping multiple stages at once.
- Defer to the brain and docs for specifics; verify paths and versions before stating them.
