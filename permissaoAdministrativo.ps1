 # Função que verifica se o usuário atual é um administrador
function Test-Admin {
    # Obtém a identidade do usuário atual
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    
    # Cria um objeto principal a partir da identidade
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
    
    # Verifica se o usuário está no grupo de administradores
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

