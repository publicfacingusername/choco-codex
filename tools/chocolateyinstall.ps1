$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.115.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '7BC8DB2EAA02235E4169ADEEA327760FF2BFACD7B5B1CBE69F6BE495B08BB87C'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.115.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '5CD50A09FE502ACFF631384144E5DC04C8E5CC331D3E111DED658EF04269724E'

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
































