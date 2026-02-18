$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.104.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '648BC2E65CE4E99B1CBD32763DF05FC987FF6E045DB5D36046E0604E22D9EA21'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.104.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '56715AA4A177D57644EED54A646BBCE1704738B28ABBBA05FB3F9FAF644658DB'

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























