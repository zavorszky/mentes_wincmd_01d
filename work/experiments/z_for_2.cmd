@echo off
:: Info: https://ss64.com/nt/delayedexpansion.html


echo --1a--
set /a szamlalo=0
for /f "tokens=*" %%g in ('type z_for_2.txt') do ( call :ciklusmag_1a %%g )
goto :cim_1a_vege

:ciklusmag_1a
    set /a szamlalo+=1
    echo [%szamlalo%] %1
goto :eof

:cim_1a_vege



echo --1b--
setlocal
set /a szamlalo=0
for /f "tokens=*" %%g in ('type z_for_2.txt') do ( call :ciklusmag_1b %%g )
goto :cim_1b_vege

:ciklusmag_1b
    set /a szamlalo+=1
    echo [%szamlalo%] %1
goto :eof

:cim_1b_vege



echo --2a--
setlocal EnableDelayedExpansion 
set /a szamlalo=0
for /f "tokens=*" %%g in ('type z_for_2.txt') do (
    set /a szamlalo+=1
    echo [!szamlalo!] %%g
)

echo --2b--
setlocal EnableDelayedExpansion 
set /a szamlalo=0
for /f %%g in ('type z_for_2.txt') do (
    set /a szamlalo+=1
    echo [!szamlalo!] %%g
)

pause