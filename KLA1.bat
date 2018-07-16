@echo off
:ask
	SET /p number="Enter the number N > 0, N < 86400: "
if %number% LSS 0 goto:ask
if %number% GTR 86400 goto:ask
if %number%=="" goto:ask
echo Number of seconds:
echo %number%
echo Number of minutes:
set /a res = %number%/60
echo %res%
echo Number of hours:
set /a res = %number%/3600
echo %res%