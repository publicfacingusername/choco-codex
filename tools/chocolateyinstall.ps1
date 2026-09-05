$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.153.4/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '444A3F0008050605CAE73CD9B7A2DCAC61294062DFAAB56DD20430FD6498518B'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.153.4/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'B2E30B58328EDF8B7FFEC20BEF5C4CC87467EC824917E7C67319C6A76B4CAC44'

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



















































































