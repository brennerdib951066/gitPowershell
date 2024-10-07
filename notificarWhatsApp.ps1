Function notificarWhatsApp {

    param(
        $mensagem,
        $idSubcriber
    )
    $cabecalho = @{
        "Content-Type" = "application/json"
        "API-KEY" = "374ed645-c62f-4d21-8f18-d85448be68ac"
    }

    $corpo = @{
        "type" = "text"
        "value" = "$mensagem"
    }
    $corpo = $corpo | ConvertTo-Json
    (Invoke-WebRequest -Uri https://backend.botconversa.com.br/api/v1/webhook/subscriber/$idSubcriber/send_message/ -Method Post -Headers $cabecalho -Body $corpo).content
}

notificarWhatsApp 'aqui é um teste com powershell no DEBIAN'.Tolower() '379274836'
