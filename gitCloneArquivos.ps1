
<#PSScriptInfo

.VERSION 1.0

.GUID 375163d3-9997-47cf-ab4a-c5882af01ad0

.AUTHOR Denner

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
 clonar os repositorios correspondentes 

#> 
#Param()

$listaDeRepositorio = @(
    'gitServiceLinux',
    'gitVbs',
    'gitPowershell',
    'gitShell',
    'gitAwk',
    'gitMarkdown',
    'gitPy'
)
$areaDeTrabalho = Join-Path -Path $Env:USERPROFILE -ChildPath 'Desktop'
if (-not($psVersionTable.OS -match 'windows')) {
    Write-Host "É sistema linux"
    $areaDeTrabalho = Join-Path -Path $Env:HOME -ChildPath 'Área de Trabalho'
}

ForEach ($clonar in $listaDeRepositorio){
    #Write-Host -ForegroundColor Red "$clonar"
    Start-Sleep -Seconds 1
    If (Test-Path "$areaDeTrabalho\$clonar"){
        Write-Host -ForegroundColor Red "$clonar já existe na sua área de trabalho".ToUpper()
        Continue
    }
    Try {
        git -C "$areaDeTrabalho\" clone "https://github.com/brennerdib951066/$clonar"
    }
    Catch {
        Write-Host "erro ao clonar seu repositório $clonar"
    }

}
#>

Write-Host -ForegroundColor DarkGreen "Repositórios clonados com sucesso".ToUpper()
