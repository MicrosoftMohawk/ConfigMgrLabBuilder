@{
    AllNodes    = @(
        @{
            NodeName                    = '*'
            PsDscAllowDomainUser        = $true
            PsDscAllowPlainTextPassword = $true
        },
        @{
            NodeName        = 'DC01'
            Purpose         = 'Domain Controller'
            WindowsFeatures = 'AD-Domain-Services'
        }
    )
    NonNodeData = @{
        DomainName          = 'lab.contoso.com'
        AdGroups            = 'Lab Users'
        OrganizationalUnits = 'Lab Users'
        AdUsers             = @(
            @{
                FirstName  = 'Wes'
                LastName   = 'Adams'
                Department = 'Lab Users'
                Title      = 'Lab Author'
            }
        )
    }
}