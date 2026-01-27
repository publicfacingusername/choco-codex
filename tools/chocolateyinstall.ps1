$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.92.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '80D00DC77B4DC3AA8C3A6291DB2B37FA43BC3A6BFA8C6E28524A6EECAE073FEC'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.92.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '074CCA5FAB2225ED95E893F8FB5040AE92E2EFF02590844E0DC18D6B8D8C8E65'

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













