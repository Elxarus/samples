@echo off
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
