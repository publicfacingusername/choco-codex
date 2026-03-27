$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.117.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '75680911104C78D5EFA52145F3532483B50514273E47DA151A0B4A9ECF844E9A'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.117.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '8204613664C02B5E62B173961CF9FDB8116685B236A2570C776F0B85B6EFB6D2'

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


































