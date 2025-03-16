
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
    'C:\Program Files\Google\Chrome\Application',
    'C:\Program Files\Flameshot\bin',
    'C:\Program Files\obs-studio\bin\64bit',
    'C:\Users\brenner\AppData\Local\Programs\Peek',
    'C:\Program Files\LibreOffice\program',
    "$env:USERPROFILE\Desktop\powershell",
    "C:\Program Files (x86)\AnyDesk",
    "C:\Program Files\REAPER (x64)"
    'C:\Program Files\Barrier',
    'C:\Users\brenner\AppData\Local\Programs\Kate\bin',
    'C:\Users\brenner\Downloads\mpv-x86_64-20241125-git-86bbe99',
    'C:\Users\brenner\AppData\Local\Microsoft\WindowsApps',
    'C:\Users\brenner\AppData\Local\Programs\Typora'
)

ForEach ($programa in $programas){
    if (-not (($env:Path).Split(';') -contains "$programa" )) {
        Write-Host -ForegroundColor green $programa
        Start-Sleep -Seconds 5
	$newPath = [System.Environment]::GetEnvironmentVariable('PATH', 'User') + ";$programa"
	[System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'User')
        #[System.Environment]::SetEnvironmentVariable("Path", $env:Path + ";$programa", [System.EnvironmentVariableTarget]::User)
    } # If para verificar se não exitir no diretorio no path, adiciona-lo

} # For para percorrer a lista de programa
