rem ---------------------------------------------------------------------------
rem This file is used to test errorless decoding of all streams by valdec 
rem application.
rem
rem Note that .dts.pes format is not supported now (due to imperfection of 
rem format detection algorithm)...
rem ---------------------------------------------------------------------------

..\..\valib\valdec\release\valdec a.ac3.005.ac3   -i -d > decode.log
..\..\valib\valdec\release\valdec a.ac3.005.pes   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.ac3.005.spdif -i -d >> decode.log

..\..\valib\valdec\release\valdec a.ac3.03f.ac3   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.ac3.03f.pes   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.ac3.03f.spdif -i -d >> decode.log

..\..\valib\valdec\release\valdec a.ac3.mix.ac3   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.ac3.mix.spdif -i -d >> decode.log

..\..\valib\valdec\release\valdec a.dts.03f.dts   -i -d >> decode.log
rem ..\..\valib\valdec\release\valdec a.dts.03f.pes   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.dts.03f.spdif -i -d >> decode.log

..\..\valib\valdec\release\valdec a.mp2.002.mp2   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.mp2.002.pes   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.mp2.002.spdif -i -d >> decode.log

..\..\valib\valdec\release\valdec a.mp2.005.mp2   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.mp2.005.pes   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.mp2.005.spdif -i -d >> decode.log

..\..\valib\valdec\release\valdec a.mp2.mix.mp2   -i -d >> decode.log
..\..\valib\valdec\release\valdec a.mp2.mix.spdif -i -d >> decode.log
