# macOS 11 (Big Sur) onboarding guide

macOS 11 pools were opened to existing customers only, and we are working on making them ready for production use, rebalancing capacity, and analyzing possible load.

Meanwhile, we'd like to start including customers to private preview on demand. 

> Big Sur will automatically become available to existing Enterprise customers. New enterprises and customers on other plans, please go through the sign up process described below.

## Sign up process

If you need to build and test your project with macOS 11, please, fill out the [form](https://forms.office.com/r/Pn0a7NqBXg).

We will review the incoming requests periodically and open macOS 11 pool for some amount of them. These are the aspects we consider when processing requests:
- _Pool capacity_. New onboardings are only possible if current performance won't degrade for existing customers.
- _Billing plan_. New Enterprise or Teams customers will be given a priority in joining macOS 11.
- _Necessity of macOS 11_. We can currently afford to add only those projects that really depend on the latest macOS version and its features.

## Usage

macOS 11 image label was changed to `macos-11` to avoid confusion with the minor version. We always update images to the latest available OS version. Use the following code snippet to run your builds on macOS Big Sur:
```
jobs:
  build:
    runs-on: macos-11
```
