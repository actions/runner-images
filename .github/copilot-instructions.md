# GitHub Copilot Instructions for Actions Runner Images Repository

## Scope and goals

- This repository serves as the source for building GitHub Actions runner and Azure DevOps agent images for Windows, Ubuntu, and macOS. You can find exact versions in the [README.md](../README.md#available-images) available images section. Windows and Ubuntu images build on Azure infrastructure using Packer; macOS images use Anka virtualization.
- Emphasize best practices for contributing to open-source projects, including code style, commit messages, and pull request etiquette.
- Prefer clarity and correctness over creativity. If information is missing, ask clarifying questions or insert TODOs instead of guessing.

## Code and command instructions

- Focus on following the style guide for [Powershell](https://github.com/PoshCode/PowerShellPracticeAndStyle) when writing Windows scripts. For shell scripts on Linux and macOS, maintain consistency with existing scripts.
- Focus on re-using helpers when writing scripts. Windows, Linux and Ubuntu scripts have helper functions available to simplify installation and validation.
- Always confirm versions and installations paths against existing toolset files and installation scripts.
- Refer to [Contributing.md](../CONTRIBUTING.md) for extended guidelines on contributing to this repository.

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
