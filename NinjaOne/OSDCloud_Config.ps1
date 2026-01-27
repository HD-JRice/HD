Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

$ErrorActionPreference = 'Stop'

try {
    Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Pro -OSLanguage en-us -OSLicense Retail -ZTI

    Write-Host -ForegroundColor Green "Start-OSDCloud completed. Restarting in 20 seconds..."
    Start-Sleep -Seconds 20

    wpeutil reboot
}
catch {
    Write-Host -ForegroundColor Red "Start-OSDCloud failed - NOT rebooting (prevents boot loop)."
    Write-Host -ForegroundColor Yellow $_.Exception.Message

    Write-Host -ForegroundColor Yellow "Dropping to a shell for troubleshooting. Type 'exit' when done."
    cmd /k
}
