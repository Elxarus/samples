@echo off

rem ----- AC3 -----

bsconvert a.ac3.03f.ac3 bs.ac3.8_8.ac3
bsconvert a.ac3.03f.ac3 bs.ac3.8_16.ac3 16le

bsconvert a.ac3.03f.spdif bs.ac3.spdif_8.ac3
bsconvert a.ac3.03f.spdif bs.ac3.spdif_16.ac3 16le

bsconvert bs.ac3.8_16.ac3 bs.ac3.16_8.ac3
bsconvert bs.ac3.8_16.ac3 bs.ac3.16_16.ac3 16le

rem ----- DTS -----

bsconvert a.dts.03f.dts bs.dts.8_8.dts
bsconvert a.dts.03f.dts bs.dts.8_16.dts 16le
bsconvert a.dts.03f.dts bs.dts.8_14le.dts 14le
bsconvert a.dts.03f.dts bs.dts.8_14be.dts 14be

bsconvert a.dts.03f.spdif bs.dts.spdif_8.dts
bsconvert a.dts.03f.spdif bs.dts.spdif_16.dts 16le
bsconvert a.dts.03f.spdif bs.dts.spdif_14le.dts 14le
bsconvert a.dts.03f.spdif bs.dts.spdif_14be.dts 14be

bsconvert bs.dts.8_16.dts bs.dts.16_8.dts
bsconvert bs.dts.8_16.dts bs.dts.16_16.dts 16le
bsconvert bs.dts.8_16.dts bs.dts.16_14le.dts 14le
bsconvert bs.dts.8_16.dts bs.dts.16_14be.dts 14be

bsconvert bs.dts.8_14le.dts bs.dts.14le_8.dts
bsconvert bs.dts.8_14le.dts bs.dts.14le_16.dts 16le
bsconvert bs.dts.8_14le.dts bs.dts.14le_14le.dts 14le
bsconvert bs.dts.8_14le.dts bs.dts.14le_14be.dts 14be

bsconvert bs.dts.8_14be.dts bs.dts.14be_8.dts
bsconvert bs.dts.8_14be.dts bs.dts.14be_16.dts 16le
bsconvert bs.dts.8_14be.dts bs.dts.14be_14le.dts 14le
bsconvert bs.dts.8_14be.dts bs.dts.14be_14be.dts 14be

rem ----- Mix -----

bsconvert a.mad.mix.mad bs.mad.8_8.mad
bsconvert a.mad.mix.mad bs.mad.8_16.mad 16le

bsconvert a.mad.mix.spdif bs.mad.spdif_8.mad
bsconvert a.mad.mix.spdif bs.mad.spdif_16.mad 16le

bsconvert bs.mad.8_16.mad bs.mad.16_8.mad
bsconvert bs.mad.8_16.mad bs.mad.16_16.mad 16le

rem ----- AC3 check -----

diff --binary a.ac3.03f.ac3 bs.ac3.8_8.ac3 > nul
if %errorlevel% == 1 echo AC3: byte to byte conversion fails

diff --binary a.ac3.03f.ac3 bs.ac3.spdif_8.ac3 > nul
if %errorlevel% == 1 echo AC3: SPDIF to byte conversion fails

diff --binary a.ac3.03f.ac3 bs.ac3.16_8.ac3 > nul
if %errorlevel% == 1 echo AC3: 16LE to byte conversion fails


diff --binary bs.ac3.8_16.ac3 bs.ac3.16_16.ac3 > nul
if %errorlevel% == 1 echo AC3: 16LE to 16LE conversion fails

diff --binary bs.ac3.8_16.ac3 bs.ac3.spdif_16.ac3 > nul
if %errorlevel% == 1 echo AC3: SPDIF to 16LE conversion fails

rem ----- DTS check -----

diff --binary a.dts.03f.dts bs.dts.8_8.dts > nul
if %errorlevel% == 1 echo DTS: byte to byte conversion fails

diff --binary a.dts.03f.dts bs.dts.SPDIF_8.dts > nul
if %errorlevel% == 1 echo DTS: SPDIF to byte conversion fails

diff --binary a.dts.03f.dts bs.dts.16_8.dts > nul
if %errorlevel% == 1 echo DTS: 16LE to byte conversion fails

diff --binary a.dts.03f.dts bs.dts.14le_8.dts > nul
if %errorlevel% == 1 echo DTS: 14LE to byte conversion fails

diff --binary a.dts.03f.dts bs.dts.14be_8.dts > nul
if %errorlevel% == 1 echo DTS: 14BE to byte conversion fails


diff --binary bs.dts.8_16.dts bs.dts.SPDIF_16.dts > nul
if %errorlevel% == 1 echo DTS: SPDIF to 16LE conversion fails

diff --binary bs.dts.8_16.dts bs.dts.16_16.dts > nul
if %errorlevel% == 1 echo DTS: 16LE to 16LE conversion fails

diff --binary bs.dts.8_16.dts bs.dts.14le_16.dts > nul
if %errorlevel% == 1 echo DTS: 14LE to 16LE conversion fails

diff --binary bs.dts.8_16.dts bs.dts.14be_16.dts > nul
if %errorlevel% == 1 echo DTS: 14BE to 16LE conversion fails


diff --binary bs.dts.8_14le.dts bs.dts.SPDIF_14le.dts > nul
if %errorlevel% == 1 echo DTS: SPDIF to 14LE conversion fails

diff --binary bs.dts.8_14le.dts bs.dts.16_14le.dts > nul
if %errorlevel% == 1 echo DTS: 16LE to 14LE conversion fails

diff --binary bs.dts.8_14le.dts bs.dts.14le_14le.dts > nul
if %errorlevel% == 1 echo DTS: 14LE to 14LE conversion fails

diff --binary bs.dts.8_14le.dts bs.dts.14be_14le.dts > nul
if %errorlevel% == 1 echo DTS: 14BE to 14LE conversion fails


diff --binary bs.dts.8_14be.dts bs.dts.SPDIF_14be.dts > nul
if %errorlevel% == 1 echo DTS: SPDIF to 14BE conversion fails

diff --binary bs.dts.8_14be.dts bs.dts.16_14be.dts > nul
if %errorlevel% == 1 echo DTS: 16LE to 14BE conversion fails

diff --binary bs.dts.8_14be.dts bs.dts.14le_14be.dts > nul
if %errorlevel% == 1 echo DTS: 14LE to 14BE conversion fails

diff --binary bs.dts.8_14be.dts bs.dts.14be_14be.dts > nul
if %errorlevel% == 1 echo DTS: 14BE to 14BE conversion fails

rem ----- Mix check -----

diff --binary a.mad.mix.mad bs.mad.8_8.mad > nul
if %errorlevel% == 1 echo Mix: byte to byte conversion fails

diff --binary a.mad.mix.mad bs.mad.spdif_8.mad > nul
if %errorlevel% == 1 echo Mix: SPDIF to byte conversion fails

diff --binary a.mad.mix.mad bs.mad.16_8.mad > nul
if %errorlevel% == 1 echo Mix: 16LE to byte conversion fails


diff --binary bs.mad.8_16.mad bs.mad.16_16.mad > nul
if %errorlevel% == 1 echo Mix: 16LE to 16LE conversion fails

diff --binary bs.mad.8_16.mad bs.mad.spdif_16.mad > nul
if %errorlevel% == 1 echo Mix: SPDIF to 16LE conversion fails

rem ----- Delete files -----

del bs.* /q > nul
