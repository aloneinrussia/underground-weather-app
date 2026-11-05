$ErrorActionPreference = 'Stop'

$partNames = @(
    'UNDERGROUND-1.1.0-windows.zip.001',
    'UNDERGROUND-1.1.0-windows.zip.002',
    'UNDERGROUND-1.1.0-windows.zip.003'
)
$parts = @($partNames | ForEach-Object { Join-Path $PSScriptRoot $_ })
$missingParts = @($parts | Where-Object { -not (Test-Path -LiteralPath $_) })
if ($missingParts.Count -gt 0) {
    throw "Download all Windows ZIP parts before joining. Missing: $($missingParts -join ', ')"
}

$archivePath = Join-Path $PSScriptRoot 'UNDERGROUND-1.1.0-windows.zip'
$output = [System.IO.File]::Create($archivePath)
try {
    foreach ($part in $parts) {
        $input = [System.IO.File]::OpenRead($part)
        try {
            $input.CopyTo($output)
        }
        finally {
            $input.Dispose()
        }
    }
}
finally {
    $output.Dispose()
}

Add-Type -AssemblyName System.IO.Compression.FileSystem
$archive = [System.IO.Compression.ZipFile]::OpenRead($archivePath)
try {
    if (-not ($archive.Entries | Where-Object { $_.FullName -eq 'UNDERGROUND.exe' })) {
        throw 'The joined ZIP is missing UNDERGROUND.exe.'
    }
    if (-not ($archive.Entries | Where-Object { $_.FullName -eq 'install.ps1' })) {
        throw 'The joined ZIP is missing install.ps1.'
    }
}
finally {
    $archive.Dispose()
}

Write-Host "Created and verified $archivePath"
