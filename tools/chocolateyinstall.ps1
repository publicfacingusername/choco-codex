$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.2/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '77699DDB70A6FFBA524698C1352F6D2B1829C6C1AD615C07C7DDE8BF3D95BB67'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.142.2/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '4796D681312D44744F308F22732D0519FC918F995F94F1FBA20B80CC744E8870'

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



























































