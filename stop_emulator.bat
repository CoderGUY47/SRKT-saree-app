@echo off
echo Stopping Android Emulator...
taskkill /F /IM emulator.exe
taskkill /F /IM qemu-system-x86_64.exe
pause
