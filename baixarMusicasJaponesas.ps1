# Diretorios
$areaDeTrabalho = "$env:USERPROFILE/Desktop"
$diretorioPowershell = "$areaDeTrabalho/gitPowershell"
$diretorioBaseDownload = "$areaDeTrabalho/musicaJaponesa"
$diretorioBiblioteca = "$diretorioPowershell/bibliotecas"
# Arquivos
$arquivoNotificao = "$diretorioPowershell/notificarWhatsApp.ps1"
$arquivoMusicaJaponesaHiroTakahashi = "$diretorioBiblioteca/hiroTakahashi.ps1"
$arquivoMusicaJaponesaHiroKasahara = "$diretorioBiblioteca/hiroKasahara.ps1"
$arquivoMusicaJaponesaAkeboshi = "$diretorioBiblioteca/akeboshi.ps1"
$arquivoMusicaJaponesaNico= "$diretorioBiblioteca/nico.ps1"

#$listaDeArquivosMusicaJaponesa = $arquivoMusicaJaponesaHiroTakahashi + $arquivoMusicaJaponesaHiroKasahara + $arquivoMusicaJaponesaAkeboshi + $arquivoMusicaJaponesaNico
# Programas e comandos
$programaYtDlp = 'yt-dlp'
$comandoInstalacao = "winget install yt-dlp"

if ($psVersionTable.PSVersion.Major -lt 7) {
    Write-Host -ForegroundColor Red 'Preciso da versão powershell 7 ou mais para continuar!'
    Exit
}

# LINUX
if ($psVersionTable.Platform -Match 'unix') {
    $areaDeTrabalho = (xdg-user-dir DESKTOP)
    $diretorioPowershell = "$areaDeTrabalho/gitPowershell"
    $diretorioBaseDownload = "$areaDeTrabalho/musicaJaponesa"
    $diretorioBiblioteca = "$diretorioPowershell/bibliotecas"
    # Arquivos
    $arquivoNotificao = "$diretorioPowershell/notificarWhatsApp.ps1"
    $arquivoMusicaJaponesaHiroTakahashi = "$diretorioBiblioteca/hiroTakahashi.ps1"
    $arquivoMusicaJaponesaHiroKasahara = "$diretorioBiblioteca/hiroKasahara.ps1"
    $arquivoMusicaJaponesaAkeboshi = "$diretorioBiblioteca/akeboshi.ps1"
    $arquivoMusicaJaponesaNico= "$diretorioBiblioteca/nico.ps1"

    $arquivoNotificao = "$diretorioPowershell/notificarWhatsApp.ps1"
    $comandoInstalacao = "sudo apt install yt-dlp"
    Write-Host 'É LINUX'
}

# Verificando se existe o diretorio base de downloads
if (-Not(Test-Path "$diretorioBaseDownload")) {
    New-Item -Type Directory -Path "$diretorioBaseDownload" -ErrorAction Ignore | Out-Null || & {
        Write-Host -ForegroundColor Yellow "Erro ai criar o diretorio base de downloads!"
    }
}

# Verificando se existe o programa Yt-dlp
Get-Command -Name "$programaYtDlp" -ErrorAction Ignore | Out-Null || & {
    Write-Host -ForegroundColor DarkRed 'Instalando o programa '$programaYtDlp' para continuar...'
    Start-Sleep -seconds 2
    Invoke-Expression $comandoInstalacao

}

$programaDiretorioExecucao = (Get-Command -Name $programaYtDlp).source
$listaDeArquivos = . $arquivoMusicaJaponesaHiroTakahashi; . $arquivoMusicaJaponesaHiroKasahara; . $arquivoMusicaJaponesaAkeboshi;. $arquivoMusicaJaponesaNico
#$listaDeArquivos
#exit
    foreach ($nomeUrlAtual in $itsumojio + $kutibirugaHodoKenai + $renaiseiriron + $roundabout + $akeboshi +
$aLittleBoy + $yellowMoon + $rustyLance + $nico) {
        #Start-Process "$programaDiretorioExecucao" -ArgumentList ''
        write-Host "$nomeUrlAtual"
        yt-dlp "https://www.youtube.com/watch?v=$nomeUrlAtual" -P "$diretorioBaseDownload" -t mp3
        Start-Sleep -Seconds 1
    }
