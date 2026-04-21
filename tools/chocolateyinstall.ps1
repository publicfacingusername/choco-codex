$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.122.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '315E3F93E0C464616122A04D82A1D89606C8BA404F11639B54B9C2BC9C945835'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.122.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '3E0ADFED291B8AD55615120264DDDEE4F1820FDFB037D78289497DFFE0D891E7'

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







































