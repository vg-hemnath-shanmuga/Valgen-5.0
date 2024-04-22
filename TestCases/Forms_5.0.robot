*** Settings ***
Documentation    This suite contains test cases of Forms
Suite Teardown     Close All Browsers
Resource          ../Config/super.resource
Resource    ../Keywords/Web/prerequsiteKeywords.resource
#Test Tags    test:retry(0)
Test Teardown    NONE

*** Test Cases ***
TC_Create Form
    [Documentation]    Create Form
    ${form_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Form
    Login To VLMS Application   ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Form
    Wait Until Time    ${SHORT_WAIT}
    Create Form prerequsite  ${form_data}   ${USER}    ${USER_PASSWORD}