New-ADOrganizationalUnit finance 
Import-Csv ".\financePersonnel.csv" |ForEach-Object {New-ADUser `
    -Name "$($_.First_Name) $($_.Last_Name)" `
    -SamAccountName $_.samAccount `
    -GivenName $_.First_Name `
    -Surname $_.Last_Name `
    -DisplayName "$($_.First_Name) $($_.Last_Name)" `
    -PostalCode $_.PostalCode `
    -OfficePhone $_.OfficePhone `
    -MobilePhone $_.MobilePhone `
    -Path "OU=finance,DC=ucertify,DC=com"}