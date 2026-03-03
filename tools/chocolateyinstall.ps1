$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.107.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '5EF2FE0C3D1259183EB1F123549C7E86839634687F75A2480CBC159CD4E8A2F7'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.107.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'B4C9568AD3B49008BDEE6CC11A969459C9C0AEE5541613B7895D98ACBA1DA850'

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


























