#!/usr/bin/env pwsh

$arquivoRelatorio = "$HOME/Desktop/RELATORIO.txt"
$diaAtual = Get-Date -UFormat %Y-%m-%d
$diaAmanha = (Get-Date).AddDays(1).ToString("yyyy-MM-dd")
$agir = 'yes'
$logoViverBem="$HOME\Desktop\logoViverBem.gif"
#. "$HOME\Desktop\powershell\bibliotecas\notificarDesktop.ps1"
$plataforma = $PSEdition
if ($agir -eq 'yes'){
    # Define os cabeçalhos com o token Bearer
    $headers = @{
        'Authorization' = 'Bearer 5b2a5efbc5fda2ffff948979031ac33a'
    }

    # Define os parâmetros
    $key = 'gerente'
    $constraint_type = 'equals'
    $valores = @(
        'micaelly ramos',
        'thales ramalho',
        'lais morais',
        'nathália santos',
        'calebe pascoal/césar/df',
        'jully isabelle/pos vendas'
    )

    $salvar = @(

    ) # Inicia vazia para ser adicionada no loop for abaixo

    $quantidade = @(

    )

    foreach ($value in $valores){

        $constraints = "[{`"key`": `"$key`", `"constraint_type`": `"$constraint_type`", `"value`": `"$value`"},{`"key`": `"Created Date`", `"constraint_type`": `"greater than`", `"value`": `"$diaAtual`"},{`"key`": `"Created Date`", `"constraint_type`": `"less than`", `"value`": `"$diaAmanha`"}]"
        $uri = "https://www.sistemaviverbemseguros.com/api/1.1/obj/bc_outrosDados?constraints=$([System.Net.WebUtility]::UrlEncode($constraints))"
        $response = Invoke-WebRequest -Uri $uri -Headers $headers -Method GET
        $countLines = ($response.Content -split "`n" | Where-Object { $_ -like "*count*" })
        $recebi = "$value vendeu hoje: $countLines"
        if ($recebi -match '"COUNT": (\d+)'){
            #echo contem
            $string = $Matches[1]
            $quantidade += [int]$string

        }
        $salvar += $recebi.ToUpper() #>> $arquivoRelatorio
    }

    if ($plataforma -match 'desktop'){
        echo $salvar[0] $salvar[1] $salvar[2] $salvar[3] $salvar[4] $salvar[5] ""  > $arquivoRelatorio
        echo "----------------------------------------------------------------------------------------"
        echo "total de:".ToUpper() ($quantidade[0] + $quantidade[1] + $quantidade[2] + $quantidade[3] + $quantidade[4] + $quantidade[5]) >> $arquivoRelatorio

        $totalDeVendas = ($quantidade[0] + $quantidade[1] + $quantidade[2] + $quantidade[3] + $quantidade[4] + $quantidade[5])
        #Add-Type -AssemblyName System.Windows.Forms
        $valores = $valores.Toupper()
        #notificarDesktop 'Cadastro de etiquetas' "Total: $totalDeVendas" "$HOME\Desktop\logoVIverBem.gif" "$HOME\Desktop\logoVIverBem.gif" # Enviando notificação para o sistema via função do arquivo . "$HOME\Desktop\powershell\bibliotecas\notificarDesktop.ps1"
        Write-Host 'Estas no windows'
    }
    else {
        #$arquivoRelatorio = "$HOME/Área de trabalho"
        #echo $salvar[0] $salvar[1] $salvar[2] $salvar[3] $salvar[4] $salvar[5] ""  > $arquivoRelatorio
        #echo "----------------------------------------------------------------------------------------"
        #echo "total de:".ToUpper() ($quantidade[0] + $quantidade[1] + $quantidade[2] + $quantidade[3] + $quantidade[4] + $quantidade[5]) >> $arquivoRelatorio

        $totalDeVendas = ($quantidade[0] + $quantidade[1] + $quantidade[2] + $quantidade[3] + $quantidade[4] + $quantidade[5])
        #Add-Type -AssemblyName System.Windows.Forms
        $valores = $valores.Toupper()

        while($true){
<<<<<<< HEAD
             start-Sleep -Seconds 10
             $notificacaoLinux = notify-send -t 9000 -c critical -i 'iconeNotificacao.png' 'Cadastro de etiquetas' "Total: $totalDeVendas"
=======
            start-Sleep -Seconds 10
             $notificacaoLinux = notify-send -t 7000 -c normal 'Cadastro de etiquetas' "Total: $totalDeVendas"
>>>>>>> 117476234e46d0d04a338f9c12c1387113dbf292
             mpv "/home/brenner/$env:areaDeTrabalhoUsuario/notificacao/dione.wav"
             Start-Sleep -duration (New-TimeSpan -Minutes 30)
        }
    }

}
