$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.91.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '4D4808A13E237F096F636A81C56C7A257B285B44A84874839E0F5968919B2280'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.91.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '0A33D755E1DF577BFE1735F90D89B336DC94CDAC9F7D0A4F2AFA37A0DEB1CD9C'

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












