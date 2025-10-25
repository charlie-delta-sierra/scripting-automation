:: gemini 28.9.2025

@echo off
setlocal enabledelayedexpansion

:: --- Date Generation for Folder Name (YYYYMMDD) ---
:: Uses WMIC to reliably get the current date/time (YYYYMMDDHHMMSS)
for /f "skip=1 tokens=2 delims==" %%d in ('wmic os get localdatetime /value') do (
    set "DATETIME=%%d"
)

:: Extract and format YYYY-MM-DD
set "YYYY=%DATETIME:~0,4%"
set "MM=%DATETIME:~4,2%"
set "DD=%DATETIME:~6,2%"
set "DATE_PREFIX=%YYYY%-%MM%-%DD%"

:: --- Request Folder Name from User ---
:INPUT_FOLDER
echo.
set "USER_INPUT="
set /p "USER_INPUT=Enter name for the folder (Ex: project name): "

if "%USER_INPUT%"=="" (
    echo Folder name cannot be empty.
    goto :INPUT_FOLDER
)

:: Remove quotes, if any, and save in FOLDER_NAME_RAW
set "FOLDER_NAME_RAW=%USER_INPUT:\"=%"

:: --- Replace Spaces with Underscores ---
set "FOLDER_NAME_CLEAN=%FOLDER_NAME_RAW: =_%"

:: --- Create Final Folder Name ---
set "FOLDER_NAME=%DATE_PREFIX%_%FOLDER_NAME_CLEAN%"
echo.
echo Creating folder: "%FOLDER_NAME%"

:: --- Create Folder ---
mkdir "%FOLDER_NAME%"

if not exist "%FOLDER_NAME%\" (
    echo.
    echo ERROR: Could not create folder "%FOLDER_NAME%". Exiting.
    goto :end
)

:: --- Create TXT File ---
set "FILE_NAME=job_description.txt"

:: set file content or write with echo
:: set "FILE_CONTENT=URL: \r\n - - - \r\n\r\nDESCRIPTION\r\n - - - - - \r\n\r\n "
(
    echo URL: 
	echo  - - 
    echo.
	echo.
	echo.
    echo DESCRIPTION
	echo  - - - - - 
	echo.
    echo.
) > "%FOLDER_NAME%\%FILE_NAME%"

echo.
echo File "%FILE_NAME%" created in "%FOLDER_NAME%".
echo Done.

:end
endlocal