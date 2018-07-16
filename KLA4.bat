@echo off
echo Set path to test folder

call :searchFolder

:searchFolder
set /p folderName=Enter the path:
if exist %folderName% (
	call :inspectMatch
) ELSE (
	echo There arent any directories with such name
	call :searchFolder
)

:inspectMatch
echo  > List.txt
echo. >> List.txt
for %%n in (%folderName%\*) do (
	echo Same files to the %%n: >> List.txt
	for /r %folderName%\ %%i in (*) do (
		if not %%n==%%i (
			fc /b %%n %%i > nul
				if errorlevel 0 (
					echo File: %%~nxi  Path: %%~dpi  >> List.txt
				)
		)
	)
	echo. >> List.txt
)
::start List.txt
exit
