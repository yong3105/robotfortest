# เอาไฟล์ csv เข้าใช้ Library CSVLibrary+Collections
#ในกรณีที่ไฟล์ csv มีภาษาไทย Lib default จะอ่านไม่จะอ่านไม่ออก
#ให้ไปที่ Folder Lib ของ CSVLibrary แก้ไฟล์ชื่อ _init_.py เพิ่ม import unicodecsv	as  csv ไว้ที่ด้านบนไฟล์
#หากยังไม่มี lib unicodecsv ให้ pip install unicodecsv
*** Settings ***
Library		Selenium2Library
Library		Collections
Library   CSVLibrary
Library 	String
Library		Enterkey.py
Library  	Sendkeysdown.py
Test Setup	OPEN true1
Test teardown    Run Keyword If Test Failed    Run Keyword And Continue On Failure    selectanotherday
*** Keywords ***
OPEN true1
	Open Browser	http://test-web.jsp	gc
	Maximize Browser Window
	Set Selenium Timeout    10s

selectanotherday
			Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[3]/button/span
			Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[3]/button/span
			Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/button
			Sleep    15s
			Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			Sleep    10
			Wait Until Page Contains    You've reached the end of our process
			Close Browser
*** Variables ***
*** Test Cases ***
Group(I)Discount(Y)TOL(Y)Mail(ENG)Address(Same)-Loop1
			@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
				: FOR    ${i}    IN    0
	#login step
	    \	Input Text    id=IDToken1   &{dict[${0}]}[id]
	    \	Input Text    id=IDToken2   &{dict[${0}]}[pass]
	    \	Click Element   xpath=//input[@value='SIGN IN']
	    \	Wait Until Page Contains  กรุณาเลือกสาขา
	#Search Sale Code
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
			\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
	#Function from Enterkey.py
			\	send_enter_key
			\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
	#Search Customer ID Card
	    \	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
	    \	Click Element    xpath=//button[@type='button']
	#Select Customer type I
			\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
			\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
			\	send_enter_key
			\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
	#Select Service
			\	Wait Until Page Contains  Recommend
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
			\	Wait Until Page Contains  บริการ
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
	#เปิดบริการ True online
			\	Wait Until Page Contains    ข้อมูล Sale
	#ใส่ข้อมูลลูกค้า
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
			\	Wait Until Page Contains    ข้อมูลที่อยู่
	#เลือก GIS
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
	#ไม่เลือก FixedLine Number
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
	#เลือก Speed and Promotion
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
	#เลือกส่วนลด(Y)เเละจำนวนเดือน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
	#เลือกเดือนสัญญา
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
	#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
	#กดยืนยันการเปิดบริการ
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Wait Until Page Contains    สรุปรายการขาย
	#กดปุ่มจดลงทะเบียน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			\	Sleep    2s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
	#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
			\	Wait Until Page Contains    ข้อมูลลูกค้า
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Sleep    5s
	#กรอกข้อมูลลูกค้าเพิ่มเติม
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
	#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
	#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ(ENG)
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
	#เลือกวันที่จะให้ติดตั้ง
			\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
			\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
	#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
	#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
			\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    13s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    10s
			\	Wait Until Page Contains    You've reached the end of our process
		  \	Close Browser
Group(I)Discount(Y)TOL(Y)Mail(ENG)Address(Diff)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    0
	#login step
			\  Input Text    id=IDToken1   &{dict[${0}]}[id]
			\  Input Text    id=IDToken2   &{dict[${0}]}[pass]
			\  Click Element   xpath=//input[@value='SIGN IN']
			\  Wait Until Page Contains  กรุณาเลือกสาขา
	#Search Sale Code
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
			\  Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
	#Function from Enterkey.py
			\  send_enter_key
			\  Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
	#Search Customer ID Card
			\  Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
			\  Click Element    xpath=//button[@type='button']
	#Select Customer type I
			\  Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
			\  Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
			\  send_enter_key
			\  Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
	#Select Service
			\  Wait Until Page Contains  Recommend
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
			\  Wait Until Page Contains  บริการ
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
	#เปิดบริการ True online
			\  Wait Until Page Contains    ข้อมูล Sale
	#ใส่ข้อมูลลูกค้า
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
			\  Wait Until Page Contains    ข้อมูลที่อยู่
	#เลือก GIS
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\  Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
	#ไม่เลือก FixedLine Number
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
	#เลือก Speed and Promotion
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
	#เลือกส่วนลด(Y)เเละจำนวนเดือน
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
	#เลือกเดือนสัญญา
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
	#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
	#กดยืนยันการเปิดบริการ
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\  Wait Until Page Contains    สรุปรายการขาย
	#กดปุ่มจดลงทะเบียน
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			\  Sleep    2s
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
	#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
			\  Wait Until Page Contains    ข้อมูลลูกค้า
			\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\  Sleep    5s
	#กรอกข้อมูลลูกค้าเพิ่มเติม
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
	#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง[Diff]
	#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
			\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
	#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ[Eng]
			\Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
	#เลือกวันที่จะให้ติดตั้ง-ระบบเจ๊งอยู่[24/4/2018 - 15.15]
			\  Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
			\  Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
	#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
	#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
			\  Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	 Sleep    15s
			\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\  Sleep    10s
			\  Wait Until Page Contains    You've reached the end of our process
			\  Close Browser
