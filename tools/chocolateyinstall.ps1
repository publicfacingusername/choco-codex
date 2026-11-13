$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

$urlX64 = 'https://github.com/openai/codex/releases/download/rust-v0.168.0/codex-x86_64-pc-windows-msvc.exe'
$checksumX64 = 'AD8296F7D95EEA56BC4BAB33CEF025EB000340A7252DDB83DD41041EBCC65D0B'
$urlArm64 = 'https://github.com/openai/codex/releases/download/rust-v0.168.0/codex-aarch64-pc-windows-msvc.exe'
$checksumArm64 = '53FAA9FED65944A94B0A0119F630F3575EE7D14D5E17522E56079940753433CE'

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










































































































