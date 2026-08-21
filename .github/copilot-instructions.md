# GitHub Copilot Instructions for Actions Runner Images Repository

## Scope and goals

- This repository serves as the source for building GitHub Actions runner and Azure DevOps agent images for Windows, Ubuntu, and macOS. You can find exact versions in the [Available Images](../README.md#available-images) section of README.md. Windows and Ubuntu images build on Azure infrastructure using Packer; macOS images use Anka virtualization.
- Emphasize best practices for contributing to open-source projects, including code style, commit messages, and pull request etiquette.
- Prefer clarity and correctness over creativity. If information is missing, ask clarifying questions or insert TODOs instead of guessing.

## Architecture overview

- **What this repo builds:** the source used to generate the VM images for [GitHub-hosted runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners) (Actions) and Microsoft-hosted agents (Azure Pipelines). See [README.md](../README.md#about).
- **Platforms and labels:** Ubuntu, Windows, and macOS across multiple versions and architectures (x64/arm64). See [Available Images](../README.md#available-images) for the supported YAML labels.
- **Build systems:**
  - Windows and Ubuntu images are built with [Packer](https://www.packer.io/) (HCL2 templates) on **Azure**.
  - macOS images are also Packer (HCL2), but use the **Anka** builder (`*.anka.pkr.hcl`) for virtualization instead of Azure; macOS CI does not accept external contributions yet (see [CONTRIBUTING.md](../CONTRIBUTING.md#macos)).
- **Build flow:** a Packer template provisions a temporary Azure VM, runs install scripts in order, runs validation tests, captures a managed image, then generates the image's software report. A failed step aborts the build and cleans up resources. Details: [docs/create-image-and-azure-resources.md](../docs/create-image-and-azure-resources.md).

## Repository map

| Path | What lives here |
| --- | --- |
| `images/<os>/` | Per-image sources, where `<os>` is a Packer-built VM image: `ubuntu`, `windows`, or `macos`. (`ubuntu-slim` is Docker-based with a different layout — see its own row.) |
| `images/<os>/templates/` | Packer (HCL2) templates. |
| `images/<os>/toolsets/toolset-*.json` | Declarative tool/version pinning (validated by `schemas/toolset-schema.json`). |
| `images/<os>/scripts/build/` | Install scripts that run during image generation. |
| `images/<os>/scripts/tests/` | [Pester v5](https://github.com/pester/pester) validation scripts (`*.Tests.ps1`). |
| `images/<os>/scripts/helpers/` | Shared install/validation helpers (e.g. Ubuntu `install.sh`, Windows `ImageHelpers.psm1`). |
| `images/<os>/scripts/docs-gen/Generate-SoftwareReport.ps1` | Generates the image's `*-Readme.md` software list. |
| `images/ubuntu-slim/` | Docker-based slim image: `Dockerfile`, `test.sh`, and `generate-software-report.sh`, plus `scripts/build`, `scripts/helpers`, and `toolsets/` (no Packer template or Pester `scripts/tests`). |
| `helpers/` | Repo-level orchestration scripts (e.g. `GenerateResourcesAndImage.ps1`). |
| `docs/` | Build and topic docs (start with `create-image-and-azure-resources.md`). |
| `schemas/` | JSON schema for toolset files. |
| `.github/workflows/` | CI: per-image builds, linting, tests, and schema/version checks. |
| `.vscode/` | Recommended extensions and editor settings for contributors. |

## Key workflows

- **Adding or updating a tool** (the most common change) requires, together:
  1. an install script in `images/<os>/scripts/build/` (reuse existing helpers),
  2. a Pester validation test in `images/<os>/scripts/tests/`, registered from the install script — `invoke_tests "<TestFile>" "<TestName>"` in Bash scripts (Ubuntu/macOS) or `Invoke-PesterTests -TestFile "<name>"` in PowerShell scripts (Windows),
  3. an update to `images/<os>/scripts/docs-gen/Generate-SoftwareReport.ps1`, and
  4. version entries in the relevant `toolsets/toolset-*.json` when the tool is versioned.

  Open an issue and get approval before adding a new tool. Full guide: [CONTRIBUTING.md](../CONTRIBUTING.md#adding-a-new-tool-to-an-image).
- **Building or testing an image:** follow [docs/create-image-and-azure-resources.md](../docs/create-image-and-azure-resources.md); validation runs through Pester.
- **CI:** workflows in `.github/workflows/` (per-image builds, `linter.yml`, `powershell-tests.yml`, `check-pinned-versions.yml`, `validate-json-schema.yml`).
- **Submitting changes:** fork, branch, make the change, validate, then open a focused pull request. See [CONTRIBUTING.md](../CONTRIBUTING.md#submitting-a-pull-request) and `.github/pull_request_template.md`.
- **Good practices from real contributions:** keep install scripts thin and reuse existing helpers instead of re-implementing version resolution or download logic; prefer surgical compatibility fixes over broader runtime changes; register validation tests from the install script so the build proves the change on a real VM; fail fast when versions or assets cannot be resolved; and only add software-report or toolset entries when they are truly applicable to the tool's packaging and versioning model.

## Onboarding new contributors

- For a guided, interactive introduction to this repository, use the **`onboarding` skill** (`.github/skills/onboarding/`). Trigger it with phrases like "Start onboarding", "give me a tour", or "help me get started".
- The skill walks newcomers through the architecture, repository map, and the add-a-tool workflow step by step (pausing for checkpoints), and also supports free exploration.

## Code and command instructions

- Follow the code style guide in [CONTRIBUTING.md](../CONTRIBUTING.md#code-style-guide) for Bash and PowerShell scripts, including naming conventions, file structure, and indentation rules.
- Focus on re-using helpers when writing scripts. Windows, Linux and Ubuntu scripts have helper functions available to simplify installation and validation.
- Keep tests simple, non-mutating, and aligned with the real install behavior; they should verify the tool works on the VM instead of asserting on mocks or synthetic state.
- Always confirm versions and installation paths against existing toolset files and installation scripts.
- When a change is non-obvious, leave a short comment or link to the issue explaining the compatibility rationale, especially for temporary pins or platform-specific workarounds.

## Output format

- Use GitHub Flavored Markdown only. Avoid raw HTML unless necessary.
- One H1 (`#`) per page, followed by logical, sequential headings (`##`, `###`, …).
- Use fenced code blocks with language identifiers (` ```bash `, ` ```json `, ` ```yaml `, etc.).
- Use blockquote callouts for notes:
  > [!NOTE] Context or nuance  
  > [!TIP] Helpful hint  
  > [!WARNING] Risks or breaking changes  
  > [!IMPORTANT] Critical requirement for functionality

## Style and tone

- Audience: Open-source contributors, GitHub Actions maintainers, and developers building custom runner images. Assume familiarity with CI/CD concepts, Packer, and basic infrastructure provisioning, but explain platform-specific details (Azure for Windows/Ubuntu, Anka for macOS) when relevant.
- Voice: Second person ("you"), active voice, imperative for operational steps.
- Be concise: short paragraphs and sentences. Prefer lists and step-by-steps, especially for operational procedures and troubleshooting.
- Use inclusive, accessible language. Avoid idioms, sarcasm, and culturally specific references.
- English: en-US (spelling, punctuation, and units).

## Safety and integrity

- Do not expose sensitive credentials (API tokens, Azure subscription IDs, etc.) in code examples.
- Do not fabricate tool versions, installation paths, or software availability without verifying against toolset files or actual installation scripts.
- Always call out assumptions and limitations explicitly, especially for changes affecting runner image behavior or software availability.
- If ambiguous requests are made about image modifications, ask clarifying questions about target OS, tool versions, and compatibility requirements before proceeding.
