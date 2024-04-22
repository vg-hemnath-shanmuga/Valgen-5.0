*** Settings ***
Documentation    This suite contains test cases of Spread Template
Suite Teardown     Close All Browsers
Resource          ../Config/super.resource
Resource    ../Keywords/Web/prerequsiteKeywords.resource
#Test Tags    test:retry(0)
Test Teardown    NONE

*** Test Cases ***
TC_Create Spread Template
    [Documentation]    Create Spread Template
    ${SpreadTemplate_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    SpreadTemplate
    Login To VLMS Application   ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Spread Template
    Wait Until Time    ${SHORT_WAIT}
    Create Spread Template    ${SpreadTemplate_data}    ${USER}    ${USER_PASSWORD}