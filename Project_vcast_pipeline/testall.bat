
set VECTORCAST_DIR=c:\vcast\2018sp5
call suite_cbt.test_cbt.bat                 >  ..\2018sp5_all_test.log 2>&1
call suite_cbt.test_migrated_unit_cbt.bat   >> ..\2018sp5_all_test.log 2>&1
call suite_cbt.test_sfp.bat                 >> ..\2018sp5_all_test.log 2>&1
call suite_cbt_legacy.test_cbt_2018.bat     >> ..\2018sp5_all_test.log 2>&1
call suite_scm.test_scm.bat                 >> ..\2018sp5_all_test.log 2>&1


set VECTORCAST_DIR=c:\vcast\2019sp6
call suite_cbt_legacy_test_cbt_2019.bat     >  ..\2019sp6_all_test.log 2>&1

set VECTORCAST_DIR=c:\vcast\2020sp7
call suite_cbt_legacy_test_cbt_2020.bat     >  ..\2020sp7_all_test.log 2>&1

set VECTORCAST_DIR=c:\vcast\2024sp6
call suite_cbt.test_cbt.bat                 >  ..\2024sp6_all_test.log 2>&1
call suite_cbt.test_migrated_unit_cbt.bat   >> ..\2024sp6_all_test.log 2>&1
call suite_cbt.test_sfp.bat                 >> ..\2024sp6_all_test.log 2>&1
call suite_cbt_legacy.test_cbt_2023.bat     >> ..\2024sp6_all_test.log 2>&1
call suite_scm.test_scm.bat                 >> ..\2024sp6_all_test.log 2>&1

set VECTORCAST_DIR=c:\vcast\2025
call suite_cbt.test_cbt.bat                 >  ..\2025_all_test.log 2>&1
call suite_cbt.test_migrated_unit_cbt.bat   >> ..\2025_all_test.log 2>&1
call suite_cbt.test_sfp.bat                 >> ..\2025_all_test.log 2>&1
call suite_cbt_legacy.test_cbt.bat          >> ..\2025_all_test.log 2>&1
call suite_scm.test_scm.bat                 >> ..\2025_all_test.log 2>&1


call npp ..\*all_test.log