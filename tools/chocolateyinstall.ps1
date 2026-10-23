$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.164.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '6F267830B029EE25D9339864AA867CD45DE9F8FD4C5EA007D2E63C13A0C66D36'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.164.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '85362ADE41746E3632FFBA54457C92BF2F82D838A4ABB2F4500F60861964BF0F'

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




































































































