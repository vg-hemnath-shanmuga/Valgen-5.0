*** Settings ***
Documentation     This suite contains test cases of workflow 1
Suite Teardown     Close All Browsers
Resource          ../Config/super.resource
#Test Tags    test:retry(1)

 
*** Test Cases ***
TC_01,02,03,04 Validate the Initiation of Document in 5.0 Version
    [Documentation]    Check Entity Selection, Content Function Is Pre-Populated And Perform Reset Data And Initiate Multiple Tasks In Initiate Task Page
    ${initiate_data}    Read TestData Fro m Excel    TC_01    Initiate
    Login To VLMS 5.0 Application   ${USER}    ${USER_PASSWORD}
    Navigate to Assign Document Screen    Content    Document    Assign
    Initiate Authoring Task    ${initiate_data}
    Validate Entity Is Selected    ${initiate_data}[Entity]
    Validate Content Function Is Pre-populated
    Click Button In VLMS    Cancel
    Validate Data Is Cleared
    Initiate Authoring Task    ${initiate_data}
    Click Button In VLMS    Submit
    Validate Toast Message    ${initiate_data}[Message]

TC_09,10 Validate User Is Unable To Enter More Than 50 Characters in Entity Name Field in 5.0 Version
    [Documentation]    Check The Length Of Entity Name Field By Providing More Than 50 Alphanumeric Characters
    ${initiate_data}    Read TestData From Excel    TC_09    Initiate
    Login To VLMS 5.0 Application   ${USER}    ${USER_PASSWORD}
    Navigate to Assign Document Screen    Content    Document    Assign
    Initiate Authoring Task    ${initiate_data}
    Validate Length Of Text Field    EntitySystemName    ${initiate_data}
    Select Submit/Reset Button    Submit
    Validate Toast Message    Information Missing. Please check the highlighted fields.
    Validate highlighted field    Select Content Type
    Validate highlighted field    Enter Entity Name
TC_11 Validate User Is Able Initiate New Entity
    [Documentation]    Initiate New Entity On The Initiate Task Page.
    ${initiate_data}    Read TestData From Excel    TC_11    Initiate
    Login To VLMS 5.0 Application   ${USER}    ${USER_PASSWORD}
    Navigate to Assign Document Screen    Content    Document    Assign
    Initiate Authoring Task    ${initiate_data}
    Select Submit/Reset Button    Submit
    Validate Toast Message    ${initiate_data}[Message]
TC_12,13 Validate User Is Able Initiate Existing Entity
    [Documentation]    Initiate multiple task
    ${initiate_data}    Read TestData Fro m Excel    TC_01    Initiate
    Login To VLMS 5.0 Application   ${USER}    ${USER_PASSWORD}
    Navigate to Assign Document Screen    Content    Document    Assign
    Initiate Authoring Task    ${initiate_data}
    Click Button In VLMS    Submit
    Validate Toast Message    ${initiate_data}[Message]
    #Wait Until Time    ${SHORT_WAIT}
    #Click Button In VLMS    Assign
    #Initiate Authoring Task    ${initiate_data}
    #Click Button In VLMS    Submit
    #Validate Toast Message    ${initiate_data}[Message]
TC_14 Validate User Is Able To Remove Selected Task
    [Documentation]    Select initiated task and delete it.
    ${assign_doc_data}    Read TestData From Excel    TC_14    Initiate
    Login To VLMS 5.0 Application   ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    Content    Document
    Wait Until Time    ${SHORT_WAIT}
    Select Frame    ${iframe.framecontent}
    Filter The Option And Search The Text    Status    To be Assigned    ${assign_doc_data}[Entity]
    Wait Until Time    ${SHORT_WAIT}
    Click And Delete The Task
    Validate Toast Message    ${assign_doc_data}[Message]
TC_15,16,17 Validate User Is Able To Assign Authoring Task As Serial Reviewer 
    [Documentation]    Assign Authoring Task As Serial Reviewer
    ${assign_doc_data}    Read TestData From Excel    TC_15    Assign
    ${assign_doc_data1}    Read TestData From Excel    TC_14    Initiate
    Login To VLMS 5.0 Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    Content    Document
    Wait Until Time    ${SHORT_WAIT}
    Select Frame    ${iframe.framecontent}
    Select The Task Filtered By Status    Status    To be Assigned    ${assign_doc_data1}[Entity]
    Wait Until Time    ${SHORT_WAIT}
    Assign Document Author    ${assign_doc_data}    ${USER}    ${USER_PASSWORD}
    #Validate Author Is Assigned For Document Authoring    ${assign_doc_data}    Ok
