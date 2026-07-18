$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.6/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '4B76DED066D0239115CA97473D010C92072BC5C5550A45DD7CBEBE1E9EB956A7'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.144.6/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '2A23CDD00332064C27D4AA453D33D7A66A060BE89FFF33B8A388BA4DB7E4C620'

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





































































