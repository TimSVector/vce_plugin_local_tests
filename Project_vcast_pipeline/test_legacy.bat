del ..\*all_test.log /y

call suite_cbt_legacy.test_cbt_2018.bat     > ..\2018sp5_legacy_test.log 2>&1
call suite_cbt_legacy.test_cbt_2019.bat     > ..\2019_legacy_test.log 2>&1
call suite_cbt_legacy.test_cbt_2019sp6.bat  > ..\2019sp6_legacy_test.log 2>&1
call suite_cbt_legacy.test_cbt_2020sp1.bat  > ..\2020sp1_legacy_test.log 2>&1
call suite_cbt_legacy.test_cbt_2020.bat     > ..\2020sp7_legacy_test.log 2>&1
call suite_cbt_legacy.test_cbt_2023.bat     > ..\2023sp5_legacy_test.log 2>&1
call suite_cbt_legacy.test_cbt_2024.bat     > ..\2024sp6_legacy_test.log 2>&1
call suite_cbt_legacy.test_cbt_2025.bat     > ..\2025sp4_legacy_test.log 2>&1

call npp ..\*all_test.log


