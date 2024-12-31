
<#PSScriptInfo

.VERSION 1.0

.GUID 6b6e9bf1-8a6f-4bfc-955c-3ec0a2418969

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
    OBJETIVO DE CRIAR USUARIOS NO WINDOWS COM POWERSHELL

#>

# VARIAVEIS
$versao = '1.0.0.3'
$versaoPowershell = ($PSVersionTable).PSVersion
function Test-Admin {
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
} # TEST-ADMIN

Function ajuda {
    Write-Output "ajuda".ToUpper() "__________________________________________________________" "" "-H|-h|help : Use essa opção para pedir ajuda" "" "-r|-R : Use essa opção para remover algum usuário [ $($args[0]) $($args[1])]" "" "__________________________________________________________"
    #Write-Host "BRENNER"
}
# Verificando se a versão do powershell está com a versão 7
if (-not($versaoPowershell -match '7')) {
    Write-Host -ForegroundColor DarkRed "Use o powershell com versão 7".ToUpper()
    Exit
}

if ($IsWindows) {
    # Se não estiver rodando como administrador, reinicia o script como administrador
    if (-not (Test-Admin)) {
        Write-Host "Não está executando como administrador. Por favor abra o powershell como administrador"
        Start-Sleep -Seconds 3
        exit
    }
} # IF WINDOWS
else {
    if (-not($Env:USER -match 'root')){
        Write-Host -ForegroundColor yellow "Por favor $env:USER acesse o programa como root"
        Start-Sleep -Seconds 3
        Exit
    }
    Switch ($args[0]){
        {$_ -eq '-r' -or $_ -eq '-R'} {
            if (-not($args[1])) {
                Write-Host -ForegroundColor Red "Escolha um nome de usuário para remover".ToUpper()
                Exit
            } # IF
            # Se o args[1] não for vazia caira aqui
            $args[1] = $($args[1]).ToLower()
            Try {
                userdel -r "$($args[1])" -f
                Exit
            } # TRY
            Catch {
                Write-Host -ForegroundColor Red "Usuario $($args[1]) não encontrado"
            } # CATCH
        } # CASE STRING
        {$_ -eq '-h' -Or  $_ -eq '-H' -Or $_ -eq 'help'} {
            #Write-Host "kkk"
            ajuda '-r' 'nomeUsuario'
            Exit
        } # CASE STRING HELP
    } # SWITCH
    <# Write-Host -ForegroundColor green 'Caiu no linux ELSE'
    Write-Host $usuarioAtual
    Start-Sleep -Seconds 5
    Exit #>
    While ($True){
        Write-Host -ForegroundColor blue 'nome:'.ToUpper()
        $nomeUsuarioLinux = Read-Host
        if (-not($nomeUsuarioLinux)){
            Continue
        }
        <#Write-Host -ForegroundColor blue 'senha:'.ToUpper()
        $senhaUsuarioLinux = Read-Host
        if (-not($senhaUsuarioLinux)){
            Continue
        }#>
        Break
    } # WHILE LINUX

    useradd -m -c "$nomeUsuarioLinux".Tolower() -s /bin/zsh "$nomeUsuarioLinux".Tolower()
    passwd "$nomeUsuarioLinux".Tolower()
    Exit

} # ELSE LINUX

Function avisoSucesso {
    Write-Host -ForegroundColor DarkGreen $args[0]
} # AVISOSUCESSO

Function deslogarPc {
    Write-Host -ForegroundColor DarkGreen $args[0]
    Start-Sleep -Seconds 2
    shutdown $args[1]
} # DESLOGAR

#Write-Host "ARGS" $args[1]
Switch ($args[0]){
    {$_ -eq '-r' -or $_ -eq '-R'} {
        if (-not($args[1])) {
            Write-Host -ForegroundColor DarkGray "Por favor escolha o nome que deseja remover".ToUpper()
            Exit
        }
        # Se o args[1] não for vazia caira aqui
        $args[1] = $($args[1]).ToLower()
        Try {
            Remove-LocalUser -Name "$($args[1])"
            Write-Host -ForegroundColor DarkGreen "$($args[1])".ToUpper() "removido com sucesso"
            Exit
        } # TRY
        Catch {
            Write-Host "Usuário não encontrado!"
        } # CATCH
    }
}

While($True) {
    Write-Host -ForegroundColor red "Nome:"
    $nomeUsuario = Read-Host #-Prompt 'nome'.ToUpper()
    if ($nomeUsuario -eq "") {
        Continue
    }
    Write-Host -ForegroundColor Darkred "Senha:"
    $senhaUsuario = Read-Host -AsSecureString #| Out-Null
    if ($senhaUsuario -eq "") {
        Continue
    }
    Break
}

# Corrigindo o nome de usuário para minúsculas
$nomeUsuario = $nomeUsuario.ToLower()

# Convertendo a senha para SecureString
#$senhaUsuario = ConvertTo-SecureString -AsPlainText -Force -String $senhaUsuario


# Tentativa de criação do usuário
Try {
    #Write-Host "Tentando criar usuário: $nomeUsuario"
    #Write-Host "Senha fornecida (não visível): $senhaUsuario"

    # Criando o usuário
    New-LocalUser -Name "$nomeUsuario" -Password $senhaUsuario -ErrorAction Stop
}
Catch {
    Write-Error "Erro ao criar usuário: $_"
    Exit
}

# Tentativa de adicionar ao grupo de Administradores
Try {
    add-localGroupMember -Group administradores -Member "$nomeUsuario" -ErrorAction Stop
}
Catch {
    Write-Error "Erro ao adicionar o usuário no grupo de Administradores: $_"
    Exit
}

# Chamando a função avisoSucesso se o usuário for cadastrado com sucesso no windows
avisoSucesso "o Usuario $nomeUsuario foi cadastrado com sucesso".ToUpper()
# Chamando a função deslogarPc para ver se o usuário já está na lista de login
deslogarPc "Deslogando para fazer o login com novo usuário" "/l"
