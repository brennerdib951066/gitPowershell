
<#PSScriptInfo

.VERSION 1.0

.GUID 00dce406-07d3-4b54-b9e7-32c3ad0ff369

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
 Para saber qual é a plataforma, se é Windows ou linux 

#> 

function verificarPlataforma {
    Write-Host -ForegroundColor yellow "Parece que você deseja saber a plataforma"
    Start-Sleep -Seconds 2
    $plataforma = $PSEdition
    if ($plataforma -match 'desktop') {
        Write-Host -ForegroundColor red "Windows concerteza!"
        Start-Sleep -Seconds 1
        Return $True
    }
    else {
        Write-Host -ForegroundColor red "Linux é pai!"
        Start-Sleep -Seconds 1
        Return $False
    }
}


