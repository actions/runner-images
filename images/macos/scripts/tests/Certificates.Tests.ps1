Describe "Certificate cleanup" {
    BeforeAll {
        $bundlePath = "/etc/ssl/cert.pem"
        if ($env:CERTIFICATE_BUNDLE_PATH) {
            $bundlePath = $env:CERTIFICATE_BUNDLE_PATH
        }

        $blockedRootNames = @(
            "emSign ECC Root CA - G3"
            "AAA Certificate Services"
        )
        $nameType = [System.Security.Cryptography.X509Certificates.X509NameType]::SimpleName
        $certificates = [System.Security.Cryptography.X509Certificates.X509Certificate2Collection]::new()
        $certificates.ImportFromPem((Get-Content -LiteralPath $bundlePath -Raw -ErrorAction Stop))
        $certificateNames = @($certificates | ForEach-Object { $_.GetNameInfo($nameType, $false) })

        $originalCertificates = [System.Security.Cryptography.X509Certificates.X509Certificate2Collection]::new()
        $originalCertificates.ImportFromPem((Get-Content -LiteralPath "$bundlePath.orig" -Raw -ErrorAction Stop))
        $expectedThumbprints = @($originalCertificates | Where-Object {
            $_.GetNameInfo($nameType, $false) -notin $blockedRootNames
        } | ForEach-Object { $_.Thumbprint })
    }

    AfterAll {
        foreach ($certificate in $certificates) {
            $certificate.Dispose()
        }
        foreach ($certificate in $originalCertificates) {
            $certificate.Dispose()
        }
    }

    It "Blocked root CA certificates are removed" {
        foreach ($rootName in $blockedRootNames) {
            $certificateNames | Should -Not -Contain $rootName
        }
    }

    It "All other certificates are preserved" {
        $expectedThumbprints.Count | Should -BeGreaterThan 0
        Compare-Object -ReferenceObject $expectedThumbprints -DifferenceObject @($certificates.Thumbprint) |
            Should -BeNullOrEmpty
    }
}
