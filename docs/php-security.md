# PHP security validation during image builds

Image builds keep the configured PHP release branches and reject packages that
lack the fixes for [CVE-2026-109618 and CVE-2026-109619](https://www.php.net/archive/2026.php#2026-10-21-5).
The upstream minimums are 8.2.35, 8.3.36, 8.4.27 and 8.5.12. Later stable patches
and future stable branches are accepted; prerelease versions are rejected.

Ubuntu validation checks all installed packages built from PHP source packages,
including Apache, FPM, CGI and bundled extensions. It also accepts the matching
vendor package revisions in [USN-8948-1](https://ubuntu.com/security/notices/USN-8948-1),
so Ubuntu 22.04 can keep PHP 8.1 with the official security backport. Unverified
backports fail the build and need vendor evidence before extending the policy.

macOS upgrades and checks every installed PHP formula, including Composer's
runtime. Windows checks the installed binary before configuring Composer, using
the policy exported by the existing ImageHelpers module. Existing toolset
versions, extension selections and default-runtime configuration remain intact.

Run the focused checks from the repository root:

```sh
python3 -m unittest discover -s tests -p test_php_security.py -v
```

On Linux, install `dpkg` and a PHP CLI to exercise vendor comparisons and the
macOS policy as well. Run the Windows policy tests with PowerShell and Pester 5:

```powershell
Invoke-Pester -Path tests/php-security -Output Detailed -CI
```

These tests validate the release policy and mixed CLI/FPM package inventories.
Full image builds and the existing PHP image tests are still required before
publishing new images. Existing VMs need their normal update/replacement rollout;
changing the build recipe does not update running machines.
