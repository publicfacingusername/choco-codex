$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.149.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '14B7E6B2356E82D1D9275579EAA588757B4E0A501B65DCC19FCCDF77BD83DC00'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.149.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'B47C075BE601E5C71C67547D0BC7D5CC66ACC4FEC78A0BC5F7B96C23D490A796'

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











































































