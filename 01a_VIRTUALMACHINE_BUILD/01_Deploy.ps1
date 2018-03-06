$ARMParams = @{
    ResourceGroupName       = "DEA_DEV_LAB"
    TemplateFile            = ".\ExampleVM.json"
    TemplateParameterFile   = ".\ExampleVMParams.json"
    DeploymentDebugLogLevel = "All"
    Verbose                 = $true
}

$RGParams = @{
    Name     = "DEA_DEV_LAB"
    Location = "usgovvirginia"
}

New-AzureRmResourceGroup @RGParams
New-AzureRmResourceGroupDeployment @ARMParams
