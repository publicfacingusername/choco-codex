$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.171.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'CEFEA4FFEE1FFF04983A99C0DDA99944D8B380E891E740A28B32F4B815A6E0B7'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.171.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '33A3248AA0F0B31B69A987658915517B0FAED6498956AD823396353845033730'

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













































































