Group(I)Discount(Y)TOL(N)Mail(ENG)Address(Same)-Loop1
		@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    0
				#login step
						\  Input Text    id=IDToken1   &{dict[${0}]}[id]
						\  Input Text    id=IDToken2   &{dict[${0}]}[pass]
						\  Click Element   xpath=//input[@value='SIGN IN']
						\  Wait Until Page Contains  กรุณาเลือกสาขา
				#Search Sale Code
						\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
						\    Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
				#Function from Enterkey.py
						\  send_enter_key
						\  Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
				#Search Customer ID Card
						\  Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
						\  Click Element    xpath=//button[@type='button']
				#Select Customer type I
						\  Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
						\    Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
						\    send_enter_key
						\    Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
				#Select Service
						\    Wait Until Page Contains  Recommend
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
						\    Wait Until Page Contains  บริการ
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
				#เปิดบริการ True online
						\  Wait Until Page Contains    ข้อมูล Sale
				#ใส่ข้อมูลลูกค้า
						\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
						\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
						\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
						\Wait Until Page Contains    ข้อมูลที่อยู่
				#เลือก GIS
						\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
						\    Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
						\    Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
				#ไม่เลือก FixedLine Number
						\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				#เลือก Speed and Promotion
						\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
						\    Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				#เลือกส่วนลด(Y)เเละจำนวนเดือน
						\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
						\    Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				#เลือกเดือนสัญญา
						\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
						\  Execute Javascript    window.scrollTo(${100},${800})
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
				#กดยืนยันการเปิดบริการ
						\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
						\    Wait Until Page Contains    สรุปรายการขาย
				#กดปุ่มจดลงทะเบียน
						\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
						\    Sleep    2s
						\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
						\  Wait Until Page Contains    ข้อมูลลูกค้า
						\    Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
						\    Sleep    5s
				#กรอกข้อมูลลูกค้าเพิ่มเติม
						\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
						\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
						\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
				#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
						\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
						\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
						\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
						\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
				#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ[Eng]
						\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
				#เลือกวันที่จะให้ติดตั้ง - ระบบเจ๊งอยู่
						\  Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
						\  Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
				#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
				#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
						\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
						\    Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
						\   Sleep    13s
						\   Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
						\   Sleep    10s
						\    Wait Until Page Contains    You've reached the end of our process
						\   Close Browser
Group(I)Discount(Y)TOL(N)Mail(ENG)Address(Diff)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
	: FOR    ${i}    IN    0
		#login step
		\	Input Text    id=IDToken1   &{dict[${0}]}[id]
		\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
		\	Click Element   xpath=//input[@value='SIGN IN']
		\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
		\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
		#Function from Enterkey.py
		\	send_enter_key
		\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
		\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
		\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
		\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
		\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
		\	send_enter_key
		\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
		\	Wait Until Page Contains  Recommend
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
		\	Wait Until Page Contains  บริการ
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
		\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
		\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
		\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#เลือกส่วนลด(Y)เเละจำนวนเดือน
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
		\	Execute Javascript    window.scrollTo(${100},${800})
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
		#กดยืนยันการเปิดบริการ
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
		\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		\	Sleep    2s
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
		\	Wait Until Page Contains    ข้อมูลลูกค้า
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
		\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง[diff]
		#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ[eng]
		\Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
		#เลือกวันที่จะให้ติดตั้ง
		\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
		\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้


		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
		\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
		\	Sleep    15s
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
		\	Sleep    10s
		\	Wait Until Page Contains    You've reached the end of our process
		\	Close Browser
