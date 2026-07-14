$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.4/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '51398051C2332B6AFE08DC3B9DBB4056085C197F35CA57A307EE303D450CADA5'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.4/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '84406BF7CB8C689E46EBD31244F0458FCE3EEED781EC1030399A96BAAB062932'

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



































































