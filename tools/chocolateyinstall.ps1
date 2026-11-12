$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.167.2/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '6F65C42E3769209976CCE097A400720B5D877E1D24EC8BB6272BF0F02D5E0FD7'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.167.2/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '841746DEB80CC07BCE00D19D4D046070F8A89EF818518C454FB5FBBDE0633DCA'

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









































































































