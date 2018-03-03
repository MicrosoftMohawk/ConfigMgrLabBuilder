$ARMParams = @{
    ResourceGroupName       = "SCCM1702"
    TemplateFile            = ".\ExampleVM.json"
    TemplateParameterFile   = ".\ExampleVMParams.json"
    DeploymentDebugLogLevel = "All"
    Verbose                 = $true
}

$RGParams = @{
    Name     = "SCCM1702"
    Location = "East US"
}

New-AzureRmResourceGroup @RGParams
New-AzureRmResourceGroupDeployment @ARMParams
