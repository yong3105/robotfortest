*** Settings ***
Library		Selenium2Library
Test Setup	OPEN Browser1

*** Keywords ***
OPEN Browser1
	Open Browser	https://google.com	gc

*** Variables ***


*** Test Cases ***
Search
	Input Text	lst-ib	Havana
	Press Key    btnK    \\13
	Wait Until Page Contains    Camila Cabello - Havana (Audio) ft. Young Thug - YouTube
	Click Link    https://www.youtube.com/watch?v=HCjNJDNzw8Y
