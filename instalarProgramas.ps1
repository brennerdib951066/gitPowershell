
<#PSScriptInfo

.VERSION 1.0

.GUID 55cce987-6f94-448e-b02d-7bec779e9a8b

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
 instalar programas via winget ou via apt do linux

#> 
$listaDeProgramas = @(
    'typora',                 # TYPORA
    'flameshot',
    'reaper',                 # Reaper
    'XP8BV7F2CT4LDK',               # GOOGLE CHROME
    'XPFFH613W8V6LV',               # OBS STUDIO
    'XP8CD3D3Q50MS2',               # PEEK
    'AnyDeskSoftwareGmbH.AnyDesk',  # ANYDESK
    'libreoffice',
    'Valve.Stean'
)
$plataforma = $PSEdition

ForEach ($programaAtual in $listaDeProgramas){
    if (-not($plataforma -match 'desktop')){
        sudo apt install $programaAtual
        continue
    }
    winget install $programaAtual
}


