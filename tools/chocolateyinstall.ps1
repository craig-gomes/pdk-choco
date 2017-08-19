$ErrorActionPreference = 'Stop'; # stop on all errors

$packageName= 'PDK'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64       = 'https://puppet-pdk.s3.amazonaws.com/pdk/1.0.0.1/repos/windows/pdk-1.0.0.1-x64.msi' # download url, HTTPS preferred$url        = 'https://puppet-pdk.s3.amazonaws.com/pdk/0.6.0.0/repos/windows/pdk-0.6.0.0-x64.msi' # download url, HTTPS preferred


$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI' #only one of these: exe, msi, msu
  url           = $url
  url64bit      = $url64
  softwareName  = 'pdk*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = ''
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = ''
  checksumType64= 'sha256' #default is checksumType

  # MSI
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-package
