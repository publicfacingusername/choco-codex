$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.158.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'AF02050CC0C95F5AEB714AF2C1077E635C58E9896C13C89D75099CF5B96477BE'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.158.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '53F7B0F6C962D073FFAE6075DC0459A9C3EF2E7013728D1D9DBE72ED92739EA0'

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


























































































