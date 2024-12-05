Function notificarWhatsApp {

    param(
        $mensagem,
        $idSubcriber
    )
    $cabecalho = @{
        "Content-Type" = "application/json"
        "API-KEY" = "c7e572f0-c17b-4304-9478-b68641234d6c"
    }

    $corpo = @{
        "type" = "text"
        "value" = "$mensagem"
    }
    $corpo = $corpo | ConvertTo-Json
    (Invoke-WebRequest -Uri https://backend.botconversa.com.br/api/v1/webhook/subscriber/$idSubcriber/send_message/ -Method Post -Headers $cabecalho -Body $corpo).content
}

#notificarWhatsApp 'aqui é um teste com powershell no DEBIAN'.Tolower() '379274836'
