# macOS 11 (Big Sur) onboarding guide

macOS 11 pools are opened to existing customers only, and we are working on making them ready for production use, rebalancing capacity and analyzing possible load.

Meanwhile, we'd like to start including customers to private preview on demand.

## Sign up process

If you need to build and test your project with macOS 11, please, fill out this [onboarding form](https://forms.office.com/r/Pn0a7NqBXg).

Once in a week we will review the incoming requests and open macOS 11 pool for some amount of them. These are the aspects we consider when processing requests:
- _Pool capacity_. Onboarding is possible only if current performace won't degrade for existing customers.
- _Necessity of macOS 11_. Currently, we can afford adding only those projects that really depends on the latest macOS version and its features.

## Usage

macOS 11 image label was changed to `macos-11` to avoid confusing of minor version. We always update images to the latest available OS version. Use the following code snippet to run your builds on macOS Big Sur:
```
jobs:
  build:
    runs-on: macos-11
```

