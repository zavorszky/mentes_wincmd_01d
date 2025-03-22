chcp 852
echo off

set ffn_7z="c:\Program Files\7-Zip\7z.exe"
set takaritas=1


echo **********************************
echo . Ment‚s (v01d)
echo . Ind¡t si param‚ter: %1
echo . Takar¡t s: %takaritas%

if "%1"=="0" (
    echo . Alap ment‚s
    goto cim_mentes
)
if "%1"=="1" (
    echo . V ltoz s met‚s
    goto cim_mentes
)
goto cim_hiba_nincs_parameter

:cim_mentes
echo **********************************



for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set datestamp=%dt:~0,8%
set timestamp=%dt:~8,6%

set idobelyeg=%datestamp%_%timestamp%_%1

rem -- XCOPY
rem -- /A Copies only files with the archive attribute set, doesn't change the attribute.
rem -- /E Copies directories and subdirectories, including empty ones. Same as /S /E. May be used to modify /T.
rem -- /Y Suppresses prompting to confirm you want to overwrite an existing destination file.
rem -- /M Copies only files with the archive attribute set, turns off the archive attribute.
set xcopy_kapcsolok=/E /Y /M
set fdn_munka=h:\DADY\rend\konyvtarak\Projektek\mentes_wincmd_240904_1338\mentes_wincmd\01d\test\tmp
set fdn_cel=%fdn_munka%\%idobelyeg%

rem -- ATTRIB
rem -- +A Archive file attribute.
rem -- /S Processes matching files in the current folder and all subfolders.
rem -- /D Processes folders as well.
set attrib_kapcsolok=/S

rem -- 7z
rem -- a Add files to archive
set z_parancs=a
set z_kapcsolok=-bt


set fdn_arch_forras=%fdn_cel%
set fdn_arch_cel=h:\DADY\rend\konyvtarak\Projektek\mentes_wincmd_240904_1338\mentes_wincmd\01d\test\cel
set ffn_arch_cel=%fdn_arch_cel%\%idobelyeg%


set fdn_forras_1=h:\DADY\rend\konyvtarak\Projektek\mentes_wincmd_240904_1338\mentes_wincmd\01d\test\forras\d1\
set fdn_forras_2=h:\DADY\rend\konyvtarak\Projektek\mentes_wincmd_240904_1338\mentes_wincmd\01d\test\forras\d2\


if "%1"=="0" (
    echo .
    echo . Archice attrib£tom be ll¡t sa.
    echo . ATTRIB kapcsol¢k: +A %attrib_kapcsolok%
    ATTRIB +A %fdn_forras_1%\*.* %attrib_kapcsolok%
    ATTRIB +A %fdn_forras_2%\*.* %attrib_kapcsolok%
)


echo .
echo . A mentend‹ file-ok ”sszeg¡ûjt‚se (XCOPY)...
echo . XCOPY kapcsol¢k: %xcopy_kapcsolok%
XCOPY %fdn_forras_1% %fdn_cel%\d1\ %xcopy_kapcsolok%
XCOPY %fdn_forras_2% %fdn_cel%\d2\ %xcopy_kapcsolok%


echo .
echo . T”m”r¡tve ment‚s....
echo . 7z parancs ‚s kapcsol¢k: %z_parancs% %z_kapcsolok%
%ffn_7z% %z_parancs% %z_kapcsolok% %ffn_arch_cel% %fdn_arch_forras%\


if "%takaritas%"=="1" (
    echo .
    echo . Takar¡t s...
    RMDIR %fdn_cel%\ /S /Q
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