$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.116.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '6C12FA3601ADDDC720DDEE60E883D480EDD3DB70C435DE6ACEB88AB180348151'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.116.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '4B7BA41FAC1066B7C767DA57142FDBFF98AB1C0B1C9F39D760FAEA80F2AE70BB'

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

































