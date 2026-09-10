@echo off
:: ==========================================
:: LE MANS ULTIMATE SETTINGS BACKUP SCRIPT (F: DRIVE)
:: ==========================================

:: 1. Define the Backup Destination (Your Desktop)
set "BACKUP_DIR=%USERPROFILE%\Desktop\LMU_Settings_Backup"

:: 2. Define your LMU Player Path (F: Drive Steam Install)
set "SOURCE_DIR=F:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player"

echo Checking for Le Mans Ultimate settings on F: Drive...

:: 3. Check if the source folder exists
if not exist "%SOURCE_DIR%" (
    echo.
    echo [ERROR] Could not find the LMU player folder at:
    echo "%SOURCE_DIR%"
    echo.
    echo If your Steam library folder has a custom name or different layout on F:, 
    echo right-click this .bat file, click Edit, and correct the SOURCE_DIR path.
    pause
    exit
)

:: 4. Create the backup directory if it doesn't exist
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: 5. Copy the files (Removed /D to force copy everything)
echo Backing up your settings to %BACKUP_DIR%...
xcopy "%SOURCE_DIR%\*" "%BACKUP_DIR%\" /E /Y /I

echo.
echo ==========================================
echo [SUCCESS] Backup complete! 
echo ==========================================
pause
