$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.159.2/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '52F75C649BEBB8001102A1DD129C1EA6D02B0940321E6D7E82EE0526753BD58A'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.159.2/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '61BA89D7FDF6322725BB3408952A1F95CD75FD78F9709E936089678F88F87179'

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




























































































