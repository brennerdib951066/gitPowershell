# Verificando se é WINDOWS
if (-not($IsWindows)) {
    Write-Host -ForegroundColor DarkYellow "Sistema operacional aceito, somente windows"
    Exit
}

$diretorioPowershell = "$Env:USERPROFILE\Desktop\gitPowershell"
$permissaoAdministrativa = "$env:USERPROFILE\Desktop\gitPowershell\permissaoAdministrativo.ps1"
$programaSSH = @(
                'OpenSSH.Server~~~~0.0.1.0'
                'OpenSSH.Client~~~~0.0.1.0'
                )
#$programaSSH
$configuracaoNet = Get-netConnectionProfile
$configuracaoNetNome = (Get-netConnectionProfile).Name
$configuracaoNetCategoria = (Get-netConnectionProfile).NetworkCategory

. $permissaoAdministrativa
if (-not(Test-Admin)){
    Write-Host -ForegroundColor DarkYellow "Preciso de permissões administrativas para prosseguir"
    Exit
}


if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-Host -ForegroundColor DarkGray 'Powerhsell 7 é necessario!'
    Exit
} # IF

Get-Service -Name sshd -ErrorAction Ignore | Out-Null || & {

        While ($TRUE){
            $resposta = Read-Host -Prompt 'o ssh não está instalado,desja instalar? [S/n]'
            if ($resposta -notMatch '[A-Za-z]+') {
                Write-Host -ForegroundColor DarkRed 'Preciso de sim ou não!'
            } # If resposta

            # Caso contenha algum valor verifique se SIM ou NÃO
            $resposta = $resposta.ToLower()
            Switch ($resposta) {
                's' {

                    Add-WindowsCapability -Online -Name $programaSSH[0]
                    Add-WindowsCapability -Online -Name $programaSSH[1]
                    Set-Service sshd -StartupType Automatic
                    Start-Service sshd
                    Remove-Variable resposta
                    Break

                } # SIM

                'n' {
                    Write-Host -ForegroundColor DarkYellow "Obriagado então, até a proxima!"
                    Exit
                } # N

                Default {
                    Continue
                } # DEFAULT
            } # CASE
            Break
        } # WHILE
    } # GET_SERVICE

    # Caso já esteja instalado verificar se está rodando
    $status = Get-Service -Name sshd
    if ($status.Status -match 'running') {
        Write-Host -ForegroundColor DarkBlue "ssh rodando".ToUpper()
    } # IF STATUS running

    if ($status.Status -match 'stopped') {
        Write-Host -ForegroundColor DarkGray "ssh parado".ToUpper()
        Write-Host -ForegroundColor Gray 'Inicializado para você!'
        Start-Service -Name sshd
    } # IF STATUS running

    # Se rede estiver em publico setar para privado

    if ($configuracaoNetCategoria -match 'public') {
        Try{
            Set-NetConnectionProfile -Name $configuracaoNetNome -NetworkCategory Private -ErrorAction Stop

            While ($TRUE) {
                $resposta = Read-Host -Prompt 'Para testar se o ssh foi instalado corretamente, deseja utiliza-lo agora[S/n]'

                if ($resposta -notMatch '[A-Za-z]+') {
                    Write-Host -ForegroundColor DarkYellow 'Escolha entre sim ou não'
                    Continue
                }
                $resposta = $resposta.ToLower()
                Switch ($resposta) {
                    's' {
                        # Verificando se o ssh esta sendo visivel, caso não esteja reiniciar o PC
                        Get-Command ssh -ErrorAction Ignore | Out-Null || & { Write-Host -ForegroundColor DarkGray 'Para continuar precsimos reniciar o PC'; shutdown.exe /r /t 2   }


                        $ip = Get-NetIPAddress -AddressFamily IPv4 `
                        | Where-Object {
                                    $_.PrefixOrigin -eq 'Dhcp' -and $_.InterfaceAlias -match 'Wi-Fi|Ethernet'
                        } `
                            | Select-Object -ExpandProperty IPAddress


                        ssh ${env:USERNAME}@$ip

                    } # S

                    'n' {
                        Write-Host -ForegroundColor DarkGreen 'Obrigado!'

                    } # N
                } # SWITCH
                Exit
            } # WHILE RESPOSTA SSH

        } # TRY
        Catch {
            Write-Host 'Erro ao setar sua categoria de internet'
        } # CATCH
} # IF PRIVATE
