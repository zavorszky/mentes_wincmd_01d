@echo off
chcp 852

set verzio=01d
set ffn_7z="c:\Program Files\7-Zip\7z.exe"

set uzemmod_batch=1
rem -- set futhat_attrib=0
rem -- set futhat_xcopy=0
set futhat_7z=1
set futhat_rmdir=0
rem set kapcs_takaritas=1


for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set datestamp=%dt:~0,8%
set timestamp=%dt:~8,6%

set idobelyeg=%datestamp%_%timestamp%_%1


rem -- A win10 TEMP k�nyvt�r�nak haszn�lata (TEMP=C:\Users\dady\AppData\Local\Temp).
set fdn_munka=%TEMP%\mentes_%verzio%

set fdn_cel=%fdn_munka%\%idobelyeg%

set fdn_arch_forras=%fdn_cel%
set fdn_arch_cel=i:
set ffn_arch_cel=%fdn_arch_cel%\%idobelyeg%


rem -- ATTRIB
rem -- +A Archive file attribute.
rem -- /S Processes matching files in the current folder and all subfolders.
rem -- /D Processes folders as well.
set attrib_kapcsolok=/S /D


rem -- XCOPY
rem -- /A Copies only files with the archive attribute set, doesn't change the attribute.
rem -- /E Copies directories and subdirectories, including empty ones. Same as /S /E. May be used to modify /T.
rem -- /Y Suppresses prompting to confirm you want to overwrite an existing destination file.
rem -- /M Copies only files with the archive attribute set, turns off the archive attribute.
rem -- /J Copies using unbuffered I/O. Recommended for very large files.
rem set xcopy_kapcsolok=/E /Y /M /Q /J
set xcopy_kapcsolok=/E /Y /M


rem -- 7z
rem -- a Add files to archive
rem -- -bt : show execution time statistics
rem -- -r[-|0] : Recurse subdirectories for name search
set z_parancs=a
set z_kapcsolok=-bt -bd -r


:cim_panel
echo **********************************
echo . Ment�s (%verzio%)
echo .
echo . Batch �zemm�d:%uzemmod_batch%
echo . Futhat a 7z:%futhat_7z%, Futhat az RMDIR:%futhat_rmdir%
echo . Mentend� k�nyvt�rak file-ja:%2
echo .
echo . XCOPY Munkak�nyvt�r:%fdn_munka%
echo . XCOPY c�lk�nyvt�r:%fdn_cel%
echo . XCOPY kapcsol�k:%xcopy_kapcsolok%
echo . ATTRIB kapcsol�k:%attrib_kapcsolok%
echo . 7z parancsok:%z_parancs%
echo . 7z kapcsol�k:%z_kapcsolok%
echo . 7z c�l teljes archi�v file:%ffn_arch_cel%

if "%1"=="0" (
    echo .
    echo . Ment�s t�pusa: %1, Alap ment�s
    goto cim_panel_vege
)
if "%1"=="1" (
    echo .
    echo . Ment�s t�pusa: %1, V�ltoz�s met�s
    goto cim_panel_vege
)
goto cim_hiba_nincs_parameter

:cim_panel_vege

set mentes_tipus=%1
echo **********************************

if "%uzemmod_batch%"=="1" goto cim_batch
echo Megszak�t�s (ctrl-C)
pause
:cim_batch


:cim_gyujtes
echo .
echo . Mentend� k�nyvt�rak �sszegy�jt�se.
echo . Kezd�s %time%
set /a szamlalo=0
for /f "tokens=*" %%g in ('type %2') do ( call :cim_gyujtes_mag %%g %%h)
echo .
echo . K�sz %time%
goto cim_gyujtes_vege



:cim_gyujtes_mag
set /a szamlalo+=1
echo .
echo [%szamlalo%] %time% %1 %2

if "%mentes_tipus%"=="1" goto cim_attrib_1
echo .
echo . Archive attrib�tum be�ll�t�sa (ATTRIB).
ATTRIB +A %1\*.* %attrib_kapcsolok%
:cim_attrib_1

echo .
echo . M�sol�s munkater�letre (XCOPY).
XCOPY %1 %fdn_cel%\%2\ %xcopy_kapcsolok%

if errorlevel 5 goto cim_xcopy_errorlevel_5
if errorlevel 4 goto cim_xcopy_errorlevel_4
if errorlevel 3 goto cim_xcopy_errorlevel_3
if errorlevel 2 goto cim_xcopy_errorlevel_2
if errorlevel 1 goto cim_xcopy_errorlevel_1
goto cim_xcopy_errorlevel_0

:cim_xcopy_errorlevel_5
echo .
echo . Hiba! Lemez�r�si hiba.
goto cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_4
echo .
echo . Hiba! Inicializ�l�si hiba. Nincs el�g mem�ria vagy lemezter�let; vagy szintaktikus hiba.
goto cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_3
echo .
echo . Hiba! Ismeretlen hibak�d: 3
goto cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_2
echo .
echo . Figyelem! Az XCOPY (ctrl-C)-vel le lett �ll�tva.
goto cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_1
echo .
echo . Figyelem! Az XCOPY nem tal�lt m�soland� file-t.
goto cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_0
goto :eof

:cim_gyujtes_vege



echo .
echo . T�m�r�tve-ment�s (7z).
if "%futhat_7z%"=="0" (
    echo .
    echo . Figyelem! Nincs t�m�r�tve-ment�s.
    goto cim_zip_vege
)

echo .
echo . Kezd�s %time%
%ffn_7z% %z_parancs% %z_kapcsolok% %ffn_arch_cel% %fdn_arch_forr

if errorlevel 1 (
    echo .
    echo . Figyelem! A t�m�r�t� fut�sa k�zben figyemeztet�s v. hiba t�rt�nt. errorlevel:%errorlevel%.
    goto cim_zip_vege
)
echo .
echo . K�sz %time%

:cim_zip_vege



echo .
echo . Takar�t�s (RMDIR).
if "%futhat_rmdir%"=="0" (
    echo .
    echo . Figyelem! Nincs takar�t�s
    goto cim_rmdir_vege
)

echo.
echo . Kezd�s %time%
RMDIR %fdn_cel%\ /S /Q

if errorlevel 1 (
    echo .
    echo . Figyelem! Az MKDIR fut�sa k�zben figyemeztet�s v. hiba t�rt�nt. errorlevel:%errorlevel%.
    goto cim_rmdir_vege
)
echo .
echo . K�sz %time%

:cim_rmdir_vege


goto cim_befejezo_uzenet


:cim_hiba_nincs_parameter
echo .
echo . Nincs vagy hib�s az ind�t�si param�ter. Helyes: 0 vagy 1
goto cim_vege

:cim_befejezo_uzenet
echo .
echo . A ment�s sikeresen v�get�rt

:cim_vege
rem -- pause