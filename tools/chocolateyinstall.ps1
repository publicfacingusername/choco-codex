$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.156.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '70BCB05F9BF1A4E7306EDD0CD1B57D02AF3267AD02A34B26F45C8C4BB20A3301'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.156.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '91307BBA889F5BF6238267F148651DFC4CC980FEE966AAFB48EB5F7F8A3AB61A'

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























































































