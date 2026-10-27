$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.165.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'D4B2E6A054EA1DFE53217F9D8942C5F8A9F4B76171A1E0BB76CED5759915300A'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.165.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'F8A536FC74DC05DE2EA84C0FFF9F92E95FD78E076CC0DC578C837F6FF00DAA1D'

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





































































































