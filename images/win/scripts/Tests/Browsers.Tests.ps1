Describe "Selenium" {
    It "Selenium 'C:\selenium' path exists" {
        "C:\selenium" | Should -Exist
    }

    It "Selenium Server 'selenium-server-standalone.jar' is installed" {
        "C:\selenium\selenium-server-standalone.jar" | Should -Exist
    }

    It "SELENIUM_JAR_PATH environment variable exists" {
        $env:SELENIUM_JAR_PATH | Should -BeExactly "C:\selenium\selenium-server-standalone.jar"
    }
}