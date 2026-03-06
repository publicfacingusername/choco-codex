$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.111.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '13CEFA7245CE3B8CE5D9FD63FD6CBD4717B14FC117B265E93A8A93F17281F233'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.111.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'A733ADD129797094AB5DF3605F094BF26522AC3D32AF6DB620DC53E7388B1BDC'

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




























