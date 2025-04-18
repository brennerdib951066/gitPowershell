
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
    'appmakes.Typora',                  # TYPORA
    'flameshot',
    'Cockos.REAPER',                    # Reaper
    'Google.Chrome',                    # GOOGLE CHROME
    'XPFFH613W8V6LV',                   # OBS STUDIO
    'XP8CD3D3Q50MS2',                   # PEEK
    'AnyDeskSoftwareGmbH.AnyDesk',      # ANYDESK
    'libreoffice',
    'Valve.Steam',                      # STEAN
    'kate',
    'visual',                           # VISUAL STUDIO
    'asio4all',                         # ASIO REPAER
    'peek',
    'anydesk',
    'DebaucheeOpenSourceGroup.Barrier',  # Barrier
    'Microsoft.Git'                      # GIT WINDOWS
)
$plataforma = $PSEdition

if ($PSVersionTable.PSVersion.Major -le 6) {
    Write-Host -ForegroundColor red "Preciso da versão 7 do powershell para continuar"
    Exit
}

ForEach ($programaAtual in $listaDeProgramasWindows){

        if (-not($ISWindows)) {
            ForEach ($programaAtual in $listaDeProgramasLinux) {
                Write-Host "CAIU NO LINUX"
                Try {
                    Get-Command "$programaAtual" -ErrorAction Stop
                    Start-Sleep -Seconds 2
                    Continue

                } # TRY
                Catch {
                    sudo apt install $programaAtual
                    Continue

                } # CATCH
                Break
            } # FOR LINUX
            Exit
        } # IF $ISWINDOWS
        Write-Host "CAIU WINDOWS"
        Winget install "$programaAtual"
 } # FOREACH WINDOWS
