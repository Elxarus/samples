@echo off

rem ---------------------------------------------------------------------------
rem This script generates files required for test application by decomposing
rem test.vob file. 
rem 
rem test.vob file contains all possible for mpeg audio streams (AC3, MPA, DTS, 
rem LPCM). Therefore it is very useful to test players. Also it allows not to
rem store all this raw streams to CVS because this streams may be extracted by 
rem this script.
rem
rem This script generates streams of 3 formats: 
rem * raw stream
rem * Program Elementary Stream (PES stream)
rem * SPDIF stream (raw stream is incapsulated according to IEC 61937)
rem
rem All files using following extensions:
rem * .ac3 .mp2 .dts .lpcm - raw steams of named format
rem * .pes - added after raw stream extension to indicate that pes steam 
rem   contains raw steam of named format
rem * .spdif - added after raw stream extension to indicate that raw stream
rem   is incapsulated according to IEC 61937.
rem * other extensions may be used to indicate mixed-streams
rem
rem Also this script generates several kinds of mixed streams:
rem
rem * test.all       Contains ac3, mpa and dts streams with all possible 
rem                  transitions between formats. This file is used to test 
rem                  syncronization functions in valib library.
rem
rem * test.all.spdif Contains SPDIF-wraped test.all file.
rem 
rem * test.all2.pes  Contains PES streams with ac3, mpa, dts and lpcm streams
rem                  with all possible transitions between formats.
rem
rem * test.all2      Contains demuxed raw streams from test.all2.pes file.
rem
rem ---------------------------------------------------------------------------

mpeg_demux test.vob

echo Building elementary streams
mpeg_demux test.vob -d test.ac3 -ss:80
mpeg_demux test.vob -d test.dts -ss:89
mpeg_demux test.vob -d test.mp2 -s:c2
mpeg_demux test.vob -d test.lpcm -ss:a3

echo Building PES streams
mpeg_demux test.vob -p test.ac3.pes -ss:80
mpeg_demux test.vob -p test.dts.pes -ss:89
mpeg_demux test.vob -p test.mp2.pes -s:c2
mpeg_demux test.vob -p test.lpcm.pes -ss:a3

echo Building SPDIF streams
spdifer test.ac3 test.ac3.spdif
spdifer test.dts test.dts.spdif
spdifer test.mp2 test.mp2.spdif

echo Building stream transitions (ac3, dts, mpa)
copy /b test.ac3+test.dts+test.mp2+test.ac3+test.mp2+test.dts+test.ac3 test.all

echo building SPDIF transitions (ac3, dts, mpa)
copy /b test.ac3.spdif+test.dts.spdif+test.mp2.spdif+test.ac3.spdif+test.mp2.spdif+test.dts.spdif+test.ac3.spdif test.all.spdif

echo building PES transitions (ac3, dts, mpa, lpcm)
copy /b test.ac3.pes+test.lpcm.pes+test.ac3.pes+test.dts.pes+test.mp2.pes+test.dts.pes+test.lpcm.pes+test.mp2.pes+test.ac3.pes+test.mp2.pes+test.lpcm.pes+test.dts.pes+test.ac3.pes test.all2.pes

echo Building PES transitions output (ac3, dts, mpa, lpcm)
copy /b test.ac3+test.lpcm+test.ac3+test.dts+test.mp2+test.dts+test.lpcm+test.mp2+test.ac3+test.mp2+test.lpcm+test.dts+test.ac3 test.all2
