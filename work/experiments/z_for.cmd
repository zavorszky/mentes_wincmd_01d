chcp 852
echo off
rem -- https://ss64.com/nt/for.html

for /f "tokens=*" %%g in ('type z_for.txt') do (
    echo %%g
)
pause