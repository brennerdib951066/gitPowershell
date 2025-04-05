
<#PSScriptInfo

.VERSION 1.0

.GUID e28354c4-787f-42d3-adac-5e7181498b7f

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
 Para ouvir musicas e albuns de sergio lopes
XYI57pJOxoA
#>

$programas = @(
    'mpv',
    'yt-dlp'
)
$albumSergioLopes = @{
    'vidas e futuros' = 'bBs75Nt9UY4'
    'selecao de ouro' = '092yCfekvhI'
    'lentilhas' = 'XYI57pJOxoA'
    'libertação' = 'vW8kWoNjBng'
    'galátas' = 'yOFgec0nX7U'
    'o sétimo' = 'UX0ohdQESEM'
    'canaan' = 'x7KYjjUMLwU3D'
    'getsemani' = 'TaMZL03TYwk'
    'yeshua' = 'bHOGzhD2lpg'
    'sonhos' = 'jGgCtexyt9g'
}

$listaAlbuns = @(
    'vidas e futuros',
    'selecao de ouro',
    'lentilhas',
    'libertação',
    'galátas',
    'o sétimo',
    'canaan',
    'getsemani',
    'yeshua',
    'sonhos'
)
$diretorioPOwershell = "$env:USERPROFILE\desktop\powershell"
$arquivoAdministrativo = Join-Path -Path "$diretorioPOwershell" -ChildPath 'permissaoAdministrativo.ps1'


# Função para criar o arquivo do powershell administrativo
Function criarArquivoAdministrativo {
@'
     # Função que verIfica se o usuário atual é um administrador
function Test-Admin {
    # Obtém a identidade do usuário atual
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()

    # Cria um objeto principal a partir da identidade
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)

    # VerIfica se o usuário está no grupo de administradores
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}
'@ | Out-File -FilePath "$($args[0])" -Encoding utf8

} # FUNÇAO CIRARARQAUIVOADMINISTRATIVO

# Function menu

If (-not ($psVersionTable.Platform -match 'Win32NT')) {
    Write-Host "Você está no linux"
    $diretorioPOwershell = "$(xdg-user-dir DESKTOP)\powershell"
    $arquivoAdministrativo = Join-Path -Path "$diretorioPOwershell" -ChildPath 'permissaoAdministrativo.ps1'
    $usuarioAtual = "$env:USER"
}

If (-not(Test-Path "$diretorioPOwershell")) {
    Write-Host "A pasta powershell não existe, criando..."
    New-item -Type Directory -Path "$diretorioPOwershell" -ErrorAction Ignore | Out-Null
    Start-Sleep -Seconds 3
}
If (-not(Test-Path "$arquivoAdministrativo")) {
    Write-Host "O arquivo permissaoAdministrativo.ps1 não existe, criando..."
    New-Item -Type File -Path "$arquivoAdministrativo" -ErrorAction Ignore | Out-Null
    criarArquivoAdministrativo "$arquivoAdministrativo"
    Start-Sleep -Seconds 3

}
# VerIficar se o usuário está como usuario administrativo

if (-not ($psVersionTable.Platform -match 'Win32NT')) {
    if ($usuarioAtual -match 'root') {
        Write-Host -ForegroundColor DarkRed "Voce está como root, use-me como usuário comum!"
        Exit
    }
}

If (-not ($psVersionTable.Platform -match 'unix')) {
    $permissao = "$arquivoAdministrativo"
    . "$permissao"
    if (Test-Admin){
        Write-Host -ForegroundColor DarkRed "Não aceito terminal administrativo, use-me como usuário comum".ToUpper()
        Exit
    }
}

# VerIficar programas instalados
For ($i = 0;$i -lt $programas.Length;$i++) {
    Try {
        Get-Command "$($programas[$i])" -ErrorAction Stop | Out-Null
        #Start-Sleep -Seconds 2
    }
    Catch {
        Write-Host -ForegroundColor DArkRed "Não encontramos o programa $($programas[$i]) no sistema"
        Exit
    } # CATCH VERIfICANDO PROGRAMA
} # FOR VERIfICAR PROGRAMAS INSTALADOS
#Exit

