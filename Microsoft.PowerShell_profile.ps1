<#
	 a versão '1.0.0.9' foram adicionados
	A função de fcrontab para filtrar linhas no arquivo do crontab
#>

$versao = '1.0.0.9'
$versaoPowershell = $PSVersionTable.PSVersion

Write-Host -ForegroundColor DarkRed "powershell versão profile $versao".Toupper()

if (-not ($versaoPowershell -match 7)) {
	Write-Error "use a versão 7 do powershell".ToUpper()
	Exit
}


function verificandoPlataforma(){
		##$plataforma = $PSEdition
		if ($isWindows) {
			#Write-Host -foregroundcolor red "É WINDOWSSSS"
			Return $True
		}
		else {
			#Write-Host -foregroundcolor red "É LINUXXXXXXXX"
			Return $False
		}
}

################################Função de ações do sistema####################################################################################

function reboot {
	#$plataforma = $PSEdition
	if ($IsWindows){
		Restart-Computer -Force
	}
	else {
		systemctl reboot -i
	}

}
function poweroff {
	#$plataforma = $PSEdition
	if ($IsWindows){
		Stop-Computer -Force
	}
	else {
		systemctl poweroff -i
	}
}

##################################################################################################################################################


################################Função de google chrome###########################################################################################
function gitHub(){
    <#param(
        $profile,
        $repositorio,
        $arquivoRepositorio
    )#>
    $profile = 'Brenner'
	#Write-Host $args.Length
	if ($args[0].Length -gt 0){

		if (verificandoPlataforma) {
			Switch ($args[0]){
				1 {
					Start-Process chrome "--profile-directory=$profile",'https://github.com/brennerdib951066/gitawk/blob/main/retirarAspas.awk'
				} # SWITCH CASE 1
				2 {
					Start-Process chrome "--profile-directory=$profile",'https://github.com/brennerdib951066/gitshell/blob/main/.bashrc'
				} # SWITCH CASE 2
				3 {
					Start-Process chrome "--profile-directory=$profile",'https://github.com/brennerdib951066/gitpowershell/blob/main/Microsoft.PowerShell_profile.ps1'
				} # SWITCH CASE 3
				Default {
					Write-Host -ForegroundColor DarkRed 'Não encontrei a opção correspondente'.ToUpper()
				}
			} # SWICTH CASE
		} # IF PLATAFORMA
		else {
			Switch ($args[0]){
				1 {
					Start-Process google-chrome-stable "--profile-directory=$profile",'https://github.com/brennerdib951066/gitawk/blob/main/retirarAspas.awk' -RedirectStandardOutput 'saidaPadrao.txt' -RedirectStandardError 'saidaErro.txt'
				} # SWITCH CASE 1
				2 {
					Start-Process google-chrome-stable "--profile-directory=$profile",'https://github.com/brennerdib951066/gitshell/blob/main/.bashrc' -RedirectStandardOutput 'saidaPadrao.txt' -RedirectStandardError 'saidaErro.txt'
				} # SWITCH CASE 2
				3 {
					Start-Process google-chrome-stable "--profile-directory=$profile",'https://github.com/brennerdib951066/gitpowershell/blob/main/Microsoft.PowerShell_profile.ps1' -RedirectStandardOutput 'saidaPadrao.txt' -RedirectStandardError 'saidaErro.txt'
				} # SWITCH CASE 3
				Default {
					Write-Host -ForegroundColor DarkRed 'Não encontrei a opção correspondente'.ToUpper()
				}
			} # SWICTH CASE
		}
	} # IF ARGS
	else {

		$listaMenu = @(
			'awk',
			'sh',
			'powershell'
		)
		function menuGit {
			$i = 1
			foreach ($menu in $listaMenu){
				Write-Host -foregroundcolor Yellow "$i) $menu"
				$i++
			} # FOR MENU
			while($true){
					$menuResposta = Read-Host -Prompt "Opcao".Toupper()
					if ($menuResposta){
						$menuResposta = [int]$menuResposta
						Write-Host -foregroundcolor green "Você escolheu $menuResposta"
						#Start-Sleep -Seconds 5
						Break
					}

			} # WHILE MENU RESPOSTA
			return $menuResposta
		} # FUNCAO MEU GIT
		$menuEscolhido = menuGit
		Switch ($menuEscolhido){
			1 {
				if (verificandoPlataforma){
					Write-Host "Você entrou no WINDOWS"
					#Start-Sleep -Seconds 5
					Start-Job -ScriptBlock {
						param($repositorio = $($listaMenu[0]))
						$arquivoGit = 'retirarAspas.awk'
						Start-Process chrome -ArgumentList "--profile-directory=Brenner", "https://github.com/brennerdib951066/git$repositorio/blob/main/$arquivoGit"
					} -ArgumentList $($listaMenu[0])  # START JOB
				} # IF VERIFIACANDO PLATAFORMA
				else {
					Write-Host "Você entrou no LINUXXXX"
					#Start-Sleep -Seconds 5
					Start-Job -ScriptBlock {
							param($repositorio = $($listaMenu[0]))
							$arquivoGit = 'retirarAspas.awk'
							Start-Process google-chrome-stable -ArgumentList "--profile-directory=Brenner", "https://github.com/brennerdib951066/git$repositorio/blob/main/$arquivoGit"
					} -ArgumentList $($listaMenu[0])
				} # ESLE VERIFIACANDO PLATAFORMA

				#Break
			} # SWITCH CASE 1
			2 {

				if (verificandoPlataforma){
					Write-Host "Você entrou no WINDOWS"
					#Start-Sleep -Seconds 5
					Start-Job -ScriptBlock {
						param($repositorio)
						$arquivoGit = '.bashrc'
						Start-Process chrome -ArgumentList "--profile-directory=Brenner", "https://github.com/brennerdib951066/git$repositorio/blob/main/$arquivoGit"
					} -ArgumentList 'shell'  # START JOB
				} # IF VERIFIACANDO PLATAFORMA
				else {
					Write-Host "Você entrou no LINUXXXX"
					#Start-Sleep -Seconds 5
					Start-Job -ScriptBlock {
							param($repositorio = $($listaMenu[1]))
							$arquivoGit = '.bashrc'
							Start-Process google-chrome-stable -ArgumentList "--profile-directory=Brenner", "https://github.com/brennerdib951066/git$repositorio/blob/main/$arquivoGit"
					} -ArgumentList 'shell'
				} # ESLE VERIFIACANDO PLATAFORMA
				#Break
			} # SWITCH CASE 2
			3 {

				if (verificandoPlataforma){
					Write-Host "Você entrou no WINDOWS"
					#Start-Sleep -Seconds 5
					Start-Job -ScriptBlock {
						param($repositorio = $($listaMenu[2]))
						$arquivoGit = 'Microsoft.PowerShell_profile.ps1'
						Start-Process chrome -ArgumentList "--profile-directory=Brenner", "https://github.com/brennerdib951066/git$repositorio/blob/main/$arquivoGit"
					} -ArgumentList $($listaMenu[2])  # START JOB
				} # IF VERIFIACANDO PLATAFORMA
				else {
					Write-Host "Você entrou no LINUXXXX"
					#Start-Sleep -Seconds 5
					Start-Job -ScriptBlock {
							param($repositorio = $($listaMenu[2]))
							$arquivoGit = 'Microsoft.PowerShell_profile.ps1'
							Start-Process google-chrome-stable -ArgumentList "--profile-directory=Brenner", "https://github.com/brennerdib951066/git$repositorio/blob/main/$arquivoGit"
					} -ArgumentList $($listaMenu[2])
				} # ESLE VERIFIACANDO PLATAFORMA
				#Break
			} # SWITCH CASE 2
			Default {
				Write-Host -foregroundcolor green "Escolha uma resposta válida"
				Write-Host -foregroundcolor green "$menuResposta"
				Break
			}
		} # Switch RESPOSTA


	} # ELSE ARGS
}

