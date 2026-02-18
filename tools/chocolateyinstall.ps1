$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.103.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'AF78BAABA59F5AD3020F2F7FE83B979C5E16FB08AAAC2E904F209B9185CF75F1'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.103.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'B13610F3A1E7CC70B041867DCC7B2EEAED17BEDC49558CD84A671347221FBD74'

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






