Group(I)Discount(Y)TOL(Y)Mail(TH)Address(Same)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    0
		#login step
				\	Input Text    id=IDToken1   &{dict[${0}]}[id]
				\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#เลือกส่วนลด(Y)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย[th]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(Y)TOL(Y)Mail(TH)Address(Diff)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
				: FOR    ${i}    IN    0
			#login step
					\	Input Text    id=IDToken1   &{dict[${0}]}[id]
					\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
					\	Click Element   xpath=//input[@value='SIGN IN']
					\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
			#Function from Enterkey.py
					\	send_enter_key
					\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
					\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\	send_enter_key
					\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\	Wait Until Page Contains  Recommend
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\	Wait Until Page Contains  บริการ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#เลือกส่วนลด(Y)เเละจำนวนเดือน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
			#กดยืนยันการเปิดบริการ
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\	Sleep    2s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\	Wait Until Page Contains    ข้อมูลลูกค้า
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษี ต่างกัน กับที่อยู่ติดตั้ง
			#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย[th]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
			#เลือกวันที่จะให้ติดตั้ง
					\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    14s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    10s
					\	Wait Until Page Contains    You've reached the end of our process
					\	Close Browser
Group(I)Discount(Y)TOL(N)Mail(TH)Address(Same)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    0
			#login step
					\	Input Text    id=IDToken1   &{dict[${0}]}[id]
					\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
					\	Click Element   xpath=//input[@value='SIGN IN']
					\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
			#Function from Enterkey.py
					\	send_enter_key
					\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
					\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\	send_enter_key
					\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\	Wait Until Page Contains  Recommend
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\	Wait Until Page Contains  บริการ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#เลือกส่วนลด(Y)เเละจำนวนเดือน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
					\	Execute Javascript    window.scrollTo(${100},${800})
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
			#กดยืนยันการเปิดบริการ
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\	Sleep    2s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\	Wait Until Page Contains    ข้อมูลลูกค้า
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
			#เลือกวันที่จะให้ติดตั้ง
					\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    14s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    10s
					\	Wait Until Page Contains    You've reached the end of our process
					\	Close Browser
Group(I)Discount(Y)TOL(N)Mail(TH)Address(Diff)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
				: FOR    ${i}    IN    0
		#login step
				\	Input Text    id=IDToken1   &{dict[${0}]}[id]
				\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#เลือกส่วนลด(Y)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
				\	Execute Javascript    window.scrollTo(${100},${800})
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง
		#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(N)TOL(Y)Mail(Eng)Address(Same)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    0
		#login step
				\	Input Text    id=IDToken1   &{dict[${0}]}[id]
				\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(N)TOL(Y)Mail(Eng)Address(Diff)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
					: FOR    ${i}    IN    0
			#login step
					\	Input Text    id=IDToken1   &{dict[${0}]}[id]
					\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
					\	Click Element   xpath=//input[@value='SIGN IN']
					\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
			#Function from Enterkey.py
					\	send_enter_key
					\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
					\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\	send_enter_key
					\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\	Wait Until Page Contains  Recommend
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\	Wait Until Page Contains  บริการ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
			#กดยืนยันการเปิดบริการ
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\	Sleep    2s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\	Wait Until Page Contains    ข้อมูลลูกค้า
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง
			#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
			#เลือกวันที่จะให้ติดตั้ง
					\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    14s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    10s
					\	Wait Until Page Contains    You've reached the end of our process
					\	Close Browser
Group(I)Discount(N)TOL(N)Mail(Eng)Address(Same)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    0
			#login step
					\	Input Text    id=IDToken1   &{dict[${0}]}[id]
					\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
					\	Click Element   xpath=//input[@value='SIGN IN']
					\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
			#Function from Enterkey.py
					\	send_enter_key
					\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
					\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\	send_enter_key
					\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\	Wait Until Page Contains  Recommend
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\	Wait Until Page Contains  บริการ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
					\	Execute Javascript    window.scrollTo(${100},${800})
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
			#กดยืนยันการเปิดบริการ
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\	Sleep    2s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\	Wait Until Page Contains    ข้อมูลลูกค้า
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
			#เลือกวันที่จะให้ติดตั้ง
					\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    14s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    10s
					\	Wait Until Page Contains    You've reached the end of our process
					\	Close Browser
