$listaDeArtistas = @(
    'hiro takahashi',
    'akeboshi',
    'nico touches the walls',
    'hiroko kasahara'
)

function verificarPlataforma {
    Write-Host -ForegroundColor yellow "Parece que vocÃª deseja saber a plataforma"
    #Start-Sleep -Seconds 2
    #$plataforma = $PSEdition
    if ($IsWindows) {
        Write-Host -ForegroundColor red "Windows concerteza!"
        #Start-Sleep -Seconds 1
        #$diretorios = "$env:USERPROFILE/Desktop"
        #$areaDeTrabalho
        Return $True
    }
    else {
        Write-Host -ForegroundColor red "Linux Ã© pai!"
        #Start-Sleep -Seconds 1

        $areaDeTrabalhoUsuario = "~"
        #set-location $areaDeTrabalho
        #get-item -Path $areaDeTrabalho
        #Start-Sleep -Seconds 5
        #write-Host -ForegroundColor green $areaDeTrabalhos
        Return $False
    }
}

#$areaDeTrabalho = verificarPlataforma



function tocar {
    param(
        $album,
        $musicas
    )
    Foreach ($musica in $musicas){
        if (($PSVersionTable.PsEdition).ToLower() -match 'desktop'){
            Write-Host "Musica atual $album > $musica" -ForegroundColor red
            mpv https://www.youtube.com/watch?v=$musica
        }
        else {
            Write-Host "Musica atual $album > $musica" -ForegroundColor DarkBlue
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
        if (verificarPlataforma){ Write-Host -ForegroundColor red "Voce é windows"; $pastaBase = join-Path -Path ~ -ChildPath "Desktop/powershell/bibliotecas"; if (-not (Test-Path $pastaBase)) { $pastaBase = join-Path -Path ~ -ChildPath "Desktop/gitPowershell/bibliotecas"}; } else { Write-Host -ForegroundColor red "Voce é LINUXXXX"; $pastaBase = join-Path -Path ~ -ChildPath "Área de Trabalho/powershell/bibliotecas"; if (-not (Test-Path $pastaBase)) { $pastaBase = join-Path -Path ~ -ChildPath "Área de Trabalho/gitPowershell/bibliotecas"};}
        #$pastaBase = join-Path -Path $areaDeTrabalho -ChildPath "Área de Trabalho/powershell/bibliotecas"
        #Get-Content $pastaBase/hiroTakahashi.ps1
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

                        Start-Sleep -Seconds 5
                            try {
                                if ([int]$albumEscolhido -and [int]$albumEscolhido -le $albunsHiroTakahashi.count){
                                    #. ../hiroTakahashi.ps1
                                    . $pastaBase/hiroTakahashi.ps1

                                    Switch ($albumEscolhido){
                                        1 {
                                            tocar $($albunsHiroTakahashi[0]).ToUpper() $itsumojio
                                            Write-Host "CAIU NO 1" -ForegroundColor red
                                            # Aqui vocÃª poderia chamar a funÃ§Ã£o `tocar` com a lista de mÃºsicas do Ã¡lbum 1
                                        }
                                        2 {
                                            tocar $($albunsHiroTakahashi[1]).ToUpper() $kutibirugaHodoKenai
                                            Write-Host "CAIU NO 2" -ForegroundColor red
                                            # Aqui vocÃª poderia chamar a funÃ§Ã£o `tocar` com a lista de mÃºsicas do Ã¡lbum 2
                                        }
                                    Default {
                                            write-Host -ForegroundColor yellow "Não sei o que deu"
                                    }

                                    }


                                }
                                else {
                                    Write-Host "Escolha uma opcao correspondente $areaDeTrabalho" -ForegroundColor red
                                }
                            }
                            catch {
                                Write-Host "Escolha uma opcao correspondente $areaDeTrabalho" -ForegroundColor red
                                #set-location $areaDeTrabalho
                                #get-location
                                Start-Sleep -Seconds 5
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

                                    . $pastaBase/akeboshi.ps1
                                    Switch ($albumEscolhido){
                                        1 {
                                            tocar $($albunsAkeboshi[0]).ToUpper() $roundabout
                                            Write-Host "CAIU NO 1" -ForegroundColor red
                                            # Aqui vocÃª poderia chamar a funÃ§Ã£o `tocar` com a lista de mÃºsicas do Ã¡lbum 1
                                        }
                                        2 {
                                            tocar $($albunsAkeboshi[1]).ToUpper() $akeboshi
                                            Write-Host "CAIU NO 2" -ForegroundColor red
                                            # Aqui vocÃª poderia chamar a funÃ§Ã£o `tocar` com a lista de mÃºsicas do Ã¡lbum 2
                                        }
                                        3 {
                                            tocar $($albunsAkeboshi[2]).ToUpper() $aLittleBoy
                                            Write-Host "CAIU NO 3" -ForegroundColor red
                                            # Aqui vocÃª poderia chamar a funÃ§Ã£o `tocar` com a lista de mÃºsicas do Ã¡lbum 2
                                        }
                                        4 {
                                            tocar $($albunsAkeboshi[3]).ToUpper() $yellowMoon
                                            Write-Host "CAIU NO 4" -ForegroundColor red
                                            # Aqui vocÃª poderia chamar a funÃ§Ã£o `tocar` com a lista de mÃºsicas do Ã¡lbum 2
                                        }
                                        5 {
                                            tocar $($albunsAkeboshi[4]).ToUpper() $rustyLance
                                            Write-Host "CAIU NO 5" -ForegroundColor red
                                            # Aqui vocÃª poderia chamar a funÃ§Ã£o `tocar` com a lista de mÃºsicas do Ã¡lbum 2
                                        }
                                    }
                                    Default {
                                            write-Host -ForegroundColor yellow "Não sei o que deu"
                                    }
                                }
                                else {
                                    Write-Host "Escolha uma opÃ§Ã£o correspondente" -ForegroundColor red
                                }
                            }
                            catch {
                                Write-Host "Escolha uma opÃ§Ã£o correspondente" -ForegroundColor red
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
                                    . $pastaBase/nico.ps1
                                    Switch ($albumEscolhido){
                                        1 {
                                            tocar $($albunsNico[0]).ToUpper() $nico
                                            Write-Host "CAIU NO 1" -ForegroundColor red
                                            # Aqui vocÃª poderia chamar a funÃ§Ã£o `tocar` com a lista de mÃºsicas do Ã¡lbum 1
                                        }
                                    }
                                    Default {
                                            write-Host -ForegroundColor yellow "Não sei o que deu"
                                    }
                                }
                                else {
                                    Write-Host "Escolha uma opÃ§Ã£o correspondente" -ForegroundColor red
                                }
                            }
                            catch {
                                Write-Host "Escolha uma opÃ§Ã£o correspondente" -ForegroundColor red
                            }
                        }
                    }
                } # SWITCH 3
                4 {
                    Write-Host "Artista escolhido" $listaDeArtistas[3] -Foreground Blue
                    $albunsHiroKasahara = @(
                        'hiroko albuns'
                        #'kuchibiru ga hodo keinai'
                    )
                    $nb = 1
                    Foreach ($album in $albunsHiroKasahara){
                        Write-Host $nb")" $album.ToUpper() -ForegroundColor Cyan
                        $nb++
                    }
                    while ($true){
                        $albumEscolhido = Read-Host -Prompt ':'
                        if ($albumEscolhido){
                            try {
                                if ([int]$albumEscolhido -and [int]$albumEscolhido -le $albunsHiroKasahara.count){
                                    #. ../hiroTakahashi.ps1
                                    . $pastaBase/hiroKasahara.ps1
                                    Switch ($albumEscolhido){
                                        1 {
                                            tocar $($albunsHiroKasahara[0]).ToUpper() $renaiseiriron
                                            Write-Host "CAIU NO 1" -ForegroundColor red
                                            # Aqui vocÃª poderia chamar a funÃ§Ã£o `tocar` com a lista de mÃºsicas do Ã¡lbum 1
                                        }
                                    }
                                    Default {
                                            write-Host -ForegroundColor yellow "Não sei o que deu"
                                    }
                                }
                                else {
                                    Write-Host "Escolha uma opÃ§Ã£o correspondente" -ForegroundColor red
                                }
                            }
                            catch {
                                Write-Host "Escolha uma opÃ§Ã£o correspondente" -ForegroundColor red
                            }
                        }
                    }
                } # SWITCH 3
                default {
                    Write-Host "Escolha um artista da lista" -Foreground Blue
                }
            }
            break  # Saia do loop apÃ³s fazer a escolha
        }
        else {
            Write-Host 'OpÃ§Ã£o invÃ¡lida' -Foreground red
        }
    }
    catch {
        Write-Host 'Algo deu errado' -Foreground red
        exit
    }

    $i = 1  # Reinicie o Ã­ndice para a prÃ³xima iteraÃ§Ã£o
}
