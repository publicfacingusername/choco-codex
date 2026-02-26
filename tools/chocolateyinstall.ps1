$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.105.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'CECE8FD0741F7B1ED663E433F5DD55E5E90ED13EBF0B0652FB8EB1E16DF86378'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.105.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'B260DD66F24B789C111C115E2CCB0D20B68C67007CFCC4669EF2FE9C79D8508A'

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
























