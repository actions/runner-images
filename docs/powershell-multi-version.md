# Multiple PowerShell Versions Support

This document describes the multi-version PowerShell support feature in GitHub Actions runner images.

## Overview

Runner images now include multiple PowerShell versions installed side-by-side, allowing workflows to specify which version channel to use:

- **stable** - The latest stable release of PowerShell
- **lts** - The Long-Term Support (LTS) version
- **preview** - The latest preview release

## Installed Versions

Each version is installed to a separate directory and available through channel-specific binaries:

| Channel | Binary | Description |
|---------|--------|-------------|
| stable | `pwsh-stable` | Latest stable PowerShell release |
| lts | `pwsh-lts` | Long-Term Support version |
| preview | `pwsh-preview` | Latest preview build |
| default | `pwsh` | Points to the default channel (stable) |

## Using Different Versions

### Direct Invocation

Call the specific version binary directly:

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Run with stable
        run: pwsh-stable -Command "Write-Host 'Using stable PowerShell'; $PSVersionTable"

      - name: Run with LTS
        run: pwsh-lts -Command "Write-Host 'Using LTS PowerShell'; $PSVersionTable"

      - name: Run with preview
        run: pwsh-preview -Command "Write-Host 'Using preview PowerShell'; $PSVersionTable"
```

### Using pwsh-select Helper

The `pwsh-select` utility allows switching the default `pwsh` command between versions:

```bash
# List installed versions
pwsh-select list

# Switch to LTS version
pwsh-select lts

# Switch to preview version
pwsh-select preview

# Switch back to stable
pwsh-select stable
```

Example workflow using `pwsh-select`:

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Switch to LTS PowerShell
        run: |
          sudo pwsh-select lts
          pwsh --version

      - name: Run PowerShell script
        shell: pwsh
        run: |
          Write-Host "Running on PowerShell $($PSVersionTable.PSVersion)"
```

### Specifying Shell with Full Path

For Windows runners, you can use full paths:

```yaml
jobs:
  test:
    runs-on: windows-latest
    steps:
      - name: Run with preview PowerShell
        shell: C:\Program Files\PowerShell\pwsh-preview\pwsh.exe {0}
        run: |
          Write-Host "Running PowerShell Preview"
          $PSVersionTable
```

## Platform-Specific Paths

### Linux/macOS

- Installation directory: `/opt/microsoft/powershell/`
- Binaries: `/usr/local/bin/pwsh`, `/usr/local/bin/pwsh-stable`, `/usr/local/bin/pwsh-lts`, `/usr/local/bin/pwsh-preview`

### Windows

- Installation directory: `C:\Program Files\PowerShell\`
- Channel directories: `pwsh-stable`, `pwsh-lts`, `pwsh-preview`
- Default link: `C:\Program Files\PowerShell\7\`

## Version Configuration

The versions installed are configured in the toolset JSON files:

```json
{
    "pwsh": {
        "versions": {
            "stable": "7.5",
            "lts": "7.4",
            "preview": "7.6"
        },
        "default": "stable"
    }
}
```

## Related Issues

This feature addresses the request in [#13569](https://github.com/actions/runner-images/issues/13569) for specifying PowerShell versions in workflows.

> **Note:** The workflow YAML syntax changes (`version: preview`, `version: lts`, etc.) would need to be implemented in the [actions/runner](https://github.com/actions/runner) repository. This runner-images enhancement provides the infrastructure for multiple versions while that enhancement is developed.
