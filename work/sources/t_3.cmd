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


rem -- A win10 TEMP kînyvt†r†nak haszn†lata (TEMP=C:\Users\dady\AppData\Local\Temp).
rem -- set fdn_munka=%TEMP%\mentes_%verzio%
set fdn_munka=%3
set fdn_munka=%fdn_munka%\mentes_%verzio%

set fdn_cel=%fdn_munka%\%idobelyeg%

set fdn_arch_forras=%fdn_cel%
set fdn_arch_cel=%4
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


if "%1"=="" goto cim_hiba_hianyzo_parameterek
if "%2"=="" goto cim_hiba_hianyzo_parameterek
if "%3"=="" goto cim_hiba_hianyzo_parameterek
if "%4"=="" goto cim_hiba_hianyzo_parameterek

if "%1"=="0" goto cim_param_ellenorzes_jo
if "%1"=="1" goto cim_param_ellenorzes_jo
goto cim_hiba_hianyzo_parameterek

if not exist %2 goto cim_hiba_nem_letezo_file
if not exist %3\nul goto cim_hiba_nem_letezo_konyvtar

:cim_param_ellenorzes_jo



echo **********************************
echo . MentÇs (%verzio%)
if "%1"=="0" echo . MentÇs t°pusa: %1, Alap mentÇs
if "%1"=="1" echo . MentÇs t°pusa: %1, V†ltoz†s metÇs
echo . Mentendã kînyvt†rakat tartalmaz¢ file : %2
echo . Munka kînyvt†r gyokere (XCOPY): %3
echo . MentÇs cÇlkînyvt†ra: %4
echo .
echo . [Batch Åzemm¢d: %uzemmod_batch%] [Futhat a 7z:%futhat_7z%] [Futhat az RMDIR:%futhat_rmdir%]
echo .
echo . XCOPY Munkakînyvt†r: %fdn_munka%
echo . XCOPY cÇlkînyvt†r: %fdn_cel%
echo . XCOPY kapcsol¢k: %xcopy_kapcsolok%
echo . ATTRIB kapcsol¢k: %attrib_kapcsolok%
echo . 7z parancsok: %z_parancs%
echo . 7z kapcsol¢k: %z_kapcsolok%
echo . 7z cÇl teljes archi°v file: %ffn_arch_cel%
echo **********************************



set mentes_tipus=%1


if "%uzemmod_batch%"=="1" goto cim_batch
echo Megszak°t†s (ctrl-C)
pause
:cim_batch



:cim_gyujtes
echo .
echo . Mentendã kînyvt†rak îsszegy˚jtÇse.
echo . KezdÇs %time%
set /a szamlalo=0
for /f "tokens=*" %%g in ('type %2') do ( call :cim_gyujtes_mag %%g %%h)
echo .
echo . KÇsz %time%
goto cim_gyujtes_vege

:cim_gyujtes_mag
set /a szamlalo+=1
echo .
echo [%szamlalo%] %time% %1 %2

if "%mentes_tipus%"=="1" goto cim_attrib_kihagyas
echo .
echo . Archive attrib£tum be†ll°t†sa (ATTRIB).
ATTRIB +A %1\*.* %attrib_kapcsolok%
:cim_attrib_kihagyas

echo .
echo . M†sol†s munkaterÅletre (XCOPY).
XCOPY %1\ %fdn_cel%\%2\ %xcopy_kapcsolok%

if errorlevel 5 goto cim_xcopy_errorlevel_5
if errorlevel 4 goto cim_xcopy_errorlevel_4
if errorlevel 3 goto cim_xcopy_errorlevel_3
if errorlevel 2 goto cim_xcopy_errorlevel_2
if errorlevel 1 goto cim_xcopy_errorlevel_1
goto cim_xcopy_errorlevel_0

