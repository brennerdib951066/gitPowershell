
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
}

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
'@ | Out-File -FilePath "$env:USERPROFILE\desktop\powershell\permissaoAdministrativo.ps1" -Encoding utf8

}

If (-not(Test-Path "$env:USERPROFILE\desktop\powershell")) {
    Write-Host "A pasta powershell não existe, criando..."
    New-item -Type Directory -Path "$env:USERPROFILE\desktop\powershell"
}
If (-not(Test-Path "$env:USERPROFILE\desktop\powershell\permissaoAdministrativo.ps1")) {
    Write-Host "O arquivo permissaoAdministrativo.ps1 não existe, criando..."
    New-Item -Type File -Path "$env:USERPROFILE\desktop\powershell\permissaoAdministrativo.ps1"
    criarArquivoAdministrativo

}
# VerIficar se o usuário está como usuario administrativo
$permissao = "$env:USERPROFILE\desktop\powershell\permissaoAdministrativo.ps1"
. "$permissao"
If (Test-Admin) {
    Write-Host -ForegroundColor DarkRed "Não aceito terminal administrativo, use-me como usuário comum".ToUpper()
    Exit
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
        Write-Host "Mande algum parametro"
        Exit
}

Switch ("$($Args[0])") {
    1 {
        $valor = 'bBs75Nt9UY4'
        $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
        Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
        # Usando o mpv para tocar o album escolhido

        mpv --fs "https://www.youtube.com/watch?v=$valor"
        Exit

    }
    2 {
        $valor = '092yCfekvhI'
        $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
        Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
        # Usando o mpv para tocar o album escolhido

        mpv --fs "https://www.youtube.com/watch?v=$valor"
        Exit
    }

    3 {
        $valor = 'XYI57pJOxoA'
        $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
        Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
        # Usando o mpv para tocar o album escolhido

        mpv --fs "https://www.youtube.com/watch?v=$valor"
        Exit
    }

    4 {
        $valor = 'vW8kWoNjBng'
        $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
        Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
        # Usando o mpv para tocar o album escolhido

        mpv --fs "https://www.youtube.com/watch?v=$valor"
        Exit
    }

    5 {
        $valor = 'yOFgec0nX7U'
        $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
        Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
        # Usando o mpv para tocar o album escolhido

        mpv --fs "https://www.youtube.com/watch?v=$valor"
        Exit
    }

    6 {
        $valor = 'UX0ohdQESEM'
        $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
        Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
        # Usando o mpv para tocar o album escolhido

        mpv --fs "https://www.youtube.com/watch?v=$valor"
        Exit
    }

    7 {
        $valor = 'x7KYjjUMLwU3D'
        $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
        Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
        # Usando o mpv para tocar o album escolhido

        mpv --fs "https://www.youtube.com/watch?v=$valor"
        Exit
    }

    8 {
        $valor = 'TaMZL03TYwk'
        $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
        Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
        # Usando o mpv para tocar o album escolhido

        mpv --fs "https://www.youtube.com/watch?v=$valor"
        Exit
    }

    9 {
        $valor = 'bHOGzhD2lpg'
        $albumAtual = $albumSergioLopes.GetEnumerator() | Where-Object {$_.Value -eq "$valor"} | Select-Object  -ExpandProperty Key
        Write-Host -ForegroundColor DarkYellow "$albumAtual".ToUpper()
        # Usando o mpv para tocar o album escolhido

        mpv --fs "https://www.youtube.com/watch?v=$valor"
        Exit
    }
}

ForEach ($chave in $albumSergioLopes.Keys) {
    Write-Host -ForegroundColor DarkYellow "Abrindo o album $chave, $($albumSergioLopes[$chave])"
    mpv "https://www.youtube.com/watch?v=$($albumSergioLopes[$chave])]"
}

