$listaDeArtistas = @(
    'hiro takahashi',
    'akeboshi',
    'nico touches the walls'
)

function tocar {
    param(
        $musicas
    )
    Foreach ($musica in $musicas){
        if (($PSVersionTable.PsEdition).ToLower() -match 'desktop'){
            Write-Host "Musica atual > $musica" -ForegroundColor red
            mpv https://www.youtube.com/watch?v=$musica
        }
        else {
            Write-Host "Musica atual > $musica" -ForegroundColor DarkBlue
            mpv --window-minimized=yes https://www.youtube.com/watch?v=$musica
        }
    }
}

$i = 1
while ($true){
    Foreach ($artista in $listaDeArtistas){
        Write-Host $i')' $artista.ToUpper() -Foreground Cyan
        $i++
    }
    
    $artistaEscolhido = Read-Host -Prompt ':'
    try {
        if ([int]$artistaEscolhido -and $artistaEscolhido -le $listaDeArtistas.count){
            Write-Host 'Tudo certo' -Foreground Cyan
            
            Switch ($artistaEscolhido){
                1 {
                    Write-Host "Artista escolhido" $listaDeArtistas[0] -Foreground Blue
                    $albunsHiroTakahashi = @(
                        'itsumojio',
                        'kuchibiru ga hodo keinai'
                    )
                    $nb = 1
                    Foreach ($album in $albunsHiroTakahashi){
                        Write-Host $nb")" $album.ToUpper() -ForegroundColor Cyan
                        $nb++
                    }
                    while ($true){
                        $albumEscolhido = Read-Host -Prompt ':'
                        if ($albumEscolhido){
                            try {
                                if ([int]$albumEscolhido -and [int]$albumEscolhido -le $albunsHiroTakahashi.count){
                                    #. ../hiroTakahashi.ps1
                                    . '/home/brenner/Área de Trabalho/powershell/bibliotecas/hiroTakahashi.ps1'
                                    Switch ($albumEscolhido){
                                        1 {
                                            tocar $itsumojio
                                            Write-Host "CAIU NO 1" -ForegroundColor red
                                            # Aqui você poderia chamar a função `tocar` com a lista de músicas do álbum 1
                                        }
                                        2 {
                                            tocar $kutibirugaHodoKenai
                                            Write-Host "CAIU NO 2" -ForegroundColor red
                                            # Aqui você poderia chamar a função `tocar` com a lista de músicas do álbum 2
                                        }
                                    }
                                }
                                else {
                                    Write-Host "Escolha uma opção correspondente" -ForegroundColor red
                                }
                            }
                            catch {
                                Write-Host "Escolha uma opção correspondente" -ForegroundColor red
                            }
                        }
                    }
                }
                2 {
                    Write-Host "Artista escolhido" $listaDeArtistas[1] -Foreground Blue
                    $albunsAkeboshi = @(
                        'roundabout',
                        'akeboshi',
                        'aLittleBoy',
                        'yellowMoon',
                        'rustyLance'
                    )
                    $nb = 1
                    Foreach ($album in $albunsAkeboshi){
                        Write-Host $nb")" $album.ToUpper() -ForegroundColor Cyan
                        $nb++
                    }
                    while ($true){
                        $albumEscolhido = Read-Host -Prompt ':'
                        if ($albumEscolhido){
                            try {
                                if ([int]$albumEscolhido -and [int]$albumEscolhido -le $albunsAkeboshi.count){
                                    #. ../hiroTakahashi.ps1
                                    . '/home/brenner/Área de Trabalho/powershell/bibliotecas/akeboshi.ps1'
                                    Switch ($albumEscolhido){
                                        1 {
                                            tocar $roundabout
                                            Write-Host "CAIU NO 1" -ForegroundColor red
                                            # Aqui você poderia chamar a função `tocar` com a lista de músicas do álbum 1
                                        }
                                        2 {
                                            tocar $akeboshi
                                            Write-Host "CAIU NO 2" -ForegroundColor red
                                            # Aqui você poderia chamar a função `tocar` com a lista de músicas do álbum 2
                                        }
                                        3 {
                                            tocar $aLittleBoy
                                            Write-Host "CAIU NO 3" -ForegroundColor red
                                            # Aqui você poderia chamar a função `tocar` com a lista de músicas do álbum 2
                                        }
                                        4 {
                                            tocar $yellowMoon
                                            Write-Host "CAIU NO 4" -ForegroundColor red
                                            # Aqui você poderia chamar a função `tocar` com a lista de músicas do álbum 2
                                        }
                                        5 {
                                            tocar $rustyLance
                                            Write-Host "CAIU NO 5" -ForegroundColor red
                                            # Aqui você poderia chamar a função `tocar` com a lista de músicas do álbum 2
                                        }
                                    }
                                }
                                else {
                                    Write-Host "Escolha uma opção correspondente" -ForegroundColor red
                                }
                            }
                            catch {
                                Write-Host "Escolha uma opção correspondente" -ForegroundColor red
                            }
                        }
                    }
                }
                3 {
                    Write-Host "Artista escolhido" $listaDeArtistas[2] -Foreground Blue
                    $albunsNico = @(
                        'nico albuns'
                        #'kuchibiru ga hodo keinai'
                    )
                    $nb = 1
                    Foreach ($album in $albunsNico){
                        Write-Host $nb")" $album.ToUpper() -ForegroundColor Cyan
                        $nb++
                    }
                    while ($true){
                        $albumEscolhido = Read-Host -Prompt ':'
                        if ($albumEscolhido){
                            try {
                                if ([int]$albumEscolhido -and [int]$albumEscolhido -le $albunsNico.count){
                                    #. ../hiroTakahashi.ps1
                                    . '/home/brenner/Área de Trabalho/powershell/bibliotecas/nico.ps1'
                                    Switch ($albumEscolhido){
                                        1 {
                                            tocar $nico
                                            Write-Host "CAIU NO 1" -ForegroundColor red
                                            # Aqui você poderia chamar a função `tocar` com a lista de músicas do álbum 1
                                        }
                                    }
                                }
                                else {
                                    Write-Host "Escolha uma opção correspondente" -ForegroundColor red
                                }
                            }
                            catch {
                                Write-Host "Escolha uma opção correspondente" -ForegroundColor red
                            }
                        }
                    }
                } # SWITCH 3
                default {
                    Write-Host "Escolha um artista da lista" -Foreground Blue
                }
            }
            break  # Saia do loop após fazer a escolha
        }
        else {
            Write-Host 'Opção inválida' -Foreground red
        }
    }
    catch {
        Write-Host 'Algo deu errado' -Foreground red
        exit
    }
    
    $i = 1  # Reinicie o índice para a próxima iteração
}
