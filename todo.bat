@echo off
setlocal enabledelayedexpansion

set "TODO_DB=todo.txt"

:: Create todo file if it doesn't exist
if not exist "%TODO_DB%" (
    type nul > "%TODO_DB%"
)

:: Check command line arguments
if "%1"=="" goto :show_help
if /i "%1"=="help" goto :show_help
if /i "%1"=="print" goto :print_todos
if /i "%1"=="add" goto :add_todo
if /i "%1"=="done" goto :mark_done
if /i "%1"=="remove" goto :remove_todo
goto :show_help

:show_help
echo Penggunaan: %~nx0 [command] [argument]
echo.
echo Command:
echo   print             Print All Todo Item
echo   add [todo_text]   Add a new todo
echo   remove [id]       Remove todo
echo   done [id]         Mark todo as finished
echo   help              Show help message
goto :end

:print_todos
:: Check if file is empty
for %%A in ("%TODO_DB%") do set size=%%~zA
if %size% equ 0 (
    echo Todo list is empty
    goto :end
)

echo Todos:
set /a counter=1
for /f "usebackq delims=" %%i in ("%TODO_DB%") do (
    echo !counter!. %%i
    set /a counter+=1
)
goto :end

:add_todo
if "%2"=="" (
    echo Please insert the todo text
    goto :end
)

:: Combine all arguments from %2 onwards
set "todo_text="
:combine_args
if "%2"=="" goto :write_todo
if defined todo_text (
    set "todo_text=%todo_text% %2"
) else (
    set "todo_text=%2"
)
shift /2
goto :combine_args

:write_todo
echo [ ] %todo_text% >> "%TODO_DB%"
echo Todo %todo_text% successfully added
goto :end

:mark_done
if "%2"=="" (
    echo Please insert todo's ID
    goto :end
)

:: Check if argument is a number
echo %2| findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo Please insert todo's ID
    goto :end
)

set "line_num=%2"
set /a counter=1
set "temp_file=%TODO_DB%.tmp"
type nul > "%temp_file%"

for /f "usebackq delims=" %%i in ("%TODO_DB%") do (
    if !counter! equ %line_num% (
        set "current_line=%%i"
        set "new_line=!current_line:[ ]=[x]!"
        echo !new_line! >> "%temp_file%"
    ) else (
        echo %%i >> "%temp_file%"
    )
    set /a counter+=1
)

move "%temp_file%" "%TODO_DB%" >nul
echo The %line_num% todo marked done
goto :end

:remove_todo
if "%2"=="" (
    echo Please insert todo's ID
    goto :end
)

:: Check if argument is a number
echo %2| findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo Please insert todo's ID
    goto :end
)

set "line_num=%2"
set /a counter=1
set "temp_file=%TODO_DB%.tmp"
type nul > "%temp_file%"

for /f "usebackq delims=" %%i in ("%TODO_DB%") do (
    if !counter! neq %line_num% (
        echo %%i >> "%temp_file%"
    )
    set /a counter+=1
)

move "%temp_file%" "%TODO_DB%" >nul
echo Removed todo #%line_num%.
goto :end

:end
endlocal