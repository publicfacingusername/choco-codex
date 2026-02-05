$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.97.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'D17252CE4CE0E8B34BA0EB62E88D7F7A9C66608E2C0BC864AA289BDAF29AB1DA'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.97.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '49F7B6293B88DBABC9B1B2E315671EF45F8D699F7E938900387790A61D493ADD'

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


















