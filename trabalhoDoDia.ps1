$dataAtual = Get-Date -Uformat %d-%m-%y
$nomeArquivo = 'viver bem-'.ToUpper() + $dataAtual + '.md'
$areaDeTrabalho = "$Env:HOMEPATH/Desktop"
#Write-Host -ForegroundColor Red $nomeArquivo


if ($psVersionTable.PSVersion.Major -lt 7) {
    Write-Host 'preciso do powershell 7 ou maior'.ToUpper()
    Exit
}

if (-not $IsWindows) {
   $areaDeTrabalho = $(xdg-user-dir DESKTOP)
}

Try {
    Get-Command typora -ErrorAction Stop | Out-Null

} Catch {
    Write-Host -ForegroundColor DarkRed 'O typora não está instalado'
    Start-Sleep -Seconds 2
    $instalar = Read-Host -Prompt 'instalar [S/n]'.ToLower()
    if ($instalar) {
        Write-Host "voce digitou $instalar"
        if ($instalar -match '[0-9]+') {
            Write-Host -ForegroundColor Yellow 'por favor escolhe entre S ou n'.ToUpper()
            Exit
        }
        Write-host 'É string'

        switch ($instalar) {
            's' {
                Write-Host 'OK instalando'
                if (-not $IsWindows) {
                    # or use
                    # wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
                    wget -qO - https://typoraio.cn/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc

                    # add Typora's repository
                    sudo add-apt-repository 'deb https://typora.io/linux ./'
                    sudo apt update

                    # install typora
                    sudo apt install typora


                } # IF $IsWindows
                # Instalando o TYPORA se for WINDOWS
                else {
                    winget install typora
                    $areaDeTrabalho = "$Env:HOMEPATH/Desktop"
                }

            } # SWITCH 1

            'n' {
                Write-Host 'OK saindo'
            } # SWITCH 2

        } # SWITCH PRINCIPAL
    } # IF INSTALAR
    Write-Host -ForegroundColor Yellow 'por favor escolhe entre S ou n'.ToUpper()
    Exit
} # CATCH
if (-not(Test-Path $nomeArquivo)) {
Write-Host "$areaDeTrabalho/$nomeArquivo"
@"
# [VIVER BEM SEGUROS](https://www.sistemaviverbemseguros.com) $dataAtual
##### ``SETOR COMERCIAL``
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
##### ``SETOR ADMINISTRATIVO``
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
##### ``SETOR FINANCEIRO``
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
##### ``SETOR ROMI``
- [ ] 
- [ ] 
- [ ] 
- [ ] 
- [ ] 
"@ | Out-File -FilePath "$areaDeTrabalho/$nomeArquivo"
Start-Sleep -Seconds 1
& typora "$areaDeTrabalho/$nomeArquivo" &

} # IF VERIFICANDO SE O ARQUIVO NÃO EXISTE, CASO SEJA VERDADEIRO CRIA-LO


