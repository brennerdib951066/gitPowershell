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
$diretorios = @(
    'testeAwk',
    'testeSh'
)
$listaCompleto = @(
    $arquivosAwk,
    $arquivoSh
)

$nomeArquivoLog = 'logGitAwk.txt'
$plataforma = $PSEdition

if ($plataforma -match 'desktop'){
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
            } # SWITCH
        } # FOR ARQUIVO ATUAL
} # FOR ARQUIVO REPOESIOTORIO
# NOTIFICAR VIA BOTCONVERSA SE FOR UM SUCESSO TODOS AS REQUISIÇÕES

notificarWhatsApp "*O backup de seus arquivos foi realizado com sucesso no $sistemaOperacional pelo $sistemaJob*".ToUpper() '385910829'
