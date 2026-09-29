$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.159.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '0E2A4CD6AC1B329E64EC74745E38B71A3D4FA701102C86F49CF605D23A02C4DF'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.159.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'C8E8BF8A7F4FE87A2D7772796950922A670E65F98B896475484B280379BAC138'

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



























































































