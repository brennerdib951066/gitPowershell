$areaDeTabalho = "$env:USERPROFILE/Desktop"
$arquivoHost = "$areaDeTabalho/hostWindows.txt"
$hostAtual = 'windows'
$arquivoNotificacao = "$areaDeTabalho/powershell/notificarWhatsApp.ps1"
$scpLigado = 'nao'
Function verificarIp {
    param(
        [string]$ip = "$meuIp"
    )
    if (-not (Test-Path "$arquivoHost")) {
        New-Item -Type File -Path "$areaDeTabalho" -ErrorAction Ignore
        Start-Sleep -Seconds 1
    }
    if ($ip -notcontains (Get-Content $arquivoHost -ErrorAction Ignore)) {
        $ip | Out-File -FilePath $arquivoHost -Encoding utf8
        $ip

        if ($scpLigado -eq 'nao') {
            . $arquivoNotificacao
            notificarWhatsApp "Seu host $hostAtual mudou para: *$(Get-Content $arquivoHost)*. Seu scp está desligado".ToUpper() '385910829'
            Return
        }
        if ($hostAtual -eq 'windows') {
            scp "$arquivoHost" brenner@192.168.1.72:'Área de trabalho'
            Write-Host 'Tem que enviar para LINUX'
            Return
        }
            scp "$arquivoHost" brenner@192.168.1.67:'Desktop'
    } # IF ARQUIVOHOST
    #Exit
}


if (-not ($isWindows)){
    $areaDeTabalho = (xdg-user-dir DESKTOP)
    $arquivoHost = "$areaDeTabalho/hostsLinux.txt"
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

