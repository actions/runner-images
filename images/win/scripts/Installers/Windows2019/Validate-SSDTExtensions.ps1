################################################################################
##  File:  Validate-SSDTExtensions.ps1
##  Desc:  Validate SQL Server Data Tools Visual Studio extensions
################################################################################

#These extensions don't have any proper name in the state.packages.json file, only id is available, which can be found on extension marketplace download page
$null = Get-VSExtensionVersion -packageName "04a86fc2-dbd5-4222-848e-911638e487fe"
$null = Get-VSExtensionVersion -packageName "851E7A09-7B2B-4F06-A15D-BABFCB26B970"
$null = Get-VSExtensionVersion -packageName "717ad572-c4b7-435c-c166-c2969777f718"
