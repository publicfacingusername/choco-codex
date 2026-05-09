$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.130.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '280CB1C4E3375D94DBDCBA1A191F4F6ADBF73C293BE1E4F16C74B006662B9C54'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.130.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '4609EBA416A5907405003418B1B1E53693D7ABA1D606F6C300590DDB72740BB9'

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













































