$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.157.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'ED1C7B36E44536809C868864C833AF8A857F56599A7A7FE23B908A1BA1093B1F'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.157.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '0F5D8893ED559DBF3FF082D84DF71E3BF90BDD19261FC3C257ACFDC8847CE342'

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
























































































