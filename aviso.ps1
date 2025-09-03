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

# Caso o diretorio $diretorioRelatorioPadrao não exista!
if (-not (Test-Path $diretorioRelatorioPadrao)) {
    Try {
        New-Item -Type Directory -Path $diretorioRelatorioPadrao -ErrorAction Stop
    }
    Catch {
        Write-Host -ForegroundColor Red "Erro ao criar $diretorioRelatorioPadrao"
    }
}

if (-not (Test-Path $arquivoAvisoPadrao)) {
    @'
Apenas texto criado automaticamente!
'@ | Out-File -FilePath $arquivoAvisoPadrao -Encoding utf8
}


if (-not $args[0]) {
    Write-host -ForegroundColor Yellow 'Por favor envie:'
    Write-host -ForegroundColor Yellow 'titulo[0], tipo de aviso[1]'.ToUpper()
    Exit
}

if (-not $args[2]) {
    $versaoApi = 'version-live'

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
    Invoke-WebRequest -URI $urlApi -Method PATCH -Headers $herader -Body (@{
'tituloAviso' = $args[0]
'textoDoAviso' = @((Get-Content -Path $arquivoAvisoPadrao -Raw))
'tipoAvisoDisplay' = $args[1]} | ConvertTo-Json) -ErrorAction Stop
 Write-Host -ForegroundColor DarkGreen "Mensagem enviada para versão $versaoApi!"
}

Catch {
    Write-Host -ForegroundColor Red "Error".ToUpper()
}


