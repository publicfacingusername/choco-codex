$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.80.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '10885AD51AECF9FA8A89D4D7FB23B84C36D587F3FC31466FA0CC30F27E8548D8'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.80.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'F55F23137FB809A65EFE62A849CAD66B44000A2DAD3561D1B7D2A0F254416EC5'

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




