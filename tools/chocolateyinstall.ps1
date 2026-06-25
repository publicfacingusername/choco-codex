$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '0C363B5BADFFE2F04071DA22867BA9532348770BB780D525C390C4A87977ACDA'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '3BDD0E2D97F7BD9C463C2BF774289FA3D5E6A238484914E0BC7E4C11F07B4E14'

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


























































