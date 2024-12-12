
<#PSScriptInfo

.VERSION 1.0

.GUID caeccc3b-3671-440f-ad59-8db65c24d67b

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
 Verificar os jobs ou crontab e ativar ou desativar o mesmo 

#> 

Function erroParamentro {
    Write-Host -ForegroundColor DarkRed "Não encontrei o parametro $($args[0]) específicado"
    Write-Host ""
    Write-Host "use:".ToUpper()
    Write-Host ""
    Write-Host -ForegroundColor blue "-d | desabilitado : Para jobs desabilitados"
    Write-Host -ForegroundColor blue "-h | habilitado   : Para jobs habilitados"
    Write-Host -ForegroundColor blue "-A | ativar       : Para ativar jobs desabilitados"
    Write-Host -ForegroundColor blue "-ds | desativar       : Para ativar jobs desabilitados"
    Write-Host ""
}

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


# Verificando se o argumento 0 está vazia, se estiver saia do programa
if (-not($($args[0]))){
    Write-Host -ForegroundColor Red "Mande algum desses parametros para prosseguir:"
    Write-Host -ForegroundColor Yellow "disabilitado".ToUpper()
    Write-Host -ForegroundColor Yellow "habilitado".ToUpper()
    Write-Host -ForegroundColor Yellow "ativar".ToUpper()
    Write-Host -ForegroundColor Yellow "desativar".ToUpper()
    exit
}

# Convertendo o parametro 0 para letras em minusculas
$args[0] = $($args[0]).ToLower()
Switch ($($args[0])){
    {$_ -eq "disabilitado" -or $_ -eq "-d"} {
        Write-Host -ForegroundColor Yellow "Buscando seus jobs disabilitados"#.ToUpper()
        Start-Sleep -Seconds 1
        $scheduledTaskDesabilitado = (Get-scheduledTask -TaskPath \ | Where  -Property State -Match "disabled")
        $scheduledTaskDesabilitado
    } # DESABILITADO CASE
    {$_ -eq "habilitado" -or $_ -eq "-h"} {
        Write-Host -ForegroundColor DarkGreen "Buscando seus jobs habilitado"#.ToUpper()
        Start-Sleep -Seconds 1
        $scheduledTaskHabilitado = (Get-scheduledTask -TaskPath \ | Where  -Property State -Match "ready")
        foreach ($valor in $scheduledTaskHabilitado.TaskName) { Start-Sleep -Seconds 2 ; Write-Host "$valor"}
    } # HABILITADO CASE
    {$_ -eq "ativar" -or $_ -eq "-a"} {
        Try {
            Enable-ScheduledTask -TaskName "$($args[1])" -ErrorAction Stop | Out-Null
            Write-Host -ForegroundColor Green "ativado o job $($args[1])".ToUpper()
        }
        Catch {
            Write-Host -ForegroundColor DarkRed "Não existe o job $($args[1])"
            exit
        }
    } # ATIVAR CASE
    {$_ -eq "desativar" -or $_ -eq "-ds"} {
        Try {
            Disable-ScheduledTask -TaskName "$($args[1])" -ErrorAction Stop | Out-Null
            Write-Host -ForegroundColor Green "job $($args[1]) desativado".ToUpper()
        }
        Catch {
            Write-Host -ForegroundColor DarkRed "Não existe o job $($args[1])"
            exit
        }
    } # ATIVAR CASE
    Default {
        erroParamentro "$($args[0])".ToUpper()
    } # DEFAULT CASE
}# SWITCH CASE


