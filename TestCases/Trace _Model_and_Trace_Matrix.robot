*** Settings ***
Documentation    This suite contains test cases of processflow 3
Suite Teardown     Run Keywords    Close Browser
...         AND    Stop Recording    False    PF3
Suite Setup        Start Recording    False    PF3
Resource          ../Config/super.resource
#Test Tags    test:retry(1)    testcase


*** Test Cases ***
Validate User Is Able To Create Trace Model
    [Tags]    PF3TC1
    [Documentation]    TC_01,02,03 View Trace Model Image and Create Trace Model
    [Setup]    Start Recording    False    T1
    [Teardown]    Stop Recording    False    T1
    ${trace_data}    Read TestData From Excel    TC_01    TraceModel
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Create Trace Model Page
    ${EXPECTED_MESSAGE}    Enter Trace Model Title And Select Content Types    ${trace_data}
    Create Trace Model    ${trace_data}    ${USER}    ${USER_PASSWORD}
    Verify Confirmation Popup    ${EXPECTED_MESSAGE}    ${trace_data}[ButtonOption]
    Verify Select Trace Model To Develop Screen Is Displayed
    # Log Actual And Expected Results    ${trace_data}[ActualResult]    ${trace_data}[ExpectedResult]
    #Log Actual And Expected Results    Trace Model is Created    Trace Model should be Created

Validate User Is Able To Create Bind Task
    [Tags]    PF3TC4
    [Documentation]    TC_04,05,06,07 Select Trace model & Entity to bind and create Bind Task
    [Setup]    Start Recording    False    T4
    [Teardown]    Stop Recording    False    T4
    ${trace_data}    Read TestData From Excel    TC_04    BindTask
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Create Bind Task Page
    ${EXPECTED_MESSAGE}    Create Bind Task    ${trace_data}    ${TRACE_MODEL_NO}    ${USER}    ${USER_PASSWORD}
    Verify Confirmation Popup    ${EXPECTED_MESSAGE}    ${trace_data}[ButtonOption]
    Verify Select Bind Task Screen Is Displayed
    Logout From VLMS Application
    # Log Actual And Expected Results    ${trace_data}[ActualResult]    ${trace_data}[ExpectedResult]
    #Log Actual And Expected Results    Bind Task is Created    Bind Task should be Created

Validate Approver Is Able To Approve Bind Task
    [Tags]    PF3TC8
    [Documentation]    TC_08,09,10,11 Login as an approver and approve bind task
    [Setup]    Start Recording    False    T8
    [Teardown]    Stop Recording    False    T8
    ${trace_data}    Read TestData From Excel    TC_08    BindTask
    Login To VLMS Application    ${APPROVER}    ${APPROVER_PASSWORD}
    Select And Accept The Bind Task To Approve    ${BIND_TASK_NO}    ${trace_data}[Message]
    Verify Approve Bind Task Screen Is Displayed
    ${EXPECTED_MESSAGE}    Approve Bind Task    ${trace_data}    ${BIND_TASK_NO}    ${APPROVER}    ${APPROVER_PASSWORD}
    Verify Confirmation Popup    ${EXPECTED_MESSAGE}    ${trace_data}[ButtonOption]
    Verify Select Bind Task To Approve Screen Is Displayed
    # Log Actual And Expected Results    ${trace_data}[ActualResult]    ${trace_data}[ExpectedResult]
    #Log Actual And Expected Results    Bind Task is Approved    Bind Task should be Approved

Validate User Is Able To Create Content Library
    [Tags]    PF3TC13
    [Documentation]    TC_13,14,15 Create Content Library and Approve Content Library
    [Setup]    Start Recording    False    T13
    [Teardown]    Stop Recording    False    T13
    ${content_data}    Read TestData From Excel    TC_13    ContentLibrary
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Initiate Content Library Page
    Initiate Content Library    ${content_data}
    Verify Confirmation Popup    ${content_data}[ExpectedMessage]    ${content_data}[ButtonOption]
    Navigate To Author Content Library Page    ${content_data}[Value]
    Author Content Library    ${content_data}
    Run Keyword And Continue On Failure    Verify Entered Details In The Content Library Grid    ${content_data}[RowNo1]    ${content_data}[RowDetails1]
    Edit Content In The Content Library Table    ${content_data}
    ${EXPECTED_MESSAGE}    Approve Content Library    ${content_data}
    Verify Confirmation Popup    ${EXPECTED_MESSAGE}    ${content_data}[ButtonOption1]
    # Log Actual And Expected Results    ${content_data}[ActualResult]    ${content_data}[ExpectedResult]
    #Log Actual And Expected Results    Content Library is Created    Content Library should be Created

Validate User Is Able To Save Trace Matrix
    [Tags]    PF3TC16
    [Documentation]    TC_16,17,18 Save Trace Matrix And Verify The Success Message
    [Setup]    Start Recording    False    T16
    [Teardown]    Stop Recording    False    T16
    ${tracematrix_data}    Read TestData From Excel    TC_16    TraceMatrix
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Create Trace Matrix Page
    Save Trace Matrix    ${tracematrix_data}    ${TRACE_MODEL_NO}
    Verify Confirmation Popup    ${EXPECTED_MESSAGE}    ${tracematrix_data}[ButtonOption]
    Verify Trace Matrix Screen Is Displayed
    # Log Actual And Expected Results    ${tracematrix_data}[ActualResult]    ${tracematrix_data}[ExpectedResult]
    #Log Actual And Expected Results    Trace Matrix is Saved    Trace Matrix should be Saved

Validate User Is Able To Create Trace Matrix
    [Tags]    PF3TC19
    [Documentation]    TC_19,20,21,22,23,24 Create Trace Matrix And Verify The Success Message
    [Setup]    Start Recording    False    T19
    [Teardown]    Stop Recording    False    T19
    ${tracematrix_data}    Read TestData From Excel    TC_19    TraceMatrix
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Trace Matrix Page    ${TRACEMATRIX_NO}
    Select Trace Matrix And Verify Spread View Tab    ${tracematrix_data}
    ${EXPECTED_SUCCESSMESSAGE}    Create Trace Matrix    ${tracematrix_data}    ${USER}    ${USER_PASSWORD}
    Verify Confirmation Popup    ${EXPECTED_SUCCESSMESSAGE}    ${tracematrix_data}[ButtonOption]
    Verify Select Trace Matrix To Develop Screen Is Displayed
    # Log Actual And Expected Results    ${tracematrix_data}[ActualResult]    ${tracematrix_data}[ExpectedResult]
    #Log Actual And Expected Results    Trace Matrix is Created    Trace Matrix should be Created