TC_19,20,21,22,23 Validate User Is Able To Add Content Library Manually & Append Content Library
    [Tags]    WF1D3
    [Documentation]    Manually generate Content library And Append Content Library.
    ${author_data}    Read TestData From Excel    TC_19    Author
    Login To VLMS 5.0 Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    Content    Document
    Wait Until Time    ${SHORT_WAIT}
    Select Frame    ${iframe.framecontent}
    Select The Task Filtered By Status    Status    Assigned    ${author_data}[Entity]
    Wait Until Time    ${SHORT_WAIT}
    Add Content Library    Generic Based    ${author_data}[Content Library Group]
    Validate Content Library Has Been Saved    ${author_data}[Message]    ${author_data}[ButtonOption]
    Select Frame    ${iframe.framecontent}
    Generate Content Library
    Wait Until Time    ${MEDIUM_WAIT}
    Append Content Library To The Document    ${DOCUMENT_NO}    ${author_data}[Tab]
    #Validate Success Message In Document Tab    ${author_data}[Message2]    ${author_data}[Button]
    Wait Until Time    ${SHORT_WAIT}
    Navigate To Page Title Tab    Content Generation
    Validate Content Library Is Highlighted In Green Colour    2
TC_37,38 Validate User Is Able To Edit Document Mapping
    [Tags]    WF1D3
    [Documentation]    select verify mapping and fix document auto mapping
    ${assign_doc_data}    Read TestData From Excel    TC_37    Assign
    Login To VLMS 5.0 Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    Content    Document
    Wait Until Time    ${SHORT_WAIT}
    Select Frame    ${iframe.framecontent}
    Select The Task Filtered By Status    Status    Assigned    ${assign_doc_data}[Entity]
    Wait Until Time    ${SHORT_WAIT}
    Navigate To Document And Click Verify Mapping    ${assign_doc_data}[AcceptMsg]    ${assign_doc_data}[PageTab]    ${AUTHOR}    ${AUTHOR_PASSWORD}
    Update Table Mapping    Fix    ${AUTHOR}    ${AUTHOR_PASSWORD}    ${assign_doc_data}[ColumnType1]    ${assign_doc_data}[ColumnType2]
    #Validate Confirmation Popup    ${EXPECTED_MSG}    ${assign_doc_data}[ButtonOption]
TC_41,42 Validate Trace Matrix
    [Tags]    WF1D1
    [Documentation]    Edit and Append Content Library To The Document, navigate to trace matrix and enter details in uncovered test cases screen
    ${author_data}    Read TestData From Excel    TC_27    Author
    Login To VLMS 5.0 Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    Content    Document
    Wait Until Time    ${SHORT_WAIT}
    Select Frame    ${iframe.framecontent}
    Select The Task Filtered By Status    Status    Assigned    ${author_data}[Entity]
    Wait Until Time    ${SHORT_WAIT}
    Navigate To Trace Matrix In Document    Author Document
    #Validate Spread View Tab Is Displayed In Trace Matrix
    #Navigate To Testing Coverage
    #Enter Details In Uncovered Test Cases    ${author_data}
    #Validate Uncovered Test Cases From Trace Matrix    ${author_data}[Y-AxisDocument]
    Click Element    ${button.document.sliderclose}
TC_24,25,28,36,44 Validate User Is Able To Add Content Library Using Decision Tree
    [Tags]    WF1D1
    [Documentation]    Add Content Library Using Decision Tree and view decision tree screen
    ${author_data}    Read TestData From Excel    TC_24    Author
    Login To VLMS 5.0 Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    Content    Document
    Wait Until Time    ${SHORT_WAIT}
    Select Frame    ${iframe.framecontent}
    Select The Task Filtered By Status    Status    Assigned    ${author_data}[Entity]
    Wait Until Time    ${SHORT_WAIT}
    Select Answers For Questions In Decision Tree In 5.0    ${author_data}[AcceptMsg]    ${author_data}[Answers] 
    Wait Until Time    ${MEDIUM_WAIT}
    Validate Delivery Type In Content Library Tab    2    Decision Tree
    Validate View Decision Tree Screen
    #Validate Document Screen Is Opened    ${DOCUMENT_NO}
    #Select Answers For Questions In Decision Tree    ${author_data}[AcceptMsg]    ${author_data}[Answers]    ${author_data}[Button]
    #Validate Notification Popup    ${author_data}[Message]    ${author_data}[ButtonOption]
    