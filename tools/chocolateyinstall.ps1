$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.5/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '645F5A1A0347ABB2B31FAE4E594C198AD00E3A4B4A999DCFA3A66C0D0F8CD43B'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.5/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '369C06F07CF97A3A3A0011648E5640ACC6BD894125D2BD5652898B53253A247C'

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






























