function planilhaNotificacao {
	param(
		$idSheet = '1V5fF38klj31iScKXRML4hEdD0L_hO5gf0NU6Pb9tizc'
	)
	#$plataforma = $PSEdition
	if ($IsWindows){
		Start-Process chrome -ArgumentList --profile-directory=Brenner,https://docs.google.com/spreadsheets/d/$idSheet
	}
	else {
		Start-Job -ScriptBlock {
			param(
				$idSheet = '1V5fF38klj31iScKXRML4hEdD0L_hO5gf0NU6Pb9tizc'
			)
			Start-Process google-chrome-stable -ArgumentList --profile-directory=Brenner,https://docs.google.com/spreadsheets/d/$idSheet
		} -ArgumentList $idSheet
	}

}
function telegram{
	param(
		$urlTelegram = 'https://web.telegram.org/k/'
	)
	#$plataforma = $PSEdition
	if ($IsWindows){
		Start-Process chrome -ArgumentList --profile-directory=Brenner,$urlTelegram
	}
	else {
		Start-Job -ScriptBlock {
			param(
					$urlTelegram = 'https://web.telegram.org/k/'
			)
			Start-Process google-chrome-stable -ArgumentList --profile-directory=Brenner,'https://web.telegram.org/k/'
		} -ArgumentList $urlTelegram
	}
}

