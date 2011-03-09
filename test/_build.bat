@echo off

rem ---------------------------------------------------------------------------
rem This script generates files required for test application by decomposing
rem test.vob file. 
rem 
rem test.vob file contains all audio streams possible for mpeg (AC3, MPA, DTS, 
rem LPCM). Therefore it is very useful to test players. Also it allows not to
rem store all this raw streams to CVS because this streams may be extracted by 
rem this script.
rem
rem This script generates streams of 3 formats: 
rem * raw stream
rem * Program Elementary Stream (PES stream)
rem * SPDIF stream (raw stream is incapsulated according to IEC 61937)
rem
rem Files are names as:
rem
rem   a.[format].[config].[file]
rem
rem where:
rem
rem   format - main stream format:
rem     mp2  - MPEG Audio
rem     ac3  - Dolby Digital
rem     dts  - DTS
rem     pcm  - PCM
rem     mad  - mixed stream - Mpa/Ac3/Dts (Mixed Audio Data :)
rem     madp - mixed stream - Mpa/Ac3/Dts/Pcm
rem
rem   config - channel configuration (same as mask field at Speakers class):
rem     002  - mono
rem     005  - stereo
rem     03f  - 5.1
rem     mix  - mixed stream
rem
rem   file - file format:
rem     same as format - raw stream
rem     lpcm           - linear PCM (big endian)
rem     spdif          - spdif wrapped stream
rem     pes            - pes wrapped stream
rem
rem ---------------------------------------------------------------------------

mpeg_demux test.vob

echo ------------------------------------------------------
echo Building elementary streams

mpeg_demux test.vob -d a.mp2.005.mp2  -s:c0
mpeg_demux test.vob -d a.mp2.002.mp2  -s:c1

mpeg_demux test.vob -d a.ac3.03f.ac3  -ss:82
rem substream 83 is the same as substream 82
mpeg_demux test.vob -d a.ac3.005.ac3  -ss:84

mpeg_demux test.vob -d a.dts.03f.dts  -ss:8d
mpeg_demux test.vob -d a.pcm.005.lpcm -ss:a6
swab a.pcm.005.lpcm a.pcm.005.pcm

echo ------------------------------------------------------
echo Building PES streams

mpeg_demux test.vob -p a.mp2.005.pes -s:c0
mpeg_demux test.vob -p a.mp2.002.pes -s:c1

mpeg_demux test.vob -p a.ac3.03f.pes -ss:82
rem substream 83 is the same as substream 82
mpeg_demux test.vob -p a.ac3.005.pes -ss:84

mpeg_demux test.vob -p a.dts.03f.pes -ss:8d
mpeg_demux test.vob -p a.pcm.005.pes -ss:a6

echo ------------------------------------------------------
echo Building SPDIF streams

spdifer a.mp2.005.mp2 a.mp2.005.spdif
spdifer a.mp2.002.mp2 a.mp2.002.spdif
                             
spdifer a.ac3.03f.ac3 a.ac3.03f.spdif
spdifer a.ac3.005.ac3 a.ac3.005.spdif
                             
spdifer a.dts.03f.dts a.dts.03f.spdif
spdifer a.dts.03f.dts a.dts.03f.spdifdts -dts_mode_padded

echo ------------------------------------------------------
echo Building streams to test DTS conversions

bsconvert a.dts.03f.dts a.dts.03f.dts14 14be

echo ------------------------------------------------------
echo Building streams to test transitions between the same
echo format but with different number of channels.
echo.
echo Note that ac3 contains special transition with the
echo same number of channels to test PES demuxer to switch
echo between tracks of the same formats.
echo.
echo mpa: stereo - mono - stereo
echo ac3: 5.1 - 5.1 - stereo - 5.1
echo dts: 8bit - 14bit - 8bit

echo -- RAW --
copy /b a.mp2.005.mp2 + a.mp2.002.mp2 + a.mp2.005.mp2 a.mp2.mix.mp2
copy /b a.ac3.03f.ac3 + a.ac3.03f.ac3 + a.ac3.005.ac3 + a.ac3.03f.ac3 a.ac3.mix.ac3
copy /b a.dts.03f.dts + a.dts.03f.dts14 + a.dts.03f.dts a.dts.03f.mix

