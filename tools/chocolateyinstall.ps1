$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.98.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '6AB270B37C2C5D0D3567F0F3F420286F6EFB3FC9D4E3BB749DF5BF4452C16502'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.98.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '9CC2E0EBF2E298A1B5E203AD108162DF6004799F9B3DDD4FF6930DB873EC962E'

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



