Group(I)Discount(N)TOL(N)Mail(Eng)Address(Diff)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
					: FOR    ${i}    IN    0
				#login step
						\	Input Text    id=IDToken1   &{dict[${0}]}[id]
						\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
						\	Click Element   xpath=//input[@value='SIGN IN']
						\	Wait Until Page Contains  กรุณาเลือกสาขา
				#Search Sale Code
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
						\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
				#Function from Enterkey.py
						\	send_enter_key
						\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
				#Search Customer ID Card
						\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
						\	Click Element    xpath=//button[@type='button']
				#Select Customer type I
						\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
						\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
						\	send_enter_key
						\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
				#Select Service
						\	Wait Until Page Contains  Recommend
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
						\	Wait Until Page Contains  บริการ
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
				#เปิดบริการ True online
						\	Wait Until Page Contains    ข้อมูล Sale
				#ใส่ข้อมูลลูกค้า
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
						\	Wait Until Page Contains    ข้อมูลที่อยู่
				#เลือก GIS
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
						\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
				#ไม่เลือก FixedLine Number
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				#เลือก Speed and Promotion
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				#เลือกเดือนสัญญา
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
						\	Execute Javascript    window.scrollTo(${100},${800})
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
				#กดยืนยันการเปิดบริการ
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
						\	Wait Until Page Contains    สรุปรายการขาย
				#กดปุ่มจดลงทะเบียน
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
						\	Sleep    2s
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
						\	Wait Until Page Contains    ข้อมูลลูกค้า
						\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
						\	Sleep    5s
				#กรอกข้อมูลลูกค้าเพิ่มเติม
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
				#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง
				#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
						\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
				#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
				#เลือกวันที่จะให้ติดตั้ง
						\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
						\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
				#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
				#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
						\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
						\	Sleep    14s
						\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
						\	Sleep    10s
						\	Wait Until Page Contains    You've reached the end of our process
						\	Close Browser
Group(I)Discount(N)TOL(Y)Mail(TH)Address(Same)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    0
			#login step
					\	Input Text    id=IDToken1   &{dict[${0}]}[id]
					\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
					\	Click Element   xpath=//input[@value='SIGN IN']
					\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
			#Function from Enterkey.py
					\	send_enter_key
					\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
					\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\	send_enter_key
					\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\	Wait Until Page Contains  Recommend
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\	Wait Until Page Contains  บริการ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
			#กดยืนยันการเปิดบริการ
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\	Sleep    2s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\	Wait Until Page Contains    ข้อมูลลูกค้า
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
			#เลือกวันที่จะให้ติดตั้ง
					\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    14s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    10s
					\	Wait Until Page Contains    You've reached the end of our process
					\	Close Browser
Group(I)Discount(N)TOL(Y)Mail(TH)Address(Diff)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    0
	#login step
			\	Input Text    id=IDToken1   &{dict[${0}]}[id]
			\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
			\	Click Element   xpath=//input[@value='SIGN IN']
			\	Wait Until Page Contains  กรุณาเลือกสาขา
	#Search Sale Code
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
			\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
	#Function from Enterkey.py
			\	send_enter_key
			\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
	#Search Customer ID Card
			\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
			\	Click Element    xpath=//button[@type='button']
	#Select Customer type I
			\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
			\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
			\	send_enter_key
			\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
	#Select Service
			\	Wait Until Page Contains  Recommend
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
			\	Wait Until Page Contains  บริการ
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
	#เปิดบริการ True online
			\	Wait Until Page Contains    ข้อมูล Sale
	#ใส่ข้อมูลลูกค้า
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
			\	Wait Until Page Contains    ข้อมูลที่อยู่
	#เลือก GIS
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
	#ไม่เลือก FixedLine Number
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
	#เลือก Speed and Promotion
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
	#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
	#เลือกเดือนสัญญา
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
	#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
	#กดยืนยันการเปิดบริการ
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Wait Until Page Contains    สรุปรายการขาย
	#กดปุ่มจดลงทะเบียน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			\	Sleep    2s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
	#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
			\	Wait Until Page Contains    ข้อมูลลูกค้า
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Sleep    5s
	#กรอกข้อมูลลูกค้าเพิ่มเติม
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
	#ใช้ข้อมูลใบกำกับภาษี ต่างกัน กับที่อยู่ติดตั้ง
	#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
	#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
	#เลือกวันที่จะให้ติดตั้ง
			\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
			\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
	#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
	#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
			\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    14s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    10s
			\	Wait Until Page Contains    You've reached the end of our process
			\	Close Browser