##################################################################################################################################################


function cdd {
	#$plataforma = $PSEdition
	if (verificandoPlataforma) {
		cd ~/Desktop
	}
	else{
		cd ~/"Área de [tT]rabalho" # Aqui o konsole já irá para a Área de trabalho do usuário
	}
}

function mpvm {
	param(
		$url
	)
	mpv --window-maximized=yes $url
}

function np {

	param(
		$arquivo
	)
	notepad $arquivo
}

function scpba {

	param(
		$arquivo,
		$hostname
	)
	scp $arquivo $hostname':Área de Trabalho'
}
function criarItem {
	param(
		$nomeItem,
		$tipoDeItem,
		$path
	)
 	New-Item -Name $nomeItem -ItemType $tipoDeItem -Path $path
}


function cattail {
	Get-Content -Tail $args[0] -Path $args[1] -Encoding utf8
}
function cathead {
	Get-Content -TotalCount $args[0] -Path $args[1] -Encoding utf8
}
function envP {
	if (verificandoPlataforma){
		Write-Host -Foregroundcolor DarkRed 'PATH Windowns'
		Write-host -Foregroundcolor DarkGray '------------------------------------'
		$env:Path.split(';')
		Write-host -Foregroundcolor DarkGray '------------------------------------'
		Write-Host -ForegroundColor DarkGray 'total:'.ToUpper() "$env:path".split(':').Length
		Return
	}
	Write-Host -Foregroundcolor DarkGreen 'PATH linux'
	Write-host -Foregroundcolor DarkGray '------------------------------------'
	$env:PATH.Split(':')
	Write-host -Foregroundcolor DarkGray '------------------------------------'
	Write-Host -ForegroundColor DarkGray 'total:'.ToUpper() "$env:PATH".split(':').Length
}

