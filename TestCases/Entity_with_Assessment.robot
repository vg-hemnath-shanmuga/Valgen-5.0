*** Settings ***
Documentation    This suite contains test cases of processflow 7
Suite Teardown     Run Keywords    Close Browser
...         AND    Stop Recording    False    PF7
Suite Setup        Start Recording    False    PF7
Resource          ../Config/super.resource
Test Tags    test:retry(0)    PF7D1


*** Test Cases ***

Validate User Is Able To Create Assessment Template
    [Tags]    PF7TC1
    [Documentation]    TC_01,02,03 Create Assessment Template
    [Setup]    Start Recording    False    T1
    [Teardown]    Stop Recording    False    T1
    ${assessment_data}    Read TestData From Excel    TC_01    AssessmentTemplate
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Create Assessment Template Page
    Enter Details In Create Assessment Template Page    ${assessment_data}
    ${EXPECTED_MESSAGE}    Create Assessment Template    ${assessment_data}    ${USER}    ${USER_PASSWORD}
    Verify Confirmation Popup    ${EXPECTED_MESSAGE}    ${assessment_data}[ButtonOption]
    Logout From VLMS Application
    #Log Actual And Expected Results    Assessment Template is Created    Assessment Template should be Created

Validate User Is Able To Create Entity Type
    [Tags]    PF7TC4
    [Documentation]    TC_04 Create Entity Type
    [Setup]    Start Recording    False    T4
    [Teardown]    Stop Recording    False    T4
    ${entity_type_data}    Read TestData From Excel    TC_04    EntityType
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Create Entity Type
    Create Entity Type    ${entity_type_data}    ${ASSESSMENT_TEMPLATE_NO}
    Verify Entity Type    ${USER}    ${USER_PASSWORD}    ${entity_type_data}
    Logout From VLMS Application
    #Log Actual And Expected Results    Entity Type is Created    Entity Type should be Created

Validate User Is Able To Create Entity With Assessment
    [Tags]    PF7TC5
    [Documentation]    TC_05 Create Entity With Assessment
    [Setup]    Start Recording    False    T5
    [Teardown]    Stop Recording    False    T5
    ${entity_data}    Read TestData From Excel    TC_05    Entity
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    ${entity_data}[Module]    ${entity_data}[Function]    ${entity_data}[Item]    ${entity_data}[PageName]
    Create Entity    ${entity_data}    ${USER}    ${USER_PASSWORD}
    Verify Created Framework Pop Up Message    ${entity_data}[ButtonOption]   ${entity_data}[PopUpMessage]    ${entity_data}[CreatedItem]    ${entity_data}
    Logout From VLMS Application
    #Log Actual And Expected Results    Entity With Assessment is Created    Entity With Assessment should be Created


Validate User Is Able To Create Assessment
    [Tags]    PF7TC6
    [Documentation]    TC_06 Create Assessment
    [Setup]    Start Recording    False    T6
    [Teardown]    Stop Recording    False    T6
    ${assessment_data}    Read TestData From Excel    TC_06    Assessment
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Create Assessment Page
    Create Assessment    ${assessment_data}    ${USER}    ${USER_PASSWORD}
    Verify Confirmation Popup    ${assessment_data}[ExpectedMessage]    ${assessment_data}[ButtonOption]
    Logout From VLMS Application
    #Log Actual And Expected Results    Assessment is Created    Assessment should be Created

Validate User Is Able To Perform The Assessment
    [Tags]    PF7TC7
    [Documentation]    TC_07,08,09 Perform The Assessment
    [Setup]    Start Recording    False    T7
    [Teardown]    Stop Recording    False    T7
    ${perform_assessment_data}    Read TestData From Excel    TC_07    PerformAssessment
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Perform Assessment Page    ${ASSESSMENT_NAME}
    ${EXPECTED_MESSAGE}    Perform The Assessment    ${perform_assessment_data}
    Verify Confirmation Popup    ${EXPECTED_MESSAGE}    ${perform_assessment_data}[ButtonOption]
    Logout From VLMS Application
    #Log Actual And Expected Results    Assessment is Performed    Assessment should be Performed

Validate User Is Able To Approve The Assessment
    [Tags]    PF7TC10
    [Documentation]    TC_10,11,12 Add Additional Deliverables, Actions And Approve Assessment
    [Setup]    Start Recording    False    T10
    [Teardown]    Stop Recording    False    T10
    ${perform_data}    Read TestData From Excel    TC_10    PerformAssessment  
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Perform Assessment Page    ${ASSESSMENT_NAME}
    Add Additional Deliverables To The Assessment    ${perform_data}
    Verify Additional Deliverables Under Validation Deliverables Section    ${perform_data}
    Add Define Deliverables And Task Dependencies For The Assessment    ${perform_data}    ${ENTITY}
    Verify Action Values Under View Saved Actions    ${perform_data}
    Approve Assessment    ${perform_data}    ${USER}    ${USER_PASSWORD}
    Verify Confirmation Popup    ${EXPECTED_MESSAGE}    ${perform_data}[ButtonOption]
    Logout From VLMS Application
    #Log Actual And Expected Results    Assessment is Approved    Assessment should be Approved