Group(I)Discount(N)TOL(N)Mail(TH)Address(Same)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    0
			#login step
					\	Input Text    id=IDToken1   &{dict[${0}]}[id]
					\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
					\	Click Element   xpath=//input[@value='SIGN IN']
					\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
			#Function from Enterkey.py
					\	send_enter_key
					\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
					\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\	send_enter_key
					\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\	Wait Until Page Contains  Recommend
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\	Wait Until Page Contains  บริการ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
					\	Execute Javascript    window.scrollTo(${100},${800})
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
			#กดยืนยันการเปิดบริการ
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\	Sleep    2s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\	Wait Until Page Contains    ข้อมูลลูกค้า
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
			#เลือกวันที่จะให้ติดตั้ง
					\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    14s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    10s
					\	Wait Until Page Contains    You've reached the end of our process
					\	Close Browser
Group(I)Discount(N)TOL(N)Mail(TH)Address(Diff)-Loop1
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
					: FOR    ${i}    IN    0
			#login step
					\	Input Text    id=IDToken1   &{dict[${0}]}[id]
					\	Input Text    id=IDToken2   &{dict[${0}]}[pass]
					\	Click Element   xpath=//input[@value='SIGN IN']
					\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${0}]}[branch]
			#Function from Enterkey.py
					\	send_enter_key
					\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${0}]}[idcard]
					\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\	send_enter_key
					\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\	Wait Until Page Contains  Recommend
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\	Wait Until Page Contains  บริการ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[mobilenumber]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${0}]}[customername]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${0}]}[customersurname]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
					\	Execute Javascript    window.scrollTo(${100},${800})
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
			#กดยืนยันการเปิดบริการ
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\	Sleep    2s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\	Wait Until Page Contains    ข้อมูลลูกค้า
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${0}]}[dateofbirth]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${0}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง
			#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${0}]}[หมู่ที่]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${0}]}[หมู่บ้าน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${0}]}[ถนน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${0}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
					\Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
			#เลือกวันที่จะให้ติดตั้ง
					\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    14s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    10s
					\	Wait Until Page Contains    You've reached the end of our process
					\	Close Browser
Group(I)Discount(Y)TOL(Y)Mail(ENG)Address(Same)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    1
	#login step
			\	Input Text    id=IDToken1   &{dict[${1}]}[id]
			\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
			\	Click Element   xpath=//input[@value='SIGN IN']
			\	Wait Until Page Contains  กรุณาเลือกสาขา
	#Search Sale Code
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
			\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
	#Function from Enterkey.py
			\	send_enter_key
			\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
	#Search Customer ID Card
			\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
			\	Click Element    xpath=//button[@type='button']
	#Select Customer type I
			\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
			\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
			\	send_enter_key
			\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
	#Select Service
			\	Wait Until Page Contains  Recommend
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
			\	Wait Until Page Contains  บริการ
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
	#เปิดบริการ True online
			\	Wait Until Page Contains    ข้อมูล Sale
	#ใส่ข้อมูลลูกค้า
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
			\	Wait Until Page Contains    ข้อมูลที่อยู่
	#เลือก GIS
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
	#ไม่เลือก FixedLine Number
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
	#เลือก Speed and Promotion
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
	#เลือกส่วนลด(Y)เเละจำนวนเดือน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
	#เลือกเดือนสัญญา
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
	#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
	#กดยืนยันการเปิดบริการ
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Wait Until Page Contains    สรุปรายการขาย
	#กดปุ่มจดลงทะเบียน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			\	Sleep    2s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
	#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
			\	Wait Until Page Contains    ข้อมูลลูกค้า
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Sleep    5s
	#กรอกข้อมูลลูกค้าเพิ่มเติม
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
	#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
	#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ(ENG)
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
	#เลือกวันที่จะให้ติดตั้ง
			\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
			\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
	#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
	#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
			\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    13s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    10s
			\	Wait Until Page Contains    You've reached the end of our process
			\	Close Browser
Group(I)Discount(Y)TOL(Y)Mail(ENG)Address(Diff)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    1
		#login step
				\  Input Text    id=IDToken1   &{dict[${1}]}[id]
				\  Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\  Click Element   xpath=//input[@value='SIGN IN']
				\  Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\  Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\  send_enter_key
				\  Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\  Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\  Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\  Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\  Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\  send_enter_key
				\  Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\  Wait Until Page Contains  Recommend
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\  Wait Until Page Contains  บริการ
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\  Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\  Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\  Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#เลือกส่วนลด(Y)เเละจำนวนเดือน
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
		#กดยืนยันการเปิดบริการ
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\  Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\  Sleep    2s
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\  Wait Until Page Contains    ข้อมูลลูกค้า
				\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\  Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง[Diff]
		#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ[Eng]
				\Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
		#เลือกวันที่จะให้ติดตั้ง-ระบบเจ๊งอยู่[24/4/2018 - 15.15]
				\  Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\  Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\  Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	 Sleep    15s
				\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\  Sleep    10s
				\  Wait Until Page Contains    You've reached the end of our process
				\  Close Browser
