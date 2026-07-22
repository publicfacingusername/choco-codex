$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.145.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '83751F15CB6A0A7B97DF67752C001E3FE1C20E18FFBFEC3FF63567296205EB6C'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.145.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'B560BADD9D5DAA353762E7EBB6822029280F1307EDB00B2988594A28465E612B'

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






































































