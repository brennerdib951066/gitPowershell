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
			Start-Process google-chrome-stable -ArgumentList --profile-directory=Brenner,https://docs.google.com/spreadsheets/d/'1V5fF38klj31iScKXRML4hEdD0L_hO5gf0NU6Pb9tizc'
		}
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
			Start-Process google-chrome-stable -ArgumentList --profile-directory=Brenner,'https://web.telegram.org/k/'
		}
	}
}

##################################################################################################################################################


function cdd {
	$plataforma = $PSEdition
	if ($plataforma.Tolower() -eq 'desktop') {
		cd ~/Desktop
	}
	else{
		cd ~/$env:areaDeTrabalhoUsuario # Aqui o konsole já irá para a Área de trabalho do usuário
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


function catt{
	cat -TotalCount $arquivo
}
function envP {
	$env:Path.split(';')
}

function meuIp{
	$meuIp = (.\ipconfig.exe | Where-Object {$_ -match 'IPv4'} | ForEach-Object { $_ -replace '.*: ', '' })
	write-host $meuIp -foreground DarkCyan
}
function kprofile {
	kate $PROFILE
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
Set-PSReadLineKeyHandler -Chord Ctrl+f -ScriptBlock {Stop-Computer -Force}
# Reiniciar Pc
Set-PSReadLineKeyHandler -Chord Ctrl+g -ScriptBlock {Restart-Computer -Force}
# abrir Whatsapp
#Set-PSReadLineKeyHandler -Chord Ctrl+w -ScriptBlock {abrirWhatsApp}
# abrir Telegram
#Set-PSReadLineKeyHandler -Chord Ctrl+t -ScriptBlock {telegram}
# abri bubble
Set-PSReadLineKeyHandler -Chord Ctrl+b -ScriptBlock {start-process chrome -ArgumentList '--profile-directory=DIB', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-1&name=escolhaLocomocao&type=custom', 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-3&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados', 'https://www.sistemaviverbemseguros.com/version-test'}

# função para abrir url com o perfil do ususario no google chrome
function urlGoogleChrome {

	param(
		$userProfile,
		$urlNavegador,
		$macroChamado
	)
	write-host  'Voce chamou' $macroChamado.toupper() -foregroundcolor red,green
	start-process chrome -ArgumentList --start-maximized,--profile-directory=$userProfile,$urlNavegador
}
Set-PSReadLineKeyHandler -Chord Ctrl+w -ScriptBlock {urlGoogleChrome 'DIB' 'https://web.whatsapp.com/' 'whatsApp'}
Set-PSReadLineKeyHandler -Chord Ctrl+t -ScriptBlock {urlGoogleChrome 'Brenner' 'https://web.telegram.org/k/' 'telegram'}
Set-PSReadLineKeyHandler -Chord Ctrl+p -ScriptBlock {urlGoogleChrome 'Brenner' 'https://docs.google.com/spreadsheets/d/1V5fF38klj31iScKXRML4hEdD0L_hO5gf0NU6Pb9tizc' 'planilha notificação'}
Set-PSReadLineKeyHandler -Chord Ctrl+y -ScriptBlock {urlGoogleChrome 'Brenner' 'https://www.youtube.com/' 'youtube'}
Set-PSReadLineKeyHandler -Chord Ctrl+b -ScriptBlock {urlGoogleChrome 'DIB' 'https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-1&name=escolhaLocomocao&type=custom https://bubble.io/page?id=viverbemseguroscrm&tab=tabs-3&name=escolhaLocomocao&type=custom&subtab=Data+Types&type_id=outros_dados https://www.sistemaviverbemseguros.com/version-test' 'bubble'}
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
@'
#!/usr/bin/env bash
arquivoLogin='/usr/bin/dibScripts/shells/stable/bibliotecas/credenciais/credencial.sh'
arquivoCor='/usr/bin/dibScripts/shells/stable/bibliotecas/cor/cores.txt'
arquivoNotificacao='/usr/bin/dibScripts/shells/stable/bibliotecas/notificacao/notificarWhatsApp.txt'
'@ | Out-File -FilePath "$nomeArquivo" -Encoding UTF8 -Confirm
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

BEGIN{
	FS=","
}
# Aqui começa as funções
function nomeFuncao(){

}
END{

}
'@ | Out-File -FilePath "$nomeArquivo" -Encoding UTF8
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






