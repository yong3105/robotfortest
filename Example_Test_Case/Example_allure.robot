*** Settings ***
Library		Selenium2Library
Library	AllureReportLibrary	C:\\Users\\Yong\\Desktop\\Robot\\Allure
Test Setup	OPEN GMAIL

*** Keywords ***
OPEN GMAIL
	Open Browser	https://accounts.google.com/ServiceLogin?continue=https%3A%2F%2Fmail.google.com%2Fmail%2F&service=mail&sacu=1&rip=1#identifier	gc

*** Variables ***
${gmaillogin}	testrobot66@gmail.com
${gmailpass}	Netbay@123
${gmailpasswrong}	123456789

*** Test Cases ***
Login1
	Input Text	Email	${gmaillogin}
	Click Button	Next
	Wait Until Element Is Visible	Passwd	
	Input Password	Passwd	${gmailpass}
	Click Button	Sign in
	Close Browser
	
Login2
	Input Text	Email	${gmaillogin}
	Click Button	Next
	Wait Until Element Is Visible	Passwd	
	Input Password	Passwd	${gmailpasswrong}
	Click Button	Sign in
	Close Browser