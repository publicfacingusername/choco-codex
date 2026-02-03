$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.94.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '2B2DAAA721151954E8BD00E5CF1C0AF62327B2D2FE4D571C332B948AFBD0A90E'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.94.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '3073AFD5AF60EA79E792DCC94E901C27BD3481658580346BBDE0E301065876BD'

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















