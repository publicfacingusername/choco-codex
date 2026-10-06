$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.160.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '9E7C59C05CC1CE5677B1F94E835B2AC038CA3BE14504E78D558EACDB0EA3F55D'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.160.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'F80D194C1B90C20F5CC8777BCA3CACAACB37E8B977509EFAFE9072FF19A300B1'

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































































































