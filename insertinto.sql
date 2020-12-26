USE $DBname

INSERT INTO dbo.Client_A_Contacts
VALUES
(
    '$($_.first_name)',
    '$($_.last_name)',
    '$($_.city)',
    '$($_.county)',
    '$($_.zip)',
    '$($_.officePhone)',
    '$($_.mobilePhone)'
)
