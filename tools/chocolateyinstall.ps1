$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.93.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '93BFFEA8ED781691DC6E956084245E2538DB33F4A9ED6BD15E54EB5BE38466FD'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.93.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '0B32F6A1C0BC718730BE3694F840EF6769B41C94D4E89EFD57E36DAFAF29F593'

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














