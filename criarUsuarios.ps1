
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
$versao = '1.0.0.0'

function Test-Admin {
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
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
    Write-Host -ForegroundColor green 'Caiu no linux ELSE'
    Write-Host $usuarioAtual
    Start-Sleep -Seconds 5
    #Exit
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
}

Function deslogarPc {
    Write-Host -ForegroundColor DarkGreen $args[0]
    Start-Sleep -Seconds 2
    shutdown $args[1]
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




