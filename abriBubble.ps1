#!/usr/bin/env -S pwsh
<#PSScriptInfo

.VERSION 1.0

.GUID 72dbb491-8a24-4ad7-84a7-5692e782c585

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


#>

<#

.DESCRIPTION
 abrir flameshot

#>
$areaDeTrabalho = "$Env:USERPROFILE/Desktop"
$arquivoNotificacao = "$areaDeTrabalho/powershell/notificarWhatsApp.ps1"
$arquivoDeErro = "$areaDeTrabalho/saidaPadraoPowershell/googleError.txt"
$arquivoDeSaida = "$areaDeTrabalho/saidaPadraoPowershell/googleSaidaPadrao.txt"
$nomePrograma = 'chrome'
$versaoBubble='022iq'

$hora = (Get-Date).Hour

if (-not $IsWindows) {
    $areaDeTrabalho = (xdg-user-dir DESKTOP)
    $nomePrograma = 'google-chrome-stable'
    $arquivoDeErro = "$areaDeTrabalho/saidaPadraoPowershell/googleError.txt"
    $arquivoDeSaida = "$areaDeTrabalho/saidaPadraoPowershell/googleSaidaPadrao.txt"

    if (-not(Test-Path ($arquivoNotificacao -replace 'notificarWhatsApp.ps1',''))) {
        $arquivoNotificacao = "$areaDeTrabalho/gitPowershell/notificarWhatsApp.ps1"
    }

    if (-not(Test-Path ($arquivoDeErro -replace 'googleError.txt',''))) {
        New-Item -Type Directory -Path ($arquivoDeErro -replace 'googleError.txt','') | Out-Null
    }
    if (-not(Test-Path ($arquivoDeSaida -replace 'googleSaidaPadrao.txt',''))) {
        New-Item -Type Directory -Path ($arquivoDeSaida -replace 'googleSaidaPadrao.txt','') | Out-Null
    }
}
else {
    if (-not(Test-Path ($arquivoDeErro -replace 'googleError.txt',''))) {
        New-Item -Type Directory -Path ($arquivoDeErro -replace 'googleError.txt','') | Out-Null
    }
    if (-not(Test-Path ($arquivoDeSaida -replace 'googleSaidaPadrao.txt',''))) {
        New-Item -Type Directory -Path ($arquivoDeSaida -replace 'googleSaidaPadrao.txt','') | Out-Null
    }
}

if ($psVersionTable.PSVersion.Major -lt 7) {
    . $arquivoNotificacao
    notificarWhatsApp 'Precisa-se de powershell igual ou maior a 7'.Tolower() '385910829'
    Exit
}

Try {
    Get-Command -Name $nomePrograma -ErrorAction Stop | Out-Null
}
Catch {
    Write-Host -ForegroundColor "$nomePrograma, não instalado!"
    Exit
}

if (-not ($hora -ge 5 -and $hora -le 20)) {
   . $arquivoNotificacao
    notificarWhatsApp 'O horario de abrir o BUBBLE está fora'.Tolower() '385910829'
    Exit
}

Start-Sleep -Seconds 5
Start-Process $nomePrograma -ArgumentList --profile-directory='DIB',"https://bubble.io/page?id=viverbemseguroscrm&tab=Design&name=escolhaLocomocao&type=custom&version=$versaoBubble","https://bubble.io/page?id=viverbemseguroscrm&tab=Data&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados&version=$versaoBubble",'https://web.whatsapp.com/','https://fvcorretora.3c.plus/manager/calls-report' -RedirectStandardError "$arquivoDeErro" -RedirectStandardOutput $arquivoDeSaida -PassThru #'https://centraldechat.sistemaviverbemseguros.com/#/atendimento/1920?t=1742911239525'
#>
#xdg-open 'https://bubble.io/page?id=viverbemseguroscrm&tab=Design&name=escolhaLocomocao&type=custom&version="'$versaoBubble'"'
Start-Sleep -Seconds 2
Start-Process $nomePrograma -ArgumentList --profile-directory='Brenner',"https://app.bolten.io/pt/oauth_sessions?","https://fvcorretora.3c.plus/agent",'https://app.vitalcross.com.br/ligacao' -RedirectStandardError "$arquivoDeErro" -RedirectStandardOutput $arquivoDeSaida -PassThru
Start-Sleep -Seconds 2
if (-Not $IsWindows) {
    Get-Command -Name xdotool | Out-Null && & {
        Start-Sleep -Seconds 2
        bash -c 'xdotool click 1'
        Start-Sleep -Seconds 1
        bash -c 'xdotool key Tab'
        Start-Sleep -Seconds 1
        bash -c 'xdotool key Return'
    }
}
Start-sleep -Seconds 2
Start-Process $nomePrograma -ArgumentList --profile-directory='Brenner',"chrome-extension://nmihkcakhpccmdhoifppbgeoapjaanno/popup-manager.html" -RedirectStandardError "$arquivoDeErro" -RedirectStandardOutput $arquivoDeSaida -PassThru
#>

