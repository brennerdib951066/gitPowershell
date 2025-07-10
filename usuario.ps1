$areaDeTrabalho = "$Env:USERPROFILE/Desktop"
$diretorioPowershell = "$areaDeTrabalho/powershell"
$arquivoNotificacao = "$diretorioPowershell/notificarWhatsApp.ps1"
$arquivoPermissao = "$diretorioPowershell/permissaoAdministrativo.ps1"
$versaoPowershell = 7
$versaoPowershellCmdLet = $PsVersionTable.PSVersion.Major
$opcaoLista = @(
    '-c',
    '-r',
    '-d',
    '-a'
)

Try {
    . $arquivoNotificacao
    . $arquivoPermissao
}
Catch {
}

if (-not (Test-Admin)) {
    Write-Host -ForegroundColor DarkRed 'use o usuário administrativo para usar-me!'.ToUpper()

}

if ($versaoPowershellCmdLet -lt $versaoPowershell) {
    Write-Host -ForegroundColor DarkRed 'Use o powershell na versão 7 ou mais'.ToUpper()
    Exit
}

Function criarUsuario ($sistema,$conta,$senha) {

    if (-not $sistema) {
        Write-Host 'Voce é lINUX GAROTO'
        Return
    }
    # Caso seja Windows caiará aqui
    if (-not $conta) {
            Try {

            While ($True) {
                $nomeUsuario = Read-Host -Prompt (Write-Host -ForegroundColor DarkRed 'NOme Usuário: '.ToUpper())
                if ($nomeUsuario -notMatch '[A-Za-z]+') {
                    aviso 'Apenas texto por favor' 'erro'
                    Continue
                }
                Break
            } # WHILE
            While ($True) {
                $senhaUsuario = Read-Host -AsSecureString 'senha Usuário'.ToUpper()
                "$senhaUsuario SENHA"
                if (-not $senhaUsuario) {
                    aviso 'Por favor insira algo como senha' 'erro'
                    Continue
                }
                Break
            } # WHILE
            $nomeUsuario = $nomeUsuario.ToLower()
            $senhaUsuario = $senhaUsuario

            New-LocalUser -Name "$nomeUsuario" -Password $senhaUsuario
            add-LocalGroupMember -Group "Administradores" -Member $nomeUsuario -ErrorAction Stop
            aviso "Usuario $nomeUsuario criado com sucesso!"
            While ($True) {
                if (-not $resposta) {
                    $resposta = Read-Host -Prompt 'deslogar para ver o novo usuário criado?[S/n]'
                    Continue
                } # IF $RESPOSTA
                if (-not ($resposta -Match '[A-Za-z]+')) {
                    Write-Host -ForegroundColor DarkRed 'Por favor use apenas texto'
                    Remove-Variable resposta
                    Continue
                } # $RESPOSTA Match
                $resposta = $resposta.ToLower()
                if (-not ($resposta -eq 's' -or $resposta -eq 'n')) {
                    Write-Host -ForegroundColor DarkYellow 'Escolha entre S ou N!'
                    Remove-Variable resposta
                    Continue
                }
                $resposta
                Start-Sleep -Seconds 5
                Break
            } # WHILE
            Switch ($resposta) {
                    's' {
                        shutdown.exe /l
                    }
                    'n' {
                        'Valeu então'
                    }

                    Default {
                        'escolha um padrão'
                        Exit
                    }
            } # SWITCH
        }
        Catch {
            aviso 'Error ao criar seu usuario Windows'
        }
} # IF
if (-not $senha) {
    while ($True) {
        if (-not $senhaUsusario) {
            $senhaUsusario = Read-Host -AsSecureString 'senha'
            Start-Sleep -Seconds 10
            Continue
        }

    } # WHILE

} # IF
$nomeUsuario = $conta.ToLower()
Try {
    Get-LocalUser -Name $nomeUsuario -ErrorAction Stop
    aviso "$nomeUsuario, ja existe!"
    Exit
}
Catch {

}
# o Argumento 2 $args[2], já será convertida automaticamente no arqumento passado via konsole

$senhaUsuario = ConvertTo-SecureString -String "$senha" -AsPlainText -Force
Try {
    New-LocalUser -Name $nomeUsuario -Password $senhaUsuario | Out-Null
    add-LocalGroupMember -Group "Administradores" -Member $nomeUsuario -ErrorAction Stop
    aviso "$nomeUsuario, criado com sucesso!"
}
Catch {
    aviso 'algum erro fatal' 'erro'
    Write-Error $_
}

}

