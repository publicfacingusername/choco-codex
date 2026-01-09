$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.79.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'FF649743A24197816A050F6C3D2C21D346C1DBED585182FBF1218D15EB3816AE'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.79.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'F8C6E82E5C195E6827197070AD572DB4C0360C31158D17AAC74DFC8B73BC4364'

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


