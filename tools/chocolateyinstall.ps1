$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.143.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '5728E3DDF1480103BAD235560E95CF7764EA3069F06029F9B2F39EB74A8066F6'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.143.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'A9A81C2DA79832424443F646360DFBD47CCA12C6585643DF7EB04E29252CEFF9'

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































































