<#  IDS Usuarios botConversa
    Brenner = '385910829'
    Denner  = '193741501'
    Daniele = '193744989'
#>
<#
    Na versão '1.0.0.1', foi adicionado nova forma de enviar notificações
    Agora poderá enviar notificação por linha de comando
    SINTAXE > args[0](notificarWhatsApp) args[1]('Mensagem a enviar') 'IdBotConversa'
#>
$versao = '1.0.0.1'
Function notificarWhatsApp {

    param(
        $mensagem,
        $idSubcriber
    )
    # Criando uma verificação com switch case para ver o segundo argumento passado
    if ($mensagem) {
        Switch ("$idSubcriber".ToLower()) {
            'brenner' {
                #$args[2] = '385910829'
                Write-Host -ForegroundColor DarkYellow "digitou $idSubcriber".ToUpper()
                $idSubcriber = '385910829' # BRENNER
                #Exit
            }
            'denner' {
                Write-Host -ForegroundColor DarkYellow "digitou $idSubcriber".ToUpper()
                $idSubcriber = '193741501' # DENNER
                #Exit
            }
            'daniele' {
                Write-Host -ForegroundColor DarkYellow "digitou $idSubcriber".ToUpper()
                $idSubcriber = '193744989' # DANIELE
                #Exit
            }
        } # SWITCH CASE
        #Write-Host -ForegroundColor DarkYellow "digitou $($args[3])".ToUpper()
    } # IF PARA O SWITCH CASE

    $cabecalho = @{
        "Content-Type" = "application/json"
        "API-KEY" = "c7e572f0-c17b-4304-9478-b68641234d6c"
    }

    $corpo = @{
        "type" = "text"
        "value" = "$mensagem"
    }
    $corpo = $corpo | ConvertTo-Json

    Try {
        (Invoke-WebRequest -Uri https://backend.botconversa.com.br/api/v1/webhook/subscriber/$idSubcriber/send_message/ -Method Post -Headers $cabecalho -Body $corpo -ErrorAction Stop).content
    }
    Catch {
        Write-Host -ForegroundColor red "erro fatal".ToUpper()
    }
}

if ($args[0]){
    if ($args[0] -eq 'notificarWhatsApp') {
        Write-Host "Seu argumento é $($args[0])".ToUpper()
        notificarWhatsApp "$($args[1])" "$($args[2])"
        Exit
    }
    Write-Host -ForegroundColor Yellow "Você tem esse argumento $($args[0])"
}