Function removerUsuario ($sistema,$contaUsuario) {

    if (-not $sistema) {
        Write-Host 'Voce é lINUX GAROTO'
        Return
    }
    if (-not $contaUsuario) {
        # Caso seja Windows caiará aqui
        Try {
            Remove-LocalUser -Name ($nomeUsuario =Read-Host -Prompt 'nome usuário remover'.ToUpper()) -ErrorAction Stop | Out-Null

            aviso "Usuario $nomeUsuario foi removeido permanentemente com sucesso!"
        }
        Catch {
            aviso 'Error ao remover usuario Windows' 'erro'
        }
        Return
    } # IF

    Try {
        Remove-LocalUser -Name "$contaUsuario" -ErrorAction stop
    } # TRY
    Catch {
        aviso "Não consegiomos remover $contaUsuario" 'erro'
    }
}

Function desabilitarUsuario ($sistema,$conta) {
        echo $conta
        if (-not $conta) {
            While ($True) {
                if ($nomeUsuarioDesbilitar) {
                    Break
                }
                $nomeUsuarioDesbilitar = Read-host -Prompt 'Nome usuário desabilitar:'
            }
            if (-not ($nomeUsuarioDesbilitar -Match '[A-Za-z]+')) {
                    aviso 'Precisa ser no formato de texto'
                    Exit
            }
            # Verificando se o usuário existe
            Try {
                Get-LocalUser -Name "$nomeUsuarioDesbilitar" -ErrorAction stop | Out-Null
                Disable-LocalUser -Name "$nomeUsuarioDesbilitar" -ErrorAction stop | Out-Null
                aviso "$nomeUsuarioDesbilitar disabilitado"
            }
            Catch {
                aviso "Usuário $($nomeUsuarioDesbilitar.ToUpper()), não encontrado" 'erro'
                Exit
            }
            $nomeUsuarioDesbilitar = $nomeUsuarioDesbilitar.ToLower()
        } # IF $ARGS[1]
        # Acso venha o paramentro $arg[1] com valor caiara aqui
        Try {
            Disable-LocalUser -Name "$conta" -ErrorAction Stop
        }
        Catch {
            aviso "$conta não encontrado!" 'erro'
        }


}

Function ativarUsusario ($sistema,$conta) {

    if (-not $conta) {
        While ($True) {
            $nomeUsuario = Read-Host -Prompt $(Write-Host -ForegroundColor red 'ativar o usuario:'.ToUpper())

            if ($nomeUsuario -notMatch '[A-Za-z]+') {
                aviso 'Por favor use apenas texto'.ToUpper() 'erro'
            }
            $nomeUsuario = $nomeUsuario.ToLower()
            Try {
                Get-LocalUser -Name $nomeUsuario -ErrorAction stop | Out-Null
                Enable-LocalUser -Name $nomeUsuario
                aviso "$nomeUsuario, ativado com sucesso"
                Exit
            } # TRY
            Catch {
                aviso "$nomeUsuario não existe!" 'erro'
                Exit
            } # CATCH

        } # WHILE

    } # IF
    $conta = $conta.ToLower()
    Try {
        Get-LocalUser -Name $conta -ErrorAction stop | Out-Null
    }
    Catch {
        aviso "$conta não é usuário local!" 'erro'
        Exit
    }
    Enable-LocalUser -Name $conta
    aviso "$conta, ativado com sucesso!"

}

Function aviso ($aviso,$tipoAviso='sucesso') {
    if ($tipoAviso -Match 'SUCESSO') {
        Return Write-Host -ForegroundColor Green "$aviso".ToUpper()

    }
    Write-Host -ForegroundColor Red "$aviso".ToUpper()
}

Function sistemaOperacional {
    Return $IsWindows
}

Function ajuda ($texto) {
    $texto
}

if (-not $args[0] -or -not $args[0] -Match '^0.*$') {
    aviso 'Use paramentros para proseguir'
ajuda @'
MENU AJUDA:
Opções

-c : Cria um novo usuário para o sistema
-r : Remove o usuario existente do sistema
-d : Desativar o usuário
-a : Ativar usuário
'@
    Exit
} # IF $ARGS[0]

if ($args[0] -Match '^0.*$') {
    aviso 'Nada de zero!'
    Exit
}

if (-not ($args[0] -Match '[A-Za-z]+')) {
    aviso 'Use apenas texto'
    Exit
}

# Transformando a entrado usuario para minuscula
$args[0] = $args[0].ToLower()
Switch ($args[0]) {
    $opcaoLista[0] {
        # aviso "VocE digitou a opção $($opcaoLista[0])"

        criarUsuario sistemaOperacional $args[1] $args[2]
        Break
    }
    $opcaoLista[1] {
        # aviso "VocE digitou a opção $($opcaoLista[1])"
        removerUsuario sistemaOperacional $args[1] $args[2]
    }
    $opcaoLista[2] {
        # aviso "VocE digitou a opção $($opcaoLista[1])"
        desabilitarUsuario sistemaOperacional $args[1]
    } #
     $opcaoLista[3] {
        # aviso "VocE digitou a opção $($opcaoLista[1])"
        ativarUsusario sistemaOperacional $args[1]
    } #
} # SWITCH


