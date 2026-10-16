$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.163.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '2692C8C7BB2CF8B0AEFE638741FC90236F4B824C59578CE84994F9DE58200993'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.163.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'BABD1EE5A76E4299D18F7EF99AA39D330E176E837566D3E2325D9B6B64E1CA61'

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



































































































