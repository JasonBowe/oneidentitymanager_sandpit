<#
Replace the placeholders (YourAdminPassword, etc.) with your actual values. This script will create the specified domains, domain controllers, and set up the necessary DNS. Adjust the Exchange Onprem server setup as needed.

Remember to test thoroughly in a non-production environment before deploying to production.
#>


# Define parameters
$ForestName = "1idm.sandpit"
$ChildDomainName = "child.1idm.sandpit"
$AdminUser = "Administrator"
$AdminPassword = "YourAdminPassword"

# Create the forest
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSForest -DomainName $ForestName -DomainMode Win2012R2 -ForestMode Win2012R2 -InstallDNS -Force

# Create the child domain
Install-ADDSForest -DomainName $ChildDomainName -ParentDomainName $ForestName -DomainMode Win2012R2 -ForestMode Win2012R2 -InstallDNS -Force

# Create domain controllers
$DC1 = New-ADComputer -Name "DC1" -SamAccountName "DC1" -Path "OU=Domain Controllers,DC=$ForestName" -Enabled $true
$DC2 = New-ADComputer -Name "DC2" -SamAccountName "DC2" -Path "OU=Domain Controllers,DC=$ChildDomainName" -Enabled $true

# Promote domain controllers
Install-ADDSDomainController -DomainName $ForestName -InstallDns -Credential (Get-Credential -UserName $AdminUser -Password $AdminPassword) -Force
Install-ADDSDomainController -DomainName $ChildDomainName -InstallDns -Credential (Get-Credential -UserName $AdminUser -Password $AdminPassword) -Force

# Verify domain controllers
Get-ADDomainController -Filter * | Select-Object Name, Domain, Forest

# Create Exchange Onprem server (adjust as needed)
# ...

# Additional configuration (e.g., GPOs, trusts, etc.)
# ...

Write-Host "Domain controllers and domains created successfully!"