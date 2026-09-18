$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.155.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'E4C11374BD9DE8AD5C3B7617FD4654BB7839901EDB0863F9930666863C7A021B'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.155.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '9D7759C63B3FE00200CA7F5610F9388251807E1234B7A17745268B13FCFEBF38'

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





















































































