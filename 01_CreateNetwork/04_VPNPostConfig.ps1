$P2SRootCertName = "P2SSCCMRootCert.cer"
$filePathForCert = "C:\git\ConfigMgrLabBuilder\01_CreateNetwork\VPNCerts\$P2SRootCertName"
$cert = new-object System.Security.Cryptography.X509Certificates.X509Certificate2($filePathForCert)
$CertBase64 = [system.convert]::ToBase64String($cert.RawData)
$P2SRootCertName = New-AzureRmVpnClientRootCertificate -Name $P2SRootCertName -PublicCertData $CertBase64

$AddVPNCertParams = @{
    VpnClientRootCertificateName = $P2SRootCertName 
    VirtualNetworkGatewayname    = "MERLIN_VPN" 
    ResourceGroupName            = "DEA_DEVELOPMENT_LAB" 
    PublicCertData               = $CertBase64

}

Add-AzureRmVpnClientRootCertificate @AddVPNCertParams