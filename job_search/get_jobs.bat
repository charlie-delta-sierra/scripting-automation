:: get applications and positions from structured job search
:: generate through gemini 2025-10-25
:: _
:: this code is intended to help the job search process, getting all applied
:: positions at once. it can be used to identify e.g. most wanted competencies
:: _
:: HINT: this code has some not-corresponded labels to formally respect the syntax
:: for CMD PROMPT, because after every comment must exist a label or valid CMD
:: _
:: enjoy the code
:: Cicero Lima
:: 2025-10-31
@echo off
setlocal enabledelayedexpansion

:: Define the base research directory as requested (must exist at the script's root)
set "ROOT_JOBS=00_get_jobs"
set "LOG_FILE=%ROOT_JOBS%\log.txt"
if exist "%LOG_FILE%" del "%LOG_FILE%"

:: Define the subdirectories for organization
set "DEST_DESC_DIR=%ROOT_JOBS%\positions"
set "DEST_CV_DIR=%ROOT_JOBS%\curriculum"


call :LOG_EXEC .
call :LOG_EXEC ==========================================================
call :LOG_EXEC           Starting Job Application File Organizer
call :LOG_EXEC           %DATE% at %TIME%
call :LOG_EXEC ==========================================================
call :LOG_EXEC .

:: --- 1. Wipe and Recreate Destination Directories ---

call :LOG_EXEC [SETUP] creating destination directories...

:: Delete existing folder and its contents (/S /Q = silent recursive)
:: and recreate folder structure
if exist "%ROOT_JOBS%\" rmdir /S /Q "%ROOT_JOBS%"
if not exist "%ROOT_JOBS%\" (
    mkdir "%ROOT_JOBS%"
	mkdir "%DEST_DESC_DIR%"
	mkdir "%DEST_CV_DIR%"
	call :LOG_EXEC Folder structure created.
)

::if not exist "%ROOT_JOBS%" or not exist "%DEST_DESC_DIR%\"  or not exist "%DEST_CV_DIR%" (
if not exist "%ROOT_JOBS%" (
    call :LOG_EXEC [ERROR] Folder struture coudnt be created. Terminate.
    goto :end
)

:: --- 2. Search and Copy Job Description Files (job_description.txt) ---
:: false -> get positions / true -> ignore jobs, jump to applications
set COUNTER_WARNING=0
if "a"=="b" (
	goto :applications
)
call :LOG_EXEC .
call :LOG_EXEC [PROGRESS]  Searching positions . . .

:: FOR /R performs a recursive search across all subfolders.
set COUNTER_FILES=0
for /R %%f in (job_description*) do (
	::call :LOG_EXEC %%f
	:label_j1
    
    :: Logic to extract the parent folder's name (e.g., 2025-10-29_anyjob_anyfirma)
    set "FULL_PATH=%%~dpf"    
    :: Remove the trailing backslash from the path
    set "FULL_PATH=!FULL_PATH:~0,-1!"    
    :: Extract the last directory name (which is the name of the job application folder)
    for %%g in ("!FULL_PATH!") do set "FOLDER_NAME=%%~nxg"
    
    :: Define the new name for the copied file: FOLDERNAME.txt
    set "NEW_NAME=!FOLDER_NAME!.txt"    
    ::call :LOG_EXEC [FOUND] job_description in folder: !FOLDER_NAME!
	:label_j2
    
    COPY %%f "%DEST_DESC_DIR%\job.txt" >nul
    
    :: Rename the copied file to the folder's name
    if exist "%DEST_DESC_DIR%\job.txt" (
        rename "%DEST_DESC_DIR%\job.txt" "!NEW_NAME!"
        call :LOG_EXEC [COPIED] !NEW_NAME!
	) else (
		call :LOG_EXEC [WARNING] Failed to copy %%~nxf
		set /a COUNTER_WARNING+=1
	)
		
	:: pause under, or timeout if unwanted
	timeout /T 1 /nobreak >nul
	set /a COUNTER_FILES+=1
)

