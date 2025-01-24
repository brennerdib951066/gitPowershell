$diretorioPowershell = "$Env:HOMEPATH\Desktop\powershell"
$permissao = "$env:HOMEPATH\Desktop\powershell\permissaoAdministrativo.ps1"
$programaSSH = ' OpenSSH.Server'

if (-not($IsWindows)) {
    Write-Host -ForegroundColor DarkYellow "Sistema operacional aceito, somente windows"
    Exit
}

if (-not(Test-Admin)){
    Write-Host -ForegroundColor DarkYellow "Preciso de permissões administrativas para prosseguir"
    Exit
}

if (-not(Test-Path "$diretorioPowershell")) {
    New-Item -Type Directory -Path "$diretorioPowershell"
    # Se não existir o arquivo de permissão criar
    if (-not(Test-Path "$permissao")){
@'
# Função que verifica se o usuário atual é um administrador
function Test-Admin {
    # Obtém a identidade do usuário atual
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()

    # Cria um objeto principal a partir da identidade
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)

    # Verifica se o usuário está no grupo de administradores
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}
'@
    } # IF $PERMISSAO
} # IF $diretorioPowershell

. $permissao
Try {
    $status = (Get-Service -Name sshd -ErrorAction Stop).Status
    Switch ($status) {
        'running'.ToLower() {
            Write-Host -ForegroundColor Green "Seu ssh está em execução"
        } # CASE RUNIING
        'stopped'.ToLower() {
            Write-Host -ForegroundColor red "SSH está parado vamos inicializa-lo"

            Start-Sleep -Seconds 1
            Try {
                    Restart-Service -Name sshd -ErrorAction Stop
                    Start-Sleep -Seconds 1
                    Write-Host -ForegroundColor DarkGreen "Inicalizado com sucesso"
                }
              Catch {
                    Write-Host -ForegroundColor "Erro ao inicilizar seu OPEN SSH"
                }
        } # CASE stopped
        Default {
            Write-Host 'Caiu no default'
        }
    } # CASE
} # TRY
Catch {
    Write-Host -ForegroundColor DarkRed "Voce não tem o SSH instalado"
    Try {
        add-WindowsCapability -Online -Name "$programaSSH" -ErrorAction Stop
        Restart-Service -Name sshd -ErrorAction Stop
        Write-Host -ForegroundColor DarkGreen "baixado com suecsso".ToUpper()
        Start-Sleep -Seconds 1

    }
    Catch {
        Write-Host -ForegroundColor DarkRed "Não consegui baixar o OPEN SSH"
    }
}
