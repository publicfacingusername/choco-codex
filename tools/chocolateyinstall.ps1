$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.146.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'BC343BA420DC2E2E9F59E6FC5E5BF0AAE1CD8C771FC319665241FC9C0271FDDB'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.146.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'D52EFA1D816B305C84C525335F451AAFC56398A7E8515B6C6DB095C4E4FB0D1D'

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







































































