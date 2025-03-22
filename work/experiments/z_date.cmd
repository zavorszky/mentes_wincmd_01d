
rem --1--
rem -- set mydate=%date:~10,4%%date:~6,2%/%date:~4,2%
rem -- echo %mydate%

echo ******************* DATE
echo %date%
echo %time%
echo %date:~2,2%%date:~5,2%%date:~8,2%

echo ***************** TIME
echo %time%
FOR /F "TOKENS=1,2 DELIMS=: " %%A IN ('TIME/T') DO SET HH=%%A && SET MM=%%B
echo %HH%
echo %MM%

echo ****************** TIME-2
for /f "tokens=1,2,4 delims=:,. " %%A in ('time/T') do (

set HH2=%%A

set MM2=%%B

set SS2=%%C
)

echo %HH2%
echo %MM2%
echo %SS2%

echo ***************** TIME-3
set x=%time /t%
echo %x%
echo %time:~-11,2%-%time:~-8,2%-%time:~-5,2%



echo ***************** TIME-4
rem -- Link: https://stackoverflow.com/questions/41019638/time-format-and-leading-trailing-zeros-spaces
@echo off
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set datestamp=%dt:~0,8%
set timestamp=%dt:~8,6%
set YYYY=%dt:~0,4%
set MM=%dt:~4,2%
set DD=%dt:~6,2%
set HH=%dt:~8,2%
set Min=%dt:~10,2%
set Sec=%dt:~12,2%
set stamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%
echo stamp: "%stamp%"
pause
echo datestamp: "%datestamp%"
pause
echo timestamp: "%timestamp%"
pause
set MyVar=%HH%.%Min%.%Sec%
echo My desired Variable in this format hh.mm.ss to use is : %MyVar%
pause