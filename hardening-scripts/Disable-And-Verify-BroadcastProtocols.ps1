# ==============================================================================
# SCRIPT: Disable-And-Verify-BroadcastProtocols.ps1
# PURPOSE: Hardening against LLMNR/NetBIOS spoofing and verifying the applied state.
# TARGET: Windows 10 / Windows Server 2016 (Core Compatible)
# ==============================================================================

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host " PHASE 1: HARDENING (Disabling LLMNR & NetBIOS over TCP/IP)" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan

# ------------------------------------------------------------------------------
# 1. DISABLE LLMNR (Link-Local Multicast Name Resolution)
# ------------------------------------------------------------------------------
# The Vance Note: In live-fire exercises—especially if you're fresh off defending 
# a network in a recent SECCDC engagement—Red Teams rely on this default 
# configuration to gain their first foothold. If DNS fails, Windows broadcasts 
# a request. Attackers running Responder answer it and capture NTLMv2 hashes.

Write-Host "`n[*] Step 1: Disabling LLMNR via Registry..." -ForegroundColor Yellow

$RegistryPath = "HKLM:\Software\Policies\Microsoft\Windows NT\DNSClient"
$Name         = "EnableMulticast"
$Value        = "0"

if (!(Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
    Write-Host "    [+] Created missing DNSClient policy path." -ForegroundColor DarkGray
}

New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null
Write-Host "    [+] LLMNR disabled successfully." -ForegroundColor Green


# ------------------------------------------------------------------------------
# 2. DISABLE NetBIOS over TCP/IP
# ------------------------------------------------------------------------------
# The Vance Note: NetBIOS (UDP 137) is another legacy fallback protocol. 
# We use WMI here instead of newer NetTCPIP cmdlets because WMI is rock-solid 
# on barebones Server Core environments where adapter bindings can get finicky.

Write-Host "`n[*] Step 2: Disabling NetBIOS over TCP/IP on active adapters..." -ForegroundColor Yellow

$adapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

foreach ($adapter in $adapters) {
    # 2 = Disable NetBIOS over TCP/IP
    $result = $adapter.SetTcpipNetbios(2)
    
    if ($result.ReturnValue -eq 0) {
        Write-Host "    [+] NetBIOS disabled on: $($adapter.Description)" -ForegroundColor Green
    } else {
        Write-Host "    [-] Failed to disable on: $($adapter.Description) (Error: $($result.ReturnValue))" -ForegroundColor Red
    }
}


Write-Host "`n================================================================" -ForegroundColor Cyan
Write-Host " PHASE 2: VERIFICATION (Auditing the changes)" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan

# ------------------------------------------------------------------------------
# 3. VERIFY LLMNR
# ------------------------------------------------------------------------------
Write-Host "`n[*] Auditing LLMNR Registry Key..." -ForegroundColor Yellow

$LLMNR = Get-ItemProperty -Path $RegistryPath -Name "EnableMulticast" -ErrorAction SilentlyContinue

if ($LLMNR.EnableMulticast -eq 0) {
    Write-Host "    [OK] LLMNR is securely DISABLED." -ForegroundColor Green
} else {
    Write-Host "    [WARN] LLMNR state could not be verified. It may still be ENABLED." -ForegroundColor Red
}

# ------------------------------------------------------------------------------
# 4. VERIFY NETBIOS
# ------------------------------------------------------------------------------
Write-Host "`n[*] Auditing NetBIOS WMI Configuration..." -ForegroundColor Yellow

# Re-query the adapters to get the fresh state
$UpdatedAdapters = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }

foreach ($Interface in $UpdatedAdapters) {
    if ($Interface.TcpipNetbiosOptions -eq 2) {
        Write-Host "    [OK] NetBIOS confirmed DISABLED on: $($Interface.Description)" -ForegroundColor Green
    } else {
        Write-Host "    [WARN] NetBIOS is still ENABLED on: $($Interface.Description)" -ForegroundColor Red
    }
}

Write-Host "`n[***] Script Execution Complete. [***]`n" -ForegroundColor Cyan
