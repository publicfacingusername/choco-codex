$ErrorActionPreference = 'Stop'

$release = Invoke-RestMethod -Uri 'https://api.github.com/repos/openai/codex/releases/latest' -Headers @{
  'User-Agent' = 'Codex-Choco-Updater'
}

$version = $release.name
if ([string]::IsNullOrWhiteSpace($version)) {
  throw 'Latest release name is empty.'
}

$tag = $release.tag_name
if ([string]::IsNullOrWhiteSpace($tag)) {
  throw 'Latest release tag is empty.'
}

$assetX64 = $release.assets | Where-Object { $_.name -eq 'codex-x86_64-pc-windows-msvc.exe' } | Select-Object -First 1
$assetArm64 = $release.assets | Where-Object { $_.name -eq 'codex-aarch64-pc-windows-msvc.exe' } | Select-Object -First 1
if (-not $assetX64 -or -not $assetArm64) {
  throw 'Missing Windows exe assets in the latest release.'
}

$urlX64 = $assetX64.browser_download_url
$urlArm64 = $assetArm64.browser_download_url
$checksumX64 = ($assetX64.digest -replace '^sha256:', '').ToUpperInvariant()
$checksumArm64 = ($assetArm64.digest -replace '^sha256:', '').ToUpperInvariant()

$repoRoot = Split-Path -Parent $PSScriptRoot
$nuspec = Get-ChildItem -Path $repoRoot -Filter 'codex.*.nuspec' | Select-Object -First 1
if (-not $nuspec) {
  throw 'Could not find a codex nuspec file.'
}

$nuspecContent = Get-Content -Path $nuspec.FullName -Raw
$updatedNuspec = [regex]::Replace(
  $nuspecContent,
  '<version>[^<]+</version>',
  "<version>$version</version>"
)
if ($updatedNuspec -ne $nuspecContent) {
  Set-Content -Path $nuspec.FullName -Value $updatedNuspec -Encoding utf8
}

$newNuspecName = "codex.$version.nuspec"
if ($nuspec.Name -ne $newNuspecName) {
  Rename-Item -Path $nuspec.FullName -NewName $newNuspecName
}

$installPath = Join-Path $repoRoot 'tools\chocolateyinstall.ps1'
$installContent = Get-Content -Path $installPath -Raw
$installContent = [regex]::Replace(
  $installContent,
  '\$urlX64\s*=\s*''[^'']+''',
  "`$urlX64 = '$urlX64'"
)
$installContent = [regex]::Replace(
  $installContent,
  '\$checksumX64\s*=\s*''[^'']+''',
  "`$checksumX64 = '$checksumX64'"
)
$installContent = [regex]::Replace(
  $installContent,
  '\$urlArm64\s*=\s*''[^'']+''',
  "`$urlArm64 = '$urlArm64'"
)
$installContent = [regex]::Replace(
  $installContent,
  '\$checksumArm64\s*=\s*''[^'']+''',
  "`$checksumArm64 = '$checksumArm64'"
)
Set-Content -Path $installPath -Value $installContent -Encoding utf8

Write-Host "Updated Codex CLI to $version (tag: $tag)"
