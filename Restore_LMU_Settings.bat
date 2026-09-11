@echo off
:: ==========================================
:: LE MANS ULTIMATE SETTINGS RESTORE SCRIPT
:: ==========================================

:: [OPTIONAL MANUAL OVERVIEW] 
:: If auto-detection fails or you want to force a specific path, 
:: uncomment the line below (remove the ::) and set your exact path:
:: set "MANUAL_SOURCE=F:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player"

set "BACKUP_DIR=%USERPROFILE%\Desktop\LMU_Settings_Backup"

:: 1. Check if the backup folder actually exists on the desktop
if not exist "%BACKUP_DIR%" (
    echo.
    echo [ERROR] Could not find the backup folder at:
    echo "%BACKUP_DIR%"
    echo Please make sure you have run your backup script first!
    echo.
    pause
    exit
)

:: 2. Check if a manual path was specified above
if defined MANUAL_SOURCE (
    set "DEST_DIR=%MANUAL_SOURCE%"
    goto CheckPath
)

echo Finding Steam installation path from Windows Registry...

:: 3. Try to get Steam path from Registry
set "STEAM_PATH="
for /f "tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\WOW6432Node\Valve\Steam" /v InstallPath 2^>nul') do set "STEAM_PATH=%%B"
if not defined STEAM_PATH (
    for /f "tokens=2,*" %%A in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "STEAM_PATH=%%B"
)

if defined STEAM_PATH set "STEAM_PATH=%STEAM_PATH:/=\%"

:: 4. Set the LMU Player Path based on found Steam path or common defaults
if defined STEAM_PATH (
    if exist "%STEAM_PATH%\steamapps\common\Le Mans Ultimate\UserData\player" (
        set "DEST_DIR=%STEAM_PATH%\steamapps\common\Le Mans Ultimate\UserData\player"
        goto CheckPath
    )
)

:: Fallback default paths if registry path doesn't contain the game
if exist "C:\Program Files (x86)\Steam\steamapps\common\Le Mans Ultimate\UserData\player" (
    set "DEST_DIR=C:\Program Files (x86)\Steam\steamapps\common\Le Mans Ultimate\UserData\player"
) else if exist "D:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player" (
    set "DEST_DIR=D:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player"
) else if exist "F:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player" (
    set "DEST_DIR=F:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player"
) else (
    set "DEST_DIR=C:\Program Files (x86)\Steam\steamapps\common\Le Mans Ultimate\UserData\player"
)

:CheckPath
echo Checking for Le Mans Ultimate player folder...

:: 5. Check if the destination folder exists
if not exist "%DEST_DIR%" (
    echo.
    echo [ERROR] Could not find the LMU player folder at:
    echo "%DEST_DIR%"
    echo.
    echo Right-click this file, click Edit, and uncomment/update the MANUAL_SOURCE line at the top.
    pause
    exit
)

:: 6. Restore the files
echo Restoring settings from %BACKUP_DIR% to your game folder...
xcopy "%BACKUP_DIR%\*" "%DEST_DIR%\" /E /Y /I

echo.
echo [SUCCESS] Settings restored successfully!
pause