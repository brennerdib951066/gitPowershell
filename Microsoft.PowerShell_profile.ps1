# Criando uma função que altera o brilho da tela
Function brilho {
	if (-not $ISWINDOWS) {
		if (-not $args[0]) {
			Return Write-Host -BackgroundColor blue 'Mande 2500 por exemplo'
		}
		if ($args[0] -notMatch '[0-9]+') {
			return Write-Host -BackgroundColor blue 'Por favor somente numeros'
		}

		[int]$valor = $args[0]
		if ($valor -lt 2500 -And $valor -ne 8000) {
			Write-Host -BackgroundColor blue 'Use 2500 = 10%'
			Write-Host -BackgroundColor blue 'Use 8000 = 42%'
			Return
		}

		if ($ENV:XDG_CURRENT_DESKTOP) {
			$interaceGrafica = ($ENV:XDG_CURRENT_DESKTOP).ToLower()
			if ($interaceGrafica -ne 'kde') {
				return Write-Host -BackgroundColor red 'Não é KDE'
			} # CASO NÃO SEJA KDE
			if ($ENV:KDE_SESSION_VERSION -lt 6) {
				return Write-Host -BackgroundColor red 'Vixe escolha a versão 6 do KDE'
			} # CASO A VERSÂO NÃO SEJA 6
			Write-Host -BackgroundColor green 'Parabens sua versão é a 6 ah mais recente!'
			qdbus6 org.kde.Solid.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl setBrightness $args[0]
		}
		else {
			Write-Host -BackgroundColor 'Olha não existe a variavél XDG_CURRENT_DESKTOP no linux atual'
		}
	} # IF Caso seja LINUX

}
Function luzAzul {
		if (-not $args[0]) {
			Return Write-Host -BackgroundColor Yellow 'Chame pelo meu nome e depois digite o valor 7500 por exemplo'
		}
		if (-not $ISWINDOWS) {
			if ($ENV:XDG_CURRENT_DESKTOP) {
				$interfaceGrafica = ($ENV:XDG_CURRENT_DESKTOP).ToLower()
				if ($interfaceGrafica -ne 'kde') {
					Return Write-Host -BackgroundColor DarkRed 'Seu motor de interface grafica não é KDE'
				}
				if ($ENV:KDE_SESSION_VERSION -lt 6) {
					Return Write-Host -BackgroundColor DarkRed 'Por favor use a versão 6 do KDE'
				}
				# Configurando a luz azul da tela
				kwriteconfig6 --file kwinrc --group NightColor --key NightTemperature $args[0] && kwin_x11 --replace &
			}
		}
}
