$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.147.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '935A1911ED2556E4FFCEC995F4886AC2AC425863BA26FED264DF62E30272AD9D'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.147.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '1F0E8C2DD3C6B471E985FAC76908366C1CF31155094FDE606FB2D3052CF00584'

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









































































