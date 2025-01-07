$notificar = Join-Path -Path "$Env:USERPROFILE\Desktop" -ChildPath "powershell"
$versao = '1.0.0.1'
# Diretório da área de trabalho do usuário atual
$DesktopPath = [Environment]::GetFolderPath("Desktop")

# Mapear extensões para pastas
$DestinationPaths = @{
    "awk" = "$DesktopPath\awk"
    "sh"  = "$DesktopPath\sh"
    "ps1" = "$DesktopPath\powershell"
    "txt" = "$DesktopPath\txt"
    "csv" = "$DesktopPath\csv"
    "md"  = "$DesktopPath\markdown"
    "rpp" = "$DesktopPath\projetosReaper"
    "mp3" = "$DesktopPath\mp3"
}

# Garantir que as pastas existam
foreach ($path in $DestinationPaths.Values) {
    if (-not (Test-Path -Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
    }
}

# Mover os arquivos
foreach ($ext in $DestinationPaths.Keys) {
    $sourceFiles = Get-ChildItem -Path $DesktopPath -Filter *.$ext -File
    foreach ($file in $sourceFiles) {
        $destination = $DestinationPaths[$ext]
        Try {
            Move-Item -Path $file.FullName -Destination $destination -Force -ErrorAction Stop
        }
        Catch {
            . $notificar
            notificarWhatsApp "Erro ao mover os arquivos $file para o diretorio $destination".Tolower() '379274836'
        }
    }
}
