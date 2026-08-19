$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.148.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '2AD2CF8A732DA68B8F141634F92DB1A03016C5FAF533A7225FBC0FB740130410'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.148.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '809EA5FDCC8FFF223DBDE888D23DDD047C097F6D40ED99E6A9EA190D46352319'

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










































































