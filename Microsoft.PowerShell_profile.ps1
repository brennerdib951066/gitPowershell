$diretorioPadrao = $env:USERPROFILE
$areaDeTrabalho = "$diretorioPadrao/Desktop"
$diretorioRelatorioPadrao = "$areaDeTrabalho/relatorioDaniele"
$arquivoAvisoPadrao = "$diretorioRelatorioPadrao/muralDoAviso"

$versaoApi = 'version-222is'
$UID = '1717789538187x815929419743296500'
$urlApi = "https://www.sistemaviverbemseguros.com/$versaoApi/api/1.1/obj/muralDoAviso/$UID"
$chaveApi = '5b2a5efbc5fda2ffff948979031ac33a'

$herader = @{
    'Content-Type' = 'Application/json'
    'Authorization' = "Bearer $chaveApi"
}


# Verificações

# Verificando a versão
if ($psVersionTable.PSVersion.Major -lt 7) {
    Write-host -ForegroundColor Yellow 'Seu powershell deve ser na versão 7 ou superior'
    Exit
}

# Verificando se não é WINDOWS
if (-not ($IsWindows)) {
    $areaDeTrabalho = (xdg-user-dir DESKTOP)
    $diretorioRelatorioPadrao = Join-Path -Path $areaDeTrabalho -ChildPath 'relatorioDaniele'
    $arquivoAvisoPadrao = Join-Path -Path $diretorioRelatorioPadrao -ChildPath 'muralDoAviso'

    if ($env:USER -match 'root' ) {
        Write-host -ForegroundColor Yellow 'Nada de ROOT'
        Exit
    }
}

if (-not $args[0]) {
    Write-host -ForegroundColor Yellow 'Por favor envie:'
    Write-host -ForegroundColor Yellow 'titulo[0], tipo de aviso[1]'.ToUpper()
    Exit
}

# Caso o diretorio $diretorioRelatorioPadrao não exista!
if (-not (Test-Path $diretorioRelatorioPadrao)) {
    Try {
        New-Item -Type Directory -Path $diretorioRelatorioPadrao -ErrorAction Stop | Out-Null
    }
    Catch {
        Write-Host -ForegroundColor Red "Erro ao criar $diretorioRelatorioPadrao"
    }
}

if (-not (Test-Path $arquivoAvisoPadrao)) {
    @'
Passando para informa-lo que nós estamos nos focando neste momento em [b]FUNÇÕES para o setor FINANCEIRO[/b], então para este setor aqui está [i]lista[/i] das [b]FUNCIONALIDADE[/b], que logo estarão disponíveis:[hr]
[list] [*] [url="https://c73cb1067cdf154944fa6442290ea297.cdn.bubble.io/f1756908135291x688094220004048800/mudancaEmMassaDeCoresFinanceiro.png?_gl=1*6c8l5v*_gcl_au*MTcwMTI1NTMxNS4xNzU2NzUzOTg4*_ga*MTQ1NTQwNDA3NS4xNzUyMTU0ODM0*_ga_BFPVR2DEE2*czE3NTY4OTMyNzMkbzI1JGcxJHQxNzU2OTA4MjEyJGo0NyRsMCRoMA.."][color=orange][b][i]Mudança de cores em massa[/i][/b][/color][/url] [size=1px][color=#1a838b63](Click-me)[/color][/size] [*] [url="https://c73cb1067cdf154944fa6442290ea297.cdn.bubble.io/f1756926968142x350320246661960400/cargoAtual.png?_gl=1*13h26vf*_gcl_au*MTcwMTI1NTMxNS4xNzU2NzUzOTg4*_ga*MTQ1NTQwNDA3NS4xNzUyMTU0ODM0*_ga_BFPVR2DEE2*czE3NTY4OTMyNzMkbzI1JGcxJHQxNzU2OTI2ODk4JGo2MCRsMCRoMA.."][color=orange][b][i]Pesquisa por cargo[/i][/b][/color][/url] [size=1px][color=#1a838b63](Click-me)[/color][/size] [*] [color=orange][b][i]Envio em massa de mensagem para os clientes[/i][/b][/color] [size=1px][size=1px][color=#1a838b63](Click-me)[/color][/size][/size] [/list]
'@ | Out-File -FilePath $arquivoAvisoPadrao -Encoding utf8
}


if (-not $args[2]) {
    $versaoApi = 'version-live'
    $urlApi = "https://www.sistemaviverbemseguros.com/$versaoApi/api/1.1/obj/muralDoAviso/$UID"
    While ($True) {
        $respostaVersaoApi = Read-Host -Prompt "A versão atual é $($versaoApi.ToUpper()), deseja continuar com esta versão?[S/n]"

        if ($respostaVersaoApi -notMatch '[A-Za-z]+') {
            continue
        }

        if ($respostaVersaoApi -notMatch 's') {
            if ($respostaVersaoApi -notMatch 'n') {
                Write-Host -ForegroundColor Red 'Opah escolha entre sim ou não!'
                continue
            }
            $versaoApi = 'version-222is'

            #Break
        }
        Break

    }
}

<#
$args[0] = $args[0].ToLower()
$args[1] = $args[1].ToLower()
#>
$args[0] = $args[0].ToUpper()
Switch ($args[1]) {
    'comum' {
        $args[1] = 'comum'
    } # COMUM

    'importante' {
        $args[1] = 'importante'
    } # IMPORTANTE

    'mega importante' {
        $args[1] = 'mega importante'
    } # IMPORTANTE
    Default {
        Write-Host -ForegroundColor DarkRed 'Por favor o seu tipo de aviso[1] deve ser: 'comum','importante' ou 'mega importante''
        Exit
    }
}



Try {
    <#$requisicao =#> (Invoke-WebRequest -URI $urlApi -Method PATCH -Headers $herader -Body (@{
'tituloAviso' = $args[0]
'textoDoAviso' = @((Get-Content -Path $arquivoAvisoPadrao -Raw))
'tipoAvisoDisplay' = $args[1]} | ConvertTo-Json) -ErrorAction Stop)
 Write-Host -ForegroundColor DarkGreen "Mensagem enviada para versão $versaoApi!"

}

Catch {
    Write-Host -ForegroundColor Red "Error na API".ToUpper()
}


