#Step 3 - Generate Certificates

#Step 3a - Generate Root Certificate

$RootCertParams = @{
    Type                = "Custom"
    KeySpec             = "Signature"
    Subject             = "CN=P2SSCCMRootCert"
    KeyExportPolicy     = "Exportable"
    HashAlgorithm       = "sha256"
    KeyLength           = 4096
    CertStoreLocation   = "Cert:\CurrentUser\My"
    KeyUsageProperty    = "Sign"
    KeyUsage            = "CertSign"
}

$rootCert = New-SelfSignedCertificate @RootCertParams

#Step 3b - Generate Client Certificate

$ChildCertParams = @{
    Type                = "Custom"
    KeySpec             = "Signature"
    Subject             = "CN=P2SSCCMChildCert"
    KeyExportPolicy     = "Exportable"
    HashAlgorithm       = "sha256"
    KeyLength           = 4096
    CertStoreLocation   = "Cert:\CurrentUser\My"
    Signer              = $rootCert
    TextExtension       = @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
}

$childCert = New-SelfSignedCertificate @ChildCertParams

#Step 3c - Export & Backup Root Cert

$exportedRootCertPath = Get-Item -Path "Cert:\CurrentUser\My\$($rootCert.Thumbprint)"
$rootCertFile = ".\VPNCerts\P2SSCCMRootCert.cer"

$content = @(
    '-----BEGIN CERTIFICATE-----'
    [System.Convert]::ToBase64String($exportedRootCertPath.RawData, 'InsertLineBreaks')
    '-----END CERTIFICATE-----'
)

$content | Out-File -FilePath $rootCertFile -Encoding ascii

#Step 3d - Capture Root Certificate Output

$rootCertThumbprint = "Cert:\CurrentUser\My\$($rootCert.Thumbprint)"
$exportedRootCertPath = Get-Item -Path $rootCertThumbprint
$rootCertFile = ".\VPNCerts\P2SSCCMRootCert.cer"

$content = @(
    [System.Convert]::ToBase64String($exportedRootCertPath.RawData, 'InsertLineBreaks')
)

#Step 3e - Remove the Root Certificate from Store (Cleanup)

Remove-Item -Path $rootCertThumbprint

#Step 3f - Export & Backup Child Cert

$childCertThumbprint = "Cert:\CurrentUser\My\$($childCert.Thumbprint)"
$exportedChildCertPath = Get-Item -Path $childCertThumbprint
$childCertFile = ".\VPNCerts\P2SSCCMChildCert.pfx"

Function New-RandomComplexPassword ($length=8)
{
    $Assembly = Add-Type -AssemblyName System.Web
    $password = [System.Web.Security.Membership]::GeneratePassword($length,2)
    return $password
}

$pwdPT = New-RandomComplexPassword -length 20
$pwdSS = ConvertTo-SecureString -String $pwdPT -Force -AsPlainText 

$exportedChildCertPath | Export-PfxCertificate -FilePath $childCertFile -Password $pwdSS

New-Item -Path .\VPNCerts\readme.txt -ItemType "file" -Value $pwdPT -Force
Remove-Variable -Name pwdPT

#Step 3g - Remove Child Cert from Store (Cleanup)

Remove-Item -Path $childCertThumbprint

#Step 3h - Remove Running Variables (Cleanup)

Get-Variable -Exclude PWD,*Preference | Remove-Variable -EA 0