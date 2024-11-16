<#PSScriptInfo
.VERSION 1.0
.GUID 4f359103-f2a1-4ea3-943f-4df98ca8fb25
.AUTHOR brenner
.COMPANYNAME
.COPYRIGHT
.TAGS
.LICENSEURI
.PROJECTURI
.ICONURI
.EXTERNALMODULEDEPENDENCIES
.REQUIREDSCRIPTS
.EXTERNALSCRIPTDEPENDENCIES
.RELEASENOTES
#>

<#
.DESCRIPTION
Criar arquivos e pastas para deixar no home com um padrão
#>

$diretorioHomeNextcloud = "~/Nextcloud/tudoDoMundoTechLinuxPc/viverBem/cofreAnotacoesViverBem/$(Get-Date -UFormat +%Y)"

# Função para criar os arquivos markdowns

Function criarMarkdown {

$nomeArquivoMarkdown = @(
    'Lista de tarefas a fazer',
    'Lista de tarefas feitas'
)
$dias = 1..31

For ($a = 0;$a -le $nomeArquivoMarkdown.Length;$a++) {
    For ($d = 1; $d -le $dias.Length;$d++){
    $nomeMarkdown = $nomeArquivoMarkdown[$a].Replace(' ','_')
    Write-Host "Seu arquivo agora é $nomeMarkdown"
    Start-Sleep -Seconds 2
@"
##($($nomeArquivoMarkdown[$a])).ToUpper() $(Get-Date -UFormat +%d-%m-%Y)
# ${d}-$(Get-Date -UFormat +%m-%Y)
- [ ] Exemplo 1
- [ ] Exemplo 2
- [ ] Exemplo 3
- [ ] Exemplo 4
- [ ] Exemplo 5
- [ ] Exemplo 6
- [ ] Exemplo 7
- [ ] Exemplo 8
- [ ] Exemplo 9
"@ |  Out-File "${nomeMarkdown}_$(Get-Date -UFormat +%B)_$(Get-Date -UFormat +%Y).md" -Encoding utf8
    } # FOR $D
} # For criando os arquivos de markdown
Typora  "listaDeTarefasAFazer_$(Get-Date -UFormat +%B)_$(Get-Date -UFormat +%Y).md"

}

# Instalar o typora se o sistema operacional não o contiver
Function instalador {

    if ($plataforma -match 'windows'){
        $linkDownload = 'https://download.typora.io/windows/typora-setup-x64.exe'
        Write-host -ForegroundColor yellow "Instalando o typora no seu $plataforma".Toupper()
        Wget "$linkDownload" -O ~/Desktop/typora.exe
        Start-Process ~/Desktop/typora.exe
    }
    else {
        $linkDownload = 'https://download.typora.io/linux/typora_1.9.3_amd64.deb'
        Write-host -ForegroundColor yellow "Instalando o typora no seu $plataforma".Toupper()
        Wget "$linkDownload" -O ~/Downloads/typora.deb
        sudo dpkg -i ~/Downloads/typora.deb
    }

}

# Verifica qual é a plataforma
Function verificarPlataforma {
    $sitema = $PSEdition
    if ($sitema -match 'desktop'){
        $plataforma = 'windows'
        Return $plataforma
    }
    else{
        $plataforma = 'linux'
        Return $plataforma
    }

} # FUNCAO VERIFICARPLATAFORMA

$plataforma = verificarPlataforma

# Verificando se exsite o typora instado no sistema widons ou linux

if ($plataforma -match 'windows') {
    Write-Host -ForegroundColor red "Seu sistema é $plataforma"
    Start-Sleep -Seconds 2
    Try {
        Get-Package -Name typora -ErrorAction Stop | Out-Null # Mandando a saida padrão para o além
    }
    Catch {
        Write-Host -ForegroundColor red "Não existe o typora instalado no seu pc $plataforma"
        instalador $plataforma

    }

} # IF plataforma
else {
    Write-Host -ForegroundColor red "Seu sistema é $plataforma"
    Start-Sleep -Seconds 2
    Try {
        Get-Command -Name typora -ErrorAction Stop
    }
    Catch {
        Write-Host -ForegroundColor red "Não existe o typora instalado no seu pc $plataforma"
    }
} # ELSE PLATAFORMA

# Verificando se existe o diretorio com o valor da variavél $DIRETORIOHOMENEXTCLAUD
# Se Naõ existir criará o diretorio no bloco CATCH
try {
    Set-Location $diretorioHomeNextcloud -ErrorAction Stop | Out-Null
}
catch {
    Write-Host -ForegroundColor green "Não encontramos o diretorio, vamos cria-lo "$diretorioHomeNextcloud
    Start-Sleep -Seconds 1

    Try {
        New-Item -Type Directory -Path $diretorioHomeNextcloud | Out-Null
        Write-Host "Diretorio criado com sucesso!"
    }
    Catch {
        Write-Host -ForegroundColor Red "Erro ao criar sua pasta"
    }

    # Criando os meses na varivael escalar
    $meses = 1..12
    Write-Host -ForegroundColor yellow "$meses"
    Set-Location $diretorioHomeNextcloud # Entrando no diretorio apos criado
    For ($i = 1;$i -le $meses.Length;$i++){
        New-Item -Type Directory -Path "0${i}_$(Get-Date -UFormat +%B)_$(Get-Date -UFormat +%Y)" | Out-Null
        Write-Host -ForegroundColor yellow "0${i}_$(Get-Date -UFormat +%B)_$(Get-Date -UFormat +%Y)"
        Start-Sleep -Seconds 2

    }
    criarMarkdown # Chamndo a função que criará os arquivos em markdown
}