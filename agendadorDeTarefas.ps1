
<#PSScriptInfo

.VERSION 1.0

.GUID c452b71a-384a-4972-a7a4-0b080fe15f9b

.AUTHOR brenner

.COMPANYNAME

.COPYRIGHT

.TAGS

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


.PRIVATEDATA

#>

<# 

.DESCRIPTION 
 script para já inserir no agendador de tarefas do windows, as automações de login 

#> 
# Teste verificando se o usuário atual é ADMIN
function Test-Admin {
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Se não estiver rodando como administrador, reinicia o script como administrador
if (-not (Test-Admin)) {
    Write-Host "Não está executando como administrador. Por favor abra o powershell como administrador"
    Start-Sleep -Seconds 3
    exit
}

$listaArquivo = @(
    'bubble.vbs',
    'flameshot.vbs',
    'powershell.vbs',
    'profile.vbs',
    'youtube.vbs',
    'gitAwk.vbs'
)
$scheduledTaskLista = @(
    'abrirBubble',
    'abrirFlameshot',
    'abrirKonsolePowershell',
    'abrirProfilePowershell',
    'abrirYoutube',
    'gitAwk'
)
$descricaoLista = @(
    'abrir o bubble pelo chrome através do perfil DIB, no login',
    'abrir op flameshot no login',
    'abrir o teminal windows no login',
    'abrir com o kate o arquivo de configuração do powershell, no login'
    'abrir o youtube no perfil do google chrome brenner, no login',
    'baixar do gitHub todos os arquivos'
)
For ($i=0;$i -le $ScheduledTaskLista.Length -1;$i++){
    Try {
        Get-ScheduledTask -TaskName "$($scheduledTaskLista[$i])" -ErrorAction Stop | Out-Null
    }
    Catch {
        #Write-Host -ForegroundColor Red "ScheduledTask não adicionado $($scheduledTaskLista[$i])"
        if ($i -ne 5){
            $acao =  New-ScheduledTaskAction -Execute "$env:USERPROFILE\Desktop\vbs\$($listaArquivo[$i])"
            $trigger = New-ScheduledTaskTrigger -AtLogOn
            $registrar = Register-ScheduledTask -Action $acao -Trigger $trigger -Description "$($descricaoLista[$i])" -TaskName "$($scheduledTaskLista[$i])"
            Continue
        }
        $acao =  New-ScheduledTaskAction -Execute "$env:USERPROFILE\Desktop\vbs\$($listaArquivo[$i])"
        $trigger = New-ScheduledTaskTrigger -At '18:00' -Daily
        $registrar = Register-ScheduledTask -Action $acao -Trigger $trigger -Description "$($descricaoLista[$i])" -TaskName "$($scheduledTaskLista[$i])"
    }
}

