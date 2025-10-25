:: gemini 2025-10-25
@echo off
setlocal enabledelayedexpansion

:: Define the base path for the template folder
set "TEMPLATE_BASE_DIR=00_template"

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

:: --- Request Folder Name and Language from the User (All at once) ---
:INPUT_ALL
echo.
set "USER_INPUT="
set /p "USER_INPUT=Enter folder name and language [DE | EN (default)]: "

if "%USER_INPUT%"=="" (
    echo Input cannot be empty.
    goto :INPUT_ALL
)

:: Remove quotation marks, if any, to simplify string manipulation
set "USER_INPUT=%USER_INPUT:\"=%"

:: --- 1. Determine Language and Extract Folder Name ---
set "FOLDER_NAME_RAW=%USER_INPUT%"
set "LANGUAGE_UPPER=EN" :: Assume EN as default
set "TEMPORARY_INPUT=!USER_INPUT! "

:: Try to identify and remove DE or EN from the end of the string
for %%L in (DE EN de en) do (
    if "!TEMPORARY_INPUT: %%L =!" neq "!TEMPORARY_INPUT!" (
        :: If the string changed, the language was found at the end
        set "LANGUAGE_UPPER=%%L"
        
        :: Remove the language and a space to get only the folder name
        set "FOLDER_NAME_RAW=!USER_INPUT: %%L=!"
        set "FOLDER_NAME_RAW=!FOLDER_NAME_RAW: %%L=!"
    )
)

:: Convert the language to uppercase (necessary for "de" or "en")
set "LANGUAGE_UPPER=!LANGUAGE_UPPER:de=DE!"
set "LANGUAGE_UPPER=!LANGUAGE_UPPER:en=EN!"

:: --- 2. Clean the Folder Name ---
:: Remove trailing and leading spaces (trim)
for /f "tokens=*" %%A in ("%FOLDER_NAME_RAW%") do set "FOLDER_NAME_RAW=%%A"

:: Replace Spaces with Underscores
set "FOLDER_NAME_CLEAN=!FOLDER_NAME_RAW: =_!"

:: --- 3. Define the Template Source ---
set "TEMPLATE_SOURCE=%TEMPLATE_BASE_DIR%\!LANGUAGE_UPPER!"

if not exist "%TEMPLATE_SOURCE%\" (
    echo.
    echo ERROR: Language template folder "!LANGUAGE_UPPER!" not found in "%TEMPLATE_BASE_DIR%\".
    echo Verify the path is correct. Exiting.
    goto :end
)

:: --- 4. Create the Final Folder Name (DATE_NAME) ---
set "FOLDER_NAME=%DATE_PREFIX%_!FOLDER_NAME_CLEAN!"
echo.
echo Detected language: !LANGUAGE_UPPER!
echo Creating folder: "%FOLDER_NAME%"

:: --- Create the Destination Folder ---
mkdir "%FOLDER_NAME%"

if not exist "%FOLDER_NAME%\" (
    echo.
    echo ERROR: Could not create folder "%FOLDER_NAME%". Exiting.
    goto :end
)

:: --- Copy Template Content ---
echo.
echo Copying !LANGUAGE_UPPER! template content to the new folder...

:: XCOPY command copies files and subdirectories, excluding hidden and system files.
:: /E: Copies subdirectories, including empty ones.
:: /I: Assumes destination is a directory.
:: /Y: Suppresses file overwrite prompt.
xcopy "%TEMPLATE_SOURCE%\*.*" "%FOLDER_NAME%\" /E /I /Y >nul

if errorlevel 1 (
    echo.
    echo WARNING: The copy may have failed or not copied all files.
) else (
    echo Copy completed successfully.
)

:: --- Create the TXT File ---
set "FILE_NAME=job_description.txt"

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
echo File "%FILE_NAME%" created inside "%FOLDER_NAME%".
echo.
echo Operation completed successfully!

:end
endlocal