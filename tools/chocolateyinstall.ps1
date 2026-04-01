$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.118.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '95B576F0B759D17C4155A66F59E9F3F2E186F2B4602F1199FEB8C08FFC67DA07'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.118.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '4BADCAF22B9421BD0F96B6BBAF7481F7E65BB1A03991EEDD0EC804A25C4BEE5A'

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



































