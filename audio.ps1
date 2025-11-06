
$indexDispositivoAtual = (get-AudioDevice -Playback | Select-Object -ExpandProperty Index)
<#
# Dispositivos

$dispositivos = @{
    'fone' = 1
    'monitor' = 2
}
Foreach ($chave in $dispositivos.keys) {
    Write-Host -ForegroundColor Green "VALOR $($dispositivos[$chave])"
    $dispositivos[$chave]
    if ($indexDispositivoAtual -eq $dispositivos[$chave]) {
        Write-Host -ForegroundColor Gray "Seu dispositvo atual é: $($dispositivos[$chave]) $chave"
        Set-AudioDevice -Index ($dispositivos[$chave]+1)
        Break
    }
    Set-AudioDevice -Index ($dispositivos[$chave]-1)
}
#>

if ($indexDispositivoAtual -ne 2) {
        Write-Host -ForegroundColor Gray "Seu dispositvo atual é: LG MONITOR"
        Set-AudioDevice -Index 2 -ErrorAction Ignore | Out-Null
        exit
}
Set-AudioDevice -Index 1 -ErrorAction Ignore | Out-Null
