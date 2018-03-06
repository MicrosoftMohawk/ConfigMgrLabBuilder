#Login and select subscription
#Login-AzureRmAccount
#Get-AzureRmSubscription

#Discover information about the environment
#Get-AzureRmResourceGroup
#Get-AzureRmVirtualNetwork | Select-Object Name

#Define variables
$RG = "DEV_LAB"
$ExistingVNet = "DEV_LAB_vNET"
$GWSubName = "GatewaySubnet"
$GWSubPrefix = "172.1.253.0/24" #Prefixes must be part of the address space of the existing VNet (Example: 10.0.1.0/24)
$GWName = "DEV_LAB_VPN" #(Example: tfsVNETgw)
$GWpip = "DEV_LAB_VPN-ip" #(Example: tfsVNETgwPIP)
$VPNClientAddressPool = "172.2.50.0/24" #Example provided
$Location = "usgovvirginia" #Resource location

#Step 1 - Add a gateway subnet
$virtualNetwork = Get-AzureRmVirtualNetwork -Name $ExistingVNet -ResourceGroupName $RG
Add-AzureRmVirtualNetworkSubnetConfig -Name $GWSubName -VirtualNetwork $virtualNetwork -AddressPrefix $GWSubPrefix
$virtualNetwork | Set-AzureRmVirtualNetwork

#Step 2 - Create Virtual Network Gateway (Run from Azure or a remote system, command takes a lot of time to complete)
$ngwpip = New-AzureRMPublicIpAddress -Name $GWpip -ResourceGroupName $RG -Location $Location -AllocationMethod Dynamic
$virtualNetwork = Get-AzureRmVirtualNetwork -Name $ExistingVNet -ResourceGroupName $RG
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -name $GWSubName -VirtualNetwork $virtualNetwork
$ngwipconfig = New-AzureRMVirtualNetworkGatewayIpConfig -Name ngwipconfig -SubnetId $subnet.Id -PublicIpAddressId $ngwpip.Id
New-AzureRmVirtualNetworkGateway -Name $GWName -ResourceGroupName $RG -IpConfigurations $ngwIpConfig  -GatewayType "Vpn" -VpnType "RouteBased" -GatewaySku "Basic" -Location $Location
$Gateway = Get-AzureRmVirtualNetworkGateway -ResourceGroupName $RG -Name $GWName
Set-AzureRmVirtualNetworkGateway -VirtualNetworkGateway $Gateway -VpnClientAddressPool $VPNClientAddressPool