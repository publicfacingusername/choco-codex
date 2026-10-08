$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.162.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'DCE685D569526EF4712FA82D20FF20E1309BAAD5FCD34215E1126698F611242F'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.162.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = 'D5D233FA93A8EA6FF856CDC2146EB216121144C2FED5568F5DEA7EE47CB409F1'

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

































































































