$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '7C8531062AA5B8252FD205852F7015412AAD646ABF4BE9C5CD5823EFE4836C71'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'EF2CA3D3748F7D08FF03726D8DC2439217D03924A3460546BFD18F411FE2BFC6'

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

























