If (-not("$($Args[0])")) {
        Write-Host -ForegroundColor darkGray "Mande algum parametro ou insira n para o menu interativo"
        Write-Host -ForegroundColor DarkGray "exemplo:".ToUpper()
        Write-HOst -ForegroundColor Gray "___________________________"
        Write-Host -ForegroundColor DarkRed 'musicasSergioLopes.ps1 n'
        Exit
}

Function menuNaoInterativo {

    if (-not ($args[1])){
            if ($funcaoChamada -ne 2) {
                $funcaoChamada = 1
            }
            else {
                Write-Host -ForegroundColor DarkRed "Seu argumento dois está vazio, saindo agora"
                Start-Sleep -Seconds 5
                Exit
            }
    } # IF ARGS[1]
    Switch ("$($Args[0])") {

        1 {
            $valor = 'bBs75Nt9UY4'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 1
            menuNaoInterativo ($opcao+1)
            #Exit

        }
        2 {
            $valor = '092yCfekvhI'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 2
            menuNaoInterativo ($opcao+1)
            #Exit
        }

        3 {
            $valor = 'XYI57pJOxoA'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 3
            menuNaoInterativo ($opcao+1)
            #Exit
        }

        4 {
            $valor = 'vW8kWoNjBng'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 4
            menuNaoInterativo ($opcao+1)
            #Exit
        }

        5 {
            $valor = 'yOFgec0nX7U'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 5
            menuNaoInterativo ($opcao+1)
            #Exit
        }

        6 {
            $valor = 'UX0ohdQESEM'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 6
            menuNaoInterativo ($opcao+1)
            #Exit
        }

        7 {
            $valor = 'x7KYjjUMLwU3D'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 7
            menuNaoInterativo ($opcao+1)
            #Exit
        }

        8 {
            $valor = 'TaMZL03TYwk'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 8
            menuNaoInterativo ($opcao+1)
            #Exit
        }

        9 {
            $valor = 'bHOGzhD2lpg'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 9
            menuNaoInterativo ($opcao+1)
            #Continue
            #Exit
        }
        10 {
            $valor = 'jGgCtexyt9g'
            $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
            Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
            # Usando o mpv para tocar o album escolhido

            mpv --window-minimized "https://www.youtube.com/watch?v=$valor"
            $funcaoChamada++
            $opcao = 1
            menuNaoInterativo $opcao
            #Exit
        }
        <#Default {

        }
        #>
    } # SWICTH
} # FUNÇAO NAO menuNaoInterativo
menuNaoInterativo "$($args[0])"
Write-Host -ForegroundColor DarkYellow "albuns sergio lopens".ToUpper()
For ($i = 0 ; $i -lt $listaAlbuns.Length ; $i++){

    <#if ($i -eq $listaAlbuns.Length) {
        Exit
    }
    #>
    Write-Host -ForegroundColor darkGray "$($i+1)) $($listaAlbuns[$i])".ToUpper()
}
While ($True){
    $opcao = Read-Host "opção ".ToUpper()
    if ($opcao) {
        if (-not($opcao -as [int])) {
            #if (-not($opcao -ge 1 -and $opcao -le 9)){
                Write-Host -ForegroundColor DarkRed "Somente numeros de 1 á 9"
                Remove-Variable opcao
                Continue
            #}
            #Break
        }
        $opcao = [int]$opcao
        if ($opcao -eq 0 -or $opcao -ge 11) {
                Write-Host -ForegroundColor DarkRed "Escolha numero entre 1 e 9"
                Remove-Variable opcao
                Continue
        }
        Write-Host -ForegroundColor DArkGreen "Entrada válida!"
        Break
    }
}
menuNaoInterativo "$opcao"
# Chamndo o menu

<#ForEach ($chave in $albumSergioLopes.Keys) {
    Write-Host -ForegroundColor DarkYellow "Abrindo o album $chave, $($albumSergioLopes[$chave])"
    mpv "https://www.youtube.com/watch?v=$($albumSergioLopes[$chave])]"
}
#>
