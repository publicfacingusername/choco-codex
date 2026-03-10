$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.113.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'C4B7BEADB383787BAD2A7D4390D20749CFB84D9CCA02883A25CE6C69D6D045E2'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.113.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '8588B2530AA2FCFF41426222D8EAA4D8B514D24C4CE82B272040854B1D24733D'

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






























