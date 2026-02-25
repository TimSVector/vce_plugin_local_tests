setlocal

set VECTORCAST_DIR=c:\vcast\2018sp5
set PATH=%VECTORCAST_DIR%;%PATH%
call suite_cbt.test_cbt.bat                 >  ..\2018sp5_all_test.log 2>&1
call suite_cbt.test_migrated_unit_cbt.bat   >> ..\2018sp5_all_test.log 2>&1
call suite_cbt.test_sfp.bat                 >> ..\2018sp5_all_test.log 2>&1
call suite_cbt_legacy.test_cbt_2018.bat     >> ..\2018sp5_all_test.log 2>&1
call suite_scm.test_scm.bat                 >> ..\2018sp5_all_test.log 2>&1

set VECTORCAST_DIR=c:\vcast\2019sp6
set PATH=%VECTORCAST_DIR%;%PATH%
call suite_cbt.test_cbt.bat                 >  ..\2019sp6_all_test.log 2>&1
call suite_cbt.test_migrated_unit_cbt.bat   >> ..\2019sp6_all_test.log 2>&1
call suite_cbt.test_sfp.bat                 >> ..\2019sp6_all_test.log 2>&1
call suite_cbt_legacy_test_cbt_2019sp6.bat  >> ..\2019sp6_all_test.log 2>&1
call suite_scm.test_scm.bat                 >> ..\2019sp6_all_test.log 2>&1
del ..\*.log

set VECTORCAST_DIR=c:\vcast\2020sp7
set PATH=%VECTORCAST_DIR%;%PATH%
call suite_cbt.test_cbt.bat                 >  ..\2020sp7_all_test.log 2>&1
call suite_cbt.test_migrated_unit_cbt.bat   >> ..\2020sp7_all_test.log 2>&1
call suite_cbt.test_sfp.bat                 >> ..\2020sp7_all_test.log 2>&1
call suite_cbt_legacy_test_cbt_2020.bat     >> ..\2020sp7_all_test.log 2>&1
call suite_scm.test_scm.bat                 >> ..\2020sp7_all_test.log 2>&1

set VECTORCAST_DIR=c:\vcast\2023sp5
set PATH=%VECTORCAST_DIR%;%PATH%
call suite_cbt.test_cbt.bat                 >  ..\2023sp5_all_test.log 2>&1
call suite_cbt.test_migrated_unit_cbt.bat   >> ..\2023sp5_all_test.log 2>&1
call suite_cbt.test_sfp.bat                 >> ..\2023sp5_all_test.log 2>&1
call suite_cbt_legacy.test_cbt_2023.bat     >> ..\2023sp5_all_test.log 2>&1
call suite_scm.test_scm.bat                 >> ..\2023sp5_all_test.log 2>&1

set VECTORCAST_DIR=c:\vcast\2024sp6
set PATH=%VECTORCAST_DIR%;%PATH%
call suite_cbt.test_cbt.bat                 >  ..\2024sp6_all_test.log 2>&1
call suite_cbt.test_migrated_unit_cbt.bat   >> ..\2024sp6_all_test.log 2>&1
call suite_cbt.test_sfp.bat                 >> ..\2024sp6_all_test.log 2>&1
call suite_cbt_legacy.test_cbt_2024.bat     >> ..\2024sp6_all_test.log 2>&1
call suite_scm.test_scm.bat                 >> ..\2024sp6_all_test.log 2>&1

set VECTORCAST_DIR=c:\vcast\2025sp4
set PATH=%VECTORCAST_DIR%;%PATH%
call suite_cbt.test_cbt.bat                 >  ..\2025sp4_all_test.log 2>&1
call suite_cbt.test_migrated_unit_cbt.bat   >> ..\2025sp4_all_test.log 2>&1
call suite_cbt.test_sfp.bat                 >> ..\2025sp4_all_test.log 2>&1
call suite_cbt_legacy.test_cbt.bat          >> ..\2025sp4_all_test.log 2>&1
call suite_scm.test_scm.bat                 >> ..\2025sp4_all_test.log 2>&1
call suite_cbt_legacy.test_cbt_2025.bat     >> ..\2025sp4_all_test.log 2>&1

call npp ..\*all_test.log

endlocal