Function notificarNtfy {

    #curl  -H"{etiqueta}" -H":${prioridade}" -d "${1}" ntfy.sh/$topico
    param(
        $mensagem,
        $topico
    )
    $cabecalho = @{
        #"Content-Type" = "application/json"
        "Title" = "Titulo da mensagem"
        "Tags" = "tags"
        "Priority" = "urgent"

    }

    #$corpo = @{
    #    "body" = "$mensagem"
    #}
    $corpo = $corpo | ConvertTo-Json
    (Invoke-WebRequest -Uri "ntfy.sh/$topico" -Method Post -Headers $cabecalho -Body "$mensagem").content
}

notificarNtfy '*naruto kun*'.Toupper() 'power'
