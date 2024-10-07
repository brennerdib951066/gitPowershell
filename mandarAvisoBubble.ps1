function mandarAviso{
    param(
        $mensagem,
        $idDadoTipo
    )

    $i = 1
    foreach ($versoes in 'test','live'){
        Switch ($i){
            1 {
                Write-Host $i")" $versoes.Toupper() -ForegroundColor Red
            }
            2{
                Write-Host $i")" $versoes.Toupper() -ForegroundColor Cyan
            }
        }
        $i++
    }
    echo ""
        while ($true){
            $opcao = read-Host -Prompt "opção".Toupper()
            Switch ($opcao){
                1 {
                    #echo "VocÊ escolheu version-test"
                    $opcao = [int]$opcao
                    $version = 'version-test'
                }
                2 {
                    #echo "VocÊ escolheu version-LIVE"
                    $opcao = [int]$opcao
                    $version = 'version-live'
                    #break
                }
                default {
                    #echo "Escolha uma opção válida"
                    $opcao = [int]$opcao
                }
            }
            if ($opcao -gt 0 -and $opcao -le 2){
                break
            }
            #break

        }
    $cabecalho = @{
        "Authorization" = "Bearer 5b2a5efbc5fda2ffff948979031ac33a"
    }
    $corpo = @{
        "avisoUniversalText" = "$mensagem".Tolower()
    }

    try {
        $avisoUniversalText = (Invoke-WebRequest -Uri "https://www.sistemaviverbemseguros.com/$version/api/1.1/obj/lead/1723476243383x434371790053661440" -Headers $cabecalho -Body $corpo -Method PATCH -ContentType 'application/x-www-form-urlencoded')

        $avisoUniversalTextEnviado = (Invoke-WebRequest -Uri "https://www.sistemaviverbemseguros.com/$version/api/1.1/obj/lead/1723476243383x434371790053661440" -Headers $cabecalho -Body @{"avisoUniversalEnviado" = "yes"} -Method PATCH -ContentType 'application/x-www-form-urlencoded')
        if ($avisoUniversalText.statusCode -eq 204 -or $avisoUniversalTextEnviado.statusCode -eq 204){
            Write-Host "Mofificação realizada com sucesso!" -ForegroundColor Cyan
        }
        else {
            Write-Host "Algo deu errado!" -ForegroundColor Red
        }
    }
    catch {
            Write-Host "Algo deu erradoooooo!" -ForegroundColor Red
    }
}
while($true){
    $mensagem = Read-Host -Prompt "mensagem aviso".Toupper()
    if(($mensagem)){
        break
    }
}
mandarAviso $mensagem '1723476243383x434371790053661440'
