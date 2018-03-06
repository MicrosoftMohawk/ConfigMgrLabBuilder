$ARMParams = @{
    ResourceGroupName       = "DEV_LAB"
    TemplateFile            = ".\CoreNetwork.json"
    TemplateParameterFile   = ".\CoreNetworkParams.json"
    Verbose                 = $true
}

$RGParams = @{
    Name     = "DEV_LAB"
    Location = "usgovvirginia"
}

New-AzureRmResourceGroup @RGParams
New-AzureRmResourceGroupDeployment @ARMParams