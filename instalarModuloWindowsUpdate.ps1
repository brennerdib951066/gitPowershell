$notificar = Join-Path -Path "\Users\brenner\Desktop" -ChildPath notificarWhatsApp.ps1
$moduloNome = 'PSWindowsUpdate'
$diretorioModulo = (Get-Module -Name $moduloNome).Path
$versao = '1.0.0'
#$diretorioModulo
if (-not (Test-Path "$diretorioModulo")) {
    Write-Host "O $moduloNome, não existe vamos baixa-lo agora... "
    Start-Sleep -Seconds 1
    Install-Module -Name "$moduloNome" -Force -AllowClobber
    Get-WindowsUpdate -Install
    exit
}
# Se já estiver instalado cairá aqui
Get-WindowsUpdate -Install
. $notificar
notificarWhatsApp 'o comando update do windows foi realizado com sucesso pelo agendador de tarefas'.ToUpper() '385910829'
