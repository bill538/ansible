#
# PowerShell

#
# Import User Cert
$cert_file = "C:\apps\winrm\gecloud-localhost-cert.pem"
$user_root_import = Import-Certificate -FilePath $cert_file -CertStoreLocation Cert:\LocalMachine\Root
$user_trusted_import = Import-Certificate -FilePath $cert_file -CertStoreLocation Cert:\LocalMachine\TrustedPeople
$user_my_import
$user_root_import


#
# Create Computer Cert

$hostname = $env:computername.ToLower()
$dte = Get-Date
# Build a local comuter self signed cert
$host_cert = New-SelfSignedCertificate -NotAfter $dte.AddYears(10) -Dnsname $hostname -CertStoreLocation cert:\LocalMachine\My
#                                                             Certificate(Local Computer)\Personal\Certificates

# Get the Thumb Print of the self signed cert
$my_certs = Get-ChildItem "cert:\LocalMachine\My"


# List winrm ports configured
winrm enumerate winrm/config/Listener

# Delete winrm port


# Create winrm ports on https
winrm enumerate winrm/config/Listener
winrm delete winrm/config/Listener?Address=*+Transport=HTTP
winrm delete winrm/config/Listener?Address=*+Transport=HTTPS
$winrm_https = New-Item -Path WSMan:\localhost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $my_certs.Thumbprint -Force -Verbose -Hostname $hostname
winrm enumerate winrm/config/Listener


# Mapping User Key to WinRM
winrm create winrm/config/service/certmapping?Issuer
