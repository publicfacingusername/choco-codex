$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.150.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'CBD657DDFE151D1A6EBAD660BEFFDBD3265DC5AFF4B3A6095124D3E2F0156F2F'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.150.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'CC4DD7D3DFF5503303539033FD2EEFEA4A68FCF73C07E52C5ADD94B3D0E30902'

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













































































