Function notificarWhatsApp {

    param(
        $mensagem,
        $idChat,
        $token
    )
    $cabecalho = @{
        "Content-Type" = "application/json"
        #"API-KEY" = "374ed645-c62f-4d21-8f18-d85448be68ac"
    }

    $corpo = @{
        "chat_id" = "$idChat"
        "text" = "$mensagem"
    }
    $corpo = $corpo | ConvertTo-Json
    (Invoke-WebRequest -Uri https://api.telegram.org/bot$token/sendMessage -Method Post -Headers $cabecalho -Body $corpo).content
}

notificarWhatsApp 'aqui é um teste com powershell no DEBIAN'.ToUpper() '-1001831122226' '5919425665:AAFgtdzX6INh56NPu_fUqqQ_AOojoeQlDLc'
