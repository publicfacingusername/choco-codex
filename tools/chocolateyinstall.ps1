$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.119.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'B54079BD47178906FA5E160324ECEF683226562C0BC4CA1D5F854B772471B09F'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.119.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '7B89042171907FD3E19D12C07BD1CDDC1C8316390B27AD937473126E6D2F284D'

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




































