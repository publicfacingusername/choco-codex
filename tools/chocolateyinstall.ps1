$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.132.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '6FDD1F4E37B8B0949751819D727D4BC6E156E42F8F86CA6AD3E7413D1AE514F7'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.132.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'E3915A1D3AF923C26BF1DDE53FA19B818DB12EBD048BEFB14BA513FB644E2DCB'

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















































