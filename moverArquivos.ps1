# esse script tem o intuito de enviar os arquivos criados no desktop do usuário para suas respectivas pastas
# Para que o usuário nem precise fazer isso manualmente

$homeUsuario = "$HOME/Desktop"
$plataforma = $PSEdition

# criar uma função caso os diretorios não existam, cria-los
Function criarDiretorio(){
    param(
        $pasta
    )
    # Se não existir o diretório crie
    if (-not(Test-Path $pasta)){
        Write-Host -ForegroundColor red "Sua pasta não existe $pasta"; Start-Sleep -Seconds 5
        New-Item -Type Directory -Path $pasta
        Write-Host -ForegroundColor red "Criado com sucesso $pasta"
    }
}


# criar lista de diretorios para enviar os arquivos correspondentes
$diretorios = @(
    'py',
    'sh',
    'awk',
    'csv',
    'markdown',
    'powershell',
    'vbs'
    #'testePowershell'
)


# Criar um lista de tipos de arquivos

$arquivos = @(
    'py',
    'sh',
    'awk',
    'csv',
    'md',
    'ps1',
    'vbs'
)


for ($i = 0;$i -lt $diretorios.Count;$i++){
    #Get-Item  "$HOME/Área de Trabalho/$chave[$i]/"
    #echo $diretorios[$i]
    #echo $arquivos[$i]
    if ($plataforma.ToLower() -eq 'desktop'){

        $diretorioAtual = Join-Path -Path "$HOME/Desktop/" -ChildPath $diretorios[$i]
        $diretorioAtual
        #start-sleep -Seconds 5
        criarDiretorio $diretorioAtual
        $arquivoAtual = $arquivos[$i]
        Write-Host $arquivos[$i] -ForegroundColor green
        $d = (Get-ChildItem -Path "$homeUsuario\*.$arquivoAtual")
        Write-Host "$d" -ForegroundColor red
        $d.Name | Move-Item -Destination $diretorioAtual #-Confirm
        #$d = Join-Path $d -ChildPath *.$($arquivos[$i])
        #$d
        start-sleep -Seconds 5

        #Move-Item "$homeUsuario/*" $diretorioAtual -Confirm
        #(Get-Item $diretorioAtual/*).Name
    }else{

        $diretorioAtual = Join-Path -Path "$HOME/$env:areaDeTrabalhoUsuario" -ChildPath $diretorios[$i]
        #$diretorioAtual | out-file -FilePath '~/Área de Trabalho/atatatata.txt'
        #start-sleep -Seconds 5
        criarDiretorio $diretorioAtual
        $arquivoAtual = $arquivos[$i]
        $d = (Get-ChildItem $HOME/"$env:areaDeTrabalhoUsuario"/*.$arquivoAtual) | Move-Item -Destination $diretorioAtual
        $d.name | out-file -FilePath '~/Área de Trabalho/atatatata.txt' -Append
        start-sleep -Seconds 5

    echo '' ''
    }

}
