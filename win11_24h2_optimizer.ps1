# ===============================
# Windows 11 24H2 Optimizer & Restore Tool
# ===============================

Write-Host "=== Windows 11 24H2 Optimizer ===" -ForegroundColor Cyan
Write-Host "1. Optimize Windows (Hemat RAM)"
Write-Host "2. Restore to Default (Undo Changes)"
$choice = Read-Host "Pilih opsi (1/2)"

function Optimize-Win11 {
    Write-Host "`n[1/10] Disabling Windows Copilot..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 0 /f

    Write-Host "[2/10] Disabling Widgets..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f

    Write-Host "[3/10] Disabling Suggestions & Tips..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 0 /f

    Write-Host "[4/10] Disabling Background Apps..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f

    Write-Host "[5/10] Disabling Edge Background Services..." -ForegroundColor Yellow
    reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\Main" /v AllowPrelaunch /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader" /v Enabled /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Policies\Microsoft\Edge" /v StartupBoostEnabled /t REG_DWORD /d 0 /f

    Write-Host "[6/10] Disabling Cortana..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f
    reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /t REG_DWORD /d 1 /f

    Write-Host "[7/10] Disabling Memory Integrity (VBS)..." -ForegroundColor Yellow
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f

    Write-Host "[8/10] Disabling Telemetry..." -ForegroundColor Yellow
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

    Write-Host "[9/10] Disabling Windows Search Indexing..." -ForegroundColor Yellow
    Stop-Service WSearch -Force
    Set-Service WSearch -StartupType Disabled

    Write-Host "[10/10] Disabling OneDrive Auto Start..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "" /f

    Write-Host "`n=== Optimization Complete! Restart PC untuk efek penuh. ===" -ForegroundColor Green
}

function Restore-Win11 {
    Write-Host "`n[1/10] Restoring Windows Copilot..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowCopilotButton /t REG_DWORD /d 1 /f

    Write-Host "[2/10] Restoring Widgets..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 1 /f

    Write-Host "[3/10] Restoring Suggestions & Tips..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338389Enabled /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353694Enabled /t REG_DWORD /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-353696Enabled /t REG_DWORD /d 1 /f

    Write-Host "[4/10] Restoring Background Apps..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 0 /f

    Write-Host "[5/10] Restoring Edge Background Services..." -ForegroundColor Yellow
    reg delete "HKCU\Software\Policies\Microsoft\MicrosoftEdge" /f
    reg delete "HKCU\Software\Policies\Microsoft\Edge" /f

    Write-Host "[6/10] Restoring Cortana..." -ForegroundColor Yellow
    reg delete "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /f
    reg delete "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitTextCollection /f
    reg delete "HKCU\Software\Microsoft\InputPersonalization" /v RestrictImplicitInkCollection /f

    Write-Host "[7/10] Restoring Memory Integrity (VBS)..." -ForegroundColor Yellow
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 1 /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 1 /f

    Write-Host "[8/10] Restoring Telemetry (Basic)..." -ForegroundColor Yellow
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f

    Write-Host "[9/10] Restoring Windows Search Indexing..." -ForegroundColor Yellow
    Set-Service WSearch -StartupType Automatic
    Start-Service WSearch

    Write-Host "[10/10] Restoring OneDrive Auto Start..." -ForegroundColor Yellow
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "%LOCALAPPDATA%\Microsoft\OneDrive\OneDrive.exe /background" /f

    Write-Host "`n=== Restore Complete! Restart PC untuk efek penuh. ===" -ForegroundColor Green
}

if ($choice -eq "1") {
    Optimize-Win11
} elseif ($choice -eq "2") {
    Restore-Win11
} else {
    Write-Host "Pilihan tidak valid." -ForegroundColor Red
}
