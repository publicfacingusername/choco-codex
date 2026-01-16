$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.85.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'BD3C6BFE5980484086BB740E1116961D147C4233866392F53F31E73369DA1D32'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.85.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'C070E05F3D6FDDFB462A66E826CE936F6B96CD920B16FAC6183D046B919B5FAB'

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







