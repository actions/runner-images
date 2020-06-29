################################################################################
##  File:  Validate-MongoDB.ps1
##  Desc:  Validate MongoDB
################################################################################
Describe "MongoDB" {

    It "mongod is on path." {
        if (Get-Command -Name 'mongod') {
            Write-Host 'mongod is on path'
        }
        else {
            Write-Host 'mongod not on path'
            exit 1
        }
    }
    It "mongo is on path." {
        if (Get-Command -Name 'mongo')
        {
            Write-Host 'mongo is on path'
        }
        else
        {
            Write-Host 'mongo not on path'
            exit 1
        }
    }
}
