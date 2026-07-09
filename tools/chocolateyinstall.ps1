$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '2B3C18D9393ED794531AE3DA13F43A6DE3BCD91DC577222BD31A17C59F7DE0AA'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'D8C7D939FB050892F08B85C74F50B99B38080F66284122CD54D9905A5B5DFA3B'

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
































































