if "%VCAST_DIRECTORY%"=="2020sp1" (
    copy /Y ENV_COVER_system_tests_2020sp1.py Project\python\ENV_COVER_system_tests.py

) else if "%VCAST_DIRECTORY%"=="2018sp5" (
    copy /Y system_tests.py Project\python\system_tests.py

) else if "%VCAST_DIRECTORY%"=="2019" (
    copy /Y system_tests_2019.py Project\python\ENV_COVER_system_tests.py

) else if "%VCAST_DIRECTORY%"=="2019sp6" (
    copy /Y system_tests_2019.py Project\python\ENV_COVER_system_tests.py

) else (
    copy /Y ENV_COVER_system_tests.py Project\python\ENV_COVER_system_tests.py
)
