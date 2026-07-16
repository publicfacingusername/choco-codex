$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.5/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'EFDB3540EF74B9909408C8D38DA79483454797B36F471E3E004FC2BF2B70E22A'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.5/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '636AFB6D2482177B1CA36CAB3752FC948658F2F2BCCA6CD159DF740E278A49DA'

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




































































