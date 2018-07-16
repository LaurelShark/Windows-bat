@echo off

setlocal enableextensions disabledelayedexpansion
if not exist Dates.txt goto errorMessage
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a" 
set "td.YY=%dt:~2,2%" 
set "td.YYYY=%dt:~0,4%"
set "td.MM=%dt:~4,2%"
set "td.DD=%dt:~6,2%"

::Remove padding from date elements and increase day
set /a "y=%td.YYYY%", "m=100%td.MM% %% 100", "d=(100%td.DD% %% 100)+1" 
::Calculate month length
set /a "ml=30+((m+m/8) %% 2)" & if %m% equ 2 set /a "ml=ml-2+(3-y %% 4)/3-(99-y %% 100)/99+(399-y %% 400)/399"
    rem Adjust day / month / year for tomorrow date
if %d% gtr %ml% set /a "d=1", "m=(m %% 12)+1", "y+=(%m%/12)"

::Pad date elements and set tomorrow variables
set /a "m+=100", "d+=100"

set "tm.YYYY=%y%"
set "tm.YY=%y:~-2%"
set "tm.MM=%m:~-2%"
set "tm.DD=%d:~-2%"

set today=%td.DD%.%td.MM%.%td.YYYY%
set tomorrow=%tm.DD%.%tm.MM%.%tm.YYYY%
echo Today's date:
echo %today%
echo Tomorrow date:
echo %tomorrow%
	
echo Notification for events: 

for /f "tokens=1,2 delims=:" %%A in (Dates.txt) do (
    if "%%B"==" %tomorrow%" (   
	echo You are going %%Atomorrow!
	) ELSE (
	echo You don't have other events for tomorrow! 
	)
)

goto :EOF

:errorMessage
echo Take file Dates.txt into right directory!
goto :EOF
	
	
	
	
