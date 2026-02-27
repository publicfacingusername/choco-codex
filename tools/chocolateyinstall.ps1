$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.106.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '84C22AE9BF827E77809B9D2FBAB281406F9508DBD7463FF66DB8363B4420FB12'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.106.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'B234AE9821D97066A16E331E86C5E318D39E75E266886AD6A8C50DE5A3C8486C'

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

























