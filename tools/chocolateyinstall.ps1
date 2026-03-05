$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.110.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '2652FC533E06E5EAD0471A8B2CFE0986D8AAB15F4810699C4C5099368D414C8F'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.110.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '834E0EB7C69E06C890BF286B22DDF8A25D3B57C5C9E8788F90F9163C11FA818D'

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



























