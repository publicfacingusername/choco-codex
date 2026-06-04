$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.137.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'DAE89A14373859B04E05A801A6104E1EF8C007059355FCD07A4EB64F893455DC'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.137.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '446D1FD44B07D05666DC8FBFB3222D0E896C68255249E16A722BC6D9EE2E2F05'

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




















































