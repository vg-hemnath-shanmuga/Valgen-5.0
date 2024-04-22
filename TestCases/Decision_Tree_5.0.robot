*** Settings ***
Documentation    This suite contains test cases of Decision Tree
Suite Teardown     Close All Browsers
Resource          ../Config/super.resource
Resource    ../Keywords/Web/prerequsiteKeywords.resource
#Test Tags    test:retry(0)
Test Teardown    NONE

*** Test Cases ***
TC_Create Decision Tree
    [Documentation]    Create Decision Tree
    ${decision_tree_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    DecisionTree
    Login To VLMS Application   ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Decision Tree
    Wait Until Time    ${SHORT_WAIT}
    Create Decision Tree_Prerequisite    ${decision_tree_data}    ${USER}    ${USER_PASSWORD}