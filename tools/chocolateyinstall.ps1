$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.159.3/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '57E1BDAB42C0559A74558CA17E85D5C7893CAA5F1E582F67E9DDD6D97FA705A7'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.159.3/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '8AE6A5EE311C73C3A41843960C801038FDFE0A68FC6667C63E69BAA53D69DE31'

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





























































































