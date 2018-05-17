@ECHO off
:: run remote command
plink -pw nut15748 uatadm@172.19.217.63 -m %cd%\movefiletest.txt
ECHO Remote command finished...
