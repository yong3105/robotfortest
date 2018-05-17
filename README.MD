Step
1. เอาไฟล์ CSV ที่ต้องใช้มาวางที่โฟลเดอร์นี้ก่อน
2. [runjenkins_test.bat] Copy CSV จากไฟล์นี้ไปวางบนเซิฟเวอร์
3. [configfile_test.bat] Move CSV ไปยังโฟลเดอร์ของ jenkins โดยใช้ shell ชื่อ movefile.sh เเล้วเปลี่ยนสิทธิ์ user ให้เป็น jenkins
4. [runjenkins_test.bat] Start jenkins โดยเข้าไปที่เครื่องเซิฟเวอร์เเล้วสั่งรัน jenkins โดยใช้ shell ชื่อ Runjenkinstest.sh 
5. [getlog_test.bat] ไปก็อปปี้ log ออกมาจากโฟลเดอร์ jenkins มาใส่ในโฟลเดอร์ตัวเอง เเล้วก็อปจากเซิฟเวอร์มาลงที่เครื่องเรา