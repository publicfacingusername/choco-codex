$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.99.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '22462B6E06B78631DB49B4431E7874645A3C8EF7074A2C1AF6758BB98C14E101'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.99.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'B57018B3DAA7316F32A7847A2856735DFE7E677FBBFB6842B0B195464B56F32B'

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




















