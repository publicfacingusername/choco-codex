$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.124.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'E130BC6C73280506A8CD2865D6C68E8601530498334DCCD7208930B6876F19CB'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.124.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '02861E22F9A3ADA8F4EB8D4A2F7F18F51F2D6ED31F79B26957C7C14EDE3ECC2E'

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









































