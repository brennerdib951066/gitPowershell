
$header = @{
    "Content-Type" = "Application/json"
}
$body = @{
    "user" = "1001"
    "password" = "Familiadib@652516"
}
$body = $body | ConvertTo-Json

$tokenApi = @(
    "GJk0Hn3UpI7JU0OzwOUsMX7FRBjBmTnec9uhqQMiZ64jNy5lRZmKj7dxnh2w"
)
$dataHoje = (Get-Date).AddDays(-1).ToString("yyyy-MM-dd")
$dataHoje
$textoLigacao = "ligação dib solucões patrimoniais ($dataHoje):"

# PLATAFORMA
$sistemaOperacional = 'windows'

# SOURCES
$areaDeTrabalho= 'C:\Users\brenner\Desktop'
$diretorioPowershell = "$areaDeTrabalho\gitPowershell"
$arquivoNotificacao = "$diretorioPowershell\notificarWhatsApp.ps1"


if ($PSVersionTable.PSVersion.Major -lt 7) {
    Write-HOst -ForegroundColor Red "Powershell na versão 7 ou maior para continuar!"
    Exit
}


if ($PSVersionTable.Platform -NotMatch 'win') {
    $areaDeTrabalho= (xdg-user-dir DESKTOP)
    $diretorioPowershell = "$areaDeTrabalho\gitPowershell"
    $arquivoNotificacao = "$diretorioPowershell\notificarWhatsApp.ps1"
    $sistemaOperacional = 'linux'
}



$resposta = (Invoke-webRequest -URI "https://3c.fluxoti.com/api/v1/authenticate?api_token=$($tokenApi[0])" -Method Post -Headers  $header -Body $body).StatusCode

if ($resposta -ne 200) {
    Write-Host -ForegroundColor Red "Deu algo errado na requisição, verificar($resposta)!"
    Exit
} # IF RESPOSTA

# LOGIN EFETUADO COM SUCESSO

$requisicaoQualificacao = (Invoke-RestMethod -URI "https://3c.fluxoti.com/api/v1/campaigns/253382/agents/qualifications?start_date=${dataHoje}&end_date=${dataHoje}&api_token=GJk0Hn3UpI7JU0OzwOUsMX7FRBjBmTnec9uhqQMiZ64jNy5lRZmKj7dxnh2w" -Headers $header)

$mensagem = $requisicaoQualificacao.data.agents."210624".qualifications.PSObject.Properties.Value |
ForEach-Object {
    "$($_.name): $($_.total)"
    $totalLigacao += $_.total
} | Out-String


$mensagem = @"
$($textoLigacao.ToUpper()) ($($sistemaOperacional.ToUpper()))

$mensagem
--------------------------------------------------
TOTAL: *_${totalLigacao}_*
"@

#$mensagem

#"$requisicaoQualificacao sasdasdasd"

#$j = $j | ConvertTo-Json
#$requisicaoQualificacao.data.agents."210624".qualifications.PSObject.Properties.Value | select-object name, total

#"$requisicaoQualificacao REQUISICAO"

. $arquivoNotificacao
notificarWhatsApp "$mensagem" 'brenner'
#>
