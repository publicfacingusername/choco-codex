$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.134.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '1766AC7DFBF4C7DDB26380E55F52C6C83847A9724294D88902EA3C5650FEC134'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.134.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'C6778DA7F8083FA2D12716E8D02FB3A714109687EAED8A975AE0B38D3082CD5B'

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

















































