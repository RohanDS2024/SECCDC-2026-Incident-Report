# ==============================================================================
# SCRIPT: Audit-And-Clean-Users.ps1
# PURPOSE: Enumerate ALL local accounts (visible & hidden) and prompt for action.
# TARGET: Windows 10 / Windows Server 2016 (Core Compatible)
# ==============================================================================

# ------------------------------------------------------------------------------
# THE VANCE ANALYST NOTE:
# "Hidden" users in Windows aren't like hidden files. They are just accounts 
# configured not to show up on the Welcome screen (via registry). 
# However, `Get-LocalUser` sees everything. 
#
# DANGER ZONE: 
# 1. NEVER delete the built-in 'Administrator' account. Even if you rename it,
#    the SID (ID ending in -500) remains the same. Disabling is safer.
# 2. 'Guest' and 'DefaultAccount' are standard. Usually, just ensure they are Disabled.
# ------------------------------------------------------------------------------

Clear-Host
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host " USER ACCOUNT AUDIT - SEARCHING FOR ANOMALIES" -ForegroundColor Cyan
Write-Host "================================================================" -ForegroundColor Cyan

# 1. GET ALL USERS
# We use Get-LocalUser because it pulls the raw local database, ignoring
# whether an account is "hidden" from the GUI login screen.

$allUsers = Get-LocalUser

# 2. DISPLAY THE LIST
# We format this as a table so you can quickly spot "Enabled" accounts that shouldn't be.
# Valid = Enabled. False = Disabled.

$allUsers | Select-Object Name, Enabled, Description, LastLogon | Format-Table -AutoSize

Write-Host "----------------------------------------------------------------" -ForegroundColor Gray
Write-Host "REVIEW THE LIST ABOVE CAREFULLY." -ForegroundColor Yellow
Write-Host "Look for generic names like 'User', 'Test', 'Admin2', or 'HelpDesk'." -ForegroundColor Yellow
Write-Host "----------------------------------------------------------------`n"

# 3. INTERACTIVE PROMPT LOOP
# This allows you to clean up multiple users without re-running the script.

while ($true) {
    
    $targetUser = Read-Host "Enter the NAME of the user to modify (or press ENTER to quit)"

    # Exit condition: If the user just hits Enter, stop the script.
    if ([string]::IsNullOrWhiteSpace($targetUser)) {
        Write-Host "Exiting Audit. Stay safe." -ForegroundColor Cyan
        break
    }

    # Verify the user actually exists before trying to kill it
    $userObject = Get-LocalUser -Name $targetUser -ErrorAction SilentlyContinue

    if ($userObject) {
        
        Write-Host "`nTarget Found: $($userObject.Name)" -ForegroundColor Cyan
        Write-Host "Choose an action:"
        Write-Host "  [D] DISABLE (Safe: Locks the account, can be undone)"
        Write-Host "  [X] DELETE  (Destructive: Removes account and profile)"
        Write-Host "  [S] SKIP    (Cancel)"
        
        $action = Read-Host "Action [D/X/S]"

        switch ($action.ToUpper()) {
            "D" {
                # DISABLE ACTION
                Disable-LocalUser -Name $targetUser
                Write-Host "[+] SUCCESS: Account '$targetUser' has been DISABLED." -ForegroundColor Green
            }
            "X" {
                # DELETE ACTION
                # Safety checks for built-in accounts to prevent bricking the OS
                if ($targetUser -in @("Administrator", "Guest", "DefaultAccount", "WDAGUtilityAccount")) {
                    Write-Host "[!] BLOCK: You cannot delete built-in Windows accounts. Try Disabling instead." -ForegroundColor Red
                }
                else {
                    # Double confirmation for deletion
                    $confirm = Read-Host "Are you SURE you want to DELETE '$targetUser'? This cannot be undone. (Type 'YES')"
                    if ($confirm -eq "YES") {
                        Remove-LocalUser -Name $targetUser
                        Write-Host "[+] SUCCESS: Account '$targetUser' has been DELETED." -ForegroundColor Green
                    } else {
                        Write-Host "[-] Action Cancelled." -ForegroundColor Yellow
                    }
                }
            }
            "S" {
                Write-Host "Skipping..." -ForegroundColor Gray
            }
            Default {
                Write-Host "Invalid selection. Skipping..." -ForegroundColor Red
            }
        }
    }
    else {
        Write-Host "[-] User '$targetUser' not found. Check spelling." -ForegroundColor Red
    }
    
    Write-Host "`n--- Ready for next command ---" -ForegroundColor Gray
}
