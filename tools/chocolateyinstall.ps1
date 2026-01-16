$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.87.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '39D11BCB0F7CBF6DD5D823DBFC5053F637E552A4B2E59FA322247F95A85CFC7E'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.87.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'EF33241976E6631984231903603E2AA0CB2FE3512C5F984781220B8D422DCD87'

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