function meuIp{
	if (-not(verificandoPlataforma)){
		ifconfig
	}
	else {
		$meuIp = (ipconfig.exe | Where-Object {$_ -match 'IPv4'} | ForEach-Object { $_ -replace '.*: ', '' })
		write-host $meuIp -foreground DarkCyan
	}
}
function kprofile {
	if (verificandoPlataforma){
		Write-Host -foregroundcolor red "Você está no windows"
		if (-not (Test-Path 'C:\Program Files\Kate\bin\')){
			Write-Host -foregroundcolor red "O kate não existe vamos instala-lo para você"
			Start-Sleep -Seconds 2
			winget install kate
			Start-Job -ScriptBlock {
				kate $args[0]
			} -ArgumentList $PROFILE
		} else {
			Start-Job -ScriptBlock {
				kate $args[0]
			} -ArgumentList $PROFILE
		}
	}
	else {
		if (-not (Test-Path '/usr/bin/kate')){
			Write-Host -foregroundcolor red "Falta o seu kate instalado, vamos instala-lo para você"
			Start-Sleep -Seconds 2
			sudo apt install kate -y
			Start-Job -ScriptBlock {
				kate $args[0]
			} -ArgumentList $PROFILE

		} # Verificando se existe o kate instalado no linux
		else {
			Start-Job -ScriptBlock {
				kate $args[0]
			} -ArgumentList $PROFILE

		}
	}
}
Function kssh {
	$arquivoSsh = 'C:\ProgramData\ssh\sshd_config'
	if (-not(verificandoPlataforma)) {
		$arquivoSsh = '/etc/ssh/sshd_config'
	} # IF
		Try {
			(Get-Command -Name kate -ErrorAction Stop).Source
			Start-Process kate "$arquivoSsh"
		}
		Catch {
			Write-Host Darkgray "Parece que não existe o kate instalado nesse pc. Instale para usa-lo"
			Write-Host -ForegroundColor red "Abrindo com notepad"
			Start-Sleep -Seconds 2
			Start-Process Notepad.exe "$arquivoSsh"
		}


}

function .profile{
	. $PROFILE
}
function dataAtual{
	Param(
		[string]$formato
	)
	if ($formato -match 'br'){
		Get-Date -Uformat %d-%m-%Y
	}
	ElseIf ($formato -match 'eua'){
		Get-Date -Uformat %Y-%m-%d
	}
	else{
		Write-Host 'Não encontrei nenhum formato epecificado' -foregroundcolor red
	}
}
cdd
# Garantir que o módulo PSReadLine esteja carregado
if (-not (Get-Module -ListAvailable PSReadLine)) {
    Import-Module PSReadLine
}

#Set-PSReadLineKeyHandler -Chord Ctrl+y -ScriptBlock {
#    Open-YouTube
#}

Set-PSReadLineKeyHandler -Chord Ctrl+n -ScriptBlock {Start-Process . $PROFILE}
# desligar o pc
Set-PSReadLineKeyHandler -Chord Ctrl+f -ScriptBlock {

if (verificandoPlataforma){
	Stop-Computer -Force
}
else {
	systemctl poweroff -i
}

}
# Reiniciar Pc
Set-PSReadLineKeyHandler -Chord Ctrl+g -ScriptBlock {
	if (verificandoPlataforma){
		Restart-Computer -Force
	}
	else{
		systemctl reboot -i
	}
}
# abrir Whatsapp
#Set-PSReadLineKeyHandler -Chord Ctrl+w -ScriptBlock {abrirWhatsApp}
# abrir Telegram
#Set-PSReadLineKeyHandler -Chord Ctrl+t -ScriptBlock {telegram}
# abri bubble
Set-PSReadLineKeyHandler -Chord Ctrl+b -ScriptBlock {
	$arquivoError = Join-Path -Path $env:HOME/Área` de` Trabalho -ChildPath 'googleError.txt'
	$arquivoSaidaPadrao = Join-Path -Path $env:HOME/Área` de` Trabalho -ChildPath 'googleSaidaPadrao.txt'
	if (verificandoPlataforma){
		Start-Process chrome -ArgumentList '--profile-directory=DIB', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-1&name=escolhaLocomocao&type=custom&version=41h0i', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-3&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados&version=41h0i', 'https://www.sistemaviverbemseguros.com/version-41h0i'
	}
	else {
			start-process google-chrome-stable -ArgumentList '--profile-directory=DIB', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-1&name=escolhaLocomocao&type=custom&version=41h0i', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-3&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados&version=41h0i', 'https://www.sistemaviverbemseguros.com/version-41h0i' -RedirectStandardError $arquivoError -RedirectStandardOutput $arquivoSaidaPadrao
	}

}

# função para abrir url com o perfil do ususario no google chrome
function urlGoogleChrome {

	param(
		$userProfile,
		$urlNavegador,
		$macroChamado
	)
	#write-host  'Voce chamou' $macroChamado.toupper() -foregroundcolor red,green
	if(verificandoPlataforma){
		start-process chrome -ArgumentList --start-maximized,--profile-directory=$userProfile,$urlNavegador  | Out-Null
	}
	else {
		Start-Job -ScriptBlock { Start-Process google-chrome-stable -ArgumentList --start-maximized,--profile-directory=$($args[0]),$($args[1]);exit } -ArgumentList $userProfile,$urlNavegador
	}
}
Set-PSReadLineKeyHandler -Chord Ctrl+w -ScriptBlock {urlGoogleChrome 'DIB' 'https://web.whatsapp.com/' 'whatsApp'}
Set-PSReadLineKeyHandler -Chord Ctrl+t -ScriptBlock {urlGoogleChrome 'Brenner' 'https://web.telegram.org/k/' 'telegram'}
Set-PSReadLineKeyHandler -Chord Ctrl+p -ScriptBlock {urlGoogleChrome 'Brenner' 'https://docs.google.com/spreadsheets/d/1V5fF38klj31iScKXRML4hEdD0L_hO5gf0NU6Pb9tizc' 'planilha notificação'}
Set-PSReadLineKeyHandler -Chord Ctrl+y -ScriptBlock {urlGoogleChrome 'Brenner' 'https://www.youtube.com/' 'youtube'}

#Set-PSReadLineKeyHandler -Chord Ctrl+c -ScriptBlock {urlGoogleChrome 'Brenner' 'https://chatgpt.com/' 'chatgpt'}

function acoesDoSistema {
	param(
		$opcao,
		$tempo,
		$segundo
	)
	shutdown.exe $opcao
}
# Desligando o pc
Set-PSReadLineKeyHandler -Chord Ctrl+0 -ScriptBlock {
	 acoesDoSistema '/p'
}
# reiniciar o pc
Set-PSReadLineKeyHandler -Chord Ctrl+1 -ScriptBlock {
	 acoesDoSistema '/r' '/t' 1
}
# Deslogando o uuário atual
Set-PSReadLineKeyHandler -Chord Ctrl+2 -ScriptBlock {
	 acoesDoSistema '/l'
}
# hibernar o uuário atual
Set-PSReadLineKeyHandler -Chord Ctrl+3 -ScriptBlock {
	 acoesDoSistema '/hybrid'
}

# Escrever markdown no konsole

Function escrever(){

	param(
		$escrita
	)

	write-host $escrita
}

set-PSReadLineKeyHandler -Chord Ctrl+d -ScriptBlock {
	#$plataforma = $PSEdition
	if ($IsWindows) {
		exit
	}

}
set-PSReadLineKeyHandler -Chord Ctrl+h -ScriptBlock { Start-Process 'steam://rungameid/1659040' }

Function arquivo(){
	param(
		$criarArquivo
	)
	#$plataforma = $PSEdition

	# Função de criação de arquivos SHELL
	Function criarShell(){
		param(
			$nomeArquivo
		)
		$plataforma
		if ($IsWindows){
@'
$arquivoLogin='/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh'
$arquivoCor='/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt'
$arquivoNotificacao='/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt'
'@ | Out-File -FilePath "$nomeArquivo" -Encoding UTF8
		} # IF plataforma criarShell
		else {
		Write-Host 'Entrou no ELSE' -foregroundcolor red
@"
#!/usr/bin/env bash
arquivoLogin='/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh'
arquivoCor='/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt'
arquivoNotificacao='/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt'
"@ | Out-File -FilePath "$nomeArquivo" -Encoding UTF8 -Confirm
sudo chmod +x "$nomeArquivo"
		} # ELSE plataforma criarShell
	} # FUNCAO CRIARSHELL

	# Função de criação de arquivos PYTHON
	Function criarPython(){
		param(
			$nomeArquivo
		)
		if ($IsWindows){
@'
import pyautogui as bot
from time import sleep as s
import webbrowser as web
import requests as api
import flet as ft
'@ | Out-File -FilePath "$nomeArquivo" -Encoding UTF8
		} # IF plataforma criarPython
		else {
@'
#!/usr/bin/env python3
import pyautogui as bot
from time import sleep as s
import webbrowser as web
import requests as api
import flet as ft
'@ | Out-File -FilePath "$nomeArquivo" -Encoding UTF8
sudo chmod +x "$nomeArquivo"
		} # ELSE plataforma criarPython
	} # FUNCAO CRIARPYTHON

	# Função de criação de arquivos AWK
	Function criarAwk(){
		param(
			$nomeArquivo
		)
		if ($IsWindows){
@'
BEGIN{
	FS=","
}
# Aqui começa as funções
function nomeFuncao(){

}
END{

}
'@ | Out-File -FilePath "$nomeArquivo" -Encoding UTF8
		} # IF plataforma criarAwk
		else {
@'
#!/usr/bin/env -S awk -f

@include "criarSubscriber.awk"
@include "enviarFluxos.awk"
@include "funcaoNotificarWhatsApp.awk"

# Aqui começa as funções
function nomeFuncao(){

}

BEGIN{
	FS=","
}

END{

}
'@ | Out-File -FilePath "$nomeArquivo" -Encoding UTF8
chmod +x "$nomeArquivo"
		} # ELSE plataforma criarAwk
	} # FUNCAO CRIARAWK

	# Função de criação de arquivos Markdown
	Function criarMarkdown(){
		param(
			$nomeArquivo
		)
$dataAtualMd = $(dataAtual br) + '.md'
$dataAtual = $(dataAtual br)
		if ($IsWindows){
$pathTypora = 'C:\Users\brenner\AppData\Local\Programs\Typora'

$texto = @"
# O que foi criado hoje? $dataAtual
##### 1
##### 2
##### 3
##### 4
##### 5
##### 6
##### 7
##### 8
##### 9
##### 10

"@ | Out-File -FilePath $dataAtualMd -Encoding UTF8
Try {
	$env:PATH.Split(';').Contains("$pathTypora")
	typora "$dataAtualMd"
	Write-Host "Voce tem o typora no path"
	#Exit
}
Catch	{
	Start-Process "$pathTypora" "$dataAtualMd"
}
#typora "$dataAtualMd"
		} # IF plataforma criaMarkdown
		else {
$pathTypora = '/usr/bin/typora'
@"
# VocÊ está no linux
# O que foi criado hoje? $dataAtual
##### 1
##### 2
##### 3
##### 4
##### 5
##### 6
##### 7
##### 8
##### 9
##### 10
"@ | Out-File -FilePath $dataAtualMd -Encoding UTF8
Try {
	(Get-Command -Name typora -ErrorAction Stop | Out-Null).Definition
	typora "$dataAtualMd"
	Write-Host "Voce tem o typora no path"
	#Exit
}
Catch	{
	Start-Process "$pathTypora" "$dataAtualMd"
}

		} # ELSE plataforma criaMarkdown
	} # FUNCAO CRIARMARKDOWN
Function criarPs1 {
	Write-Host -ForegroundColor red $criarArquivo
	if ($IsWindows){
		Write-Host -ForegroundColor red "ESTA NO WINDOWS"
		$diretorioPadrao = Join-Path -Path $env:HOMEPATH -ChildPath "Desktop"
		Write-Host "$diretorioPadrao"
		@"
notificar = Join-Path -Path "$diretorioPadrao" -ChildPath notificarWhatsApp.ps1
"@ | Out-File -FilePath "$diretorioPadrao/$criarArquivo" -Encoding Utf8
Start-Process kate "$diretorioPadrao/$criarArquivo"
	}
	else {
		# Definindo o diretório da área de trabalho
$diretorioPadrao = Join-Path -Path $env:HOME -ChildPath 'Área de Trabalho'
Write-Host -ForegroundColor DarkGreen "LINUX"
Write-Host "$diretorioPadrao"

# Nome do arquivo a ser criado
$criarArquivo = $criarArquivo

# Caminho completo do arquivo
$arquivoCaminho = Join-Path -Path $diretorioPadrao -ChildPath $criarArquivo

# Criar o conteúdo e salvar no arquivo
@"
notificar = Join-Path -Path "$diretorioPadrao" -ChildPath notificarWhatsApp.ps1
"@ | Out-File -FilePath $arquivoCaminho -Encoding Utf8

# Abrir o arquivo com o Kate, garantindo que o caminho com espaços seja tratado corretamente
sudo chmod +x "$arquivoCaminho"
Start-Process "kate" -ArgumentList "`"$arquivoCaminho`""


	}
} # FUNCAO CRIARPS1


	if ($criarArquivo){
		switch -Wildcard ($criarArquivo) {
			"*.sh"{
					Write-Host 'Seua arquivo é SH'
					criarShell $criarArquivo # chamando a função de criar arquivos em shell
			} # Opção 1 SH
			"*.py"{
					Write-Host 'Seua arquivo é py'
					criarPython $criarArquivo # chamando a função de criar arquivos em python
			} # Opção 2 PY
			"*.awk"{
					Write-Host 'Seua arquivo é AWK'
					criarAwk $criarArquivo # chamando a função de criar arquivos em awk
			} # Opção 3 awk
			"*.md"{
					Write-Host 'Seua arquivo é MARKDOWN'
					criarMarkdown $criarArquivo # chamando a função de criar arquivos em awk
			}
			"*.ps1"{
					Write-Host 'Seua arquivo é PS1'
					criarPs1 $criarArquivo # chamando a função de criar arquivos em ps1
			}
			Default {
					Write-Host 'Encontrei nada aqui'
			}

			}# SWITCH
	}

	#switch($criarArquivo){

	#}
}

###### ALIAS #####################################################################################################################
# Aqui vem o nome que você deseja que alias tenha
$novoNomeAlias = @(
	'nitem',
	'cat'
	#'nsp'
)
# Aqui é o nome dos CMD LET
$nomeCMDLet = @(
	'New-Item',
	'Get-Content',
	'New-ScriptFileInfo'
)

for ($i=0;$i -le $novoNomeAlias.Length-1;$i++){
	#Write-Host -foregroundcolor green "Configurando o nome de $($novoNomeAlias[$i]) para o CMD LET $($nomeCMDLet[$i])"

	if ($i -ne 2){
		New-Alias -Name $($novoNomeAlias[$i]) -Value $($nomeCMDLet[$i]) -ErrorAction Ignore
		Continue
	}
	#Write-Host -Foregroundcolor red "Agora é o numero 2222222222"; Start-Sleep -Seconds 5
	New-Alias -Name $($novoNomeAlias[$i]) -Value $($nomeCMDLet[$i]) -Description "Só teste mesmo" -ErrorAction Ignore
}

#################################################################################################################################


if (verificandoPlataforma){
	Try {
		$arquivoPs1 = 'Microsoft.PowerShell_profile.ps1'
		Invoke-WebRequest "https://raw.githubusercontent.com/brennerdib951066/gitpowershell/refs/heads/main/$arquivoPs1" -OutFile "$HOME/Desktop/powershell/$arquivoPs1" -ErrorAction Stop
	}
	Catch {
		Write-Host ""
	}
}
else {
	$arquivoPs1 = 'Microsoft.PowerShell_profile.ps1'
	# Configurando para que o powershell ignorar o case dos diretorios
	$pastaDestino = (Get-ChildItem "$HOME" -Filter "Área de Trabalho" -Directory | Where-Object { $_.Name -ieq "Área de Trabalho" }).FullName
	Invoke-WebRequest "https://raw.githubusercontent.com/brennerdib951066/gitpowershell/refs/heads/main/$arquivoPs1" -OutFile "$pastaDestino/powershell/$arquivoPs1"
}

<# if (verificandoPlataforma){
	# Adicionando diretorios no PATH do sistema
	Write-Host -Foregroundcolor blue "Adicionando seus path"
	Start-Sleep -Seconds 1
	$diretoriosPath = @(
	"$env:USERPROFILE\Desktop",
	"$env:USERPROFILE\Desktop\powershell",
	"$env:USERPROFILE\Desktop\py",
	"C:\Program Files\Kate\bin",
	"C:\Program Files\Flameshot\bin",
	"C:\Program Files\REAPER (x64)",
	"C:\Program Files\Google\Chrome\Application\",
	"C:\Program Files\Typora",
	"C:\Program Files\obs-studio\bin\64bit"
	)

	foreach ($diretorio in $diretoriosPath){
		Write-Host -Foregroundcolor green "$diretorio"
		if ($env:PATH -split ';' | Where-Object { $_ -eq $diretorio }) {
			#Write-Output "O $diretorio já está no PATH."
			Continue
		} else {
			Write-Host -ForegroundColor red "Falatava esse diretorio $diretorio"
			[System.Environment]::SetEnvironmentVariable("Path", "$env:Path;$diretorio", [System.EnvironmentVariableTarget]::User)
		}

	}
}
#>

Set-PSReadlineKeyHandler -Chord Ctrl+o -ScriptBlock {peek}

# Função para criar arquivos em ps1

Function nsp {
	Try {
		New-ScriptFileInfo -Path $($args[0]) -Description $($args[1]) -ErrorAction Stop
		kate $($args[0])
		Write-Host -ForegroundColor green $($args[0]) $($args[1])
	}
	Catch {
		Write-Host -ForegroundColor red "Já existe o seu script" $($args[0]).ToUpper()
		kate $($args[0])
	}
}

Set-PSReadLineKeyHandler -Chord Ctrl+i -ScriptBlock {
	Try {
		Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge_proxy.exe"  -ArgumentList --profile-directory=Default,--app-id=khiogjgiicnghciboipemonlmgelhblf,--app-url=https://copilot.microsoft.com/?dpwa=1,--app-launch-source=4 -ErrorAction Stop

	}
	Catch {
			Write-Host -ForegroundColor DarkRed 'Erro ao inicializar o copilot'
	}
}

Function sshb {
	$usuarioSsh = 'brennersshb'
	$ipSsh = '31.220.88.74'

	if (-not($ISWindows)) {
		if (-not ($env:USER -eq 'brenner')) {
			$usuarioSsh = 'denner'
		}
	}
	else {
		if (-not($Env:USERNAME -eq 'brenner')){
			$usuarioSsh = 'denner'
		}
	}

		ssh $usuarioSsh@$ipSsh
}

Function sshbw {
	$usuarioSsh = 'brenner'
	$ipSsh = '192.168.0.2'

	if (-not($ISWindows)) {
		if (-not ($env:USER -eq 'brenner')) {
			$usuarioSsh = 'denner'
		}
	}
	else {
		if (-not($Env:USERNAME -eq 'brenner')){
			$usuarioSsh = 'denner'
		}
	}

		ssh $usuarioSsh@$ipSsh
}

Function b {
	$shell = 'bash'
	if (-not(verificandoPlataforma)){
		Try {
			(Get-Command -Type Application -Name $shell -ErrorAction Stop).Source | Out-Null
			exec $shell
		}
		Catch {
			Write-Host -ForegroundColor DarkRed "erro ao executar o $shell".ToUpper()
			#Exit
		}

	}
}

Function chatgpt {
		$url = 'https://chatgpt.com/'
		$profile = 'Brenner'
		$arquivoError = Join-Path -Path $env:HOME/Área` de` Trabalho -ChildPath 'googleError.txt'
		$arquivoSaidaPadrao = Join-Path -Path $env:HOME/Área` de` Trabalho -ChildPath 'googleSaidaPadrao.txt'

		if (-not(verificandoPlataforma)) {
			Start-Process google-chrome-stable -ArgumentList --profile-directory=$profile,"$url" -RedirectStandardError "$arquivoError" -RedirectStandardOutput "$arquivoSaidaPadrao"
			#Exit
		}
		else {
			# Caso seja windows cairá aqui
			chrome --profile-directory=$profile "$url"
		}
}

Function fcrontab {
	if (-not(verificandoPlataforma)){
		if ($args[0]) {
		$filtro = (grep -i "$($args[0])".ToLower() /etc/crontab)
		Write-Host -ForegroundColor DarkGreen "$filtro"
		} else {
				Write-Host -ForegroundColor Red 'Mande um padrão para buscar no crontab'
		}
	} # IF VERIFICANDOPLATAFORMA

}
