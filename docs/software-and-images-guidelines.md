# Software and image guidelines

## Software preinstallation policy
In general, these are the guidelines we consider when deciding what to pre-install:

- Tools and ecosystems that are broadly popular and widely-used will be given priority.
- Recent versions of tools will be given priority over older versions.
- Tools and versions that are deprecated or have reached end-of-life will not be added.
- If a tool can be installed during the build, we will evaluate how much time is saved
 and how much space is used by having the tool pre-installed.
- MIT, Apache, and GNU licenses are ok, anything else we'll have to check with lawyers.
- If a tool takes much space we will evaluate space usage and provide a decision if this tool can be pre-installed.
- If a tool requires the support of more than one version, we will consider the cost of this maintenance, how often new versions bring dangerous updates.

**Note:** For new tools, please, create an issue and get an approval from us to add this tool to the image before creating the pull request.

## Software and images support policy
These are the guidelines we follow in software and images supporting routine:
- Tools and versions will typically be removed 6 months after they are deprecated or have reached end-of-life.
- We support at least 2 latest OS versions (LTS only for Ubuntu) and initiate deprecation process for the oldest one when image usage drops below 5%.
- Most of the tools are preinstalled in the latest version only.
- Popular tools can have several versions installed side-by-side with the following strategy:

| Tool name | Installation strategy |
|-----------|-----------------------|
| Java      | all LTS versions |
| Node.js   | 3 latest LTS versions |
| Go        | 3 latest minor versions     |
| Python <br/> Ruby | 5 most popular `major.minor` versions |
| PyPy      | 3 most popular `major.minor` versions |
| .NET Core | 2 latest LTS versions and 1 latest version. For each feature version only latest patch is installed |
| GCC <br/> GNU Fortran <br/> Clang <br/> GNU C++ | 3 latest major versions |
| Android NDK | 1 latest, 1 LTS version |
| Xcode     | all OS compatible versions, latest beta for each new version |

## Software default versions update policy for tools with multiple versions installed
In general, once a new version is installed on the image, we announce the default version update 2 weeks prior to deploying it to give time to adapt to upcoming changes. For potentially dangerous updates, we can extend the timeline up to 1 month between the announcement and deployment.