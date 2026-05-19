$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.131.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '353A6774D0AE335A8115221C1759650F0BD41C83C43C0639C3B40645ABDFFFBF'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.131.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '715055B016B9A6FB6096E5263E9EF09DBBF18876EB7F43839C69397E095AF52D'

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














































