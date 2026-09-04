$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.153.2/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'E86FFD96751DED51F669B520D70BA3139B514EB36313A8EEEEDDE37BAA7B58E3'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.153.2/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '2C617EE290541C09154A854180ECBA5E2BD91E4930BBE24D895BBAEFAB6598B9'

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


















































