Group(I)Discount(Y)TOL(N)Mail(ENG)Address(Same)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    1
			#login step
					\  Input Text    id=IDToken1   &{dict[${1}]}[id]
					\  Input Text    id=IDToken2   &{dict[${1}]}[pass]
					\  Click Element   xpath=//input[@value='SIGN IN']
					\  Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\    Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
			#Function from Enterkey.py
					\  send_enter_key
					\  Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\  Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
					\  Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\  Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\    Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\    send_enter_key
					\    Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\    Wait Until Page Contains  Recommend
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\    Wait Until Page Contains  บริการ
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\  Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
					\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
					\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\    Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\    Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\    Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#เลือกส่วนลด(Y)เเละจำนวนเดือน
					\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
					\    Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
					\  Execute Javascript    window.scrollTo(${100},${800})
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
			#กดยืนยันการเปิดบริการ
					\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\    Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\  Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\    Sleep    2s
					\    Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\  Wait Until Page Contains    ข้อมูลลูกค้า
					\    Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\    Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
					\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
					\  Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
					\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
					\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
					\    Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ[Eng]
					\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
			#เลือกวันที่จะให้ติดตั้ง - ระบบเจ๊งอยู่
					\  Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\  Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\  Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\    Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\   Sleep    13s
					\   Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\   Sleep    10s
					\    Wait Until Page Contains    You've reached the end of our process
					\   Close Browser
Group(I)Discount(Y)TOL(N)Mail(ENG)Address(Diff)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    1
			#login step
			\	Input Text    id=IDToken1   &{dict[${1}]}[id]
			\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
			\	Click Element   xpath=//input[@value='SIGN IN']
			\	Wait Until Page Contains  กรุณาเลือกสาขา
				#Search Sale Code
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
			\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
			#Function from Enterkey.py
			\	send_enter_key
			\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
			\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
			\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
			\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
			\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
			\	send_enter_key
			\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
			\	Wait Until Page Contains  Recommend
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
			\	Wait Until Page Contains  บริการ
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
			\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
			\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#เลือกส่วนลด(Y)เเละจำนวนเดือน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
			\	Execute Javascript    window.scrollTo(${100},${800})
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
			#กดยืนยันการเปิดบริการ
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			\	Sleep    2s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
			\	Wait Until Page Contains    ข้อมูลลูกค้า
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง[diff]
			#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ[eng]
			\Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
			#เลือกวันที่จะให้ติดตั้ง
			\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
			\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้


			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
			\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    15s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    10s
			\	Wait Until Page Contains    You've reached the end of our process
			\	Close Browser
Group(I)Discount(Y)TOL(Y)Mail(TH)Address(Same)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    1
			#login step
					\	Input Text    id=IDToken1   &{dict[${1}]}[id]
					\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
					\	Click Element   xpath=//input[@value='SIGN IN']
					\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
			#Function from Enterkey.py
					\	send_enter_key
					\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
					\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\	send_enter_key
					\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\	Wait Until Page Contains  Recommend
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\	Wait Until Page Contains  บริการ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#เลือกส่วนลด(Y)เเละจำนวนเดือน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
			#กดยืนยันการเปิดบริการ
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\	Sleep    2s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\	Wait Until Page Contains    ข้อมูลลูกค้า
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย[th]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
			#เลือกวันที่จะให้ติดตั้ง
					\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    14s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    10s
					\	Wait Until Page Contains    You've reached the end of our process
					\	Close Browser
