$plataforma = $PsVersionTable.OS
$diaAtual = Get-Date -UFormat %Y-%m-%d
$diaAmanha = (Get-Date).AddDays(1).ToString("yyyy-MM-dd")
$cabecalho = @{
    'Content-Type' = 'application/json'
    'Authorization' = 'Berear 5b2a5efbc5fda2ffff948979031ac33a'
}
#$body = @{


$filtros = "[{`"key`": `"gerente`", `"constraint_type`": `"equals`", `"value`": `"thales ramalho`"},{`"key`": `"Created Date`", `"constraint_type`": `"greater than`", `"value`": `"$diaAtual`"},{`"key`": `"Created Date`", `"constraint_type`": `"less than`", `"value`": `"$diaAmanha`"}]"
$url = "https://www.sistemaviverbemseguros.com/api/1.1/obj/bc_outrosDados?constraints=$([System.Net.WebUtility]::UrlEncode($filtros))"
Write-Host $plataforma -ForegroundColor red

if ($plataforma -match 'windows'){
    Write-Host "Sua plataforma é windows"
    try{
        (invoke-webRequest -Uri $url -Headers $Headers).Content
    }
    catch {
        Write-Host 'Erro fatal' -ForegroundColor red
    }
}
elseif ($plataforma -match 'mint') {
     Write-Host "Sua plataforma é linux mint"
     (invoke-webRequest -Uri $url -Headers $Headers).Content
}
elseif ($plataforma -match 'debian') {
     Write-Host "Sua plataforma é linux debian"
     (invoke-webRequest -Uri $url -Headers $Headers).Content
}
else{
    Write-Host 'Não sei qual é sua plataforma'
    (invoke-webRequest -Uri $url -Headers $Headers).Content
}
