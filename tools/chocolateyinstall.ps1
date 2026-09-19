$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.155.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'EBA0F32C976667CB9298EFAFD98513E823EEDA7B576A03EC658BB8BE8D336316'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.155.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '30BBE48875B79F8C4715D079812E9CA82176870E948992324ABB941C15E4D5F6'

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






















































































