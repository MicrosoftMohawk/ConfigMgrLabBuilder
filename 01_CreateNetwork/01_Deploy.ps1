$ARMParams = @{
    ResourceGroupName       = "DEA_DEV_LAB"
    TemplateFile            = ".\CoreNetwork.json"
    TemplateParameterFile   = ".\CoreNetworkParams.json"
    Verbose                 = $true
}

$RGParams = @{
    Name     = "DEA_DEV_LAB"
    Location = "usgovvirginia"
}

New-AzureRmResourceGroup @RGParams
New-AzureRmResourceGroupDeployment @ARMParams