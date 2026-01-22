$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.88.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'D0421927ED83A0959CD9CADABDDA395E8086EFF518653F205D86F4F11027BE2A'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.88.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '82AF3E165FF94284720F176AEE9CA86435EAD3B4960BDD1096984FFCF29D998B'

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










