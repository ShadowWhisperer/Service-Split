@echo off

::
:: Creator: ShadowWhisperer
::  Github: https://github.com/ShadowWhisperer
:: Created: 2019
:: Updated: 12/09/2024
::
:: Reduce the number of svchost.exe processes that appear in the Taskmanager
:: Run the script and reboot.
:: If you add or remove RAM, run this script again, and reboot
::
::

:: Check if ran as Admin
net session >nul 2>&1 || (echo. & echo Run Script As Admin & echo. & pause & exit)

:: Get RAM in KB using PowerShell
for /f "tokens=*" %%p in ('powershell -NoProfile -Command "& {(Get-CimInstance -ClassName Win32_OperatingSystem).TotalVisibleMemorySize}"') do (
    set m=%%p
    goto :done
)
:done
set "HEX=%m%"

:: Convert HEX to Dec
set /A DEC=0x%HEX%

:: Set SVCHost Split Size
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v SvcHostSplitThresholdInKB /t REG_DWORD /d "%DEC%" /f >nul 2>&1
