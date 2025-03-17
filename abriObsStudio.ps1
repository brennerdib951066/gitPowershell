
<#PSScriptInfo

.VERSION 1.0

.GUID 72dbb491-8a24-4ad7-84a7-5692e782c585

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
 abrir flameshot 

#>
$diretorioObs = ((Get-Command obs64.exe).Source)
$diretorioObs = $diretorioObs.Replace('\obs64.exe','')
cd "$diretorioObs"
obs64.exe  --minimize-to-tray
