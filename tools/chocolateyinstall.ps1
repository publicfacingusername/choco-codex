$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.81.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'ADCE64523441F76AB1FF2539DCCB4432340D71D5168506409F47751E81BEC572'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.81.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'C98E4A4BE28745EBBC8EE3F581A544CF434640A2B6F039929646C1B96D19BD26'

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





