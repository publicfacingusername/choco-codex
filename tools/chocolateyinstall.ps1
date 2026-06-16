$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.140.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '03E5CF467F4EF2C06360B00CDC9AEF64BB79B2028E25E3E122DD0BD2152ACE22'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.140.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '3CDEDD2157865E95286C46E535EFFD6EECEA7E5771BC9B6AF4B3AAA5F8B899FF'

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























































