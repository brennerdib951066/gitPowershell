
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


. ./verificarPlataforma.ps1 # Verificando se é linux ou Windows
if (verificarPlataforma){
    $areaDetrabalho='Desktop'
}
else {
    $areaDetrabalho='Área de Trabalho'
}

for ($i=0;$i -le $arquivos.Count-1;$i++){

        if (-not (Test-Path $env:HOME/$areaDetrabalho/$($pastas[$i]))){
            Write-Host "Sua pasta $($pastas[$i]), não existe vamos cria-los"
            Start-Sleep -Seconds 5
            New-Item $env:HOME/$areaDetrabalho/$($pastas[$i]) #-Confirm
        }
        Write-Host -Foregroundcolor red "$($pastas[$i])"

        if ($($arquivos[$i]) -eq 'md'){
            Move-Item  -Path $env:HOME/$areaDetrabalho/*.$($arquivos[$i]) -Destination $env:HOME/$areaDetrabalho/$($pastas[$i])/viverBem #-Confirm
        }
        else {
            Move-Item  -Path $env:HOME/$areaDetrabalho/*.$($arquivos[$i]) -Destination $env:HOME/$areaDetrabalho/$($pastas[$i]) #-Confirm
        }
}
