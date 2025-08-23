<#
	 a versão '1.0.0.16' foram adicionados
	Foi adicionando a função para abrir a hashtag programcao

#>

$versao = '1.0.0.15'
$versaoPowershell = $PSVersionTable.PSVersion


if (-not ($versaoPowershell -match 7)) {
	Write-Error "use a versão 7 do powershell".ToUpper()
	Exit
}


function matarProcess {
	For ($i=0;$i -le $args.Length -1 ;$i++) {
		Stop-Process -Name "$($args[$i])"
	}
	# FOR
}

function verificandoPlataforma(){
		##$plataforma = $PSEdition
		if (-not($isWindows)) {
			#Write-Host -foregroundcolor red "É WINDOWSSSS"
			Return $False
		}
		Return $True
}

################################Função de ações do sistema####################################################################################

function reboot {
	#$plataforma = $PSEdition
	if (-not($IsWindows)){
			systemctl reboot -i
	}
	Start-Sleep -Seconds 5
	Start-Job -ScriptBlock {
		Restart-Computer -Force
	}
}
function poweroff {
	#$plataforma = $PSEdition
	if (-not($IsWindows)){
		systemctl poweroff -i
		Return

	}
	Stop-Computer -Force
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
	if (-not($IsWindows)){
		Start-Job -ScriptBlock {
			param(
				$idSheet = '1V5fF38klj31iScKXRML4hEdD0L_hO5gf0NU6Pb9tizc'
			)
			Start-Process google-chrome-stable -ArgumentList --profile-directory=Brenner,https://docs.google.com/spreadsheets/d/$idSheet
		} -ArgumentList $idSheet # START-JOB
		Return
	} # IF $ISWINDOWS
	Start-Process chrome -ArgumentList --profile-directory=Brenner,https://docs.google.com/spreadsheets/d/$idSheet

}
function telegram{
	param(
		$urlTelegram = 'https://web.telegram.org/k/'
	)
	#$plataforma = $PSEdition
	if ($IsWindows){
		Start-Job -ScriptBlock {
			param(
					$urlTelegram = 'https://web.telegram.org/k/'
			)
			Start-Process google-chrome-stable -ArgumentList --profile-directory=Brenner,'https://web.telegram.org/k/'
		} -ArgumentList $urlTelegram # START-PROCESS
	} # IF $ISWINDOWS
	Start-Process chrome -ArgumentList --profile-directory=Brenner,$urlTelegram
}

##################################################################################################################################################


function cdd {
	#$plataforma = $PSEdition
	if (-not(verificandoPlataforma)) {
		$padrao = $(xdg-user-dir DESKTOP)
		cd "$padrao"
		Return
	}
	cd "$env:USERPROFILE\Desktop"
	<#else{
		cd ~/"Área de [tT]rabalho" # Aqui o konsole já irá para a Área de trabalho do usuário
	}
	#>
}

function mpvm {
	param(
		$url
	)
	mpv --fs "$url" --cookies
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
	if (-not(verificandoPlataforma)){
		Write-Host -Foregroundcolor DarkGreen 'PATH linux'
		Write-host -Foregroundcolor DarkGray '------------------------------------'
		$env:PATH.Split(':')
		Write-host -Foregroundcolor DarkGray '------------------------------------'
		Write-Host -ForegroundColor DarkGray 'total:'.ToUpper() "$env:PATH".split(':').Length
		Return
	} # IF VERIFICANDO PLATAFORMA
	Write-Host -Foregroundcolor DarkRed 'PATH Windowns'
	Write-host -Foregroundcolor DarkGray '------------------------------------'
	$env:Path.split(';')
	Write-host -Foregroundcolor DarkGray '------------------------------------'
	Write-Host -ForegroundColor DarkGray 'total:'.ToUpper() "$env:path".split(':').Length

}

