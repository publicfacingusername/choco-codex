$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.141.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'EECADB5C78FC71D41ECC8B7857774BC2B114E402C94A7FB9F4FF15B7B9008186'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.141.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'E650EB4B396A6F6B6DEA68C3ADA8927410B81B91EFE5113251BF9B84910FA5AD'

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
























































