#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-php.sh
##  Desc:  Install PHP
################################################################################

source ~/utils/utils.sh

echo Installing PHP
phpVersionToolset=$(get_toolset_value '.php.version')
brew_smart_install "php@${phpVersionToolset}"

echo Installing composer
brew_smart_install "composer"

# Check every installed PHP formula, including Composer's PHP dependency.
phpFormulas=$(brew list --formula)
phpFormulaCount=0
while IFS= read -r phpFormula; do
    [[ $phpFormula =~ ^php(@[0-9]+\.[0-9]+)?$ ]] || continue
    phpFormulaCount=$((phpFormulaCount + 1))
    brew upgrade --formula "$phpFormula"
    "$(brew --prefix "$phpFormula")/bin/php" -r '
        function phpSecurityVersionIsFixed(string $version): bool {
            if (!preg_match("/^[0-9]+\\.[0-9]+\\.[0-9]+$/D", $version)) {
                return false;
            }
            $minimums = ["8.2" => "8.2.35", "8.3" => "8.3.36", "8.4" => "8.4.27", "8.5" => "8.5.12"];
            $branch = implode(".", array_slice(explode(".", $version), 0, 2));
            return version_compare($version, $minimums[$branch] ?? "8.6.0", ">=");
        }
        if (!phpSecurityVersionIsFixed(PHP_VERSION)) {
            fwrite(STDERR, "PHP " . PHP_VERSION . " lacks a verified fix for CVE-2026-109618/109619.\n");
            exit(1);
        }
    '
done <<< "$phpFormulas"
if ((phpFormulaCount == 0)); then
    echo "No installed PHP formula was found to validate." >&2
    exit 1
fi

invoke_tests "PHP"
