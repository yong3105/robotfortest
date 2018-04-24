# เอาไฟล์ csv เข้าใช้ Library CSVLibrary+Collections
#ในกรณีที่ไฟล์ csv มีภาษาไทย Lib default จะอ่านไม่จะอ่านไม่ออก
#ให้ไปที่ Folder Lib ของ CSVLibrary แก้ไฟล์ชื่อ _init_.py เพิ่ม import unicodecsv	as  csv ไว้ที่ด้านบนไฟล์
#หากยังไม่มี lib unicodecsv ให้ pip install unicodecsv
*** Settings ***
Library		Selenium2Library
Library		Collections
Library   CSVLibrary
Library 	String
Test Setup	OPEN true1
Suite teardown    Close all browsers

*** Keywords ***
OPEN true1
	Open Browser	https://goo.gl/VbBknj	gc
	Maximize Browser Window
	Set Selenium Timeout    30s

*** Variables ***

*** Test Cases ***
TestCase001
#Set data อ่านค่าจาก csv ใช้ associative เพื่อให้กำหนดฟิลด์ที่จะนำไปใส่ในเเต่ละ element ได้
		@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order FTTH Alone.csv
#เซตค่า ${i} เป็นตัวเลขเเทนในอาเรย์กำหนดช่วงวนลูปเป็นข้อมูลชุดเเรกถึงชุดที่ 99
		: FOR    ${i}    IN RANGE    0    100
#login step
    \	Input Text    id=IDToken1   &{dict[${i}]}[id]
    \	Input Text    id=IDToken2   &{dict[${i}]}[pass]
    \	Click Element   xpath=//input[@value='SIGN IN']
    \	Wait Until Page Contains  SHOP
#Search Sale Code
    \	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/div/div/div[2]/div/div/div[2]/div[1]/div/div[3]/div/input    &{dict[${i}]}[salecode]
    \	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/div/div/div[2]/div/div/div[2]/div/div/div[3]/div/span[2]/a/i
    \	Wait Until Page Contains  Dummy Leader Prepay H-249
    \	Click Element   xpath=//*[@id="app"]/div/div[1]/div[2]/div/div/div/div[2]/div/div/div[3]/a
    \	Wait Until Page Contains  ตรวจสอบข้อมูลลูกค้า
#Search Customer ID Card
    \	Input Text    xpath=//*[@id="searchbox"]/div/div/div[1]/div/input    &{dict[${i}]}[customeridcard]
    \	Click Element    xpath=//button[@type='button']
#Select Customer type
    \	Wait Until Page Contains  กรุณาเลือกประเภทลูกค้า
    \	Click Element    xpath=//div[@id='app']/div/div/div[2]/div/section/span/div/div[4]/div/div/button[2]
#Select Service
		\	Wait Until Page Contains  Recommend
    \	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[4]
		\	Wait Until Page Contains  บริการ
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div[2]/div[3]/div[3]
#เปิดบริการ True online
		\	Wait Until Page Contains    ข้อมูล Sale
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[1]/div/div[2]/input    &{dict[${i}]}[customername]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[1]/div[2]/div[2]/div/div[2]/input    &{dict[${i}]}[customersurname]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[2]/div[2]/div[2]/div/div[2]/input    &{dict[${i}]}[customertel]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div/div/div[3]/div/div/button
		\	Wait Until Page Contains    ข้อมูลที่อยู่
#เลือก GIS ID
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div[3]/div[2]/div/div
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
		\	Click Button    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[4]/div/div/button[2]
		\	Wait Until Page Contains    ข้อมูลบริการ Fixedline Plus เพิ่ม
#ไม่สมัคร Fixlined Plus เพิ่ม
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[1]/div/div[2]/div/div/a[2]
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[9]
		\	Wait Until Element Is Enabled    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[2]/div/div[2]/select/option[20]
		\	Wait Until Page Contains    ข้อมูล True Online
		\	Click Element    xpath=//div[@id="app"]/div/div/div[2]/div/section/span/div/div[3]/div/ul/li[2]
		\	Wait Until Page Contains    ข้อมูล Fixedline Plus
		\	Click Button    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[2]/div[1]/div[1]/div[2]/div[1]/span/button
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[2]/div[1]/div[2]/form/div[1]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[3]/div[1]/div/div[2]/select/option[3]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[3]/div/div[2]/div/div[4]/div/div/div[2]/select/option[2]
		\	Click Button    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[4]/div/div/button
#สรุปรายการขาย
		\	Wait Until Page Contains    สรุปรายการขาย
		\	Click Button    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[5]/div/div/div[2]/div/button[2]
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[1]/div/div/div/a[1]
#กรอกข้อมูลลูกค้าเพิ่มเติม
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[2]/div/div/div[1]/input    &{dict[${i}]}[วันเกิด]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[1]/div/div[2]/div/div[2]/div[5]/div[3]/div/div/div[1]/input    &{dict[${i}]}[วันหมดอายุบัตร]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[3]/div[3]/div/div/input    &{dict[${i}]}[หมู่บ้าน]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[5]/div/div[2]/div/div/div/div[4]/div[4]/div/div/input    &{dict[${i}]}[ถนน]
		\	Input Text    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[7]/div/div[2]/div[1]/div/div/input    &{dict[${i}]}[เบอร์โทรที่สามารถติดต่อได้]
		\	Focus    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
#เลือกวันที่ต้องการติดตั้ง
		\	Click Button    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[1]/section[9]/div/div[2]/div[1]/div/div[3]/div[7]/div/div[2]/button
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div[2]/div[2]/a
#ยืนยัน
		\	Wait Until Element Is Visible    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
		\	Click Element    xpath=//*[@id="app"]/div/div[1]/div[2]/div/section/span/div/div/div[1]/div[4]/div/div[2]/a
		\	Wait Until Page Contains    You've reached the end of our process
		\	Close Browser
