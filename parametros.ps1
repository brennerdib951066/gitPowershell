function parametros{
    param(
        [string]$mensagem1,
        [string]$mensagem2,
        [string]$mensagem3
    )

    Write-Host "Você me enviou de parametro $mensagem1   $mensagem2   $mensagem3" -foreground red
}
parametros
