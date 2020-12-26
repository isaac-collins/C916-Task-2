#         EEP1-Task2
#
#
#
#
#
#########################
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

$InsertCSVQuery = @'
USE ClientDB

INSERT INTO dbo.Client_A_Contacts
VALUES
(
    "$($_.first_name)",
    "$($_.last_name)",
    "$($_.city)",
    "$($_.county)",
    "$($_.zip)",
    "$($_.officePhone",
    "$($_.mobilePhone)"
)

'@

Import-Module sqlps -DisableNameChecking

$ServerObject = New-Object Microsoft.SqlServer.Management.Smo.Server($SqlServer)
$DBobject = New-Object Microsoft.SqlServer.Management.Smo.Database($ServerObject, $DBname)
$DBobject.Create()
Write-Host $DBobject "create success @ " $DBobject.CreateDate

Invoke-sqlcmd -ServerInstance $SqlServer -Database $DBname -Query $CreateTableQuery

#Import-Csv "C:\Users\Administrator\Downloads\NewClientData.csv" | ForEach-Object {Invoke-sqlcmd -ServerInstance $SqlServer -Database $DBname -Query $InsertCSVQuery}
Import-Csv "C:\Users\Administrator\Downloads\NewClientData.csv" | ForEach-Object {Invoke-sqlcmd -ServerInstance $SqlServer -Database $DBname -Query "insert into dbo.Client_A_Contacts values ('$($_.first_name)','$($_.last_name)','$($_.city)','$($_.county)','$($_.zip)','$($_.officePhone)','$($_.mobilePhone)')"}
#New-ADOrganizationalUnit
