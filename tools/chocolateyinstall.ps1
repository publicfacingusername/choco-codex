$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.89.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'CB816CC9B0821FA2406661A0A53EDDFEE881B117701AB953B659A73BD6218635'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.89.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '12C48D98B2136FCCD8F509E3529D27DB0C71FA6D5FB415DACF6949B482B4F07C'

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











