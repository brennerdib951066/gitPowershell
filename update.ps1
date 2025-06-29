
<#PSScriptInfo

.VERSION 1.0

.GUID b2da22ee-ee4b-47b3-bacb-18585a641e6e

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
 atualizar o windows automaticamente

#>
$areaDeTrabalho = "$Env:USERPROFILE/Desktop"
$arquivoNotificacao = "$areaDeTrabalho/powershell/notificarWhatsApp.ps1"
$permissao = "$areaDeTrabalho/powershell/permissaoAdministrativo.ps1"
$versaoWindowsUpdate = '2.2.0.3'

Try {
    . $permissao
}
Catch {

}

if ($psVersionTable.PSVersion.Major -lt 7) {
    <# Cahamando o arquivo de notificar caso o powershell seja menor que a versão 7 #>
    . $arquivoNotificacao
    notificarWhatsApp 'aqui é um teste com powershell no DEBIAN'.Tolower() '385910829'
    Exit
}

if (-not ($isWindows)) {
    $areaDeTrabalho = (xdg-user-dir DESKTOP)
    if (-not (Test-Path "$areaDeTrabalho/powershell")) {
        $arquivoNotificacao = "$areaDeTrabalho/gitPowershell/notificarWhatsApp.ps1"
        $permissao = "$areaDeTrabalho/gitPowershell/permissaoAdministrativo.ps1"
    }
    . $arquivoNotificacao
    notificarWhatsApp 'És linux top demais'.Tolower() '385910829'
    Exit
}

if (-not (Test-Admin)) {
    . $arquivoNotificacao
    notificarWhatsApp 'Voce precisa ser ROOT para prosseguir'.Tolower() '385910829'
    Exit
}


<# Verificando se passou pelo if do powershell 7
    . $arquivoNotificacao
    notificarWhatsApp 'Passou por todas as condicionais'.Tolower() '385910829'
    exit
#>
Try {
    Get-Package PSWindowsUpdate -ErrorAction Stop | Out-Null
    # Verificando se foi instalado ou atualizado alguma coisa
    if (-not (Get-WindowsUpdate -Install -Confirm:$false)) {
        . $arquivoNotificacao
        notificarWhatsApp 'Nada para instalar e para atualizar para seu windows'.Tolower() '385910829'
        Exit
    }
        . $arquivoNotificacao
        notificarWhatsApp 'Windows atualizado com sucesso!'.Update() '385910829'
        Exit
}
Catch {
    . $arquivoNotificacao
    notificarWhatsApp 'O modulo powershell update não está instalado. Instalando!'.Tolower() '385910829'
    Install-Module -Name PSWindowsUpdate -RequiredVersion "$versaoWindowsUpdate" -Confirm:$false -Force
}

