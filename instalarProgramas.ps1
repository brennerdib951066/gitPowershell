
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
$listaDeProgramasLinux = @(
    'typora',
    'flameshot',
    'google-chrome-stable'
    'obs-studio',
    'kate',
    'code'
)

$listaDeProgramasWindows = @(
    'typora',                       # TYPORA
    'flameshot',
    'reaper',                       # Reaper
    'XP8BV7F2CT4LDK',               # GOOGLE CHROME
    'XPFFH613W8V6LV',               # OBS STUDIO
    'XP8CD3D3Q50MS2',               # PEEK
    'AnyDeskSoftwareGmbH.AnyDesk',  # ANYDESK
    'libreoffice',
    'Valve.Stean',                  # STEAN
    'kate',
    'visual'                        # VISUAL STUDIO
    'asio4all'                      # ASIO REPAER
)
$plataforma = $PSEdition

if (-not($plataforma -match 'desktop')){
    ForEach ($programaAtual in $listaDeProgramasLinux){
        sudo apt install $programaAtual
    }
} # IF $PLATAFORMA
else {
    ForEach ($programaAtual in $listaDeProgramasWindows){
        winget install $programaAtual
    }
} # ELSE $PLATAFORMA
