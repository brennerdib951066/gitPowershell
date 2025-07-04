$areaDeTabalho = "$env:USERPROFILE/Desktop"
$pastaHost = "$areaDeTabalho/hosts"
$arquivoHost = "$pastaHost/hostWindows.txt"
$hostAtual = 'windows'
$arquivoNotificacao = "$areaDeTabalho/powershell/notificarWhatsApp.ps1"
$scpLigado = 'sim'
Function verificarIp {
    param(
        [string]$ip = "$meuIp"
    )
    if (-not (Test-Path "$pastaHost")) {
        New-Item -Type Directory -Path "$pastaHost" -ErrorAction Ignore
        Start-Sleep -Seconds 1
    }
    if (-not (Test-Path "$arquivoHost")) {
        New-Item -Type File -Path "$arquivoHost" -ErrorAction Ignore
        Start-Sleep -Seconds 1
    }


    if ($ip -notcontains (Get-Content $arquivoHost -ErrorAction Ignore)) {
        $ip | Out-File -FilePath $arquivoHost -Encoding utf8
        $ip

        if ($scpLigado -eq 'nao') {
            . $arquivoNotificacao
            notificarWhatsApp "Seu host ``$hostAtual`` mudou para: *$(Get-Content $arquivoHost)*. Seu scp está desligado".ToUpper() '385910829'
            Return
        }
        if ($hostAtual -eq 'windows') {
            $arquivoHostLinux = (Get-Content "$pastaHost/hostsLinux.txt")
            Write-Host -ForegroundColor Red "$arquivoHostLinux"
            Start-Sleep -Seconds 3
            Get-Content ($arquivoHostLinux)
            scp -v "$arquivoHost" brenner@${arquivoHostLinux}:'Área de trabalho/hosts'
            Write-Host 'Tem que enviar para LINUX'
            Start-Sleep -Seconds 3
            Return
        }
            $arquivoHostWindows = (Get-Content "$pastaHost/hostWindows.txt")
            Write-Host -ForegroundColor Red "$arquivoHostWindows"
            scp -v "$arquivoHost" brenner@${arquivoHostWindows}:'Desktop/hosts'
    } # IF ARQUIVOHOST
    #Exit
    <# Notificar dizendo que IP da maquina ainda permance o mesmo
    . $arquivoNotificacao
    notificarWhatsApp "Tudo certo com ip ``$hostAtual``".ToUpper() '385910829'
    #>
}


if (-not ($isWindows)){
    $areaDeTabalho = (xdg-user-dir DESKTOP)
    $pastaHost = "$areaDeTabalho/hosts"
    $arquivoHost = "$pastaHost/hostsLinux.txt"
    $meuIp = (ip a | grep -iwE '^.+inet.*wlo1$' | cut -d' ' -f6 | cut -d'/' -f1)
    #$meuIp = ($meuIp -replace "`e\[[\d;]*m", "")
    $hostAtual = 'linux'
    if (-Not (Test-Path $arquivoNotificacao)) {
        $arquivoNotificacao = "$areaDeTabalho/gitPowershell/notificarWhatsApp.ps1"
        $arquivoNotificacao
    }
    verificarIp
    Exit
}


$meuIp = (ipconfig.exe | Where-Object {$_ -match 'IPv4' -and $_ -notmatch '172'} | ForEach-Object { $_ -replace '.*: ', '' })
verificarIp

