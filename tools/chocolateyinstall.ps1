$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.170.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '8D06DC231DBA649C7D48D3EECAB239C452A1AC498C41DD6492A6F301B90A22CE'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.170.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '57E60C27714335AA05BFE64C65F11E874BF29633FE7515C1298FAF9B5DB1AC29'

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












































































































