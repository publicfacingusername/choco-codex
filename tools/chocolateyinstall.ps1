$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.133.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'AC1462D39B8F2ECDB24E37C752B45B1765AE9D3BBD0EB1D0E086EE28D7834B84'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.133.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'D87579F7586D48016AA7C512AC61FDF9BD8CF55BBE4339166B05EA05C823A3D2'

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
















































