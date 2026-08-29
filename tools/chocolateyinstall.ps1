$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.151.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'CF68265897197AC5F3BFF6A10C168EEC159842B353129726DA5E3ED6B91EF0F4'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.151.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '04DA38480F95C111C2396D7011B0C599B301E238F134E78AEF3F3A7C9840F108'

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














































































