rem Batch file to make .love file automatically
rem ---
rem Output file name can be sent as %1 command-line argument,
rem default output file is bin/game.love
rem ---
rem Requires 7-zip installed and on PATH


echo off
title Make Love File
setlocal

set file_name=%1
if "%1"=="" (set file_name=bin/game.love)

rem Gather required files
set assets=assets/
set scripts=scripts/
set conf_file=conf.lua
set main_file=main.lua

set files_to_zip=%scripts% %assets% %conf_file% %main_file%

rem Zip required files into game.zip
call 7z a -tzip %file_name% %files_to_zip%

echo Created %file_name% with %files_to_zip%
