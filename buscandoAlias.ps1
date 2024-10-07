#!/snap/bin/powershell # Excluar essa linha se estiver no windows

function avisoDeDesativacao($aviso){
    Write-Host $aviso -foreground red -background darkgreen ""
    Start-Sleep 2s
    menu
}

# função para buscar os alias com get-alias -Name

function buscar($funcao){
    echo "Olha o que recebi $funcao"
    switch ($funcao){
        'name' {
                while ($true){
                    $nome = read-Host -Prompt "Nome"
                    if ($nome -gt 0) {
                        get-alias -Name $nome
                        start-sleep 5s
                        clear
                        menu
                        break
                    }
                } # WHILE
        } # SWITCH NAME
        'definition' {
                while($true){
                    $nome = read-host -Prompt "Definição"
                    if ($nome -gt 0){
                        get-alias -Definition $nome
                        start-sleep 5s
                        clear
                        menu
                        break
                    } # IF
                } # WHILE

        } # SWITCH DEFINITION
          <#'todosAlias' {
               Get-Alias
               start-sleep 10s
               clear
               menu

        } # SWITCH TODOSOSALIAS
        'novoAlias' {
                # Define a lista de perguntas
            $listaDePerguntas = @(
                'Novo Nome do Alias:',
                'Comando Original:'
            )

            # Inicializa $novaLista como uma matriz vazia
            $novaLista = @()


        } # SWITCH NOVOALIAS #> # comentario em BLOCO

    } # SWITCH

} # FUNCAO PRINCIPAL

#lista de buscas
$opcao = @(
    'Apelido ja registrado',
    'Nome Original',
    'Mostrar todos ALIAS'
    'CRIAR UM NOVO APELIDO'
)



function menu(){
    $i=1
    Write-Host "COMO DESEJA USAR AS FUNÇÔES DE ALIAS HOJE?" "" -foreground red -background gray

    foreach ($buscar in $opcao){
        echo "$i) $buscar"
        $i++
    }
    echo "______________________" ""

    while ($true){
        Write-Host "Opção:" -foreground red -background gray ""
        $escolha = Read-Host
        if ($escolha -gt 0){
            switch ($escolha){
                '1' {
                echo "Você escolheu 1"
                start-sleep -seconds 1
                buscar($funcao='name')
                #buscarPorNome
                #break
                }
                '2' {
                echo "Você escolheu 2"
                start-sleep -seconds 1
                buscar($funcao='definition')
                #buscarPorDefinicao
                #break
                }
                '3' {
                echo "Buscando os ALIAS..."
                start-sleep -seconds 1
                buscar($funcao='todosAlias')
                }
                '4' {
                #echo "O comando cmdLet será"
                #Write-Host 'NEW-ALIAS -Name Apelido -Value Valor original do CMDLET'
                #start-sleep -seconds 1
                avisoDeDesativacao($aviso='Neste momento essa opção está desativada!')
                }
            } # SWITCH
        } # IF
    }# WHILE
} # Termino do bloco da função Menu

menu
