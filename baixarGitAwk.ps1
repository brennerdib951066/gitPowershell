$arquivosGit = @(
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

$plataforma = $PSEdition

if ($plataforma -match 'desktop'){
    $diretorioPadrao = 'desktop'
}
else {
    $diretorioPadrao = 'Área de Trabalho'
}
$notificacao = "~/$diretorioPadrao/powershell/notificarWhatsApp.ps1"
ForEach ($arquivo in $arquivosGit){
    Write-Host -ForegroundColor red $arquivo
    #Start-Sleep -Seconds 5
    Try {
        Wget -O ~/$diretorioPadrao/powershell/$arquivo "https://raw.githubusercontent.com/brennerdib951066/gitAwk/refs/heads/main/$arquivo"  -ErrorAction Stop
        Write-Output "$arquivo $(Get-Date -UFormat +%d-%m-%Y)" | Out-File -Encoding utf8 ~/$diretorioPadrao/logGitAwk.txt
    }
    Catch {
        Write-Host -ForegroundColor red "ERRO"
      . $notificacao
      notificarWhatsApp "*Erro ao executar o salvamento do git $arquivo no windows*".Tolower() '385910829'
      exit
    }
} # FOREACH

#Write-Host -ForegroundColor red "Você está na ultima linha"
# Enviando notificação para o celuar caso tenha sido sucesso
. $notificacao
notificarWhatsApp "*O backup dos seus arquivos, feitos via ScheduledTaskTrigger efeituados com sucesso*".Toupper() '385910829'
Start-Sleep -Seconds 2
