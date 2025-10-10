$programaEA = 'EADesktop'
$programaFC = 'fc25'

New-burntToastNotification -Text "Verificação", "Script de verificação de EAFC startado com sucesso!"

# Verificando se o processo do jogo existe

While ($True){
    Get-Process -Name $programaEA -ErrorAction Ignore | Out-Null && & {
        Get-Process -Name $programaFC -ErrorAction Ignore | Out-Null && & {
            Stop-Process -Name $programaEA -Force
            Write-Host 'O processo do app do EAFC foi removido com sucesso!'.ToUpper()
            Start-Sleep -Seconds 2
        }
    }
    Start-Sleep -Seconds 5
} # WHILE
