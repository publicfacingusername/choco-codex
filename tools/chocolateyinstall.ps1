$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.152.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'E31B931087C22F0039C11476600D0933C3E661D8C2C03BACE4995A66D2994BC6'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.152.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '50B7096C946EDE6E1751865886FBEB5853C77040488F49559FA5FD8D7D5CD793'

$arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture.ToString()
switch ($arch) {
  'Arm64' {
    $url = $urlArm64
    $checksum = $checksumArm64
  }
  default {
    $url = $urlX64
    $checksum = $checksumX64
  }
}

Get-ChocolateyWebFile -PackageName $env:ChocolateyPackageName `
  -FileFullPath $exePath `
  -Url $url `
  -Checksum $checksum `
  -ChecksumType 'sha256'

Install-BinFile -Name 'codex' -Path $exePath















































































