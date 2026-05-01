$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.128.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '85A75FAF207720A9A3032F6FA77664B537E67884EB6A7E0C954D22E7F864A5AE'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.128.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '4ACF84401BF6B3F53980303826F8231AF7E45AD88CE1D65ADBCDB893A0CC1DB6'

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











































