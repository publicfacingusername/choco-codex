$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.112.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'AF6E92E7DAA829CDE457C257F712C42A17AF130F476E52B02BD026964BAA474B'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.112.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '62726702995AC6123F7C0416B02B392A1FFF74A9BA8836DD774AC48CB6FC460A'

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





























