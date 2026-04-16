$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.121.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'E0AF363469EB24105E535435BC9715202375242AAF0366C408987BA142A58B74'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.121.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'FAE5CBBD9066C514DE75AD15C0294E8EEB5313452F4DCAD35461C1A15EB9371A'

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






































