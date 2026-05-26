Describe "PHP" {
    $testCases = (Get-ToolsetContent).php.versions | ForEach-Object { @{PhpVersion = $_} }

    It "php <phpVersion>" -TestCases $testCases {
        "php${PhpVersion} --version" | Should -ReturnZeroExitCode
        "php-config${PhpVersion} --version" | Should -ReturnZeroExitCode
        "phpize${PhpVersion} --version" | Should -ReturnZeroExitCode
    }

    It "PHPUnit" {
        "phpunit --version" | Should -ReturnZeroExitCode
    }

    It "Composer" {
        "composer --version" | Should -ReturnZeroExitCode
    }

    It "Pear" {
        "pear" | Should -ReturnZeroExitCode
    }

    It "Pecl" {
        "pecl" | Should -ReturnZeroExitCode
    }
}

Describe "Swift" -Skip:(Test-IsUbuntu26) {
    It "swift" {
        "swift --version" | Should -ReturnZeroExitCode
    }

    It "swiftc" {
        "swiftc --version" | Should -ReturnZeroExitCode
    }

    It "libsourcekitd" {
        "/usr/local/lib/libsourcekitdInProc.so" | Should -Exist
    }

    It "SDK list" {
        "swift sdk list" | Should -ReturnZeroExitCode
    }

    It "SDK registered" {
        $expectedSdk = "swift-${env:SWIFT_VERSION}-RELEASE_static-linux-${env:SWIFT_STATIC_SDK_VERSION}"
        $sdkListOutput = swift sdk list
        $sdkListOutput | Should -Be $expectedSdk
    }
}

Describe "PipxPackages" {
    $testCases = (Get-ToolsetContent).pipx | ForEach-Object { @{package=$_.package; cmd = $_.cmd} }

    It "<package>" -TestCases $testCases {
        "$cmd --version" | Should -ReturnZeroExitCode
    }
}
