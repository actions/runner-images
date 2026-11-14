#!/bin/bash -e -o pipefail
################################################################################
##  File:  install-php.sh
##  Desc:  Install PHP
################################################################################

source ~/utils/utils.sh

# Check the available branch before any install can upgrade an existing runtime.
# In particular, the unversioned "php" formula may move to a new release branch.
assert_php_formula_branch() {
    local formula=$1
    local expected_branch=$2
    local formula_info candidate_version
    formula_info=$(HOMEBREW_NO_AUTO_UPDATE=1 brew info --json=v2 --formula "$formula") || return
    candidate_version=$(jq -er '.formulae | if length == 1 then .[0].versions.stable else error("Expected one formula") end' <<< "$formula_info") || return
    if [[ ! $candidate_version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || [[ ${candidate_version%.*} != "$expected_branch" ]]; then
        echo "Refusing to change $formula from PHP $expected_branch to $candidate_version." >&2
        exit 1
    fi
}

php_formula_branch() {
    local formula_prefix
    formula_prefix=$(brew --prefix "$1") || return
    "$formula_prefix/bin/php" -r 'echo PHP_MAJOR_VERSION . "." . PHP_MINOR_VERSION;'
}

phpVersionToolset=$(get_toolset_value '.php.version')
assert_php_formula_branch "php@${phpVersionToolset}" "$phpVersionToolset"
phpFormulas=$(brew list --formula)
phpExistingFormulas=()
phpExistingBranches=()
while IFS= read -r phpFormula; do
    [[ $phpFormula =~ (^|/)php(@[0-9]+\.[0-9]+)?$ ]] || continue
    phpBranch=$(php_formula_branch "$phpFormula")
    assert_php_formula_branch "$phpFormula" "$phpBranch"
    phpExistingFormulas+=("$phpFormula")
    phpExistingBranches+=("$phpBranch")
done <<< "$phpFormulas"

echo Installing PHP
HOMEBREW_NO_AUTO_UPDATE=1 brew_smart_install "php@${phpVersionToolset}"

echo Installing composer
HOMEBREW_NO_AUTO_UPDATE=1 brew_smart_install "composer"

for ((phpFormulaIndex=0; phpFormulaIndex<${#phpExistingFormulas[@]}; phpFormulaIndex++)); do
    phpFormula=${phpExistingFormulas[$phpFormulaIndex]}
    if [[ $(php_formula_branch "$phpFormula") != "${phpExistingBranches[$phpFormulaIndex]}" ]]; then
        echo "PHP release branch changed while installing PHP or Composer: $phpFormula." >&2
        exit 1
    fi
done

# Check every installed PHP formula, including Composer's PHP dependency.
phpFormulas=$(brew list --formula)
phpFormulaCount=0
while IFS= read -r phpFormula; do
    [[ $phpFormula =~ (^|/)php(@[0-9]+\.[0-9]+)?$ ]] || continue
    phpFormulaCount=$((phpFormulaCount + 1))
    phpBranch=$(php_formula_branch "$phpFormula")
    assert_php_formula_branch "$phpFormula" "$phpBranch"
    HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade --formula "$phpFormula"
    if [[ $(php_formula_branch "$phpFormula") != "$phpBranch" ]]; then
        echo "PHP release branch changed while upgrading $phpFormula." >&2
        exit 1
    fi

    # Image shells disable automatic cleanup; do not ship old vulnerable kegs.
    HOMEBREW_NO_CLEANUP_FORMULAE= brew cleanup --prune=all "$phpFormula"
    phpCellar=$(brew --cellar "$phpFormula")
    phpKegCount=0
    for phpBinary in "$phpCellar"/*/bin/php; do
        if [[ ! -x $phpBinary ]]; then
            echo "Unable to validate the installed PHP binary $phpBinary." >&2
            exit 1
        fi
        phpKegCount=$((phpKegCount + 1))
        "$phpBinary" -r '
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
    done
    if ((phpKegCount == 0)); then
        echo "No installed PHP binary was found in $phpCellar." >&2
        exit 1
    fi
done <<< "$phpFormulas"
if ((phpFormulaCount == 0)); then
    echo "No installed PHP formula was found to validate." >&2
    exit 1
fi

if [[ $(php_formula_branch "php@${phpVersionToolset}") != "$phpVersionToolset" ]]; then
    echo "The configured PHP $phpVersionToolset runtime was not preserved." >&2
    exit 1
fi

invoke_tests "PHP"
