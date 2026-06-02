$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.136.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'F39EA8CDB79376553137155263AF85F0C16F5A54FFA107879341F5AD0016ED2C'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.136.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '9BB9A68C3AC9B0C698A17C490A224726369836CF742C521EF223A3AB610A92C9'

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



















































