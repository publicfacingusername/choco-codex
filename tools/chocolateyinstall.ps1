$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.123.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '27E560B49B8D28B624C117D54F996A0172093265C71240600014E6B7B9A33D88'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.123.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'B28F047DA4CBC284F25E0B09AD705CC65791FD06EECC1CC2B064116EE2EA9BF2'

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








































