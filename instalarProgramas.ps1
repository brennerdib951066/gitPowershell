
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
$pastaNodeLinux = '/home/brenner/.nvm/versions/node/v22.16.0/bin/node'
$listaDeProgramasLinux = @(
    'typora',
    'flameshot',
    'google-chrome-stable'
    'obs',
    'kate',
    'code',
    'node'
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
    'KDE.Kate',
    'visual',                           # VISUAL STUDIO
    'asio4all',                         # ASIO REPAER
    'peek',
    'anydesk',
    'DebaucheeOpenSourceGroup.Barrier',  # Barrier
    'Microsoft.Git'                      # GIT WINDOWS
    'node.js'
)
$plataforma = $PSEdition
$arquivo = @(
'.\VCLibs.appx','.\UIXaml.appx','.\AppInstaller.msixbundle'
)
Try {
    $diretorioTemporario = "$env:USERPROFILE\Desktop\winget-install"
}
Catch {
    $diretorioTemporario = "$(xdg-user-dir DESKTOP)/winget-install"
}


Try {
    Get-Command wwinget.exe -ErrorAction Stop | Out-Null
}
    Catch {
    Write-Host -ForegroundColor Red 'O winget não está instalado!'

    While ($True) {
        $resposta = Read-Host -Prompt 'Deseja instalar? [S/n]'

        if ($resposta -NotMatch '[A-Za-z]+') {
            Write-Host -ForegroundColor DarkRed 'Preciso de sua resposta como S ou n'
            Continue
        } #IF

        # SWICTH
        Swicth ($resposta) {
            {$_ -eq 's' -Or $_ -eq 'S' -Or $_ -eq 'sim'} {
                    Write-Host -ForegroundColor DarkYeloow 'Instando agora'
                    Start-Sleep -Seconds 2
                    # Cria pasta temporária

                    New-Item -ItemType Directory -Force -Path $diretorioTemporario | Out-Null
                    Set-Location $diretorioTemporario

                    # Baixa os pacotes necessários (última versão estável)
                    Invoke-WebRequest -Uri "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -OutFile "$diretorioTemporario\VCLibs.appx"
                    Invoke-WebRequest -Uri "https://aka.ms/Microsoft.UI.Xaml.2.8.appx" -OutFile "$diretorioTemporario\UIXaml.appx"

                    # Pega o instalador mais recente do winget
                    $latest = Invoke-RestMethod "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
                    $asset = $latest.assets | Where-Object { $_.name -match "msixbundle$" } | Select-Object -First 1
                    Invoke-WebRequest -Uri $asset.browser_download_url -OutFile "$diretorioTemporario\AppInstaller.msixbundle"

                     Foreach ($instalar in $arquivo)  {
                        Add-AppxPackage $instalar
                        Start-Sleep -Seconds 2
                    } # ForEach

            } # CASE SIM

            {$_ -eq 'n' -Or $_ -eq 'N' -Or $_ -eq 'nao' -Or $_ -eq 'não'} {
                Write-Host -ForegroundColor 'Perfeito então'
                Break
            } # CASE NAO

            Default {
                Continue
            } # DEFAULT
        } # SWICTH
    } # WHILE
} # CATCH

<#
if ($PSVersionTable.PSVersion.Major -le 6) {
    Write-Host -ForegroundColor red "Preciso da versão 7 do powershell para continuar"
    Exit
}

#>
ForEach ($programaAtual in $listaDeProgramasWindows){

        if (-not($ISWindows)) {

            ForEach ($programaAtual in $listaDeProgramasLinux) {
                if ($programaAtual -eq 'node') {
                    if (-not (Test-Path $pastaNodeLinux)) {
                      # Descarregar e instalar a nvm:
                        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

                        # Em vez de reiniciar a concha ou shell
                        \. "$HOME/.nvm/nvm.sh"

                        # Descarregar e instalar a Node.js:
                        nvm install 22

                        # Consultar a versão da Node.js:
                        node -v # Deveria imprimir "v22.16.0".
                        nvm current # Deveria imprimir "v22.16.0".

                        # Consultar a versão da npm:
                        npm -v # Deveria imprimir "10.9.2".
                      Continue
                    }
                } # IF NOODE
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
