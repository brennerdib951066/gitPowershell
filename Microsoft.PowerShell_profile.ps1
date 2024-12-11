$arquivosAwk = @(
    'arquivo.awk',
    'buscandoEmAwk.awk',
    'buscandoFiltrosViverBem.awk',
    'calculandoLeads.awk',
    'calculandoPlailha.awk',
    'caracteresMinuscula.awk',
    'comprasGlau.awk',
    'criarSubscriber.awk',
    'deletarSubscriber.awk',
    'elane.awk',
    'eliminandoAspas.awk',
    'enviarFluxos.awk',
    'funcaoNotificarTelegram.awk',
    'funcaoNotificarWhatsApp.awk',
    'minhasCompras.awk',
    'principalAwk.awk',
    'relatorioViverBem.awk',
    'retirarAspas.awk',
    'subscriber.awk',
    'tratarDados.awk'
)
$arquivoSh = @(
    '.bashrc',
    'apiBubble.sh',
    'buscandoFeedsYoutube.sh',
    'criarPerfilgoofle.sh',
    'descompactar.sh',
    'googleChromeDefault.sh',
    'inputDevice.sh',
    'instalador.sh',
    'moverArquivo.sh',
    'mudancaLocale.sh',
    'notificacaoPlanilha.sh'
)
$arquivoPowerhsell = @(
    'Microsoft.PowerShell_profile.ps1',
    'abriBubble.ps1',
    'abriFlameshot.ps1',
    'abrirProfileUser.ps1',
    'baixarGitAwk.ps1',
    'buscandoAlias.ps1',
    'criarDesktopPadrao.ps1',
    'criarPath.ps1',
    'filtrosBubble.ps1',
    'hiroKasahara.ps1',
    'instalarProgramas.ps1',
    'mandarAvisoBubble.ps1',
    'moverArquivos.ps1',
    'moverItens.ps1',
    'musicasJaponesa.ps1',
    'notificarNtfy.ps1',
    'notificarTelegram.ps1',
    'notificarWhatsApp.ps1',
    'padraoDib.ps1',
    'permissaoAdministrativo.ps1',
    'relatorioDiario.ps1',
    'relatorioDiarioLinux.ps1',
    'verificarPlataforma.ps1'
)
$arquivoVbs = @(
    'bubble.vbs',
    'flameshot.vbs',
    'gitAwk.vbs',
    'moverArquivosAreaDeTrabalho.vbs',
    'powershell.vbs',
    'profile.vbs',
    'relatorioDiarioViverBem.vbs'
)
$diretorios = @(
    'awk',
    'sh',
    'powershell',
    'vbs'
)
$listaCompleto = @(
    $arquivosAwk,
    $arquivoSh,
    $arquivoPowerhsell,
    $arquivoVbs
)

$nomeArquivoLog = 'logGitAwk.txt'
$versao = '1.0.1'
$plataforma = $PSEdition

if ($IsWindows){
    $diretorioPadrao = Join-Path -Path $env:HOMEPATH -ChildPath 'Desktop'
    $sistemaOperacional = "windows"
    $sistemaJob = "SCHEDULEDTASKTRIGGER"
}
else {
    $diretorioPadrao = Join-Path -Path $env:HOME -ChildPath 'Área de Trabalho'
    $sistemaOperacional = "linux"
    $sistemaJob = "CRONTAB"
}
$notificacao = "$diretorioPadrao/powershell/notificarWhatsApp.ps1"
. $notificacao

#notificarWhatsApp "*O backup de seus arquivos foi realizado com sucesso no $sistemaOperacional pelo $sistemaJob*".ToUpper() '385910829'
#exit
# Verificando se existe a pasta ou diretorio na área de trabalho do usuário
ForEach ($diretorioAtual in $diretorios){
    if (-not(Test-Path "$diretorioPadrao/$diretorioAtual")){
        New-Item -Tyoe Directory -Path "$diretorioPadrao/$diretorioAtual"
        continue
    }
    Write-Host -ForegroundColor blue "já existe o diretorio $diretorioAtual"
}
#exit


