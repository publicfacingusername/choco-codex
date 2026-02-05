$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.96.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '992DB36471FF015EA65AACC529208146AC6BF10EB22720B47636F94A05F1CB02'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.96.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '57D116434355348461EA682A50D206B1A48650144D08C1CE01012D1CA389650D'

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

















