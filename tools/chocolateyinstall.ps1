$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.101.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '61DA33414961395772323646BF0E353A48CCA74D99CE4A014A0E0016E5388B25'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.101.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '334D02A44B4FFCF050716B1FDD222516838A031BF363D7AFD1CBCF9AEB7D8C58'

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





















