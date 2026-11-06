$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.167.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'EDFDD48F8B458AF0906E507B4CB05217B326C3D6E515E9F024E05E3B8D650F70'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.167.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '11B1D0F17C6C39261BB26B94D48844871B732751065B0164E7EF3BF3CCE41055'

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







































































