Group(I)Discount(Y)TOL(Y)Mail(TH)Address(Diff)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    1
		#login step
				\	Input Text    id=IDToken1   &{dict[${1}]}[id]
				\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#เลือกส่วนลด(Y)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษี ต่างกัน กับที่อยู่ติดตั้ง
		#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย[th]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(Y)TOL(N)Mail(TH)Address(Same)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    1
		#login step
				\	Input Text    id=IDToken1   &{dict[${1}]}[id]
				\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#เลือกส่วนลด(Y)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
				\	Execute Javascript    window.scrollTo(${100},${800})
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(Y)TOL(N)Mail(TH)Address(Diff)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
			: FOR    ${i}    IN    1
	#login step
			\	Input Text    id=IDToken1   &{dict[${1}]}[id]
			\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
			\	Click Element   xpath=//input[@value='SIGN IN']
			\	Wait Until Page Contains  กรุณาเลือกสาขา
	#Search Sale Code
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
			\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
	#Function from Enterkey.py
			\	send_enter_key
			\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
	#Search Customer ID Card
			\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
			\	Click Element    xpath=//button[@type='button']
	#Select Customer type I
			\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
			\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
			\	send_enter_key
			\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
	#Select Service
			\	Wait Until Page Contains  Recommend
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
			\	Wait Until Page Contains  บริการ
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
	#เปิดบริการ True online
			\	Wait Until Page Contains    ข้อมูล Sale
	#ใส่ข้อมูลลูกค้า
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
			\	Wait Until Page Contains    ข้อมูลที่อยู่
	#เลือก GIS
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
			\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
	#ไม่เลือก FixedLine Number
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
	#เลือก Speed and Promotion
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
	#เลือกส่วนลด(Y)เเละจำนวนเดือน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[2]
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
	#เลือกเดือนสัญญา
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
	#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
			\	Execute Javascript    window.scrollTo(${100},${800})
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
	#กดยืนยันการเปิดบริการ
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
			\	Wait Until Page Contains    สรุปรายการขาย
	#กดปุ่มจดลงทะเบียน
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			\	Sleep    2s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
	#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
			\	Wait Until Page Contains    ข้อมูลลูกค้า
			\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Sleep    5s
	#กรอกข้อมูลลูกค้าเพิ่มเติม
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
	#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง
	#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
			\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
	#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
	#เลือกวันที่จะให้ติดตั้ง
			\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
			\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
	#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
	#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
			\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    14s
			\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
			\	Sleep    10s
			\	Wait Until Page Contains    You've reached the end of our process
			\	Close Browser
Group(I)Discount(N)TOL(Y)Mail(Eng)Address(Same)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    1
		#login step
				\	Input Text    id=IDToken1   &{dict[${1}]}[id]
				\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(N)TOL(Y)Mail(Eng)Address(Diff)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
				: FOR    ${i}    IN    1
		#login step
				\	Input Text    id=IDToken1   &{dict[${1}]}[id]
				\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง
		#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(N)TOL(N)Mail(Eng)Address(Same)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    1
		#login step
				\	Input Text    id=IDToken1   &{dict[${1}]}[id]
				\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
				\	Execute Javascript    window.scrollTo(${100},${800})
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(N)TOL(N)Mail(Eng)Address(Diff)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
				: FOR    ${i}    IN    1
			#login step
					\	Input Text    id=IDToken1   &{dict[${1}]}[id]
					\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
					\	Click Element   xpath=//input[@value='SIGN IN']
					\	Wait Until Page Contains  กรุณาเลือกสาขา
			#Search Sale Code
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
					\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
			#Function from Enterkey.py
					\	send_enter_key
					\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
			#Search Customer ID Card
					\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
					\	Click Element    xpath=//button[@type='button']
			#Select Customer type I
					\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
					\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
					\	send_enter_key
					\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
			#Select Service
					\	Wait Until Page Contains  Recommend
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
					\	Wait Until Page Contains  บริการ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
			#เปิดบริการ True online
					\	Wait Until Page Contains    ข้อมูล Sale
			#ใส่ข้อมูลลูกค้า
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
					\	Wait Until Page Contains    ข้อมูลที่อยู่
			#เลือก GIS
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
					\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
			#ไม่เลือก FixedLine Number
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
			#เลือก Speed and Promotion
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
			#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
			#เลือกเดือนสัญญา
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
			#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
					\	Execute Javascript    window.scrollTo(${100},${800})
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
			#กดยืนยันการเปิดบริการ
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
					\	Wait Until Page Contains    สรุปรายการขาย
			#กดปุ่มจดลงทะเบียน
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
					\	Sleep    2s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
			#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
					\	Wait Until Page Contains    ข้อมูลลูกค้า
					\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Sleep    5s
			#กรอกข้อมูลลูกค้าเพิ่มเติม
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
			#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง
			#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
					\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
			#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาอังกฤษ
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[2]
			#เลือกวันที่จะให้ติดตั้ง
					\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
					\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
			#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
			#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
					\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    14s
					\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
					\	Sleep    10s
					\	Wait Until Page Contains    You've reached the end of our process
					\	Close Browser
