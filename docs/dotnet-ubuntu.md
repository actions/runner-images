# Ubuntu .NET Core Versions

.NET has changed the recommended install methods for Ubuntu from 2404.

This document gives an overview of these change and the impact this has on the `runner-images`.

## .NET Core for Ubuntu 2004 and 2204

2004 and 2204 use the [Microsoft Package repository](https://learn.microsoft.com/en-us/dotnet/core/install/linux-ubuntu-install?tabs=dotnet8&pivots=os-linux-ubuntu-2004) to install .NET deb files built and published by the .NET team.

## .NET Core Versions from Ubuntu 2404

The .NET Core team have worked with Canonical and Ubuntu now provides its own .NET packages.

These are the recommended install path and, as-such what is installed on the image.

> The release of Ubuntu 24.04 is just around the corner. Canonical-produced .NET 6, 7, and 8 packages will be available on day one, for "Noble Numbat". Microsoft will not be publishing .NET packages to the 24.04 feed at packages.microsoft.com.

You can read the [full announcement from .NET team here](https://github.com/dotnet/core/discussions/9258). We'll briefly summarize how this change may impact users of the image.

### [`Feature Bands`](https://learn.microsoft.com/dotnet/core/porting/versioning-sdk-msbuild-vs)

Going forward only the `1xx` feature band will be present in the image as Ubuntu only build and publish this band.

> Most distros, including Ubuntu, stick to the .1xx feature band for the lifetime of a major .NET version. They make this choice because .1xx is (effectively) the "compatibility band". Higher bands can have breaking changes.
> This means there will no longer be packages available for .2xx and later feature bands. Such packages have been exclusively available from Microsoft. If users see an incompatibility between .1xx and higher feature bands, we ask that you please report it in the dotnet/sdk repo. [link: dotnet/core discussion](https://github.com/dotnet/core/discussions/9258)

If you need a higher feature band for your Actions the recommendation is to use the [`setup-dotnet`](https://github.com/actions/setup-dotnet) action to install the desired version.

### .NET MAUI

.NET MAUI is [not included](https://github.com/dotnet/core/discussions/9258#discussioncomment-9548857) in the Ubuntu .NET package. There is work [ongoing to fix.](https://github.com/dotnet/core/discussions/9258#discussioncomment-9548857)

You should be able to resolve this by using the [`setup-dotnet`](https://github.com/actions/setup-dotnet) action to install the desired version.
