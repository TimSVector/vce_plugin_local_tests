del ..\*all_test.log /y

call suite_cbt_legacy.test_cbt_2018.bat     > ..\2018_all_test.log 2>&1
call suite_cbt_legacy.test_cbt_2019.bat     > ..\2019_all_test.log 2>&1
call suite_cbt_legacy.test_cbt_2020.bat     > ..\2020_all_test.log 2>&1
call suite_cbt_legacy.test_cbt_2023.bat     > ..\2023_all_test.log 2>&1

call npp ..\*all_test.log


