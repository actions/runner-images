#
# https://github.com/actions/runner-images/issues/7987 for reference
#

Describe "Sudoers" {
    Context "Test sudoers" {
        It "Create temporariry user" {
            "sudo sysadminctl -addUser myuser -admin" | Should -ReturnZeroExitCode
        }

        It "Sudo is available" {
            "sudo -u myuser -H bash -e -c 'id'" | Should -ReturnZeroExitCode
        }
    }

}