#Remove-Item -Path "$diretorioPadrao/$nomeArquivoLog" -ErrorAction Ignore
ForEach ($repositorio in $listaCompleto){
        #Write-Host ForegroudColor Red $repositorio
        ForEach ($arquivoAtual in $repositorio.split(" ")) {
            Switch -Wildcard ($arquivoAtual){
                '*.awk' {
                    Write-Host -ForegroundColor Red "AWK $arquivoAtual"
                    Write-Host -ForegroundColor green "$diretorioPadrao/$($diretorios[0])"
                    #Start-Sleep -Seconds 5
                        Try {
                            wget -O "$diretorioPadrao/$($diretorios[0])/$arquivoAtual" "https://raw.githubusercontent.com/brennerdib951066/gitAwk/refs/heads/main/$arquivoAtual" -ErrorAction Stop
                            break
                        } # TRY AWK
                        Catch {
                            # Notificando via botConversa se der erro
                            notificarWhatsApp "error no ai buscar seus arquivos em awk no $sistemaOperacional".Tolower() '385910829'
                            exit
                        } # CATCH AWK

                } # "AWK"
                '*.sh' {
                    Try {
                        Write-Host -ForegroundColor Red "SH $arquivoAtual"
                        Write-Host -ForegroundColor green "$diretorioPadrao/$($diretorios[1])"
                        wget -O "$diretorioPadrao/$($diretorios[1])/$arquivoAtual" "https://raw.githubusercontent.com/brennerdib951066/gitShell/refs/heads/main/$arquivoAtual" -ErrorAction Stop
                        break
                    } # TRY SH
                    Catch {
                            # Notificando via botConversa se der erro

                            notificarWhatsApp "error no ai buscar seus arquivos em shell no $sistemaOperacional".Tolower() '385910829'
                            exit
                    }
                } # "SHHHHH"
                '*.bashrc' {
                    Try {
                        Write-Host -ForegroundColor Red "SH $arquivoAtual"
                        Write-Host -ForegroundColor green "$diretorioPadrao/$($diretorios[1])"
                        wget -O "$diretorioPadrao/$($diretorios[1])/$arquivoAtual" "https://raw.githubusercontent.com/brennerdib951066/gitShell/refs/heads/main/$arquivoAtual" -ErrorAction Stop
                        break
                    } # TRY BAHRC
                    Catch {
                            # Notificando via botConversa se der erro

                            notificarWhatsApp "error no ai buscar seus arquivos em shell no $sistemaOperacional".Tolower() '385910829'
                            exit
                    }
                } # "BAHRCCCCC"
                '*.ps1' {
                    Try {
                        Write-Host -ForegroundColor Red "PS1 $arquivoAtual"
                        Write-Host -ForegroundColor green "$diretorioPadrao/$($diretorios[2])"
                        wget -O "$diretorioPadrao/$($diretorios[2])/$arquivoAtual" "https://raw.githubusercontent.com/brennerdib951066/gitPowershell/refs/heads/main/$arquivoAtual" -ErrorAction Stop
                        break
                    } # TRY PS1
                    Catch {
                            # Notificando via botConversa se der erro

                            notificarWhatsApp "error no ai buscar seus arquivos em shell no $sistemaOperacional".Tolower() '385910829'
                            exit
                    } # CACTH PS1
                } # "PS1"
                '*.vbs' {
                    Try {
                        Write-Host -ForegroundColor Red "VBS $arquivoAtual"
                        Write-Host -ForegroundColor green "$diretorioPadrao/$($diretorios[3])"
                        wget -O "$diretorioPadrao/$($diretorios[3])/$arquivoAtual" "https://raw.githubusercontent.com/brennerdib951066/gitVbs/refs/heads/main/$arquivoAtual" -ErrorAction Stop
                        break
                    } # TRY VBS
                    Catch {
                            # Notificando via botConversa se der erro

                            notificarWhatsApp "error no ai buscar seus arquivos em shell no $sistemaOperacional".Tolower() '385910829'
                            exit
                    } # CACTH VBS
                } # "VBS"
            } # SWITCH
        } # FOR ARQUIVO ATUAL
} # FOR ARQUIVO REPOESIOTORIO
# NOTIFICAR VIA BOTCONVERSA SE FOR UM SUCESSO TODOS AS REQUISIÇÕES

notificarWhatsApp "*O backup de seus arquivos foi realizado com sucesso no $sistemaOperacional pelo $sistemaJob\n\n$versao*".Tolower() '385910829'
