
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
$arquivoNotificacao = "$areaDeTrabalho/gitPowershell/notificarWhatsApp.ps1"
$diretorioSaida = "$areaDeTrabalho/saidaPadraoPowershell"
$arquivoDeErro = "$diretorioSaida/googleError.txt"
$arquivoDeSaida = "$diretorioSaida/googleSaidaPadrao.txt"
$nomePrograma = 'chrome'

$hora = (Get-Date).Hour

if (-not $IsWindows) {
    $areaDeTrabalho = (xdg-user-dir DESKTOP)
    $nomePrograma = 'google-chrome-stable'
    $diretorioSaida = "$areaDeTrabalho/saidaPadraoPowershell"
    $arquivoDeErro = "$diretorioSaida/googleError.txt"
    $arquivoDeSaida = "$diretorioSaida/googleSaidaPadrao.txt"

    if (-not(Test-Path ($arquivoNotificacao -replace 'notificarWhatsApp.ps1',''))) {
        $arquivoNotificacao = "$areaDeTrabalho/gitPowershell/notificarWhatsApp.ps1"
    }



    if (-not(Test-Path ($arquivoDeErro -replace 'googleError.txt',''))) {
        New-Item -Type Directory -Path ($arquivoDeErro -replace 'googleError.txt','')
    }
    if (-not(Test-Path ($arquivoDeErro -replace 'googleSaidaPadrao.txt',''))) {
        New-Item -Type Directory -Path ($arquivoDeSaida -replace 'googleSaidaPadrao.txt','')
    }
}

if (-Not(Test-Path "$diretorioSaida")) {
        New-Item -Type Directory -Path $diretorioSaida -ErrorAction Ignore | Out-Null
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
$nomePrograma

Start-Process $nomePrograma -ArgumentList --profile-directory='DIB','https://bubble.io/page?id=viverbemseguroscrm&tab=Design&name=escolhaLocomocao&type=custom&version=022ip','https://bubble.io/page?id=viverbemseguroscrm&tab=Data&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados&version=022ip','https://www.sistemaviverbemseguros.com/version-022ip' -RedirectStandardError "$arquivoDeErro" -RedirectStandardOutput $arquivoDeSaida #'https://centraldechat.sistemaviverbemseguros.com/#/atendimento/1920?t=1742911239525'
