$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.149.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'A395030B56B126F608F2403036DDDB654A9C063213E9C2B5F85D954CF490EBE6'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.149.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'F10A8261E588099A28482CE724024750EDE88751A580E00E8F64BF14CC7A3C49'

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












































































