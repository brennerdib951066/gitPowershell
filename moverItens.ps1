
<#PSScriptInfo

.VERSION 1.0

.GUID 3a43e65d-07b2-4759-9e48-66b5cc3258f5

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
 Para mover itens para suas respectivas pastas 

#> 

#$HOME/

$arquivos = @(
    'awk',
    'csv',
    'py',
    'sh',
    'txt',
    'md',
    'ps1',
    'vbs'
)

$pastas = @(
    'awk',
    'csv',
    'py',
    'sh',
    'txt',
    'markdown',
    'powershell',
    'vbs'
)

function verificarPlataforma {
    Write-Host -ForegroundColor yellow "Parece que você deseja saber a plataforma"
    Start-Sleep -Seconds 2
    $plataforma = $PSEdition
    if ($plataforma -match 'desktop') {
        Write-Host -ForegroundColor red "Windows concerteza!"
        Start-Sleep -Seconds 1
        $areaDeTrabalhos = "$env:USERPROFILE/Desktop"
        #$areaDeTrabalho
        Return $areaDeTrabalhos
    }
    else {
        Write-Host -ForegroundColor red "Linux é pai!"
        Start-Sleep -Seconds 1

        $areaDeTrabalhos="$env:HOME/Área de Trabalho"
        #set-location $areaDeTrabalho
        #get-item -Path $areaDeTrabalho
        #Start-Sleep -Seconds 5
        #write-Host -ForegroundColor green $areaDeTrabalho
        Return $areaDeTrabalhos
    }
}

$areaDeTrabalho = verificarPlataforma



for ($i=0;$i -le $arquivos.Count-1;$i++){

        if (-not (Test-Path $areaDeTrabalho/$($pastas[$i]))){
            Write-Host "Sua pasta $areaDeTrabalho/, não existe vamos cria-los"
            Start-Sleep -Seconds 5
            New-Item $areaDeTrabalho/$($pastas[$i]) -Confirm
        }
        Write-Host -Foregroundcolor red "$($pastas[$i])"

        if ($($arquivos[$i]) -eq 'md'){
            write-Host -Foregroundcolor red 'Caiu no IFFFF'
            #"$areaDeTrabalho"
            Move-Item -Path $areaDeTrabalho/*.$($arquivos[$i]) -Destination $areaDeTrabalho/$($pastas[$i])/viverBem  -Force
        }
        else {
            write-Host -Foregroundcolor yellow 'Caiu no ELSE'
            #"$areaDeTrabalho"
            Move-Item -Path "$areaDeTrabalho/*.$($arquivos[$i])" -Destination "$areaDeTrabalho/$($pastas[$i])" -Force
        }
}
