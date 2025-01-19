@echo off

REM Check if a parameter is provided for the project name
if "%~1"=="" (
    REM Prompt the user for the project name
    set /p PROJECT_NAME="Enter the project name: "
) else (
    set PROJECT_NAME=%~1
)

REM Prompt the user for the project location
set /p PROJECT_LOCATION="Enter the project location (full path): "

REM Path to the template folder
set TEMPLATE_FOLDER=%~dp0HardwareFolderStructure

echo Creating project folder structure for: %PROJECT_NAME% at %PROJECT_LOCATION%

REM Create the project folder and subfolders
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\src\HardwareDesign"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\src\PDF"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\src\Libraries"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\src\Software"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\docs\Datasheets"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\docs"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\docs\Manuals"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\docs\Reports"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\images"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\tests"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\tests\UnitTests"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\tests\IntegrationTests"
call :CreateDir "%PROJECT_LOCATION%\%PROJECT_NAME%\misc"

echo Creating files in %PROJECT_LOCATION%\%PROJECT_NAME%\src\HardwareDesign

REM Create eagle.epf file in src\HardwareDesign with specified content
(
    echo [Eagle]
    echo Version="09 02 01"
) > "%PROJECT_LOCATION%\%PROJECT_NAME%\src\HardwareDesign\eagle.epf"
echo Created eagle.epf with content

REM Create %PROJECT_NAME%.sch file in src\HardwareDesign with specified content
(
    echo ^<?xml version="1.0" encoding="utf-8"?^>
    echo ^<!DOCTYPE eagle SYSTEM "eagle.dtd"^>
    echo ^<eagle version="9.2.1"^>
    echo ^<drawing^>
    echo ^<settings^>
    echo ^<setting alwaysvectorfont="no"/^>
    echo ^<setting verticaltext="up"/^>
    echo ^</settings^>
    echo ^<grid distance="0.1" unitdist="inch" unit="inch" style="lines" multiple="1" display="no" altdistance="0.01" altunitdist="inch" altunit="inch"/^>
    echo ^<layers^>
    echo ^<layer number="88" name="SimResults" color="9" fill="1" visible="yes" active="yes"/^>
    echo ^<layer number="89" name="SimProbes" color="9" fill="1" visible="yes" active="yes"/^>
    echo ^<layer number="90" name="Modules" color="5" fill="1" visible="yes" active="yes"/^>
    echo ^<layer number="91" name="Nets" color="2" fill="1" visible="yes" active="yes"/^>
    echo ^<layer number="92" name="Busses" color="1" fill="1" visible="yes" active="yes"/^>
    echo ^<layer number="93" name="Pins" color="2" fill="1" visible="no" active="yes"/^>
    echo ^<layer number="94" name="Symbols" color="4" fill="1" visible="yes" active="yes"/^>
    echo ^<layer number="95" name="Names" color="7" fill="1" visible="yes" active="yes"/^>
    echo ^<layer number="96" name="Values" color="7" fill="1" visible="yes" active="yes"/^>
    echo ^<layer number="97" name="Info" color="7" fill="1" visible="yes" active="yes"/^>
    echo ^<layer number="98" name="Guide" color="6" fill="1" visible="yes" active="yes"/^>
    echo ^</layers^>
    echo ^<schematic xreflabel="%%F%%N/%%S.%%C%%R" xrefpart="/%%S.%%C%%R"^>
    echo ^<libraries^>
    echo ^</libraries^>
    echo ^<attributes^>
    echo ^</attributes^>
    echo ^<variantdefs^>
    echo ^</variantdefs^>
    echo ^<classes^>
    echo ^<class number="0" name="default" width="0" drill="0"^>
    echo ^</class^>
    echo ^</classes^>
    echo ^<parts^>
    echo ^</parts^>
    echo ^<sheets^>
    echo ^<sheet^>
    echo ^<plain^>
    echo ^</plain^>
    echo ^<instances^>
    echo ^</instances^>
    echo ^<busses^>
    echo ^</busses^>
    echo ^<nets^>
    echo ^</nets^>
    echo ^</sheet^>
    echo ^</sheets^>
    echo ^</schematic^>
    echo ^</drawing^>
    echo ^</eagle^>
) > "%PROJECT_LOCATION%\%PROJECT_NAME%\src\HardwareDesign\%PROJECT_NAME%.sch"
echo Created %PROJECT_NAME%.sch with content

echo Copying and updating Readme.md files

REM Copy and update Readme.md files
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%" "%PROJECT_LOCATION%\%PROJECT_NAME%"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\src" "%PROJECT_LOCATION%\%PROJECT_NAME%\src"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\src\HardwareDesign" "%PROJECT_LOCATION%\%PROJECT_NAME%\src\HardwareDesign"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\src\PDF" "%PROJECT_LOCATION%\%PROJECT_NAME%\src\PDF"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\src\Libraries" "%PROJECT_LOCATION%\%PROJECT_NAME%\src\Libraries"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\src\Software" "%PROJECT_LOCATION%\%PROJECT_NAME%\src\Software"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\docs\Datasheets" "%PROJECT_LOCATION%\%PROJECT_NAME%\docs\Datasheets"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\docs" "%PROJECT_LOCATION%\%PROJECT_NAME%\docs"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\docs\Manuals" "%PROJECT_LOCATION%\%PROJECT_NAME%\docs\Manuals"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\docs\Reports" "%PROJECT_LOCATION%\%PROJECT_NAME%\docs\Reports"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\images" "%PROJECT_LOCATION%\%PROJECT_NAME%\images"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\tests" "%PROJECT_LOCATION%\%PROJECT_NAME%\tests"
call :CopyAndReplaceReadme "%TEMPLATE_FOLDER%\tests\UnitTests" "%PROJECT_LOCATION%\%PROJECT_NAME%\tests\UnitTests"

echo Folder structure and Readme.md files created for project: %PROJECT_NAME%
pause
goto :eof

REM Function to create a directory if it doesn't exist
:CreateDir
if not exist "%~1" (
    echo Creating directory: %~1
    mkdir "%~1"
) else (
    echo Directory already exists: %~1
)
goto :eof

REM Function to copy and replace %PROJECT_NAME% in Readme.md files
:CopyAndReplaceReadme
if exist "%~1\Readme.md" (
    echo Copying and updating Readme.md from %~1 to %~2
    copy "%~1\Readme.md" "%~2\Readme.md"
    call :ReplaceInFile "%~2\Readme.md" "%%PROJECT_NAME%%" "%PROJECT_NAME%"
) else (
    echo Readme.md not found in %~1
)
goto :eof

REM Function to replace a string in a file
:ReplaceInFile
setlocal enabledelayedexpansion
set "search=%~2"
set "replace=%~3"
(for /f "delims=" %%i in ('type "%~1"') do (
    set "line=%%i"
    set "line=!line:%search%=%replace%!"
    echo(!line!
)) > "%~1.tmp"
move /y "%~1.tmp" "%~1" > nul
endlocal
goto :eof