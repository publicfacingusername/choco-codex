$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.139.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '77A84F8078400467ADE4301D827B8BCEA2D29B6838C9CD162BF3573B7EF97E10'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.139.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '1CA519406ECDF72E64B2D9F8428D2F645FD88982D47390569746815D03A022EA'

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






















































