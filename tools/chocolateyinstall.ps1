$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.154.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'BE96B992178B1E467C225800DA0D65F2C86D5EBA1EF0B14632F65DB381CBDFDE'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.154.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'DC6D744D747A50F8CAF7F08817E0CCC9B09781F6269DEC3609E2F9FBE036233D'

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




















































































