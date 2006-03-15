rem ---------------------------------------------------------------------------
rem This file is used to test errorless decoding of all streams by valdec 
rem application.
rem
rem Note that .dts.pes format is not supported now (due to imperfection of 
rem format detection algorithm)...
rem ---------------------------------------------------------------------------


..\..\valib\valdec\release\valdec test.mp2       -i -d > decode.log
..\..\valib\valdec\release\valdec test.mp2.pes   -i -d >> decode.log
..\..\valib\valdec\release\valdec test.mp2.spdif -i -d >> decode.log

..\..\valib\valdec\release\valdec test.ac3       -i -d >> decode.log
..\..\valib\valdec\release\valdec test.ac3.pes   -i -d >> decode.log
..\..\valib\valdec\release\valdec test.ac3.spdif -i -d >> decode.log

..\..\valib\valdec\release\valdec test.dts       -i -d >> decode.log
rem ..\..\valib\valdec\release\valdec test.dts.pes   -i -d >> decode.log
..\..\valib\valdec\release\valdec test.dts.spdif -i -d >> decode.log
