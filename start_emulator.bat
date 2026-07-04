@echo off
echo Starting Android Emulator (medium_phone)...
"%LOCALAPPDATA%\Android\Sdk\emulator\emulator.exe" -avd medium_phone -no-snapshot-load
pause
