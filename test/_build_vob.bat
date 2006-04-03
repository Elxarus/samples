@echo off

rem ---------------------------------------------------------------------------
rem This script generates test.vob file from raw streams
rem Following files are required to build:
rem   MuxMan.exe    - vob muxer application
rem   test.mxp      - muxman script
rem   test.bmp      - static picture used as video
rem   a.mp2.005.mp2 - mono MPA audio stream
rem   a.mp2.002.mp2 - stereo MPA audio stream
rem   a.ac3.03f.ac3 - 5.1 AC3 audio stream
rem   a.ac3.005.ac3 - stereo AC3 audio stream
rem   a.dts.03f.dts - 5.1 DTS audio stream
rem   a.pcm.005.wav - stereo 16 bit PCM audio stream
rem ---------------------------------------------------------------------------


echo ------------------------------------------------------
echo Checking for required files

if not exist "MuxMan.exe" goto not_exist
if not exist "test.mxp" goto not_exist
if not exist "test.bmp" goto not_exist
if not exist "a.mp2.005.mp2" goto not_exist
if not exist "a.mp2.002.mp2" goto not_exist
if not exist "a.ac3.03f.ac3" goto not_exist
if not exist "a.ac3.005.ac3" goto not_exist
if not exist "a.dts.03f.dts" goto not_exist
if not exist "a.pcm.005.wav" goto not_exist

del test.vob 2> nul
rmdir /s /q vob 2> nul
MuxMan.exe test.mxp -run
move vob\VTS_01_1.VOB test.vob
rmdir /s /q vob 2> nul

if not exist "test.vob" goto build_failed

echo Everything is OK!
goto end


:build_failed

echo Building VOB file failed!
goto end


:not_exist

echo Some required file(s) missing!!!
echo Required files:
echo   MuxMan.exe    - vob muxer application         
echo   test.mxp      - muxman script                 
echo   test.bmp      - static picture used as video  
echo   a.mp2.005.mp2 - mono MPA audio stream         
echo   a.mp2.002.mp2 - stereo MPA audio stream       
echo   a.ac3.03f.ac3 - 5.1 AC3 audio stream          
echo   a.ac3.005.ac3 - stereo AC3 audio stream       
echo   a.dts.03f.dts - 5.1 DTS audio stream          
echo   a.pcm.005.wav - stereo 16 bit PCM audio stream

goto end

:end
