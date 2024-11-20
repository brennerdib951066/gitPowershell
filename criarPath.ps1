
<#PSScriptInfo

.VERSION 1.0

.GUID d3303c8d-4c10-4c57-9295-cd3d06abace1

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
 para criar diretorios no path do usuario para poder executar arquivos e programas 

#> 

# Lsita de programas a serem adicionados no path se não existirem
$programas = @(
    'C:\Program Files\Google\Chrome\Application\',
    'C:\Program Files\Flameshot\bin\',
    'C:\Program Files\obs-studio\bin\64bit\',
    "$env:USERPROFILE\AppData\Local\Programs\Peek\",
    'C:\Program Files\LibreOffice\program\',
    "$env:USERPROFILE\Desktop\powershell"
)

ForEach ($programa in $programas){
    if (-not (($env:Path).Split(';') | Where-Object {$_ -like "$programa"})) {
        Write-Host -ForegroundColor green $programa
        Start-Sleep -Seconds 5
        [System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$programa", [System.EnvironmentVariableTarget]::User)
    } # If para verificar se não exitir no diretorio no path, adiciona-lo

} # For para percorrer a lista de programa
