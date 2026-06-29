$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.4/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '6BE448C12A2EA32386B652FF22A7861AC56E55F9673AE95A4685E06C18E4CDC3'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.4/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '3BE08FD1E93C821702C36CA446D18F64E128FDADFCA6C2FB409D7A52B9CE79A2'

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





























































