$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.84.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'D6C1951D5A9149AEEE4DA0A0B2367155B370AFEFA5649F3C5E108F10A03AD8DE'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.84.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '91C3B6E1A8C34CCD195F0FE5B7F88AF1CA1351F7F44F457F290AC544738125CA'

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






