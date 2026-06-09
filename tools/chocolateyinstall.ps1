$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.138.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'C2E50FA58A6FAD1F5BE0BBB121D4F161573D8A0F67A14A9DC31027ED0A9B5B9E'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.138.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '70FF70AAD19B940AB9C7646B98BA3E4B04FA318B002268702967D2BA5E86AEF2'

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





















































