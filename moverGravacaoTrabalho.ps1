$notificar = Join-Path -Path "\Users\brenner\Desktop\powershell" -ChildPath notificarWhatsApp.ps1

$areaDeTrabalho = "$Env:HOMEPATH\Desktop"
$moverArquivos = (Get-ChildItem -File).FullName -match '[A-Za-z]+\.webm$'
$versaoPowershell = $PSVersionTable.PSVersion.Major
$pastaDeGravacao = 'gravacaoTrabalho'

if ($versaoPowershell -lt 7) {
    Write-Host -ForegroundColor DarkRed 'Baixe o powershell na versão 7 ou maior'
    Exit
}
if (-not $isWindows) {
    $areaDeTrabalho = (xdg-user-dir DESKTOP)
}

if (-not (Test-Path "$areaDeTrabalho/$pastaDeGravacao")) {
    Try {
        New-Item -Type Directory -Path "$areaDeTrabalho/$pastaDeGravacao" -ErrorAction Stop | Out-Null
    }
    Catch {
        Write-Host -ForegroundColor DarkRed 'Deu algum erro ao criar a pasta de gravação'.ToUpper()
    }
}

if ($moverArquivos){
    $moverArquivos = $moverArquivos.Split(' ')
    $moverArquivos = @($moverArquivos)
    for ($i=0;$i -le $moverArquivos.Length - 1 ;$i++) {
        Write-Host $moverArquivos[$i]
        Move-Item -Path $moverArquivos[$i] -Destination "$areaDeTrabalho/$pastaDeGravacao"
        Start-Sleep -seconds 1
    }
    <# Move-Item -Path "$moverArquivos" -Destination "$areaDeTrabalho/$pastaDeGravacao"
    . $notificar
    notificarWhatsApp 'aqui é um teste com powershell no DEBIAN'.Tolower() '385910829'
    #>
    Exit
}
Write-Host -ForegroundColor Red 'Erro ao mover seus arquivos de gravação'.ToUpper()
. $notificar
notificarWhatsApp 'aqui é um teste com powershell no DEBIAN'.Tolower() '385910829'