:: --- 3. Search and Copy CV/Resume Files (Exact Filenames) ---
call :LOG_EXEC .
:applications
call :LOG_EXEC [PROGRESS] Searching applications . . .

:: Loop through the exact filenames to be copied
for %%a in (Lebenslauf.pdf Curriculum.pdf) do (

    :: Search and copy the specific file (e.g., Lebenslauf.pdf)
    for /R %%f in (%%a) do (
	
		if exist %%f (
        
			:: extract the parent folder's name (e.g., yyyy-mm-dd_anyjob_anyfirma)
			set "FULL_PATH=%%~dpf"
			set "FULL_PATH=!FULL_PATH:~0,-1!"
			for %%g in ("!FULL_PATH!") do set "FOLDER_NAME=%%~nxg"
			
			:: Define the new name for the copied file: FOLDERNAME.pdf
			set "NEW_NAME=!FOLDER_NAME!.pdf"
			::call :LOG_EXEC [FOUND] application in folder: !FOLDER_NAME!
			:label_a2
		
			COPY %%f "%DEST_CV_DIR%\application.pdf" >nul
			:: Rename the copied file to the folder's name
			if exist "%DEST_CV_DIR%\application.pdf" (
				rename "%DEST_CV_DIR%\application.pdf" "!NEW_NAME!"
				call :LOG_EXEC [COPIED] !NEW_NAME!
			) else (
				call :LOG_EXEC [WARNING] Failed to copy %%~nxf
				set /a COUNTER_WARNING+=1
			)
			
			:: pause under, or timeout if unwanted
			timeout /T 1 /nobreak >nul
		)
    )
)

call :LOG_EXEC .
call :LOG_EXEC ==========================================================
call :LOG_EXEC            --- Organization Complete ---
call :LOG_EXEC [FOLDER]  Files copied to: %ROOT_JOBS%
call :LOG_EXEC [SUMMARY] %COUNTER_FILES% job positions were scanned.
call :LOG_EXEC [SUMMARY] %COUNTER_WARNING% warnings found.
call :LOG_EXEC ==========================================================
call :LOG_EXEC .

:end
call :LOG_EXEC [END]
:: Keeps the window open until a key is pressed.
pause

endlocal

:: - - - SUBROUTINES - - -
: label_s1

:: subroutine copy file (source file, dest path, file name, counter warnings)
:PROCESS_FILE
    set "SOURCE_FILE=%1"
    set "DEST_DIR=%2"
    set "TEMP_NAME=%3"
    set "COUNTER_W=%4"
	
	:: extract the infos to create the new file name (e.g., yyyy-mm-dd_anyjob_anyfirma)
    set "FILE_EXT=%~x3" 
    set "FULL_PATH_SUB=%~dp1"    
    set "FULL_PATH_SUB=!FULL_PATH_SUB:~0,-1!"    
    for %%h in ("!FULL_PATH_SUB!") do set "FOLDER_NAME_SUB=%%~nxh"
	
    set "NEW_NAME_SUB=!FOLDER_NAME_SUB!!FILE_EXT!"    
    ::call :LOG_EXEC [FOUND] !TEMP_NAME! in folder: !FOLDER_NAME_SUB!
	:label_c1
    
	:: copy and rename new file at destination
    COPY !SOURCE_FILE! "%DEST_DIR%\!TEMP_NAME!" >nul
    if exist "%DEST_DIR%\!TEMP_NAME!" (
        rename "%DEST_DIR%\!TEMP_NAME!" "!NEW_NAME_SUB!"
        call :LOG_EXEC [COPIED] !NEW_NAME_SUB!
        )
	) else (
		call :LOG_EXEC [WARNING] Failed to copy !TEMP_NAME!
		set /a COUNTER_W+=1
	)
	
	timeout /T 1 /nobreak >nul
    goto :eof


:: subroutine log execution: prints the output at screen and at log file
:LOG_EXEC
    echo %*
    echo %* >> "%LOG_FILE%"
    goto :eof
	