Group(I)Discount(N)TOL(Y)Mail(TH)Address(Same)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    1
		#login step
				\	Input Text    id=IDToken1   &{dict[${1}]}[id]
				\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(N)TOL(Y)Mail(TH)Address(Diff)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
				: FOR    ${i}    IN    1
		#login step
				\	Input Text    id=IDToken1   &{dict[${1}]}[id]
				\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ต้องจ่าย TOLENTRYFEE 650(Y)-ไม่ต้องเพิ่มโค้ดบรรทัดนี้ระบบออโต้ฟิลให้อยู่เเล้ว
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษี ต่างกัน กับที่อยู่ติดตั้ง
		#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(N)TOL(N)Mail(TH)Address(Same)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
		: FOR    ${i}    IN    1
		#login step
				\	Input Text    id=IDToken1   &{dict[${1}]}[id]
				\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
				\	Execute Javascript    window.scrollTo(${100},${800})
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีที่เดียวกับที่อยู่ติดตั้ง
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
Group(I)Discount(N)TOL(N)Mail(TH)Address(Diff)-Loop2
	@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
				: FOR    ${i}    IN    1
		#login step
				\	Input Text    id=IDToken1   &{dict[${1}]}[id]
				\	Input Text    id=IDToken2   &{dict[${1}]}[pass]
				\	Click Element   xpath=//input[@value='SIGN IN']
				\	Wait Until Page Contains  กรุณาเลือกสาขา
		#Search Sale Code
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div/div[2]/div
				\	Input Text    xpath=//*[@id="react-select-2--value"]/div[2]/input    &{dict[${1}]}[branch]
		#Function from Enterkey.py
				\	send_enter_key
				\	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
		#Search Customer ID Card
				\	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${1}]}[idcard]
				\	Click Element    xpath=//button[@type='button']
		#Select Customer type I
				\	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/div/div[2]/ul/li[1]/a
				\	Click Element    xpath=//*[@id="react-select-3--value"]/div[1]
				\	send_enter_key
				\	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
		#Select Service
				\	Wait Until Page Contains  Recommend
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
				\	Wait Until Page Contains  บริการ
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
		#เปิดบริการ True online
				\	Wait Until Page Contains    ข้อมูล Sale
		#ใส่ข้อมูลลูกค้า
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[mobilenumber]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${1}]}[customername]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${1}]}[customersurname]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
				\	Wait Until Page Contains    ข้อมูลที่อยู่
		#เลือก GIS
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
				\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
		#ไม่เลือก FixedLine Number
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[1]
		#เลือก Speed and Promotion
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[6]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[13]
		#ไม่เลือกส่วนลด(N)เเละจำนวนเดือน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[1]/div/div[2]/select/option[1]
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[4]/div[2]/div/div[2]/select/option
		#เลือกเดือนสัญญา
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[1]/div/div[2]/select/option
		#ไม่ต้องจ่าย TOLENTRYFEE 650(N)
				\	Execute Javascript    window.scrollTo(${100},${800})
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[7]/div[2]/div[2]/label
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div[8]/div[2]/div[2]/div[2]/select/option[5]
		#กดยืนยันการเปิดบริการ
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
				\	Wait Until Page Contains    สรุปรายการขาย
		#กดปุ่มจดลงทะเบียน
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
				\	Sleep    2s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		#รอกดปุ่มไปหน้ากรอกข้อมมูลเพิ่มเติม
				\	Wait Until Page Contains    ข้อมูลลูกค้า
				\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Sleep    5s
		#กรอกข้อมูลลูกค้าเพิ่มเติม
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${1}]}[dateofbirth]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${1}]}[idcardexpiredate]
		#ใช้ข้อมูลใบกำกับภาษีคนละที่กับที่อยู่ติดตั้ง
		#เปลี่ยนบ้านเลขที่ฟิกค่า 999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[1]/div/div[2]/input		999/999
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${1}]}[หมู่ที่]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[2]/div/div[2]/input    &{dict[${1}]}[หมู่บ้าน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${1}]}[ถนน]
				\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${1}]}[เบอร์โทรที่ติดต่อได้]
		#เลือกภาษาที่จะใช้ติดต่อเป็นภาษาไทย
				\Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[4]/div/div/div/a[1]
		#เลือกวันที่จะให้ติดตั้ง
				\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
				\	Click Element    xpath =//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[5]/div/div[2]/button/span
		#ยังไม่กดต่อเพราะเดี๋ยว้อมูลใช้ต่อไม่ได้
		#ยืนยันขั้นตอนสุดท้ายเพื่อออกบิล
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
				\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    14s
				\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
				\	Sleep    10s
				\	Wait Until Page Contains    You've reached the end of our process
				\	Close Browser
