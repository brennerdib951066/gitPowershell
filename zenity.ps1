
<#PSScriptInfo

.VERSION 1.0

.GUID 60adbec4-1e04-453b-abca-dac8946141fd

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
 criar com zenity interface grafica para poder visualizar exemplos de comandos

#>
$versao = '1.0.0.0.3'
$programa = 'zenity'.Tolower()
$textoInstalacao = 'deseja instalar? [S/n]'
$pathPrograma = (Get-Command -Name $programa -ErrorAction ignore).Source
# Aplique aqui seus arquivos de comandos de exemplos do shell gnu-linux

$menuPrincipal = @(
    'useradd',
    'userdel',
    'usermod',
    'split',
    'fusoHorario',
    'inputrc',
    'kdeglobal',
    'mapFile',
    'passwd',
    'tail',
    'uniq',
    'xdotool'
)
Function instalarZenity {
    #$textoInstalacao = 'deseja instalar? [S/n]'
    While ($True) {
        $resposta = Read-Host -Prompt $textoInstalacao.ToUpper()
        if ($resposta){
            Break
        }
    }
    $resposta = $resposta.Tolower()

    Switch ($resposta) {

        's' {
            Write-Host -ForegroundColor Yellow "Instalando" "$programa".ToUpper()
            sudo apt install zenity -y
            clear
        } # resposta SIM
        'n' {
            Write-Host -ForegroundColor Yellow "OK"
            Exit
        } # resposta NÃO
        Default {
            Write-Host -ForegroundColor red "Escolha S ou n"
            Start-Sleep -Seconds 2
            instalarZenity
        }

    } # SWITCH
} # FUNçÃO INSTALR ZENITY

Function mostrarArquivo {
    Try {
        Get-Content -Path "$($args[0])" -ErrorAction Stop
    }
    Catch {
        Write-Host -ForegroundColor DarkRed "Erro ao exibir | $($args[1]) |".ToUpper()
    }
}

Function menu {
    # Criando um menu para mostra a usuário

    For ($i=0;$i -le $menuPrincipal.Length - 1;$i++){
        if ($i -eq 0) {
                Write-Output  "menu principal".ToUpper() "--------------------"
                Write-Host -ForegroundColor DarkYellow "Versão $versao"
                Write-Host ""
        }
        Write-Host -ForegroundColor DarkGray $i")" "$($menuPrincipal[$i])".ToUpper()
        if ($i -eq $menuPrincipal.Count - 1){
                Write-Host -ForegroundColor Gray "--------------------"
                #Continue
        }


    }
    $n = 0
    While ($True){
        $opcao = Read-Host -Prompt "($n/3) Opção"
        if ($opcao){
            Try {
                [int]$opcao = $opcao
                Break
            }
            Catch {
            if ($n -eq 3) {
                Write-Host -ForegroundColor DarkYellow "Você atingiu a quantidade de tentativas disponíveis!"
                Exit
            }
                Write-Host -ForegroundColor Red "Aceito apenas numero"
            $n += 1
            }
        }
        else {
            if ($n -eq 3) {
                Write-Host -ForegroundColor DarkYellow "Você atingiu a quantidade de tentativas disponíveis!"
                Exit
            }
            $n += 1
            Write-Host -ForegroundColor DarkRed "Sua resposta está vazio"

        }
    }

    Switch ($opcao){
        0 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[0]).txt" "$($menuPrincipal[0]).txt".ToUpper()
            #clear
            menu
        } # CASE 0
        1 {
            mostrarArquivo  "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[1]).txt" "$($menuPrincipal[1]).txt".ToUpper()
            #clear
            menu
        } # CASE 1
        2 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[2]).txt" "$($menuPrincipal[2]).txt".ToUpper()
            #clear
            menu
        }# CASE 2
        3 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[3]).txt" "$($menuPrincipal[3]).txt".ToUpper()
            #clear
            menu
        }# CASE 3
        4 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[4]).txt" "$($menuPrincipal[4]).txt".ToUpper()
            #clear
            menu
        }# CASE 4
        5 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[5]).txt" "$($menuPrincipal[5]).txt".ToUpper()
            #clear
            menu
        }# CASE 5
        6 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[6]).txt" "$($menuPrincipal[6]).txt".ToUpper()
            #clear
            menu
        }# CASE 6
        7 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[7]).txt" "$($menuPrincipal[7]).txt".ToUpper()
            #clear
            menu
        }# CASE 7
        8 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[8]).txt" "$($menuPrincipal[8]).txt".ToUpper()
            #clear
            menu
        }# CASE 8
        9 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[9]).txt" "$($menuPrincipal[9]).txt".ToUpper()
            #clear
            menu
        }# CASE 9
        10 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[10]).txt" "$($menuPrincipal[10]).txt".ToUpper()
            #clear
            menu
        }# CASE 10
        11 {
            mostrarArquivo "/usr/bin/dibScripts/shells/comandos/$($menuPrincipal[11]).txt" "$($menuPrincipal[11]).txt".ToUpper()
            #clear
            menu
        }# CASE 11
        Default {
            Write-Host -ForegroundColor Yellow "$opcao não é opção válida!"
            Start-Sleep -Seconds 2
            clear
            menu
        }
    } # SWICTH CASE $OPCAO
}

if ($IsWindows) {
 Write-Host -ForegroundColor red 'Você está no windows, por isso não poderá usar a interface zenity'
 Exit
}
if (-not(Test-Path "$pathPrograma")){
    Write-Host -ForegroundColor red 'Você precisa do zenity instalado'
    instalarZenity

} # CAHMANDO A FUNÇÃO DE INSTALAR O ZENITY

menu

<# Se ja estiver instalado vai cair aqui
zenity --text='zinity' --title='zenity' --info
#>

