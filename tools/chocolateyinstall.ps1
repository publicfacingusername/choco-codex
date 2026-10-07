$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.161.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'A0F89ACCA07A511734CAC7FDDEE26B2106FAB68918717BC90DF16104A0760A30'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.161.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '8E2ED3F92C26FC8B75774311D22643AD30395BD21AC07C72C4DAFE5ADA575F88'

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
































































































