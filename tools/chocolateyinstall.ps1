$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.146.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'AE9D865F3D346A1A2A60C4E84775622D74E3E7EF53E0DEDE9C68B81EAB306CCA'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.146.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '5171CCDC9C6E4D9BB039517D1E3C319D5F9A2AF976556A6D4369670837E37504'

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








































