function meuIp{
	if (-not(verificandoPlataforma)){
		ip -c a | grep -iwE '^.+inet.*wlo1$' | cut -d' ' -f6 | cut -d'/' -f1
		Return
	}
	$meuIp = (ipconfig.exe | Where-Object {$_ -match 'IPv4' -and $_ -notmatch '172'} | ForEach-Object { $_ -replace '.*: ', '' })
	write-host $meuIp -foreground DarkCyan
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
	if (-not(verificandoPlataforma)){
		systemctl reboot -i
		Return
	}
	Restart-Computer -Force
}
# abrir Whatsapp
#Set-PSReadLineKeyHandler -Chord Ctrl+w -ScriptBlock {abrirWhatsApp}
# abrir Telegram
#Set-PSReadLineKeyHandler -Chord Ctrl+t -ScriptBlock {telegram}
# abri bubble
Set-PSReadLineKeyHandler -Chord Ctrl+b -ScriptBlock {
	$padrao = "$env:USERPROFILE\Desktop\saidaPadraoPowershell"
	if (-not (verificandoPlataforma)) {
		$padrao = Join-Path -Path $(xdg-user-dir DESKTOP) -ChildPath "saidaPadraoPowershell"
	}

	$arquivoError = Join-Path -Path "$padrao" -ChildPath 'googleError.txt'
	$arquivoSaidaPadrao = Join-Path -Path "$padrao" -ChildPath 'googleSaidaPadrao.txt'
	if (-not(Test-Path "$arquivoError")) {
		New-Item -Type File -Path "$arquivoError"
	}
	if (-not(Test-Path "$arquivoSaidaPadrao")) {
		Write-Host "Nao existe"
		New-Item -Type File -Path "$arquivoSaidaPadrao"
	}
	if (verificandoPlataforma){
		Start-Process chrome -ArgumentList '--profile-directory=DIB', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-1&name=escolhaLocomocao&type=custom&version=022ip', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-3&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados&version=022ip', 'https://www.sistemaviverbemseguros.com/version-022ip'
	}
	else {
			start-process google-chrome-stable -ArgumentList '--profile-directory=DIB', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-1&name=escolhaLocomocao&type=custom&version=022ip', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-3&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados&version=022ip', 'https://www.sistemaviverbemseguros.com/version-022ip' -RedirectStandardError "$arquivoError" -RedirectStandardOutput "$arquivoSaidaPadrao"
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
	if(-not(verificandoPlataforma)){
		Start-Job -ScriptBlock { Start-Process google-chrome-stable -ArgumentList --start-maximized,--profile-directory=$($args[0]),$($args[1]);exit } -ArgumentList $userProfile,$urlNavegador
		Return
	}
	start-process chrome -ArgumentList --start-maximized,--profile-directory=$userProfile,$urlNavegador  | Out-Null
} # FUNÇAO URMGOOGLECROME
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
if (verificandoPlataforma){
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
} # IF


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
		Invoke-WebRequest "https://raw.githubusercontent.com/brennerdib951066/gitpowershell/refs/heads/main/$arquivoPs1" -OutFile "$USERPROFILE/Desktop/powershell/$arquivoPs1" -ErrorAction Stop
		Copy-Item "$USERPROFILE/Desktop/powershell/$arquivoPs1" "$PROFILE"
	}
	Catch {
	}
}
else {
	$arquivoPs1 = 'Microsoft.PowerShell_profile.ps1'
	# Configurando para que o powershell ignorar o case dos diretorios
	$pastaDestino = (Get-ChildItem "$HOME" -Filter "Área de Trabalho" -Directory | Where-Object { $_.Name -ieq "Área de Trabalho" }).FullName
		Try {
			Invoke-WebRequest "https://raw.githubusercontent.com/brennerdib951066/gitpowershell/refs/heads/main/$arquivoPs1" -OutFile "$pastaDestino/powershell/$arquivoPs1" -ErrorAction Stop
		}
		Catch {
		}
	Copy-Item "$pastaDestino/powershell/$arquivoPs1" "$PROFILE" -ErrorAction Ignore
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

Set-PSReadlineKeyHandler -Chord Ctrl+o -ScriptBlock {
	if (-not($IsWindows)) {
		exec sudo su
	}
}

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
	$ipSsh = '192.168.0.4'

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
		$padrao = "$env:USERPROFILE\Desktop"
		if (-not (verificandoPlataforma)) {
			$padrao = $(xdg-user-dir DESKTOP)
		}

		$arquivoError = Join-Path -Path "$padrao" -ChildPath 'googleError.txt'
		$arquivoSaidaPadrao = Join-Path -Path "$padrao" -ChildPath 'googleSaidaPadrao.txt'
		if (-not(Test-Path "$arquivoError")) {
			New-Item -Type File -Path "$arquivoError" | Out-Null
		}
		if (-not(Test-Path "$arquivoSaidaPadrao")) {
			Write-Host "Nao existe"
			New-Item -Type File -Path "$arquivoSaidaPadrao" | Out-Null
		}

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


	# No terminal se for teclado 1, ele irá setar o tema windows para tema CLARO
	Set-PSReadLineKeyHandler -Chord Alt+1 -ScriptBlock {
		if (verificandoPlataforma){
			reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 1 /f
			reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f
		} # IF
	}
	# No terminal se for teclado 1, ele irá setar o tema windows para tema ESCURO
	Set-PSReadLineKeyHandler -Chord Alt+0 -ScriptBlock {
		if (verificandoPlataforma){
			reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d 0 /f
			reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f
		} # IF
	}
	#

# No terminal teclar ctrl+A abrir o atende chat pedrinho da nasa
Set-PSReadLineKeyHandler -Chord ctrl+a -ScriptBlock {
	$diretorioChrome = 'C:\Program Files\Google\Chrome\Application'
	$carecter = ";"
	$nomePath = 'path'.Toupper()
	if (-not(verificandoPlataforma)){
		$diretorioChrome = '/usr/bin'
		$carecter = ":"
	}
	if ($env:PATH.Split("$carecter") -contains "$diretorioChrome") {
		#Write-Host -ForegroundColor green 'Existe sim seu chrome no PATH windows'
		if (verificandoPlataforma){
			chrome --profile-directory='DIB' 'https://centraldechat.sistemaviverbemseguros.com/#/atendimento/contatos'
		}
		else {
			google-chrome-stable --profile-directory='DIB' 'https://centraldechat.sistemaviverbemseguros.com/#/atendimento/contatos'
		}

	}
	else {
		Write-Host -ForegroundColor red 'Adicione seu chrome no path'
		if (verificandoPlataforma){
			Start-Process "$diretorioChrome\chrome.exe" -ArgumentList --profile-directory='DIB','https://centraldechat.sistemaviverbemseguros.com/#/atendimento/contatos'
		}
		else {
			google-chrome-stable --profile-directory='DIB' 'https://centraldechat.sistemaviverbemseguros.com/#/atendimento/contatos'
		}

	}

}

function corDesktop {
	param(
			[string]$cor
		)
		Switch ($cor) {
			'd' {
				if (-not(verificandoPlataforma)) {
					$cor = 'light'
				}
				else {
					#Write-Host "VOce que o modo dia para Windows"
					#Start-Sleep -Seconds 3
					[int]$cor = 1
				}
			}
			'n' {
				if (-not(verificandoPlataforma)) {
					$cor = 'dark'
				}
				else {
					#Write-Host "VOce que o modo NOITE para Windows"
					#Start-Sleep -Seconds 3
					[int]$cor = 0
				}
			}
		} # SWICTH
		if (-not (verificandoPlataforma)) {
			$distro = $env:DESKTOP_SESSION.ToLower()
			Switch ($distro) {
				{'plasma' -or 'plasmawayland'} {
					Start-Process plasma-apply-desktoptheme "breeze-$cor" -RedirectStandardOutput 'ver.txt'
					$cor = $cor.Substring(0,1).ToUpper() + $cor.Substring(1).ToLower()
					Start-Process plasma-apply-colorscheme Breeze$cor -RedirectStandardOutput 'ver.txt'
					Return
				} # CASE PLASMA
			} # SWICTH DISTRO

		}
		#-WindowStyle Minimized
		#Start-Process reg -ArgumentList add,"HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize", /v, "AppsUseLightTheme", /t, REG_DWORD, /d, "$cor", /f
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "SystemUsesLightTheme" /t REG_DWORD /d $cor /f
		reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d $cor /f

} # FUNCAO CORDESKTOP

Function hastag {
	Try {
		$areaDeTrabalho = Join-Path -Path $Env:USERPROFILE -ChildPath 'Desktop'
		$diretorioPowershell = Join-Path "$areaDeTrabalho" -ChildPath 'powershell'
		$diretorioBiblioteca = Join-Path "$diretorioPowershell" -ChildPath 'bibliotecas'
		$arquivoBibliotecaHastag = Join-Path "$diretorioBiblioteca" -ChildPath 'hastagProgramacao.ps1'
		. $arquivoBibliotecaHastag
	}
	Catch {
	}
	if (-not $args[0]) {
		if (-not ($IsWindows)) {
			$areaDeTrabalho = (xdg-user-dir DESKTOP)
			$diretorioPowershell = Join-Path "$areaDeTrabalho" -ChildPath 'gitPowershell'
			$diretorioBiblioteca = Join-Path "$diretorioPowershell" -ChildPath 'bibliotecas'
			$arquivoBibliotecaHastag = Join-Path "$diretorioBiblioteca" -ChildPath 'hastagProgramacao.ps1'
			. $arquivoBibliotecaHastag

			google-chrome-stable --profile-directory='DIB' "$urlAtual"
			Return
		} # IF $ISWINDOWS
			chrome  --profile-directory='DIB' "$urlAtual"
			Return
	} # IF SE ARGS[0] for vazio
	# Se ARGS[0] contiver algo cai aqui
	$args[0] = $args[0].ToLower()
	Switch ($args[0]) {
		'html' {
			if (-not $IsWindows) {
				$areaDeTrabalho = (xdg-user-dir DESKTOP)
				$diretorioPowershell = Join-Path "$areaDeTrabalho" -ChildPath 'gitPowershell'
				$diretorioBiblioteca = Join-Path "$diretorioPowershell" -ChildPath 'bibliotecas'
				$arquivoBibliotecaHastag = Join-Path "$diretorioBiblioteca" -ChildPath 'hastagProgramacao.ps1'
				. $arquivoBibliotecaHastag
				ForEach ($valor in $url.keys) {
					if ($valor -ne $args[0]) {
						Continue
					}
					$urlAtual = $url[$valor]
				} # FOR
				google-chrome-stable --profile-directory='DIB' "$urlAtual"
				Return
			}
				ForEach ($valor in $url.keys) {
					if ($valor -ne $args[0]) {
						Continue
					}
					$urlAtual = $url[$valor]
				} # FOR
			chrome  --profile-directory='DIB' "$urlAtual"
			Return
		} # SWITCH CASE HTML
		'javascript' {
			if (-not $IsWindows) {
				$areaDeTrabalho = (xdg-user-dir DESKTOP)
				$diretorioPowershell = Join-Path "$areaDeTrabalho" -ChildPath 'gitPowershell'
				$diretorioBiblioteca = Join-Path "$diretorioPowershell" -ChildPath 'bibliotecas'
				$arquivoBibliotecaHastag = Join-Path "$diretorioBiblioteca" -ChildPath 'hastagProgramacao.ps1'
				. $arquivoBibliotecaHastag

				ForEach ($valor in $url.keys) {
					if ($valor -ne $args[0]) {
						Continue
					}
					$urlAtual = $url[$valor]
				}
				google-chrome-stable --profile-directory='DIB' "$urlAtual"
				Return
			}
			ForEach ($valor in $url.keys) {
					if ($valor -ne $args[0]) {
						Continue
					}
					$urlAtual = $url[$valor]
			}
			chrome  --profile-directory='DIB' "$urlAtual"
			Return
		} # SWITCH CASE AAVASCRIPT
		'python' {
			if (-not $IsWindows) {
				$areaDeTrabalho = (xdg-user-dir DESKTOP)
				$diretorioPowershell = Join-Path "$areaDeTrabalho" -ChildPath 'gitPowershell'
				$diretorioBiblioteca = Join-Path "$diretorioPowershell" -ChildPath 'bibliotecas'
				$arquivoBibliotecaHastag = Join-Path "$diretorioBiblioteca" -ChildPath 'hastagProgramacao.ps1'
				. $arquivoBibliotecaHastag

				ForEach ($valor in $url.keys) {
					if ($valor -ne $args[0]) {
						Continue
					}
					$urlAtual = $url[$valor]
				}
				google-chrome-stable --profile-directory='DIB' "$urlAtual"
				Return
			}
			ForEach ($valor in $url.keys) {
					if ($valor -ne $args[0]) {
						Continue
					}
					$urlAtual = $url[$valor]
			}
			chrome  --profile-directory='DIB' "$urlAtual"
			Return
		} # SWITCH CASE AAVASCRIPT

	} # SWITCH CASE

}
# Criando uma função que altera o brilho da tela
Function brilho {
	if (-not $ISWINDOWS) {
		if (-not $args[0]) {
			Return Write-Host -BackgroundColor blue 'Mande 2500 por exemplo'
		}
		if ($args[0] -notMatch '[0-9]+') {
			return Write-Host -BackgroundColor blue 'Por favor somente numeros'
		}
		if ($args[0] -lt 2500 -And $args[0] -ne 8000) {
			Write-Host -BackgroundColor blue 'Use 2500 = 10%'
			Write-Host -BackgroundColor blue 'Use 8000 = 42%'
			Return
		}

		if ($ENV:XDG_CURRENT_DESKTOP) {
			$interaceGrafica = ($ENV:XDG_CURRENT_DESKTOP).ToLower()
			if ($interaceGrafica -ne 'kde') {
				return Write-Host -BackgroundColor red 'Não é KDE'
			} # CASO NÃO SEJA KDE
			if ($ENV:KDE_SESSION_VERSION -lt 6) {
				return Write-Host -BackgroundColor red 'Vixe escolha a versão 6 do KDE'
			} # CASO A VERSÂO NÃO SEJA 6
			Write-Host -BackgroundColor green 'Parabens sua versão é a 6 ah mais recente!'
			qdbus6 org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl setBrightness $args[0]
		}
		else {
			Write-Host -BackgroundColor 'Olha não existe a variavél XDG_CURRENT_DESKTOP no linux atual'
		}
	} # IF Caso seja LINUX

}
Function luzAzul {
		if (-not $args[0]) {
			Return Write-Host -BackgroundColor Yellow 'Chame pelo meu nome e depois digite o valor 7500 por exemplo'
		}
		if (-not $ISWINDOWS) {
			if ($ENV:XDG_CURRENT_DESKTOP) {
				$interfaceGrafica = ($ENV:XDG_CURRENT_DESKTOP).ToLower()
				if ($interfaceGrafica -ne 'kde') {
					Return Write-Host -BackgroundColor DarkRed 'Seu motor de interface grafica não é KDE'
				}
				if ($ENV:KDE_SESSION_VERSION -lt 6) {
					Return Write-Host -BackgroundColor DarkRed 'Por favor use a versão 6 do KDE'
				}
				# Configurando a luz azul da tela
				kwriteconfig6 --file kwinrc --group NightColor --key NightTemperature $args[0] && kwin_x11 --replace &
			}
		}
}







