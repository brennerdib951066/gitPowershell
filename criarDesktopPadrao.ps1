
<#PSScriptInfo

.VERSION 1.0

.GUID 2dd4701a-d717-466c-9b0f-cd3ada60af91

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
 criar pastas padrao no sistema operacional 

#> 
$diretorios = @(
    'awk',
    'csv',
    'leadsElane',
    'markdown',
    'mp3',
    'powershell',
    'projetosReaper',
    'py',
    'sh',
    'vbs'
)


# Função para verificar qual é a plataforma

Function plataforma {
    $sistemaOperacional = $PSEdition
    if ($sistemaOperacional -match 'desktop'){
        $homePath = "$env:USERPROFILE\Desktop"
        Return $homePath
    }
    else {
        $homePath = "$env:HOME\Área de Trabalho"
        Return $homePath
    }
}

$plataforma = plataforma

ForEach ($diretorio in $diretorios){

        Try {
            if (-Not(Test-Path "$plataforma\$diretorio")){
                New-Item -Type Directory -Path "$env:USERPROFILE\Desktop\$diretorio" -ErrorAction Stop | Out-Null

                Write-Host -ForegroundColor green "criando $diretorio"
                Start-Sleep -Seconds 1.5
            }
            else {
                Write-Host -ForegroundColor red Já existe o $diretorio.ToUpper()
            }
        } # TRY
        Catch {
                Write-Host -ForegroundColor red Já existe o $diretorio.ToUpper()
        }
}



