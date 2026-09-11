==================================================
LE MANS ULTIMATE - SETTINGS BACKUP & RESTORE UTILITY
==================================================

Overview:
These two simple batch scripts allow you to easily back up and restore your 
Le Mans Ultimate (LMU) player settings (such as control profiles, custom setups, 
and configurations) so you never lose your progress when updating or reinstalling the game.

What's Included:
- LMU_Backup_Settings.bat  - Copies your current LMU player settings to your Desktop.
- LMU_Restore_Settings.bat - Restores your settings from your Desktop back into the game.

--------------------------------------------------
HOW TO USE THE BACKUP SCRIPT
--------------------------------------------------
1. Make sure Le Mans Ultimate is closed.
2. Double-click "LMU_Backup_Settings.bat".
3. The script will automatically try to locate your Steam installation and game folder.
4. Once completed, a folder named "LMU_Settings_Backup" will appear on your Desktop 
   containing all your configuration files.

--------------------------------------------------
HOW TO USE THE RESTORE SCRIPT
--------------------------------------------------
1. Make sure Le Mans Ultimate is closed.
2. Double-click "LMU_Restore_Settings.bat".
3. The script will copy the files from your Desktop backup folder straight back 
   into your LMU player directory.

--------------------------------------------------
TROUBLESHOOTING: CUSTOM INSTALLATION PATHS
--------------------------------------------------
If you have Steam or Le Mans Ultimate installed on a custom drive or folder 
where the auto-detection fails (giving an error saying it couldn't find the folder):

1. Right-click either the backup or restore .bat file and select "Edit" (opens in Notepad).
2. Look near the top for this line:
   :: set "MANUAL_SOURCE=F:\SteamLibrary\steamapps\common\Le Mans Ultimate\UserData\player"
3. Remove the two colons (::) at the very beginning of the line to activate it.
4. Change the file path inside the quotation marks to match your exact LMU player folder location.
5. Save the file (Ctrl + S) and run it again!