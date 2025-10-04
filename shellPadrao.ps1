$openSsh = 'HKLM:\SOFTWARE\OpenSSH\'

while ($True) {
    $nomePropriedade = Read-Host -Prompt "Nome da PORPRIEDADE)"
    if ($nomePropriedade -NotMatch '[A-Z-az]+') {
        Write-Host -ForegroundColor DarkRed "Por favor apenas letras"
        Start-Sleep -Seconds 2
        Continue
    }
    Break
}

$nomePropriedade = $nomePropriedade.ToLower()
$valorPropriedade = $(Get-Command pwsh.exe -ErrorAction Stop).Source
# Verificando se existe o PWSH instalado
Try {
    $(Get-Command pwsh.exe -ErrorAction Stop).Source
    if (-not(Test-Path $openSsh)) {
        Write-Host -ForegroundColor Yellow "Não foi encontrado a pasta $openSsh"
        Exit
    }
    New-ItemProperty -Path $openSsh -Name $nomePropriedade -Value $valorPropriedade -PropertyType String -Force | Out-Null
    Restart-Service sshd

}
Catch {
    Write-Host -ForegroundColor Red "Opah não existe o ssh instalado no seu pc!"
    Exit
}