:cim_xcopy_errorlevel_5
echo .
echo . Hiba! Lemez°r†si hiba.
goto cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_4
echo .
echo . Hiba! Inicializ†l†si hiba. Nincs elÇg mem¢ria vagy lemezterÅlet; vagy szintaktikus hiba.
goto cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_3
echo .
echo . Hiba! Ismeretlen hibak¢d: 3
goto cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_2
echo .
echo . Figyelem! Az XCOPY (ctrl-C)-vel le lett †ll°tva.
goto cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_1
echo .
echo . Figyelem! Az XCOPY nem tal†lt m†soland¢ file-t.
goto cim_gyujtes_hibauzenetek_vege

:cim_gyujtes_hibauzenetek_vege

:cim_xcopy_errorlevel_0

goto :eof

:cim_gyujtes_vege



echo .
echo . Tîmîr°tve-mentÇs (7z).
if "%futhat_7z%"=="1" goto cim_futhat_zip
echo .
echo . Figyelem! Nincs tîmîr°tve-mentÇs.
goto cim_zip_vege


:cim_futhat_zip
echo .
echo . KezdÇs %time%
%ffn_7z% %z_parancs% %z_kapcsolok% %ffn_arch_cel% %fdn_arch_forras%

if errorlevel 1 goto cim_hiba_zip
echo .
echo . KÇsz %time%
goto cim_zip_vege

:cim_hiba_zip
echo .
echo . Hiba %time%
echo . Figyelem! A tîmîr°tã fut†sa kîzben figyemeztetÇs v. hiba tîrtÇnt. errorlevel:%errorlevel%.
goto cim_zip_vege

:cim_zip_vege



echo .
echo . Takar°t†s (RMDIR).
if "%futhat_rmdir%"=="1" goto cim_futhat_rmdir
echo .
echo . Figyelem! Nincs takar°t†s
goto cim_rmdir_vege


:cim_futhat_rmdir
echo.
echo . KezdÇs %time%
RMDIR %fdn_cel%\ /S /Q

if errorlevel 1 goto cim_hiba_rmdir
echo .
echo . KÇsz %time%
goto cim_rmdir_vege

:cim_hiba_rmdir
echo .
echo . Hiba: %time%
echo . Figyelem! Az MKDIR fut†sa kîzben figyemeztetÇs v. hiba tîrtÇnt. errorlevel:%errorlevel%.
goto cim_rmdir_vege

:cim_rmdir_vege


goto cim_befejezo_uzenet



:cim_hiba_hianyzo_parameterek
echo .
echo . Hiba! A szkript ind°t†s†hoz hi†nyik egy vagy tîbb paramÇter.
goto cim_intitasi_javaslat

:cim_hiba_elso_parameter
echo .
echo . Hiba! Az elsã ind°t†si paramÇter csak 0 vagy 1 lehet.
goto cim_intitasi_javaslat

:cim_hiba_nem_letezo_file
echo .
echo . Hiba! A m†sodik ind°t†si paramÇter egy lÇtezã †llom†ny kell hogy legyen.
goto cim_intitasi_javaslat

:cim_hiba_nem_letezo_konyvtar
echo .
echo . Hiba! A harmadik ind°t†si paramÇter egy lÇtezã kînyvt†r kell hogy legyen.
goto cim_intitasi_javaslat

:cim_intitasi_javaslat
echo .
echo . Ind°t†s:
rem -- echo . mentes_%verzio% mentÇs_tipus mentendã_kînyvt†rak_†llom†nya munka_gyîkÇrkînyvt†r mentÇs_cÇlkînyvt†r
rem -- echo .      mentÇs_tipus : 0 vagy 1.
echo . mentes_%verzio% p1 p2 p3 p4
rem -- echo .   p1 : mentÇs_tipus, 0|1
echo .   p1 : mentÇs tipus, 0 vagy 1
echo .   p2 : mentendã kînyvt†rak †llom†nya (ell. lÇtezã †llom†ny)
echo .   p3 : munka gyîkÇrkînyvt†r (ell. lÇtezã kînyvt†r)
echo .   p4 : mentÇs cÇlkînyvt†r
goto cim_vege


:cim_befejezo_uzenet
echo .
echo . A mentÇs sikeresen vÇgetÇrt.

:cim_vege
rem -- pause