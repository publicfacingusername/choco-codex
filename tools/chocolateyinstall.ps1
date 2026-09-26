$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.157.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '8CB0E69E99FF2A158C54815DB82D0F2E524D8F301BC30184722CFD1AE5973574'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.157.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '04CB2F6143DA840F33F0061ED9E13FCB0F4D7CD9BFCE27299C456A6BC47B410D'

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

























































































