function verificandoPlataforma(){
		$plataforma = $PSEdition
		if ($plataforma.Tolower() -eq 'desktop') {
			Write-Host -foregroundcolor red "É WINDOWSSSS"
			Return $True
		}
		else {
			Write-Host -foregroundcolor red "É LINUXXXXXXXX"
			Return $False
		}
}

################################Função de ações do sistema####################################################################################

function reboot {
	$plataforma = $PSEdition
	if ($plataforma.Tolower() -eq 'desktop'){
		Restart-Computer -Force
	}
	else {
		systemctl reboot -i
	}

}
function poweroff {
	$plataforma = $PSEdition
	if ($plataforma.Tolower() -eq 'desktop'){
		Stop-Computer -Force
	}
	else {
		systemctl poweroff -i
	}
}

##################################################################################################################################################


################################Função de google chrome###########################################################################################
function gitHub(){
    param(
        $profile,
        $repositorio,
        $arquivoRepositorio
    )

	if ($args.Length -gt 0){

		if (verificandoPlataforma) {
			Start-Process chrome -ArgumentList "--profile-directory=$profile", "https://github.com/brennerdib951066/$repositorio/blob/main/$arquivoRepositorio"
		} else {
			Start-Job -ScriptBlock {
				param($profile, $repositorio, $arquivoRepositorio)
				Start-Process google-chrome-stable -ArgumentList "--profile-directory=$profile", "https://github.com/brennerdib951066/$repositorio/blob/main/$arquivoRepositorio"
			} -ArgumentList $profile, $repositorio, $arquivoRepositorio
		} # IF PLATAFORMA
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
	$plataforma = $PSEdition
	if ($plataforma.Tolower() -eq 'desktop'){
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
	$plataforma = $PSEdition
	if ($plataforma.Tolower() -eq 'desktop'){
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
	$plataforma = $PSEdition
	if ($plataforma.Tolower() -eq 'desktop') {
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
	mpv --window-minimized=yes $url
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
	$env:Path.split(';')
}

function meuIp{
	$meuIp = (.\ipconfig.exe | Where-Object {$_ -match 'IPv4'} | ForEach-Object { $_ -replace '.*: ', '' })
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
	if (verificandoPlataforma){
		start-process chrome -ArgumentList '--profile-directory=DIB', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-1&name=escolhaLocomocao&type=custom', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-3&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados', 'https://www.sistemaviverbemseguros.com/version-test'
	}
	else {
			start-process google-chrome-stable -ArgumentList '--profile-directory=DIB', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-1&name=escolhaLocomocao&type=custom', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-3&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados', 'https://www.sistemaviverbemseguros.com/version-test'
	}

}

# função para abrir url com o perfil do ususario no google chrome
function urlGoogleChrome {

	param(
		$userProfile,
		$urlNavegador,
		$macroChamado
	)
	write-host  'Voce chamou' $macroChamado.toupper() -foregroundcolor red,green
	if(verificandoPlataforma){
		start-process chrome -ArgumentList --start-maximized,--profile-directory=$userProfile,$urlNavegador -RedirectStandardOutput /dev/null
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
	$plataforma = $PSEdition
	if ($plataforma.Tolower() -eq 'desktop') {
		exit
	}

}
set-PSReadLineKeyHandler -Chord Ctrl+h -ScriptBlock { Start-Process 'steam://rungameid/1659040' }

Function arquivo(){
	param(
		$criarArquivo
	)
	$plataforma = $PSEdition

	# Função de criação de arquivos SHELL
	Function criarShell(){
		param(
			$nomeArquivo
		)
		$plataforma
		if ($plataforma.Tolower() -eq 'desktop'){
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
		if ($plataforma.Tolower() -eq 'desktop'){
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
		if ($plataforma.Tolower() -eq 'desktop'){
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
		if ($plataforma.Tolower() -eq 'desktop'){


$texto = @"
# O que foi criado hoje? $dataAtual
#### SETORES
1. Comercial
!["IMAGEM"]()
####  Backends
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
- [ ] Testado?
2. Administrativo
!["IMAGEM"]()
####  Backends
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
 [ ] Testado?
2. Financeiro
!["IMAGEM"]()
####  Backends
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
- [ ] Testado?

"@ | Out-File -FilePath $dataAtualMd -Encoding UTF8
		} # IF plataforma criaMarkdown
		else {
@"
# VocÊ está no linux
# O que foi criado hoje? $dataAtual
#### SETORES
1. Comercial
!["IMAGEM"]()
####  Backends
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
- [ ] Testado?
2. Administrativo
!["IMAGEM"]()
####  Backends
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
 [ ] Testado?
2. Financeiro
!["IMAGEM"]()
####  Backends
- [ ] ###### Exemplo1
- [ ] ###### Exemplo2
- [ ] ###### Exemplo3
- [ ] ###### Exemplo4
- [ ] Testado?
"@ | Out-File -FilePath $dataAtualMd -Encoding UTF8
		} # ELSE plataforma criaMarkdown
	} # FUNCAO CRIARMARKDOWN



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
	'cat',
	'nsp'
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

	$arquivoPs1 = 'Microsoft.PowerShell_profile.ps1'
	wget "https://raw.githubusercontent.com/brennerdib951066/gitpowershell/refs/heads/main/$arquivoPs1" -O "$HOME/Desktop/powershell/$arquivoPs1"
}
else {
	$arquivoPs1 = 'Microsoft.PowerShell_profile.ps1'
	# Configurando para que o powershell ignorar o case dos diretorios
	$pastaDestino = (Get-ChildItem "$HOME" -Filter "Área de Trabalho" -Directory | Where-Object { $_.Name -ieq "Área de Trabalho" }).FullName
	Invoke-WebRequest "https://raw.githubusercontent.com/brennerdib951066/gitpowershell/refs/heads/main/$arquivoPs1" -OutFile "$pastaDestino/powershell/$arquivoPs1"
}

