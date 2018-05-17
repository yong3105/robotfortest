@echo off
call copycsv.bat
timeout 5 > NUL
echo %time%
echo =================================================
call configfile_test.bat
timeout 5 > NUL
echo %time%
echo =================================================
echo %time%
call runjenkins_test.bat
timeout 5400 > NUL
echo %time%
call getlog_test.bat
echo ====================FINISH=======================
pause