@ECHO off
plink -pw nut15748 uatadm@172.19.217.63 -m %cd%\getlogstest.txt
timeout 5 > NUL
echo Move Logs
echo =================================================
pscp -pw nut15748 uatadm@172.19.217.63:/home/uatadm/Desktop/SmartUI2018/Test/GotLogs/log.html %cd%\Logs
pscp -pw nut15748 uatadm@172.19.217.63:/home/uatadm/Desktop/SmartUI2018/Test/GotLogs/report.html %cd%\Logs
pscp -pw nut15748 uatadm@172.19.217.63:/home/uatadm/Desktop/SmartUI2018/Test/GotLogs/output.xml %cd%\Logs
echo =================================================
echo Move Logs success