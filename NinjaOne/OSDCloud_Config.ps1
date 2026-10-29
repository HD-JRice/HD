Write-Host -ForegroundColor Green 'Starting OSDCloud ZTI - Windows 11 26H2'
Start-Sleep -Seconds 5

# Fail early (with a readable message) if the module in WinPE is too old to know 26H2
$osNames = ((Get-Command Start-OSDCloud).Parameters['OSName']).Attributes |
    Where-Object { $_ -is [System.Management.Automation.ValidateSetAttribute] } |
    ForEach-Object ValidValues
if ($osNames -and 'Windows 11 26H2 x64' -notin $osNames) {
    Write-Host -ForegroundColor Red "OSD module in WinPE is too old for 26H2. Ensure network is up so it can self-update."
    Start-Sleep -Seconds 30
    return
}

Start-OSDCloud -OSName 'Windows 11 26H2 x64' -OSEdition Pro -OSLanguage en-us -OSActivation Retail -ZTI

wpeutil reboot
