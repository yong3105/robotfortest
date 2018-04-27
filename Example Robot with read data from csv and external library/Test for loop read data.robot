*** Settings ***
Library		Collections
Library   CSVLibrary
*** Keywords ***
*** Variables ***
*** Test Cases ***
Test
			@{dict}=    read csv file to associative  ${CURDIR}${/}Creat Order Docsis.csv
      Log    &{dict[${0}]}[customername]
			Log    &{dict[${1]}[customername]
