# lista de programas a serem instalados
$listaDeProgramas = @(
    'Google.Chrome',
    'obs.studio',
    'cockos.reaper',
    'flameshot'
    'Valve.Steam',
    'anydesk',
    'python3',
    'sublime',
    'mpv',
    'KDE.Kate',
    'wsl',
    'libreoffice',
    'appmakes.Typora',
    'vscode'
)
$plataforma = $PSEdition

#Write-Host ($listaDeProgramas).Langht
# for para percorrer  a lista de instlar os programas
foreach ($programa in $listaDeProgramas){
    if( $programa -match 'sublime' ){
        write-Host Instalndo o $programa.ToUpper() via WGET -ForegroundColor red
        Start-Sleep -Seconds 2
        if ($plataforma.Tolower() -eq 'desktop') {
            wget 'https://download.sublimetext.com/Sublime%20Text%20Build%203211%20x64%20Setup.exe'  -O $HOME/Desktop/sublime.exe
            Start-Process $HOME/Desktop/sublime.exe
        }
        else{
            sudo apt install sublime-text
        }
    }
    #Write-Host "$programa" -ForegroundColor Cyan
    if ($programa -eq 'wsl'){ wsl --install --distribution Debian }
    try {
        Start-Process winget.exe -ArgumentList 'install',$programa -NoNewWindow -wait
        Write-Host "$programa instalado ou atualizado com sucesso" -ForegroundColor Cyan
        Start-Sleep -Seconds 1
    }
    catch{
        Write-Host "Erro fatal" -ForegroundColor Cyan
    }
}
