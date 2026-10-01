$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.160.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'FDDA5FA3CF3FB3D000B876720742857676293E4315E4B045FAE6F8BD7E866D1D'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.160.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '1F090167E94ED25969C47381868C6FFB78BE2A195E13891FCDC969531CA16EAF'

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






























































































