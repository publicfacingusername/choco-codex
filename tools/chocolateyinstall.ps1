$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.86.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '0B44243ED0CEE28E9F7FD7F5F017B527CE1C728AEC8A55CF549754E068DC754E'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.86.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'F4F384B5B445479E865A94605BB869882D0EC41499F636D499A70DBF30B1C43A'

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








