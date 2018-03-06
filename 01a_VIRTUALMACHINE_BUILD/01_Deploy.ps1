$ARMParams = @{
    ResourceGroupName       = "DEV_LAB"
    TemplateFile            = ".\VM.json"
    TemplateParameterFile   = ".\VMParams.json"
    DeploymentDebugLogLevel = "All"
    Verbose                 = $true
}

$RGParams = @{
    Name     = "DEV_LAB"
    Location = "usgovvirginia"
}

New-AzureRmResourceGroup @RGParams
New-AzureRmResourceGroupDeployment @ARMParams
