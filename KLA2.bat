@echo off & setlocal EnableDelayedExpansion
set map=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ

:Main
cls
set "DecIn="
set /p DecIn=Enter the value you want to convert:
set /p base=Enter base: 
if not defined DecIn goto :Eof
Set /A DecIn=DecIn
Set /A base=base

call :Dec2Base  %base% %DecIn%  BaseOut
call :Base2Dec  %base% %BaseOut% DecBack
echo DecBack=%DecBack%  Base  %base%=%BaseOut%
pause

goto :main
::-------------------------------------------------------------------------------------
:Dec2Base Base DecIn BaseOut
Setlocal
set /a Num=%2
set "Ret="

:Dec2BaseLoop
set /a "Digit=Num %% %1"
set /a "Num /= %1"
set Ret=!map:~%Digit%,1!%Ret%
if "%Num%" neq "0" goto :Dec2BaseLoop
Endlocal&Set "%3=%Ret%"&Goto :Eof
::-------------------------------------------------------------------------------------

:Base2Dec Base BaseIn DecBack
Setlocal EnableDelayedExpansion
Set /A "Base=%1,PlaceVal=1,Ret=0"
Set Val=%2

:Base2DecLoop
Set "Digit=%Val:~-1%"
If %Digit% Leq 9 goto :Next
For /L %%i in (10,1,%Base%) Do If /i "!Digit!" Equ "!map:~%%i,1!" (Set "Digit=%%i" & Goto :Next )
Echo Something went wrong & Pause

:Next
set /A "Ret+=Digit * PlaceVal,PlaceVal *= Base"
Set "Val=%Val:~0,-1%"
If defined Val goto :Base2DecLoop
Endlocal & Set "%3=%Ret%" & Goto :Eof