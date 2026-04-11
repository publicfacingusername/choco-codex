$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.120.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '3CDDB048D6939B97A290936DF0B398D078D842C44187B0462D4AE71B0947A3CD'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.120.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '7A6E9DD48CE85984B274A96CAEA5F8B905D4288A3FE7E960626947496C00DC7E'

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





































