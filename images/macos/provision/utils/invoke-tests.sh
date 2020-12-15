invoke_tests() {
    local TEST_FILE="$1"
    local TEST_NAME="$2"

    pwsh -Command "Import-Module '$HOME/image-generation/tests/Tests.Helpers.psm1' -DisableNameChecking
        Invoke-PesterTests -TestFile \"$TEST_FILE\" -TestName \"$TEST_NAME\""
} 