$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.125.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'F6B979DAB014091D037C2785F7878F51BE6E5B263AAE7A0D835D02ABA410E5AA'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.125.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'C8887EBCDB0CA4258BE854B3F20C31B0E03FA268816BF67856508F29CE6BDD90'

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










































