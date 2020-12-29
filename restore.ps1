#################################
#       
#        EEP1-Task2
#
#   Name:Isaac Collins,
#   StudentID:001526534
#
#
#
##################################

$DBname = "ClientDB"
$SqlServer = ".\UCERTIFY3"
$CreateTableQuery = @"
use $DBname

CREATE TABLE Client_A_Contacts
(
    first_name varchar(20),
    last_name varchar(20),
    city varchar(20),
    county varchar(20),
    zip varchar(20),
    officePhone varchar(20),
    mobilePhone varchar(20)
)

"@



try {

New-ADOrganizationalUnit -Name "finance" 
Import-Csv "financePersonnel.csv" | ForEach-Object {New-ADUser `
    -Name "$($_.First_Name) $($_.Last_Name)" `
    -SamAccountName $_.samAccount `
    -GivenName $_.First_Name `
    -Surname $_.Last_Name `
    -DisplayName "$($_.First_Name) $($_.Last_Name)" `
    -PostalCode $_.PostalCode `
    -OfficePhone $_.OfficePhone `
    -MobilePhone $_.MobilePhone `
    -Path "OU=finance,DC=ucertify,DC=com"}

Push-Location

Import-Module sqlps -DisableNameChecking

$ServerObject = New-Object Microsoft.SqlServer.Management.Smo.Server($SqlServer)
$DBobject = New-Object Microsoft.SqlServer.Management.Smo.Database($ServerObject, $DBname)
$DBobject.Create()
Write-Host $DBobject "create success @ " $DBobject.CreateDate

Invoke-sqlcmd -ServerInstance $SqlServer -Database $DBname -Query $CreateTableQuery

Pop-Location

Import-Csv "NewClientData.csv" | ForEach-Object {Invoke-sqlcmd -ServerInstance $SqlServer -Database $DBname -Query "insert into dbo.Client_A_Contacts values ('$($_.first_name)','$($_.last_name)','$($_.city)','$($_.county)','$($_.zip)','$($_.officePhone)','$($_.mobilePhone)')"}


 }

catch [System.OutOfMemoryException] {
    Write-Host "Caught: System.OutOfMemoryException" 
}