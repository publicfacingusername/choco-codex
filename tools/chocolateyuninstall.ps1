$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$exePath = Join-Path $toolsDir 'codex.exe'

Uninstall-BinFile -Name 'codex' -ErrorAction SilentlyContinue

if (Test-Path $exePath) {
  Remove-Item $exePath -Force
}
