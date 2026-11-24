$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.172.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '3F42B12274B353ECB3EC555E6C8D0A43F6C6CB29C3A546179BC12DEE4855DEB6'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.172.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'E84E514BC87BD84292D835BC03D037D4B97C40677E368E4C9CADF88113BE9015'

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














































































































