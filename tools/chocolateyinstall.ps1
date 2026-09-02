$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.152.1/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = '01B0FD4167393E004B9174C77AE5F8570486118E19DC4216CFC62A62A74B6EE6'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.152.1/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '08AE3E635EEBAF0B0825DE9D223EEA1E5E94027BE66495CFE46BE3541A7EB988'

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
















































































