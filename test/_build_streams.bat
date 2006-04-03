@echo off

rem ---------------------------------------------------------------------------
rem This script generates streams required to build test.vob from test.vob.
rem It is nessesary when we want to rebuild test.vob file...
rem Following files are required to build:
rem   mpeg_demux.exe - MPEG demuxer
rem   test.vob       - vob file to demux
rem   test.wavhdr    - wave header for pcm stream
rem ---------------------------------------------------------------------------

echo ------------------------------------------------------
echo Checking for required files

if not exist "mpeg_demux.exe" goto not_exist
if not exist "test.vob" goto not_exist
if not exist "test.wavhdr" goto not_exist

mpeg_demux test.vob -d a.mp2.005.mp2 -s:c0
mpeg_demux test.vob -d a.mp2.002.mp2 -s:c1
mpeg_demux test.vob -d a.ac3.03f.ac3 -ss:82
mpeg_demux test.vob -d a.ac3.005.ac3 -ss:83
mpeg_demux test.vob -d a.dts.03f.dts -ss:8c
mpeg_demux test.vob -d a.pcm.005.lpcm.tmp -ss:a5

copy /b test.wavhdr + a.pcm.005.lpcm.tmp a.pcm.005.wav
del a.pcm.005.lpcm.tmp
goto end

:not_exist

echo Some required file(s) missing!!!
echo Required files:
echo   mpeg_demux.exe - MPEG demuxer
echo   test.vob       - vob file to demux
echo   test.wavhdr    - wave header for pcm stream

goto end

:end