echo -- SPDIF --
copy /b a.mp2.005.spdif + a.mp2.002.spdif + a.mp2.005.spdif a.mp2.mix.spdif
copy /b a.ac3.03f.spdif + a.ac3.03f.spdif + a.ac3.005.spdif + a.ac3.03f.spdif a.ac3.mix.spdif

echo -- PES --
mpeg_demux test.vob -p a.ac3.03f.pes2 -ss:83
copy /b a.mp2.005.pes + a.mp2.002.pes + a.mp2.005.pes a.mp2.mix.pes
copy /b a.ac3.03f.pes + a.ac3.03f.pes2 + a.ac3.005.pes + a.ac3.03f.pes a.ac3.mix.pes
del a.ac3.03f.pes2

echo ------------------------------------------------------
echo Building streams to test transitions between different
echo formats without PCM (ac3, dts, mpa)
echo.
echo ac3-dts-mp2-ac3-mp2-dts-ac3

echo -- RAW --
copy /b a.ac3.03f.ac3 + a.dts.03f.dts + a.mp2.005.mp2 + a.ac3.03f.ac3 + a.mp2.005.mp2 + a.dts.03f.dts + a.ac3.03f.ac3 a.mad.mix.mad

echo -- SPDIF --
copy /b a.ac3.03f.spdif + a.dts.03f.spdif + a.mp2.005.spdif + a.ac3.03f.spdif + a.mp2.005.spdif + a.dts.03f.spdif + a.ac3.03f.spdif a.mad.mix.spdif

echo -- PES --
copy /b a.ac3.03f.pes + a.dts.03f.pes + a.mp2.005.pes + a.ac3.03f.pes + a.mp2.005.pes + a.dts.03f.pes + a.ac3.03f.pes a.mad.mix.pes

echo ------------------------------------------------------
echo Building streams to test transitions between different
echo formats including PCM (ac3, dts, mpa, lpcm)
echo.
echo ac3-pcm-ac3-dts-mp2-dts-pcm-mp2-ac3-mp2-pcm-dts-ac3
echo.
echo Note that pes and raw files contains LPCM, but SPDIF
echo file uses PCM (correct file for SPDIF playback)

echo -- RAW --
copy /b a.ac3.03f.ac3 + a.pcm.005.lpcm + a.ac3.03f.ac3 + a.dts.03f.dts + a.mp2.005.mp2 + a.dts.03f.dts + a.pcm.005.lpcm + a.mp2.005.mp2 + a.ac3.03f.ac3 + a.mp2.005.mp2 + a.pcm.005.lpcm + a.dts.03f.dts + a.ac3.03f.ac3 a.madp.mix.madp

echo -- SPDIF --
copy /b a.ac3.03f.spdif + a.pcm.005.pcm + a.ac3.03f.spdif + a.dts.03f.spdif + a.mp2.005.spdif + a.dts.03f.spdif + a.pcm.005.pcm + a.mp2.005.spdif + a.ac3.03f.spdif + a.mp2.005.spdif + a.pcm.005.pcm + a.dts.03f.spdif + a.ac3.03f.spdif a.madp.mix.spdif

echo -- PES --
copy /b a.ac3.03f.pes + a.pcm.005.pes + a.ac3.03f.pes + a.dts.03f.pes + a.mp2.005.pes + a.dts.03f.pes + a.pcm.005.pes + a.mp2.005.pes + a.ac3.03f.pes + a.mp2.005.pes + a.pcm.005.pes + a.dts.03f.pes + a.ac3.03f.pes a.madp.mix.pes

echo ------------------------------------------------------
echo Building AAC test streams

faac test.pcm16.03f.wav -b 420 -o a.aac.03f.adts

echo ------------------------------------------------------
echo Decoded streams

faad a.aac.03f.adts -b 4 -o a.aac.03f.adts.wav
valdec a.ac3.03f.ac3 -fmt:6 -w a.ac3.03f.ac3.wav
valdec a.dts.03f.dts -fmt:6 -w a.dts.03f.dts.wav
valdec a.mp2.005.mp2 -fmt:6 -w a.mp2.005.mp2.wav
