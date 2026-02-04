$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.95.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'B9E75DBE4529F3E39CB6D9FEBE127D6EB634CCB9B2D46D6EBC5BB4EBAA488A33'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.95.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '629A9C9D125AF3D2EFB3EC976AB0FA775CAF8A8B38381C64CB3A952C705A8444'

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
















