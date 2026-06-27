$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.3/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'D0021501D2779B6CD3DAF292308FCECCEE009002E62C9E93977CACE7D4C52535'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.3/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '7D687673CC8DFF9AFC2A2D0EF52189884EAFA7D8DEC34031348826498410FC88'

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




























































