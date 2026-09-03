$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.153.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '0F8ED9678BCA539AA6517ADB0C8D50AD9A94FF5DF4D21E149AE700D219FFF69D'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.153.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '13F958407A5817F2A88775339D73C3EEB9C6FA3C8C1532C5E73F0036421485D3'

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

















































































