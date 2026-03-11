$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.114.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'D58A9674570CAF245F093FB2050D9052F3495F8556E37B39C31587E932714615'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.114.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '70BA365C54DA56415BD094E74CD1FAE9A923163ECDE660108A70DAB102579870'

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































