$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.167.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'C12ACA02DE615A9FCB76F955BF005A33F4B10B577F8A1730161953F57A1155B3'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.167.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '91A28945EFF7E22562F0541989B24A5033525271624AC90BBDD8C46752C9D3CF'

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








































































































