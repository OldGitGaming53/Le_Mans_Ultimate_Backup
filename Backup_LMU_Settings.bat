@echo off
:: ==========================================
:: LE MANS ULTIMATE SETTINGS BACKUP SCRIPT
:: ==========================================

:: [OPTIONAL MANUAL OVERVIEW] 
:: If auto-detection fails or you want to force a specific path, 
:: uncomment the line below (remove the ::) and set your exact path:
:: set "MANUAL_SOURCE=F:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player"

set "BACKUP_DIR=%USERPROFILE%\Desktop\LMU_Settings_Backup"

:: 1. Check if a manual path was specified above
if defined MANUAL_SOURCE (
    set "SOURCE_DIR=%MANUAL_SOURCE%"
    goto CheckPath
)

echo Finding Steam installation path from Windows Registry...

:: 2. Try to get Steam path from Registry
set "STEAM_PATH="
for /f "tokens=2,*" %%A in ('reg query "HKLM\SOFTWARE\WOW6432Node\Valve\Steam" /v InstallPath 2^>nul') do set "STEAM_PATH=%%B"
if not defined STEAM_PATH (
    for /f "tokens=2,*" %%A in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do set "STEAM_PATH=%%B"
)

if defined STEAM_PATH set "STEAM_PATH=%STEAM_PATH:/=\%"

:: 3. Set the LMU Player Path based on found Steam path or common defaults
if defined STEAM_PATH (
    if exist "%STEAM_PATH%\steamapps\common\Le Mans Ultimate\UserData\player" (
        set "SOURCE_DIR=%STEAM_PATH%\steamapps\common\Le Mans Ultimate\UserData\player"
        goto CheckPath
    )
)

:: Fallback default paths if registry path doesn't contain the game
if exist "C:\Program Files (x86)\Steam\steamapps\common\Le Mans Ultimate\UserData\player" (
    set "SOURCE_DIR=C:\Program Files (x86)\Steam\steamapps\common\Le Mans Ultimate\UserData\player"
) else if exist "D:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player" (
    set "SOURCE_DIR=D:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player"
) else if exist "F:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player" (
    set "SOURCE_DIR=F:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player"
) else (
    set "SOURCE_DIR=C:\Program Files (x86)\Steam\steamapps\common\Le Mans Ultimate\UserData\player"
)

:CheckPath
echo Checking for Le Mans Ultimate settings...

:: 4. Check if the source folder exists
if not exist "%SOURCE_DIR%" (
    echo.
    echo [ERROR] Could not find the LMU player folder at:
    echo "%SOURCE_DIR%"
    echo.
    echo Right-click this file, click Edit, and uncomment/update the MANUAL_SOURCE line at the top.
    pause
    exit
)

:: 5. Create the backup directory if it doesn't exist
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: 6. Copy the files
echo Backing up your settings to %BACKUP_DIR%...
xcopy "%SOURCE_DIR%\*" "%BACKUP_DIR%/" /E /Y /I

echo.
echo [SUCCESS] Backup completed successfully!
pause