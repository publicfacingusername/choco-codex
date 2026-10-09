$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.162.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'DD13BDB162A184FA04039488B234A8258EF9B76F84E926C505D5742B19249A6A'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.162.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '3AFC6A5195CE3FC08EE69B99521773B1542F129EE5B68DD4F0BB10CF7930C6EF'

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


































































































