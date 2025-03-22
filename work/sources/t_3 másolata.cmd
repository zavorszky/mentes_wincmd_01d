@echo off
chcp 852

set verzio=01d
set ffn_7z="c:\Program Files\7-Zip\7z.exe"

set futhat_attrib=0
set futhat_xcopy=0
set futhat_7z=0
set futhat_rmdir=0
set kapcs_takaritas=0


for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set datestamp=%dt:~0,8%
set timestamp=%dt:~8,6%

set idobelyeg=%datestamp%_%timestamp%_%1


rem -- A win10 TEMP k”nyvt r nak haszn lata (TEMP=C:\Users\dady\AppData\Local\Temp).
set fdn_munka=%TEMP%\mentes_%verzio%

set fdn_cel=%fdn_munka%\%idobelyeg%

set fdn_arch_forras=%fdn_cel%
set fdn_arch_cel=i:
set ffn_arch_cel=%fdn_arch_cel%\%idobelyeg%


rem -- XCOPY
rem -- /A Copies only files with the archive attribute set, doesn't change the attribute.
rem -- /E Copies directories and subdirectories, including empty ones. Same as /S /E. May be used to modify /T.
rem -- /Y Suppresses prompting to confirm you want to overwrite an existing destination file.
rem -- /M Copies only files with the archive attribute set, turns off the archive attribute.
rem -- /J Copies using unbuffered I/O. Recommended for very large files.
rem set xcopy_kapcsolok=/E /Y /M /Q /J
set xcopy_kapcsolok=/E /Y /M


rem -- ATTRIB
rem -- +A Archive file attribute.
rem -- /S Processes matching files in the current folder and all subfolders.
rem -- /D Processes folders as well.
set attrib_kapcsolok=/S /D


rem -- 7z
rem -- a Add files to archive
rem -- -bt : show execution time statistics
rem -- -r[-|0] : Recurse subdirectories for name search
set z_parancs=a
set z_kapcsolok=-bt -bd -r


echo **********************************
echo . Ment‚s (v01d)
echo . Ind¡t si param‚ter: %1
echo . Futhat az ATTRIB  : %futhat_attrib%
echo . Futhat az XCOPY   : %futhat_xcopy%
echo . Futhat a 7z       : %futhat_7z%
echo . Futhat az RMDIR   : %futhat_rmdir%
echo . Takar¡t s         : %kapcs_takaritas%
echo .
echo . XCOPY Munkak”nyvt r : %fdn_munka%
echo . XCOPY c‚lk”nyvt r   : %fdn_cel%
echo . XCOPY kapcsol¢k     : %xcopy_kapcsolok%
echo . ATTRIB kapcsol¢k    : %attrib_kapcsolok%
echo . 7z parancsok        : %z_parancs%
echo . 7z kapcsol¢k        : %z_kapcsolok%
echo . 7z c‚l teljes archi¡v file: %ffn_arch_cel%

if "%1"=="0" (
    echo .
    echo . Alap ment‚s
    goto cim_mentes
)
if "%1"=="1" (
    echo .
    echo . V ltoz s met‚s
    goto cim_mentes
)
goto cim_hiba_nincs_parameter

:cim_mentes
echo **********************************
pause

set szamlalo=0
pause
for /f "tokens=*" %%g in ('type t_3.txt') do (
    set /a szamlalo+=1
    echo %szamlalo% %time% %%g

    rem call :mentes_mag
    
)
goto mentes_ciklus_vege

:mentes_mag
rem goto :eof
rem if "%1"=="0" (
rem     echo .
rem     echo . Archice attrib£tom be ll¡t sa (ATTRIB).
rem     if "%futhat_attrib%"=="1" ATTRIB +A %fdn_forras_1%*.* %attrib_kapcsolok%
rem )
rem 
rem echo .
rem echo . A mentend‹ file-ok ”sszegyûjt‚se (XCOPY).
rem if "%futhat_xcopy%"=="1" XCOPY %fdn_forras_1% %fdn_cel%\%fdn_forras_1:~3,1000%\ %xcopy_kapcsolok%
goto :eof

:mentes_ciklus_vege

echo .
echo . T”m”r¡tve ment‚s (7z).
if "%futhat_7z%"=="1" %ffn_7z% %z_parancs% %z_kapcsolok% %ffn_arch_cel% %fdn_arch_forras%\


if "%kapcs_takaritas%"=="1" (
    echo .
    echo . Takar¡t s...
    if RMDIR %fdn_cel%\ /S /Q
)


goto cim_vege_1


:cim_hiba_nincs_parameter
echo .
echo . Nincs vagy hib s az ind¡t si param‚ter. Helyes: 0 vagy 1
goto cim_vege

:cim_vege_1
echo .
echo . A ment‚s sikeresen v‚get‚rt

:cim_vege
pause