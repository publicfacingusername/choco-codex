$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.129.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '92BC0470E82909D797996262E55CA940E5B8405E01B9C44FC6501579FE01A9E6'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.129.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '6ACDBBC3943B22CB1E9C238A45EFE6B43751818D931C30E6CFA448FC9EBB44F6'

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












































