@echo off

rem -- Settings ----------------------------

rem pyinstaller flag to add a console window
set console=0

rem pause when done
rem (note: errors will always pause)
set dopause=0

rem ----------------------------------------


set starttime=%TIME%

rem test to make sure we have the "where" command
where/?>nul 2>&1
if %errorlevel% NEQ 0 set errormessage="where" command not available.& goto error

rem set pyinstaller flag to determine if a console window will be added
set parameter=w
if %console% NEQ 0 set suffix=C& set parameter=c

rem make sure we can find pyinstaller
where/q pyinstaller
if %errorlevel% NEQ 0 set errormessage=Could not find pyinstaller.& goto error

rem copy files
echo copying required files to dist folder...
copy/y main.lua dist
if %errorlevel% NEQ 0 set errormessage=Could not copy main.lua & goto error
copy/y chr.png dist
if %errorlevel% NEQ 0 set errormessage=Could not copy chr.png & goto error

rem run pyinstaller
pyinstaller --onefile -%parameter% -i icon.ico -n NESBuilder%suffix%.exe ^
            --add-binary "include\Tserial.lua;include" ^
            --add-binary "include\util.lua;include" ^
            --add-binary "cursors\pencil.cur;cursors" ^
            NESBuilder.py
if %errorlevel% NEQ 0 goto error

echo start time: %starttime%
echo end time: %TIME%

goto theend

:error
echo.
echo.ERROR: %errormessage%
echo.
pause
exit

:theend
echo Done.
if %dopause% NEQ 0 pause