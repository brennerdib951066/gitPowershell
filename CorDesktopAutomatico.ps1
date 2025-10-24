if ($PSVErsionTable.psVersion.Major -lt 7) {
    Write-Host -ForegroundColor DarkGray 'Precisso dopowershell na versão 7 ou mais'
    Exit
}


if ($PSVErsionTable.OS -notMatch 'windows') {
    $areaDeTrabalho = $(xdg-user-dir DESKTOP)
    $arquivoNotificacao = Join-Path -Path "$areaDeTrabalho/gitPowershell" -ChildPath 'notificarWhatsApp.ps1'
    $usuarioAtual = $Env:USER
    [int]$horaAtual = (Get-Date -UFormat %H)
    $mundancaCor = 'breeze'

    # Verificando se é root
    if ($usuarioAtual -match 'root') {
        Write-Host -ForegroundColor Red 'root não!'.ToUpper()
        Exit
    }
    # Verificando se existe o lookandfeeltool
    Get-Command lookandfeeltool -ErrorAction Ignore | Out-Null || & {
        Write-Host -ForegroundColor Red 'Não encontrei o programa necessario para prosseguir(lookandfeeltool)'
        Exit
    } # GET
    # Verificando se existe o notify-send
    Get-Command notify-send -ErrorAction Ignore | Out-Null || & {
        Write-Host -ForegroundColor Red 'notify-send é necessario para notificação'
        Write-Host 'Inslando agora!'
        Start-Sleep -Seconds 2

        # Instalndo o notify-send
        $notifySend = $(sudo apt install notify-send -y)

        if ($LASTEXITCODE -ne 0) {
            Write-Host -ForegroundColor DarkYelow 'Não consegui instalar o programa notify-send!'
            Start-Sleep -Seconds 5
        } # Não ionstalacao do notify-send
    } # GET

    Switch ($horaAtual) {
        {$horaAtual -Ge 6 -And $horaAtual -Lt 18 } {
           lookandfeeltool  -a org.kde.${mundancaCor}.desktop
           Start-Sleep -Seconds 2
           notify-send -u normal -a 'Mudança de tema' 'DIA' 'Mudança de tema efetuado com sucesso!' -t 5000
        } # IGUAL OU MAIOR A ¨6 E MENOR QUE 18 HORAS(DIA)

        {$horaAtual -Ge 18 -And $horaAtual -Lt 6 } {
            $mundancaCor = 'breezedark'
            lookandfeeltool  -a org.kde.${mundancaCor}.desktop
            Start-Sleep -Seconds 2
            notify-send -u normal -a 'Mudança de tema' 'NOITE' 'Mudança de tema efetuado com sucesso!' -t 5000
        } # IGUAL OU MAIOR A 18 E MENOR QUE 6 HORAS(NOITE)

    } # SWITCH

    #lookandfeeltool -a org.kde.breeze.desktop
} else {
    $areaDeTrabalho = "$env:USERPROFILE/Desktop"
    $arquivoNotificacao = Join-Path -Path "$areaDeTrabalho/gitPowershell" -ChildPath 'permissaoAdministrativo.ps1'
    $arquivoPermissaoAdministrativa = Join-Path -Path "$areaDeTrabalho/gitPowershell" -ChildPath 'notificarWhatsApp.ps1'
    [int]$horaAtual = (Get-Date -UFormat %H)
    $mundancaCor = 1 # Equivale a dia

    Switch ($horaAtual) {
        {$horaAtual -Ge 6 -And $horaAtual -Lt 18 } {
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value $mundancaCor
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value $mundancaCor
            # Adiciona o tipo NativeMethods apenas se ainda não foi carregado
            if (-not ([System.Management.Automation.PSTypeName]'NativeMethods').Type) {
                Add-Type @"
                using System;
                using System.Runtime.InteropServices;

                public class NativeMethods {
                    [DllImport("user32.dll", SetLastError=true)]
                    public static extern IntPtr SendMessageTimeout(
                        IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
                        uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
                }
"@
            }

            # Envia a notificação de mudança de tema para os apps abertos
            $HWND_BROADCAST = [IntPtr]0xffff
            $WM_SETTINGCHANGE = 0x001A
            $SMTO_ABORTIFHUNG = 0x0002
            [UIntPtr]$result = [UIntPtr]::Zero

            [NativeMethods]::SendMessageTimeout(
                $HWND_BROADCAST,
                $WM_SETTINGCHANGE,
                [UIntPtr]::Zero,
                "ImmersiveColorSet",
                $SMTO_ABORTIFHUNG,
                100,
                [ref]$result
            ) | Out-Null

           Start-Sleep -Seconds 2
           New-BurntToastNotification -Text 'Mudanca de tema efetuado com sucesso! DIA'
           Write-Host 'CAIU NO DIA'
        } # IGUAL OU MAIOR A ¨6 E MENOR QUE 18 HORAS(DIA)

        {$horaAtual -Ge 18 -And $horaAtual -Lt 6 } {
            $mundancaCor = 1 # Equivale a noite
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value $mundancaCor
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value $mundancaCor
            # Adiciona o tipo NativeMethods apenas se ainda não foi carregado
            if (-not ([System.Management.Automation.PSTypeName]'NativeMethods').Type) {
                Add-Type @"
                using System;
                using System.Runtime.InteropServices;

                public class NativeMethods {
                    [DllImport("user32.dll", SetLastError=true)]
                    public static extern IntPtr SendMessageTimeout(
                        IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
                        uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
                }
"@
            }

            # Envia a notificação de mudança de tema para os apps abertos
            $HWND_BROADCAST = [IntPtr]0xffff
            $WM_SETTINGCHANGE = 0x001A
            $SMTO_ABORTIFHUNG = 0x0002
            [UIntPtr]$result = [UIntPtr]::Zero

            [NativeMethods]::SendMessageTimeout(
                $HWND_BROADCAST,
                $WM_SETTINGCHANGE,
                [UIntPtr]::Zero,
                "ImmersiveColorSet",
                $SMTO_ABORTIFHUNG,
                100,
                [ref]$result
            ) | Out-Null

           Start-Sleep -Seconds 2
           New-BurntToastNotification -Text 'Mudanca de tema efetuado com sucesso! NOITE'
           Write-Host 'CAIU NO NOITE'
        } # IGUAL OU MAIOR A 18 E MENOR QUE 6 HORAS(NOITE)

    } # SWITCH

}




<# Defina aqui o valor do tema:
	# Altera os valores de tema no registro
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value $mundancaCor
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value $mundancaCor

	# Adiciona o tipo NativeMethods apenas se ainda não foi carregado
	if (-not ([System.Management.Automation.PSTypeName]'NativeMethods').Type) {
		Add-Type @"
		using System;
		using System.Runtime.InteropServices;

		public class NativeMethods {
			[DllImport("user32.dll", SetLastError=true)]
			public static extern IntPtr SendMessageTimeout(
				IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam,
				uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
		}
"@
	}

	# Envia a notificação de mudança de tema para os apps abertos
	$HWND_BROADCAST = [IntPtr]0xffff
	$WM_SETTINGCHANGE = 0x001A
	$SMTO_ABORTIFHUNG = 0x0002
	[UIntPtr]$result = [UIntPtr]::Zero

	[NativeMethods]::SendMessageTimeout(
		$HWND_BROADCAST,
		$WM_SETTINGCHANGE,
		[UIntPtr]::Zero,
		"ImmersiveColorSet",
		$SMTO_ABORTIFHUNG,
		100,
		[ref]$result
		)
#>
