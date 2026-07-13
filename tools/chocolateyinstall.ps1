$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.3/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'E5DCC9F9B08102C58596AF85345F689A69FD53A87D8D408BDC0FCDAF99FCF6E3'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.3/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'F11CAC115F0EEDB5E14517D0DF0BF6D59308D7ED74AC86E4A14E8E21CD54D5EA'

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


































































