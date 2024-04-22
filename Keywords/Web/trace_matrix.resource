*** Settings ***
Documentation     This trace matrix resource file has all the trace matrix keywords
Resource          ../../Config/super.resource

Library    CustomLibrary
Library    CustomLibrary
Library    CustomLibrary

*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Navigate To Create Trace Model Page
    [Documentation]    This Keyword is used to Navigate To Create Trace Model Page
    Menu Navigation_5.0    Content    Trace
    Click Button In VLMS    Create

Enter Trace Model Title And Select Content Types
    [Arguments]    ${trace_data}
    [Documentation]    This Keyword is used to Enter Trace Model Title And Select Content Types
    IF    'TraceModelTitle' in ${trace_data}    Enter Text In Mandatory Fields    Title    ${trace_data}[TraceModelTitle]
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.create.trace_model.header_id}    ${MEDIUM_WAIT}    Trace model header is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${trace_model_id}    Get Text    ${label.create.trace_model.header_id}
    ${TRACE_MODEL_NO}    Remove String    ${trace_model_id}    <    >
    IF    'Description' in ${trace_data}    Enter Text In Mandatory Fields    Description    ${trace_data}[Description]
    IF    'TargetDateType' in ${trace_data}
        Click Calendar    ${icon.create_trace_model.calendar}
        Select Target Date    ${trace_data}[TargetDateType]    txtTargetDt    txtTargetDt_DrpPnl_Calendar1_506    txtTargetDt_DrpPnl_Calendar1_504    ${trace_data}[Year]    ${trace_data}[Month]    ${trace_data}[Date]
    END
    IF    'SelectContentTypes' in ${trace_data}
        #@{CT}    Set Variable    ${trace_data}[SelectContentTypes]       
        @{CT}    Create List    ${trace_data}[SelectContentTypes]
        ${Contenttype}    Split String    ${trace_data}[SelectContentTypes]    |
        @{Contenttypecount}    Create List    ${Contenttype}
        ${count}    Get Length    @{Contenttypecount}    
            FOR    ${key}    IN RANGE   0    ${count}
                ${ContentType}    Set Variable    ${Contenttype}[${key}]
                Select Value From Dropdown    lstAvailbleValidationType_chosen    ${ContentType}
            END
    END
    IF    'DeselectContentTypes' in ${trace_data}   Swipe Values Between Groups    ${trace_data}[DeselectContentTypes]    lstSelectedValidationType    lstAvailbleValidationType
    IF    'ContentLibrary' in ${trace_data}    Select Value For Radio Button    TestFnReq    ${trace_data}[ContentLibrary]
    IF    'OrderButton' in ${trace_data}    Click Button In VLMS    ${trace_data}[OrderButton]
    Wait Until Time    5
    #@{SELECTED_LIST}    Get Selected List Labels    ${label.content.create.trace_model.selected_content_types}
    Set Suite Variable    @{CT}
    ${SELECTED_CT_VALUES}    Create Dictionary
    
    FOR    ${key}    IN   @{CT}
        ${label.content.create.trace_model.screen.newselected_content_types}    Update Dynamic Value    ${label.content.create.trace_model.screen.selected_content_types}    ${key}
        ${value}    Get Value    ${label.content.create.trace_model.screen.newselected_content_types}
        Set To Dictionary    ${SELECTED_CT_VALUES}    ${key}    ${value}
    END
    Set Suite Variable    ${SELECTED_CT_VALUES}
    Set Test Variable    ${TRACE_MODEL_NO}
    ${EXPECTED_MESSAGE}    Set Variable    ${trace_data}[TraceModelTitle] Trace Model ${TRACE_MODEL_NO} has been created
    RETURN    ${EXPECTED_MESSAGE}

Create Trace Model
    [Arguments]    ${trace_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Trace Model
    Wait Until Element Is Visible    ${img.content.create.trace_model}    ${LONG_WAIT}    Trace Model Image is not visible after waiting for ${LONG_WAIT} seconds
    # Log Actual And Expected Results    "Trace Model" image with check boxes as matrix structure is Displayed    "Trace Model" image with check boxes as matrix structure should be populated
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Verify Selected Content Types In Trace Model
    IF    'CheckboxList' in ${trace_data}    Select Checkboxes In Trace Model    ${trace_data}[CheckboxList]
    IF    'Approval' in ${trace_data}    Select Value For Radio Button    ApprovReq    ${trace_data}[Approval]
    IF    '${trace_data}[Approval]'=='rdoAppYes'
        IF    'Workflow' in ${trace_data}    Select Value From Dropdown    ddlWorkflow    ${trace_data}[Workflow]
    END
    IF    'Comments' in ${trace_data}    Enter Text In Mandatory Fields    Comment    ${trace_data}[Comments]
    IF    'Button' in ${trace_data}    Select Submit/Reset Button    ${trace_data}[Button]
    IF    '${trace_data}[Approval]'=='rdoAppYes'    Handle Electronic Sign    ${user_name}    ${password}    Submit

Verify Select Trace Model To Develop Screen Is Displayed
    [Documentation]    This Keyword is used to Verify "Select Trace Model to Develop" Screen is displayed or not.
    Set Suite Variable    ${TRACE_MODEL_NO}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.create.trace_model}    ${MEDIUM_WAIT}    Screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    # Log Actual And Expected Results    "Select Trace Model to Develop" Screen is displayed    "Select Trace Model to Develop" Screen should be displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Navigate To Create Bind Task Page
    [Documentation]    This Keyword is used to Navigate To Create Bind Task Page
    Navigate To Module Tab    System    Bind    Bind Task    Select Bind Task
    Click Button In VLMS    Create

Verify Selected Content Types In Trace Model
    [Documentation]    This keyword is used to Verify Selected Content Types In Trace Model
    FOR    ${key}    IN   @{SELECTED_LIST}
        ${key}    Replace String    ${key}    ${SPACE}    ^
        ${label.content.create.trace_model.image.newselected_doc_type}    Update Dynamic Value    ${label.content.create.trace_model.image.selected_doc_type}    ${key}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.create.trace_model.image.newselected_doc_type}    ${MEDIUM_WAIT}    ${key} is not visible after waiting for ${MEDIUM_WAIT} seconds
    END

Navigate To Create Trace Matrix Page
    [Documentation]    This Keyword is used to Navigate To Create Trace Matrix Page
    Menu Navigation_5.0    Content    Trace    Trace Matrix
    Wait Until Time    ${SHORT_WAIT}
    Click Button In VLMS    Create

Save Trace Matrix
    [Arguments]    ${tracematrix_data}    ${trace_model_no}
    [Documentation]    This keyword is used to enter data to Save Trace Matrix
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Trace Matrix
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Trace Matrix page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'TraceAs' in ${tracematrix_data}    Select Value For Radio Button    TraceAs    ${tracematrix_data}[TraceAs]
    Wait Until Time    3
    IF    'SelectEntity' in ${tracematrix_data}    Select Value From Table Dropdown    ${tracematrix_data}[SelectEntity]
    ${trace_matrix_id}    Get Text    ${label.create.trace_model.header_id}
    ${TRACEMATRIX_NO}    Remove String    ${trace_matrix_id}    <    >
    Set Suite Variable    ${TRACEMATRIX_NO}
    IF    'TraceModel' in ${tracematrix_data}
        Select Dropdown Value With Partial Text    select2-ddlTraceDesignList-container    ${trace_model_no}
        Verify Mapped Content Types In Trace Model
        Verify TraceModel And Document Mapping Are Populated    ${tracematrix_data}
    END
    IF    'TraceMatrixTitle' in ${tracematrix_data}
        Enter Text In Mandatory Fields    Title    ${tracematrix_data}[TraceMatrixTitle]
        ${TRACE_MATRIX_TITLE}    Set Variable    ${tracematrix_data}[TraceMatrixTitle]
        Set Suite Variable    ${TRACE_MATRIX_TITLE}
    END
    IF    'Description' in ${tracematrix_data}    Enter Comments/Description    txtDescription    ${tracematrix_data}[Description]
    IF    'TargetDate' in ${tracematrix_data}
        Click Calendar Icon In Vlms    ${button.content.create.tracematrix.calendar}
        Select Target Date    ${tracematrix_data}[TargetDate]    txtTargetDt    txtTargetDt_DrpPnl_Calendar1_506    txtTargetDt_DrpPnl_Calendar1_504    ${tracematrix_data}[Year]    ${tracematrix_data}[Month]    ${tracematrix_data}[Date]
    END
    IF   'SelectAllCheckbox' in ${tracematrix_data}    Select Checkbox    ${checkbox.content.create.tracematrix.documentmapping}
    IF    'SelectDocuments' in ${tracematrix_data}    Select Documents Under Document Mapping Grid    ${tracematrix_data}[SelectDocuments]
    IF    'SaveButton' in ${tracematrix_data}    Click Button In VLMS    ${tracematrix_data}[SaveButton]
    ${label.content.create.newtracematrix}    Update Dynamic Value    ${label.content.create.tracematrix}    ${tracematrix_data}[AlertMSgOption]
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.content.create.newtracematrix}    ${SHORT_WAIT}
    IF    '${status}'=='True'    Unselect Unmapped Documents    ${tracematrix_data}
    ${expected_msg}    Set Variable    Document Positioning for ${TRACEMATRIX_NO} trace matrix has been saved
    ${EXPECTED_MESSAGE}    Set Variable    ${expected_msg}
    Set Test Variable    ${EXPECTED_MESSAGE}

Verify TraceModel And Document Mapping Are Populated
    [Arguments]    ${tracematrix_data}
    [Documentation]    This Keyword is used to Verify populated tabs and expand link after selecting the TraceModel.
    @{tabslist}    Split String    ${tracematrix_data}[PopulatedTabs]    ,
    FOR    ${key}    IN    @{tabslist}
        ${label.content.create.tracematrix.newtabs}    Update Dynamic Value    ${label.content.create.tracematrix}    ${key}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.create.tracematrix.newtabs}    ${SHORT_WAIT}    ${key} is not displayed after waiting for ${SHORT_WAIT} seconds
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END
    ${req_docs_count}    Get Element Count    ${label.create_tracematrix.tracemodel.req_doc_rows}
    @{req_doc_list}    Create List
    FOR    ${index}    IN RANGE    1    ${req_docs_count}+1
        ${value}    Get Text    (${label.create_tracematrix.tracemodel.req_doc_rows})[${index}]//td[1]
        Append To List    ${req_doc_list}    ${value}
    END
    ${all_docs_count}    Get Element Count    ${label.create_tracematrix.tracemodel.doc_col}
    @{all_doc_list}    Create List
    FOR    ${index}    IN RANGE    1    ${all_docs_count}+1
        ${value}    Get Element Attribute    (${label.create_tracematrix.tracemodel.doc_col})[${index}]    onmouseover
        ${value}    Remove String    ${value}    RTMPlanTip(    )    '    "
        ${value1}    Replace String    ${value}    ^    ${SPACE}
        ${value1}    Replace String    ${value1}    -Content    -Content Library
        Append To List    ${all_doc_list}    ${value1}
    END
    FOR    ${key}    IN    @{req_doc_list}
        Remove Values From List    ${all_doc_list}    ${key}
    END
    @{exe_doc_list}    Copy List    ${all_doc_list}
    FOR    ${key}    IN    @{req_doc_list}
        ${icon.create_tracematrix.doc_mapping.newcontent_types}    Update Dynamic Values    ${icon.create_tracematrix.doc_mapping.content_types}    Requirement Documents    ${key}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${icon.create_tracematrix.doc_mapping.newcontent_types}    ${SHORT_WAIT}
        IF    '${status}'=='True'    Click Element    ${icon.create_tracematrix.doc_mapping.newcontent_types}
    END
    FOR    ${key}    IN    @{exe_doc_list}
        ${icon.create_tracematrix.doc_mapping.newcontent_types}    Update Dynamic Values    ${icon.create_tracematrix.doc_mapping.content_types}    Executable/Content Library Documents    ${key}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${icon.create_tracematrix.doc_mapping.newcontent_types}    ${SHORT_WAIT}
        IF    '${status}'=='True'    Click Element    ${icon.create_tracematrix.doc_mapping.newcontent_types}
    END
    # Log Actual And Expected Results   Requirement Documents and Executable/Content Library Documents are displayed     Requirement Documents and Executable/Content Library Documents are displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Unselect Unmapped Documents
    [Arguments]    ${tracematrix_data}
    [Documentation]    This key word is used to unselect the unmapped documents.
    ${label.content.create.newtracematrix}    Update Dynamic Value    ${label.content.create.tracematrix}    val1_lblErrorAlert
    ${popup_msg}    Get Text    ${label.content.create.newtracematrix}
    ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    val1_btnerrorok
    Click Element    ${button.notification.newok/cancel}
    @{msg}    Split String    ${popup_msg}    ${SPACE}
    Remove Values From List    ${msg}    Selected    documents    is    not    yet    Mapped
    FOR    ${key}    IN    @{msg}
        ${doc}    Remove String    ${key}    ,
        ${checkbox.content.create.tracematrix.new.document_unmapping}    Update Dynamic Value    ${checkbox.content.create.tracematrix.document_unmapping}    ${doc}
        Scroll Element Into View    ${button.content.save}
        Scroll Till Element Is Visible    ${checkbox.content.create.tracematrix.new.document_unmapping}
        Unselect Checkbox    ${checkbox.content.create.tracematrix.new.document_unmapping}
    END
    Click Button In VLMS    ${tracematrix_data}[SaveButton]

Verify Trace Matrix Screen Is Displayed
    [Documentation]    This keyword is used to Verify Trace Matrix screen is displayed.
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Trace Matrix
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Trace Matrix page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Select Trace Model And Select Entities
    [Arguments]    ${trace_data}    ${trace_model_no}
    [Documentation]    This Keyword is used to Select Trace Model And Select Entities
    IF    'TaskType' in ${trace_data}    Select Value For Radio Button    TaskType    ${trace_data}[TaskType]
    IF    'Bind' in ${trace_data}    Select Value From Dropdown    AssociateType    ${trace_data}[Bind]
    IF    'ActivityType' in ${trace_data}    Select Value For Radio Button    ValPlan    ${trace_data}[ActivityType]
    IF    'BindTaskName' in ${trace_data}    Enter Text In Mandatory Fields    AssociateEntityName    ${trace_data}[BindTaskName]
    IF    'TraceModel' in ${trace_data}
        Select Dropdown Value With Partial Text    DefaultTracebility    ${trace_model_no}
        Wait Until Element Is Visible    ${img.content.create.trace_model}    ${LONG_WAIT}    Trace Model Image is not visible after waiting for ${LONG_WAIT} seconds
    END
    IF    'AssociateWith' in ${trace_data}    Select Value For Radio Button    TraceFor    ${trace_data}[AssociateWith]
    IF    'Entity/EntityType' in ${trace_data}    Select Entity/Entity Type Using Filter    ${trace_data}[Entity/EntityType]

Create Bind Task
    [Arguments]    ${trace_data}    ${trace_model_no}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Bind Task
    Select Trace Model And Select Entities    ${trace_data}    ${trace_model_no}
    IF    'Entity/EntityType' in ${trace_data}    Verify Entity Table Populated With Selected Entities    ${trace_data}[Entity/EntityType]
    Wait Until Element Is Visible    ${label.create.bind_task.header_id}    ${MEDIUM_WAIT}    Bind task header is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${bind_task_id}    Get Text    ${label.create.bind_task.header_id}
    ${BIND_TASK_NO}    Remove String    ${bind_task_id}    <    >
    Set Test Variable    ${BIND_TASK_NO}
    IF    'ApprovalRequired' in ${trace_data}    Select Value For Radio Button    Approval    ${trace_data}[ApprovalRequired]
    Wait Until Time    2
    IF    'WorkFlow' in ${trace_data}    Select Value From Dropdown    WorkFlow    ${trace_data}[WorkFlow]
    IF    'RouteTaskFor' in ${trace_data}    Select Value From Dropdown    WorkflowTransfer    ${trace_data}[RouteTaskFor]
    IF    'Comments' in ${trace_data}    Enter Text In Mandatory Fields    Comment    ${trace_data}[Comments]
    IF    'Button' in ${trace_data}    Select Submit/Reset Button    ${trace_data}[Button]
    IF    'eSign' in ${trace_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    Bind Task - ${trace_data}[BindTaskName] for ${BIND_TASK_NO} has been routed for Approval
    RETURN    ${EXPECTED_MESSAGE}

Create Bind Task_Prerequisite
    [Arguments]    ${trace_data}    ${trace_model_no}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Bind Task
    Select Trace Model And Select Entities    ${trace_data}    ${trace_model_no}
    Wait Until Element Is Visible    ${label.create.bind_task.header_id}    ${MEDIUM_WAIT}    Bind task header is not visible after waiting ${MEDIUM_WAIT} seconds
    ${bind_task_id}    Get Text    ${label.create.bind_task.header_id}
    ${BIND_TASK_NO}    Remove String    ${bind_task_id}    <    >
    Set Test Variable    ${BIND_TASK_NO}
    IF    'WorkFlow' in ${trace_data}    Select Value From Dropdown    WorkFlow    ${trace_data}[WorkFlow]
    IF    'RouteTaskFor' in ${trace_data}    Select Value From Dropdown    WorkflowTransfer    ${trace_data}[RouteTaskFor]
    IF    'Comments' in ${trace_data}    Enter Text In Mandatory Fields    Comment    ${trace_data}[Comments]
    Select Submit/Reset Button    Submit
    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    Bind Task - ${trace_data}[TraceModelTitle] for ${BIND_TASK_NO} has been created
    RETURN    ${EXPECTED_MESSAGE}
Verify Entity Table Populated With Selected Entities
    [Arguments]    ${entity_list}
    [Documentation]    This keyword is used to Verify Entity Table Populated With Selected Entities
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.system.create.bind_task.selected_entity_table}    ${MEDIUM_WAIT}    Entity Table is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{list}    Split String    ${entity_list}    ,
    FOR    ${key}    IN    @{list}
        ${label.system.create.bind_task.newselected_entity}    Update Dynamic Value    ${label.system.create.bind_task.selected_entity}   ${key}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.system.create.bind_task.newselected_entity}    ${SHORT_WAIT}    Selected Entity is not visible after waiting for ${SHORT_WAIT} seconds
        # Log Actual And Expected Results    Selected ${key} is Populated in the Entity Table    Selected ${key} should be Populated in the Entity Table
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Select Bind Task Screen Is Displayed
    [Documentation]    This Keyword is used to Verify "Select Bind Task" Screen is displayed.
    Set Suite Variable    ${BIND_TASK_NO}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.system.bind.bind_task.select}    ${MEDIUM_WAIT}    Screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    # Log Actual And Expected Results    "Select Bind Task" Screen is displayed    "Select Bind Task" Screen should be displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Select And Accept The Bind Task To Approve
    [Arguments]    ${bind_task_no}    ${message}
    [Documentation]    It is used to Select And Accept the Bind Task To Approve
    Navigate To Module Tab    System    Approve    Bind Task    Select Bind Task to Approve
    Select The Section    Select Bind Task to Approve
    Search And Select The Value From The Section    ${bind_task_no}
    Wait Until Element Is Visible    ${label.system.approve.bind_task.header_id}    ${MEDIUM_WAIT}    Approve Bind task header is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Accept Button And Accept The Popup    ${message}

Verify Approve Bind Task Screen Is Displayed
    [Documentation]    It is used to Approve Bind Task Screen Is Displayed
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.system.approve.bind_task.select_task.header}    ${MEDIUM_WAIT}    Screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    # Log Actual And Expected Results    Approve Bind Task Screen Is Displayed    Approve Bind Task Screen should be Displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Approve Bind Task
    [Arguments]    ${trace_data}    ${bind_task_no}    ${user_name}    ${password}
    [Documentation]    It is used to Approve the Bind Task
    Wait Until Element Is Visible    ${label.system.approve.bind_task.header_id}    ${MEDIUM_WAIT}    Approve Bind task header is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${bindtask_id}    Get Text    ${label.system.approve.bind_task.header_id}
    ${approve_bind_task_no}    Remove String    ${bindtask_id}    <    >
    Verify String Should Be Equal    ${approve_bind_task_no}    ${bind_task_no}
    ${bindtask_name}    Get Text    ${label.system.approve.bind_task.taskname}
    IF    'Transfer' in ${trace_data}    Select Value For Radio Button    rbtntransfer    ${trace_data}[Transfer]
    IF    '${trace_data}[Transfer]'=='rbtnTransferYes'
        IF    'TransferTo' in ${trace_data}    Select Value From Dropdown    ddlTransferto    ${trace_data}[TransferTo]
    END
    IF    'Approve' in ${trace_data}    Select Value For Radio Button    ApproveReq    ${trace_data}[Approve]
    IF    'Comments' in ${trace_data}    Enter Comments/Description    txtComments    ${trace_data}[Comments]
    IF    'Button' in ${trace_data}    Select Submit/Reset Button    ${trace_data}[Button]
    IF    'eSign' in ${trace_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    ${bindtask_name} Bind Task ${approve_bind_task_no} has been approved
    RETURN    ${EXPECTED_MESSAGE}

Verify Select Bind Task To Approve Screen Is Displayed
    [Documentation]    This Keyword is used to Verify "Select Bind Task To Approve" Screen is displayed.
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.system.approve.bind_task.page_title}    ${MEDIUM_WAIT}    Screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    # Log Actual And Expected Results    "Select Bind Task To Approve" Screen is displayed    "Select Bind Task To Approve" Screen should be displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Select Trace Matrix And Verify Spread View Tab
    [Arguments]    ${tracematrix_data}
    [Documentation]    This Keyword is used to select Trace Matrix and Verify Trace View Screen is displayed with selected documents under spread view tab
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.content.create.trace_matrix.save_docs.trace_matrix}    ${MEDIUM_WAIT}    Trace Matrix button is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${selected_docs_list}    Get List Of Selected Documents Under Requirements And Executable Tabs
    Click Element    ${button.content.create.trace_matrix.save_docs.trace_matrix}
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT}
    Select Frame    ${iframe.library_frame.screen}
    Wait Till Loading Icon Is Invisible    ${label.content.author.document.trace_matrix}
    Wait Until Element Is Visible    ${label.content.create.trace_matrix.trace_view_screen}    ${MEDIUM_WAIT}    Trace View screen is not visible after waiting for ${MEDIUM_WAIT}
    Verify Spread View Tab Is Displayed In Trace Matrix
    IF    'ValidateDocuments' in ${tracematrix_data}    Run Keyword And Continue On Failure    Verify Selected Documents Displayed Under Spread View Tab    ${selected_docs_list}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    IF    'ExpandDocuments' in ${tracematrix_data}    Run Keyword And Continue On Failure    Expand Documents Under Spread View Tab And Verify Mapped References    ${tracematrix_data}[LinkNo]    ${tracematrix_data}[ExpandDocuments]
    IF    'MappedRequirements' in ${tracematrix_data}    Run Keyword And Continue On Failure    Select Trace View Tab And Verify Mapped Requirements
    Click Navigation Buttons In Screen    Close
    Verify Trace Matrix Screen Is Displayed

Create Trace Matrix
    [Arguments]    ${tracematrix_data}    ${user_name}    ${password}
    [Documentation]    It is used to Submit the Trace Matrix
    IF    'Approval' in ${tracematrix_data}    Select Value For Radio Button    ApprovReq    ${tracematrix_data}[Approval]
    IF    '${tracematrix_data}[Approval]'=='rdoAppYes'
        IF    'Workflow' in ${tracematrix_data}    Select Value From Dropdown    ddlWorkflow    ${tracematrix_data}[Workflow]
    END
    IF    'Comments' in ${tracematrix_data}    Enter Comments/Description    txtComments    ${tracematrix_data}[Comments]
    IF    'Button' in ${tracematrix_data}    Select Submit/Reset Button    ${tracematrix_data}[Button]
    IF    'eSign' in ${tracematrix_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_SUCCESSMESSAGE}    Set Variable    ${TRACE_MATRIX_TITLE} Trace Matrix ${TRACEMATRIX_NO} has been created
    RETURN    ${EXPECTED_SUCCESSMESSAGE}

Verify Select Trace Matrix To Develop Screen Is Displayed
    [Documentation]    This Keyword is used to Verify "Select Trace Matrix To Develop" Screen is displayed.
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.create.trace_matrix.screen}    ${MEDIUM_WAIT}    Screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    # Log Actual And Expected Results    "Select Trace Matrix To Develop" Screen is displayed    "Select Trace Matrix To Develop" Screen should be displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Select Checkboxes In Trace Model
    [Arguments]    ${checkbox_list}
    [Documentation]    This Keyword is used to Select Checkboxes In Trace Model and Store the selected checkboxes list
    @{MAPPED_CONTENT_TYPES}    Create List
    @{check_list}    Split String    ${checkbox_list}    |
    FOR    ${key}    IN    @{check_list}
        @{map_docs}    Split String    ${key}    &
        ${x_axis_doc}    Set Variable    ${map_docs}[0]
        ${y_axis_doc}    Set Variable    ${map_docs}[1]
        ${x_axis_doc1}    Set Variable    ${x_axis_doc}-Content Library
        IF  '${x_axis_doc1}'=='${y_axis_doc}'
            ${x_axis_value1}    Get From Dictionary    ${SELECTED_CT_VALUES}    ${x_axis_doc}
            ${id_value}    Set Variable    ${x_axis_value1}_${x_axis_value1}T
            ${checkbox.create_tracemodel.image.newcontent_type_checkbox}    Update Dynamic Value    ${checkbox.create_tracemodel.map.content_library_type}    ${id_value}
            Select Checkbox    ${checkbox.create_tracemodel.image.newcontent_type_checkbox}
            ${value}    Get Element Attribute    ${checkbox.create_tracemodel.image.newcontent_type_checkbox}    id
            Append To List    ${MAPPED_CONTENT_TYPES}    ${value}
        ELSE
            ${x_axis_value}    Get From Dictionary    ${SELECTED_CT_VALUES}    ${x_axis_doc}
            ${y_axis_value}    Get From Dictionary    ${SELECTED_CT_VALUES}    ${y_axis_doc}
            ${id_value1}    Set Variable    ${x_axis_value}_${y_axis_value}
            ${id_value2}    Set Variable    ${y_axis_value}_${x_axis_value}
            ${checkbox.create_tracemodel.image.newmapping_checkbox}    Update Dynamic Values    ${checkbox.create_tracemodel.map.content_types}    ${id_value1}    ${id_value2}
            Select Checkbox    ${checkbox.create_tracemodel.image.newmapping_checkbox}
            ${value}    Get Element Attribute    ${checkbox.create_tracemodel.image.newmapping_checkbox}    id
            Append To List    ${MAPPED_CONTENT_TYPES}    ${value}
        END
    END
    Set Suite Variable    @{MAPPED_CONTENT_TYPES}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Navigate To Initiate Content Library Page
    [Documentation]    This Keyword is used to navigate to Initiate Content Library Page
    Menu Navigation_5.0    Content    Content Library
    Click Button In VLMS    Create

Initiate Content Library
    [Arguments]    ${content_data}
    [Documentation]    This Keyword is used to Initiate Content Library
    Wait Until Element Is Visible    ${label.content.create.content_library.create.initiate_content_library}    ${MEDIUM_WAIT}    Initiate Content Library screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'ContentLibraryType' in ${content_data}    Select Value For Radio Button    TestType    ${content_data}[ContentLibraryType]
    Wait Until Time    2
    IF    '${content_data}[ContentLibraryType]'=='rbtEntity'
        IF    'TaskType' in ${content_data}    Select Value For Radio Button    rbtnlstTFnDocType    ${content_data}[TaskType]
        Wait Until Time    2
        IF    'SelectEntity' in ${content_data}    Select Value From Table Dropdown    ${content_data}[SelectEntity]
        IF    'ReferenceContentType' in ${content_data}    Select Value From Dropdown    ddlValidationType    ${content_data}[ReferenceContentType]
        IF    'RefDocNo' in ${content_data}    Select Value From Dropdown    ddlRequirement    ${content_data}[RefDocNo]
    END
    IF    '${content_data}[ContentLibraryType]'=='rbtGeneric'
        IF    'TaskType' in ${content_data}    Select Value For Radio Button    rbtnlstTFnDocType    ${content_data}[TaskType]
        IF    'ContentLibraryGroup' in ${content_data}    Select Value From Dropdown    ddlTemplateGroup    ${content_data}[ContentLibraryGroup]
    END
    IF    'Assignment' in ${content_data}    Choose Assignee Type    ${content_data}[Assignment]    ${content_data}[AssignTo]
    IF    'TargetDateType' in ${content_data}
        Click Calendar Icon In Vlms    ${icon.content.assign_doc.calendar}
        Select Target Date    ${content_data}[TargetDateType]    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${content_data}[Year]    ${content_data}[Month]    ${content_data}[Date]
    END
    IF    'Comments' in ${content_data}    Enter Text In Mandatory Fields    Comments    ${content_data}[Comments]
    IF    'Button' in ${content_data}    Select Submit/Reset Button    ${content_data}[Button]

Select Content Library Task To Author
    [Arguments]    ${value}
    [Documentation]    It is used to select Content Library Task To Author
    Select The Section    Select Content Library to Author
    ${label.content.author.content_library.select.newcontent_lib_task}    Update Dynamic Value    ${label.content.author.content_library.select.content_lib_task}    ${value}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.content.author.content_library.select.newcontent_lib_task}    ${MEDIUM_WAIT}    Content Library Task is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.content.author.content_library.select.newcontent_lib_task}

Navigate To Author Content Library Page
    [Arguments]    ${value}
    [Documentation]    This keyword will Navigate To Author Content Library Page
    Unselect Frame
    Navigate To Module Tab    Content    Author    Content Library    Select Content Library
    Select Content Library Task To Author    ${value}

# Author Content Library
#     [Arguments]    ${content_data}
#     [Documentation]    This keyword is used to Author Content Library
#     Wait Until Element Is Visible    ${label.content.author.content_library.select.content_lib_task.author}    ${LONG_WAIT}    Author Content Library screen is not visible after waiting for ${LONG_WAIT} seconds
#     Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create}    ${MEDIUM_WAIT}    Create Link is not visible after waiting for ${MEDIUM_WAIT} seconds
#     Wait Until Time    2
#     Click Element    ${link.content.author.content_library.select_task.create}
#     Wait Until Time    3
#     Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create.select_req}    ${MEDIUM_WAIT}    Select Link is not visible after waiting for ${MEDIUM_WAIT} seconds
#     IF    'SelectRequirements' in ${content_data}
#         Click Element    ${link.content.author.content_library.select_task.create.select_req}
#         Select Requirements    ${content_data}[SelectRequirements]
#     END
#     ${CONTENT_LIBRARY_NO}    Get Text    ${label.content.author.content_library.author_content_lib.content_lib_no}
#     Set Test Variable    ${CONTENT_LIBRARY_NO}
#     IF    'ContentLibraryName' in ${content_data}    Enter Text In Mandatory Fields    TestFnTitle    ${content_data}[ContentLibraryName]
#     IF    'Prefix' in ${content_data}    Enter Text In Mandatory Fields    TestFnPrefix    ${content_data}[Prefix]
#     IF    'Description' in ${content_data}    Enter Comments/Description    txtBoxDesc   ${content_data}[Description]
#     IF    'ContentLibraryStructure' in ${content_data}    Select Value From Dropdown    ddlTable    ${content_data}[ContentLibraryStructure]
#     IF    'RowDetails1' in ${content_data}
#         Wait Until Time    2
#         Wait Until Element Is Visible    ${icon.content.author.content_library.create.table.add_row}    ${MEDIUM_WAIT}    Add a row icon is not visible after waiting for ${MEDIUM_WAIT} seconds
#         Click Element    ${icon.content.author.content_library.create.table.add_row}
#         Select Requirements From Content Table And Verify Displayed Details    ${content_data}[RowNo1]    ${content_data}[ContentTableRequirements]
#         Enter Details In Content Library Table    ${content_data}[RowNo1]    ${content_data}[RowDetails1]
#     END

Select Requirements
    [Arguments]    ${table_req_list}
    [Documentation]    This keyword is used to Select Requirements in Author Content Library
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Element Is Visible    ${label.content.author.content_library.select_task.create.select_req_screen}    ${MEDIUM_WAIT}    Select Requirement screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Visible    ${dropdown.content.author.content_library.select_req.select_table}    ${MEDIUM_WAIT}    Select table dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{table_list}    Split String    ${table_req_list}    |
    FOR    ${key}    IN    @{table_list}
        @{list}    Split String    ${key}    -
        ${tableno}    Set Variable    ${list}[0]
        ${select_list}    Set Variable    ${list}[1]
        @{select_reqlist}    Split String    ${select_list}    ,
        Select From List By Label    ${dropdown.content.author.content_library.select_req.select_table}    ${tableno}
        Wait Until Time    2
        FOR    ${key}    IN    @{select_reqlist}
            ${checkbox.content.author.content_library.select_req.newselect_req_no}    Update Dynamic Value    ${checkbox.content.author.content_library.select_req.select_req_no}    ${key}
            Wait Until Element Is Visible    ${checkbox.content.author.content_library.select_req.newselect_req_no}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
            Select Checkbox    ${checkbox.content.author.content_library.select_req.newselect_req_no}
        END
    END
    Click Button In VLMS    Save
    Verify Confirmation Popup    Requirements have been saved    btnMessageOk
    Click Navigation Buttons In Screen    Close

Enter Details In Content Library Table
    [Arguments]    ${row_no}    ${details}
    [Documentation]    This keyword is used to Enter Details in Content Library Table
    ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${row_no}
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${MEDIUM_WAIT}    ${row_no} row is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{details_list}    Split String    ${details}    |
    ${col_no}    Set Variable    1
    FOR    ${key}    IN    @{details_list}
        IF    "${key}"!="None"
            Wait Until Element Is Visible    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]    ${MEDIUM_WAIT}    cell is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]
            Wait Until Time    2
            Press Keys    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]    ${key}
        END
        ${col_no}    Evaluate    ${col_no}+1
    END

# Verify Entered Details In The Content Library Grid
#     [Arguments]    ${row_no}    ${details}
#     [Documentation]    This keyword is used to Verify Entered Details In The Content Library Grid In Author Content Library Screen
#     ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${row_no}
#     Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${MEDIUM_WAIT}    ${row_no} row is not visible after waiting for ${MEDIUM_WAIT} seconds
#     @{details_list}    Split String    ${details}    |
#     ${col_no}    Set Variable    1
#     FOR    ${key}    IN    @{details_list}
#         IF    "${key}"!="None"
#             Wait Until Time    2
#             Press Keys    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]    BACKSPACE
#             ${value}    Get Element Attribute    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]/input    value
#             IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
#             Run Keyword And Continue On Failure    Should Be Equal    ${key}    ${value}
#             # Log Actual And Expected Results    ${key}    ${value}
#         END
#         ${col_no}    Evaluate    ${col_no}+1
#     END
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Select Requirements From Content Table And Verify Displayed Details
    [Arguments]    ${row_no}    ${table_with_list}
    [Documentation]    This keyword is used to Select Requirements From Content Table Reference Column and Verify displayed details in Reference cell
    Wait Until Time    2
    Press Keys    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[5]    BACKSPACE
    Wait Until Element Is Visible    (${icon.content.author.content_library.table.reference.search_icon})[${row_no}]    ${MEDIUM_WAIT}    Search icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    @{selected_requirements}    Create List
    @{table_list}    Split String    ${table_with_list}    |
    FOR    ${key}    IN    @{table_list}
        Click Element   (${icon.content.author.content_library.table.reference.search_icon})[${row_no}]
        Wait Until Element Is Visible    ${dropdown.content.author.content_library.table.reference.select_requirements}    ${MEDIUM_WAIT}    Select table dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        @{list}    Split String    ${key}    -
        ${table}    Set Variable    ${list}[0]
        ${select_req_list}    Set Variable    ${list}[1]
        @{req_list}    Split String    ${select_req_list}    ,
        Select From List By Label    ${dropdown.content.author.content_library.table.reference.select_requirements}    ${table}
        Wait Until Time    2
        FOR    ${value}    IN    @{req_list}
            ${checkbox.content.author.content_library.table.reference.newselect_requirements}    Update Dynamic Value    ${checkbox.content.author.content_library.table.reference.select_requirements}    ${value}
            Wait Until Element Is Visible    ${checkbox.content.author.content_library.table.reference.newselect_requirements}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
            Select Checkbox    ${checkbox.content.author.content_library.table.reference.newselect_requirements}
        END
        Click Element    ${button.content.author.content_library.table.search.save}
        Verify Notification Popup    Reference saved successfully    btnConfirmOk
        Click Button In VLMS    Close
        Append To List    ${selected_requirements}    @{req_list}
    END
    Log    ${selected_requirements}
    Wait Until Element Is Visible    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[4]    ${MEDIUM_WAIT}    Reference cell is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    3
    Click Element    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[4]
    Wait Until Time    1
    Press Keys    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[4]    BACKSPACE
    ${value}    Get Element Attribute    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[4]/input    value
    ${displayed_values}    Split String    ${value}    ,
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${selected_requirements}    ${displayed_values}
    # Log Actual And Expected Results    ${selected_requirements}    ${displayed_values}

Import Testcase In Author Content Library
    [Arguments]    ${content_data}
    [Documentation]    This keyword is used to Import Testcase In Author Content Library Screen
    Wait Until Time    3
    Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create.import}    ${MEDIUM_WAIT}    Import link is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${link.content.author.content_library.select_task.create.import}
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Element Is Visible    ${button.content.author.content_library.import.browse}    ${MEDIUM_WAIT}    Browse button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Choose File    ${textbox.content.author.content_library.import.fileupload}    ${SAMPLE_EXCEL_FOLDER}
    Wait Until Time    2
    Click Element    ${link.content.author.content_library.import.browse.upload}
    Wait Until Element Is Visible    ${label.content.author.content_library.import.browse.upload.tableheader}    ${MEDIUM_WAIT}    Table header is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'HeadersList' in ${content_data}
        @{header_list}    Split String    ${content_data}[HeadersList]    ,
        ${index}    Set Variable    1
        FOR    ${key}    IN    @{header_list}
            Wait Until Time    1
            Wait Until Element Is Visible    (${dropdown.content.author.content_library.import.upload.headers})[${index}]    ${MEDIUM_WAIT}    Header dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
            Select From List By Label    (${dropdown.content.author.content_library.import.upload.headers})[${index}]    ${key}
            ${index}    Evaluate    ${index}+1
        END
    END
    Click Element    ${button.content.author.content_library.import.upload.save}
    Verify Notification Popup    Do you want to append the Content ?    btnDevDiscussionAlertOk
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Insert A Row In The Content Table
    [Arguments]    ${select_row_to_insert}
    [Documentation]    This keyword is used to Insert a Row In The Content Table
    Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create.import}   ${MEDIUM_WAIT}    Import link is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${select_row_to_insert}
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${LONG_WAIT}    ${select_row_to_insert} row is not visible after waiting for ${LONG_WAIT} seconds
    Wait Until Time    2
    ${row_count_before_insert}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    Click Element    ${label.content.author.content_library.create.add_row.newrow_no}
    ${label.content.author.content_library.create.add_row.newselected_row_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.selected_row_no}    ${select_row_to_insert}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newselected_row_no}    ${MEDIUM_WAIT}    selected row is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${icon.content.author.content_library.create.table.insert_row}
    Wait Until Time    4
    ${row_count_after_insert}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    ${exp_count}    Evaluate    ${row_count_before_insert}+1
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Be Equal    ${row_count_after_insert}    ${exp_count}

Delete A Row From The Content Table
    [Arguments]    ${select_row_to_delete}
    [Documentation]    This keyword is used to Delete a Row From The Content Table
    ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${select_row_to_delete}
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${MEDIUM_WAIT}    ${select_row_to_delete} row is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    ${row_count_before_delete}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    Click Element    ${label.content.author.content_library.create.add_row.newrow_no}
    ${label.content.author.content_library.create.add_row.newselected_row_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.selected_row_no}    ${select_row_to_delete}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newselected_row_no}    ${MEDIUM_WAIT}    selected row is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${icon.content.author.content_library.create.table.delete_row}
    Wait Until Time    4
    ${row_count_after_delete}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    ${exp_count}    Evaluate    ${row_count_before_delete}-1
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Be Equal    ${row_count_after_delete}    ${exp_count}
    # Log Actual And Expected Results    Selected row is deleted from the content table    Selected row should be deleted from the content table

# Approve Content Library
#     [Arguments]    ${content_data}
#     [Documentation]    This keyword is used to Approve Content Library
#     Click Button In VLMS    Save and Complete
#     Verify Confirmation Popup    Content Library Task has been completed    btnMessageOk
#     ${checkbox.content.author.content_library.select_content_libno.newcheckbox}    Update Dynamic Value    ${checkbox.content.author.content_library.select_content_libno.checkbox}    ${CONTENT_LIBRARY_NO}
#     Wait Until Element Is Visible    ${checkbox.content.author.content_library.select_content_libno.newcheckbox}    ${MEDIUM_WAIT}    ${CONTENT_LIBRARY_NO} is not visible after waiting for ${MEDIUM_WAIT} seconds
#     Select Checkbox    ${checkbox.content.author.content_library.select_content_libno.newcheckbox}
#     ${CONTENT_LIBRARY_TASKNO}    Get Text    ${label.content.author.content_library.author_content_lib.content_lib_task_no}
#     Set Test Variable    ${CONTENT_LIBRARY_TASKNO}
#     IF    'Approval' in ${content_data}
#         Select Value For Radio Button    WorkflowReq    ${content_data}[Approval]
#         IF    '${content_data}[Approval]'=='rbtnWorkflowYes'
#             IF    'Workflow' in ${content_data}    Select Value From Dropdown    ddlWorkflow    ${content_data}[Workflow]
#             IF    'RouteTaskFor' in ${content_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${content_data}[RouteTaskFor]
#         END
#     END
#     IF    'ApproveComments' in ${content_data}    Enter Comments/Description    txtComments    ${content_data}[ApproveComments]
#     IF    'Button1' in ${content_data}    Select Submit/Reset Button    ${content_data}[Button1]
#     ${EXPECTED_MESSAGE}    Set Variable    Content Library Task ${CONTENT_LIBRARY_TASKNO}-Set-01 has been Approved
#     RETURN    ${EXPECTED_MESSAGE}

Verify Mapped Content Types In Trace Model
    [Documentation]    This Keyword is used to Verify Mapped Content Types In Trace Model Grid in Trace Matrix Screen
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${img.content.create.trace_model}    ${LONG_WAIT}    Trace Model Image is not visible after waiting for ${LONG_WAIT} seconds
    FOR    ${key}    IN   @{MAPPED_CONTENT_TYPES}
        ${checkbox.create_tracematrix.tracemodel.newselected_checkboxes}    Update Dynamic Value    ${checkbox.create_tracematrix.tracemodel.selected_checkboxes}    ${key}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${checkbox.create_tracematrix.tracemodel.newselected_checkboxes}    ${MEDIUM_WAIT}    ${key} is not visible after waiting for ${MEDIUM_WAIT} seconds
    END
    # Log Actual And Expected Results    Trace Model grid is displayed with checkboxes selected as in trace model creation    Trace Model grid should be displayed with checkboxes selected as in trace model creation
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Edit Content In The Content Library Table
    [Arguments]    ${content_data}
    [Documentation]    This Keyword is used to Import Testcase, Insert row and add content, Delete a row in the content table in Author Content Library Screen
    Import Testcase In Author Content Library    ${content_data}
    Insert A Row In The Content Table    ${content_data}[InsertRowNo]
    Enter Details In Content Library Table    ${content_data}[RowNo2]    ${content_data}[RowDetails2]
    Delete A Row From The Content Table    ${content_data}[DeleteRowNo]
    Verify Entered Details In The Content Library Grid    ${content_data}[RowNo2]    ${content_data}[RowDetails2]

Select Documents Under Document Mapping Grid
    [Arguments]    ${documents_list}
    [Documentation]    This key word is used to Select Documents Under Document Mapping Grid to create trace matrix
    Wait Until Element Is Visible    ${button.content.save}    ${MEDIUM_WAIT}    Save Draft button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Scroll Element Into View    ${button.content.save}
    @{doc_list_to_map}    Split String    ${documents_list}    ,
    FOR    ${key}    IN    @{doc_list_to_map}
        ${checkbox.content.create.tracematrix.new.document_mapping}    Update Dynamic Value    ${checkbox.content.create.tracematrix.document_unmapping}    ${key}
        Scroll Till Element Is Visible    ${checkbox.content.create.tracematrix.new.document_mapping}
        Select Checkbox    ${checkbox.content.create.tracematrix.new.document_mapping}
    END

Get List Of Selected Documents Under Requirements And Executable Tabs
    [Documentation]    This keyword is used to Get List Of Selected Documents Under Requirements And Executable Tabs in Trace Matrix Screen
    ${count}    Get Element Count    ${checkbox.content.create.trace_matrix.selected_documents}
    @{selected_docs_list}    Create List
    FOR    ${index}    IN RANGE    1    ${count}+1
        ${value}    Get Text    (${checkbox.content.create.trace_matrix.selected_documents})[${index}]
        Append To List    ${selected_docs_list}    ${value}
    END
    RETURN    ${selected_docs_list}

Verify Selected Documents Displayed Under Spread View Tab
    [Arguments]    ${selected_docs_list}
    [Documentation]    This keyword is used to Verify Selected Documents are displayed Under Spread View Tab in Trace View Screen
    @{tracematrix_docs_list}    Create List
    ${link_count}    Get Element Count    ${link.create_tracematrix.traceview.trace_dependencies.tracematrix_links}
    FOR    ${linkindex}    IN RANGE    1    ${link_count}+1
        Wait Until Element Is Visible    (${link.create_tracematrix.traceview.trace_dependencies.tracematrix_links})[${linkindex}]    ${MEDIUM_WAIT}    Link-${linkindex} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    2
        Click Element    (${link.create_tracematrix.traceview.trace_dependencies.tracematrix_links})[${linkindex}]
        Wait Until Element Is Not Visible    ${label.content.author.document.trace_matrix}    ${MEDIUM_WAIT}
        ${count}    Get Element Count    ${label.create_tracematrix.traceview_screen.spread_view.documents}
        FOR    ${index}    IN RANGE    1    ${count}+1
            ${value}    Get Text    (${label.create_tracematrix.traceview_screen.spread_view.documents})[${index}]
            Append To List    ${tracematrix_docs_list}    ${value}
        END
    END
    ${spreadview_docs_list}    Remove Duplicates    ${tracematrix_docs_list}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${spreadview_docs_list}    ${selected_docs_list}    ignore_order=True

Expand Documents Under Spread View Tab And Verify Mapped References
    # robocop: disable=too-long-keyword
    [Arguments]    ${linkname}    ${expand_documents}
    [Documentation]    This keyword is used to Expand Documents Under Spread View Tab And Verify Mapped References in Trace View Screen
    ${link.create_tracematrix.traceview.trace_dependencies.tracematrix.newspecific_link}    Update Dynamic Value    ${link.create_tracematrix.traceview.trace_dependencies.tracematrix.specific_link}    ${linkname}
    Click Element    ${link.create_tracematrix.traceview.trace_dependencies.tracematrix.newspecific_link}
    Wait Until Element Is Not Visible    ${label.content.author.document.trace_matrix}    ${MEDIUM_WAIT}
    Wait Until Time    2
    @{doc_list_to_expand}    Split String    ${expand_documents}    ,
    FOR    ${key}    IN    @{doc_list_to_expand}
        ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}    Update Dynamic Value    ${icon.create_tracematrix.traceview.spreadview_tab.doc.expand}    ${key}
        Scroll Till Element Is Visible    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}
        Click Element    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}
        Wait Till Loading Icon Is Invisible    ${label.content.author.document.trace_matrix}
    END
    ${status}    Run Keyword And Return Status     Wait Until Element Is Visible     ${label.create_tracematrix.traceview_screen.spread_view.ref_no}    ${SHORT_WAIT}
    IF    '${status}'=='False'    Run Keyword And Continue On Failure    Fail And Take Screenshot    Mapped Reference No's Not Found
    IF    '${status}'=='True'
        ${TRACEVIEW_Y_AXIS_VALUES}    Create Dictionary
        ${mapped_count}    Get Element Count    ${label.create_tracematrix.traceview_screen.spread_view.ref_no}
        @{ref_no_list}    Create List
        FOR    ${index}    IN RANGE    1    ${mapped_count}+1
            ${ref_no}    Get Text    (${label.create_tracematrix.traceview_screen.spread_view.ref_no})[${index}]
            ${text}    Get Text    (${label.create_tracematrix.traceview_screen.spread_view.y_axis_text})[${index}]
            ${number}    Get Text    (${label.create_tracematrix.traceview_screen.spread_view.y_axis_no})[${index}]
            ${value}    Set Variable    ${number}-${text}
            ${multiple_ref_status}    Run Keyword And Return Status    Should Contain    ${ref_no}    ,
            IF    '${multiple_ref_status}'=='True'
                @{multi_ref_list}    Split String    ${ref_no}    ,
                FOR    ${key}    IN   @{multi_ref_list}
                    ${key}    Strip String    ${key}
                    Append To List    ${ref_no_list}    ${key}
                    Set To Dictionary    ${TRACEVIEW_Y_AXIS_VALUES}    ${key}^R${index}    ${value}
                END
            ELSE
                Append To List    ${ref_no_list}    ${ref_no}
                Set To Dictionary    ${TRACEVIEW_Y_AXIS_VALUES}    ${ref_no}^R${index}    ${value}
            END
        END
        Log    ${TRACEVIEW_Y_AXIS_VALUES}
        Set Suite Variable    ${TRACEVIEW_Y_AXIS_VALUES}
        @{mapped_req_list}    Remove Duplicates    ${ref_no_list}
        ${TRACEVIEW_X_AXIS_VALUES}    Create Dictionary
        FOR    ${key}    IN   @{mapped_req_list}
            ${label.create_tracematrix.traceview_screen.spread_view.newx_axis_values}    Update Dynamic Value    ${label.create_tracematrix.traceview_screen.spread_view.x_axis_values}    ${key}
            ${value}    Get Value    ${label.create_tracematrix.traceview_screen.spread_view.newx_axis_values}
            Set To Dictionary    ${TRACEVIEW_X_AXIS_VALUES}    ${key}    ${value}
        END
        Log    ${TRACEVIEW_X_AXIS_VALUES}
        Set Suite Variable    ${TRACEVIEW_X_AXIS_VALUES}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Select Trace View Tab And Verify Mapped Requirements
    [Documentation]    This keyword is used to Select Trace View Tab And Verify Mapped Requirements in Trace View Screen
    Click Element    ${label.create_tracematrix.traceview_screen.traceview_tab}
    Wait Until Time    3
    Wait Until Element Is Visible    ${img.content.create.trace_model}    ${MEDIUM_WAIT}    Trace Model Image is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${traceview_y_axis_indexes}    Create Dictionary
    ${count}    Get Element Count    ${label.create_tracematrix.traceview_screen.trace_view.y_axis_elements}
    FOR    ${key}    IN   @{TRACEVIEW_Y_AXIS_VALUES}
        FOR    ${index}    IN RANGE    1    ${count}+1
            ${value}    Get From Dictionary    ${TRACEVIEW_Y_AXIS_VALUES}    ${key}
            ${expected}    Remove String    ${value}    ${SPACE}
            ${actual}    Get Element Attribute    (${label.create_tracematrix.traceview_screen.trace_view.y_axis_elements})[${index}]    onmouseover
            IF    "${actual}"!="None"
                ${actual1}    Remove String    ${actual}    ${SPACE}
                ${status}    Run Keyword And Return Status    Should Contain    ${actual1}    ${expected}    ignore_case=True
                IF    '${status}'=='True'
                    Set To Dictionary    ${traceview_y_axis_indexes}    ${key}    ${index}
                    BREAK
                END
            END
            ${index}    Evaluate    ${index}+1
        END
    END
    Log    ${traceview_y_axis_indexes}
    FOR    ${key}    IN   @{TRACEVIEW_Y_AXIS_VALUES}
        ${value1}    Get From Dictionary    ${traceview_y_axis_indexes}    ${key}
        ${value1}    Evaluate    ${value1}-1
        ${index}    Convert To String    ${value1}
        @{list}    Split String    ${key}    ^
        ${key1}    Set Variable    ${list}[0]
        ${id}    Get From Dictionary    ${TRACEVIEW_X_AXIS_VALUES}    ${key1}
        ${checkbox.create_tracematrix.create.trace_matrix.traceview_newmappedcheckboxes}    Update Dynamic Values    ${checkbox.create_tracematrix.create.trace_matrix.traceview_mappedcheckboxes}    ${id}    ${index}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${checkbox.create_tracematrix.create.trace_matrix.traceview_newmappedcheckboxes}    ${SHORT_WAIT}    Mapped Checkbox is not visible after waiting ${SHORT_WAIT} seconds
        Run Keyword And Continue On Failure    Scroll Element Into View    ${checkbox.create_tracematrix.create.trace_matrix.traceview_newmappedcheckboxes}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END
    # Log Actual And Expected Results    Mapped requirements selected for respective Documents are checked    Mapped requirements selected for respective Documents should be checked

Navigate To Trace Matrix Page
    [Arguments]    ${trace_matrix_id}
    [Documentation]    This Keyword is used to Navigate To Trace Matrix Page using Trace matrix ID
    Navigate To Module Tab    Content    Create    Trace Matrix    Select Trace Matrix to Develop
    Search And Select The Value From The Section    ${trace_matrix_id}

Create Trace Model and Bind Task
    [Arguments]    ${trace_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Trace Model
    ${TRACE_MODEL_NO}    Set Variable    ACND-DDTM-0001.01
    ${count}    Get Length    ${trace_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${dict_data}    Set Variable    ${trace_data}[${key}]
        Navigate To Create Trace Model Page
        ${EXPECTED_MESSAGE}    Enter Trace Model Title And Select Content Types    ${dict_data}
        Wait Until Element Is Visible    ${img.content.create.trace_model}    ${LONG_WAIT}    Trace Model Image is not visible after waiting ${LONG_WAIT} seconds
        Log Expected And Actual Results    "Trace Model" image with check boxes as matrix structure is Displayed    "Trace Model" image with check boxes as matrix structure should be populated
        Verify Selected Content Types In Trace Model
        IF    'CheckboxList' in ${dict_data}    Select Checkboxes In Trace Model    ${dict_data}[CheckboxList]
        IF    'Approval' in ${dict_data}    Select Value For Radio Button    ApprovReq    ${dict_data}[Approval]
        IF    '${dict_data}[Approval]'=='rdoAppYes'
            IF    'Workflow' in ${dict_data}    Select Value From Dropdown    ddlWorkflow    ${dict_data}[Workflow]
        END
        IF    'Comments' in ${dict_data}    Enter Text In Mandatory Fields    Comment    ${dict_data}[Comments]
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${user_name}    ${password}    Submit
        Verify Confirmation Popup    ${EXPECTED_MESSAGE}    btnMessageOk
        Navigate To Create Bind Task Page
        ${EXPECTED_MESSAGE}    Create Bind Task_Prerequisite    ${dict_data}    ${TRACE_MODEL_NO}    ${USER}    ${USER_PASSWORD}
        Verify Confirmation Popup    ${EXPECTED_MESSAGE}    btnMessageOk
    END

Create Trace Matrix_Prereuisite
    [Arguments]    ${tracematrix_data}    ${USER}    ${USER_PASSWORD}
    [Documentation]    This keyword is used to enter data to create Trace Matrix
    ${count}    Get Length    ${tracematrix_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${dict_data}    Set Variable    ${tracematrix_data}[${key}]
        Navigate To Create Trace Matrix Page
        ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Trace Matrix
        Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Trace Matrix page is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    'TraceAs' in ${dict_data}    Select Value For Radio Button    TraceAs    ${dict_data}[TraceAs]
        Wait Until Time    3
        IF    'SelectEntity' in ${dict_data}    Select Value From Table Dropdown    ${dict_data}[SelectEntity]
        Wait Until Time    6
        ${trace_matrix_id}    Get Text    ${label.create.trace_model.header_id}
        ${TRACEMATRIX_NO}    Remove String    ${trace_matrix_id}    <    >
        Set Test Variable    ${TRACEMATRIX_NO}
        IF    'TraceModel' in ${dict_data}
            Select Value From Dropdown    ddlTraceDesignList_chosen    ${dict_data}[TraceModel]
        END
        Wait Until Element Is Enabled    ${textarea.title.content.tracematrix}    ${LONG_WAIT}
        IF    'TraceMatrixTitle' in ${dict_data}    Enter Text In Mandatory Fields    Title    ${dict_data}[TraceMatrixTitle]
        IF    'Description' in ${dict_data}    Enter Comments/Description    txtDescription    ${dict_data}[Description]
        IF    'TargetDate' in ${dict_data}
            Click Calendar    ${button.content.create.tracematrix.calendar}
            Select Target Date    ${dict_data}[TargetDate]    txtTargetDt    txtTargetDt_DrpPnl_Calendar1_506    txtTargetDt_DrpPnl_Calendar1_504    ${dict_data}[Year]    ${dict_data}[Month]    ${dict_data}[Date]
        END
        IF   'SelectAllCheckbox' in ${dict_data}    Select Checkbox    ${checkbox.content.create.tracematrix.documentmapping}
        IF    'SelectDocuments' in ${dict_data}    Select Documents Under Document Mapping Grid    ${dict_data}[SelectDocuments]
        IF    'SaveButton' in ${dict_data}    Click Button In VLMS    ${dict_data}[SaveButton]
        ${label.content.create.newtracematrix}    Update Dynamic Value    ${label.content.create.tracematrix}    ${dict_data}[AlertMSgOption]
        # ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.content.create.newtracematrix}
        # IF    '${status}'=='True'    Unselect Unmapped Documents    ${dict_data}
        ${expected_msg}    Set Variable    Document Positioning for ${TRACEMATRIX_NO} trace matrix has been saved
        Get Value From Toast Message    ${expected_msg}
        ${EXPECTED_MESSAGE}    Set Variable    ${expected_msg}
        Set Test Variable    ${EXPECTED_MESSAGE}
        Get Value From Toast Message    ${EXPECTED_MESSAGE}
        Wait Until Element Is Visible    ${button.content.create.trace_matrix.save_docs.trace_matrix}    ${MEDIUM_WAIT}    Trace Matrix button is not visible after waiting ${MEDIUM_WAIT} seconds
        ${selected_docs_list}    Get List Of Selected Documents Under Requirements And Executable Tabs
        Click Element    ${button.content.create.trace_matrix.save_docs.trace_matrix}
        Wait Until Time    ${MEDIUM_WAIT}
        Unselect Frame
        Select Frame    ${iframe.view_icon.view_details.frame}
        Click Element    ${button.close.content.trace.tracematrix}
        Unselect Frame
        Select Frame    ${iframe.framecontent}
        ##Javascript Click    ${button.close.content.trace.tracematrix}
        #Verify Trace Matrix Screen Is Displayed
        ${EXPECTED_SUCCESSMESSAGE}    Submit Trace Matrix_Prerequisite    ${dict_data}    ${USER}    ${USER_PASSWORD}
        Get Value From Toast Message    ${EXPECTED_SUCCESSMESSAGE}
    END

Submit Trace Matrix_Prerequisite
    [Arguments]    ${tracematrix_data}    ${user_name}    ${password}
    [Documentation]    It is used to Submit the Trace Matrix
    IF    'Approval' in ${tracematrix_data}    Select Value For Radio Button    ApprovReq    ${tracematrix_data}[Approval]
    IF    '${tracematrix_data}[Approval]'=='rdoAppYes'
        IF    'Workflow' in ${tracematrix_data}    Select Value From Dropdown    ddlWorkflow    ${tracematrix_data}[Workflow]
    END
    #IF    'Comments' in ${tracematrix_data}    Enter Comments/Description    txtComments    ${tracematrix_data}[Comments]
    IF    'Button' in ${tracematrix_data}    Select Submit/Reset Button    ${tracematrix_data}[Button]
    IF    'eSign' in ${tracematrix_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_SUCCESSMESSAGE}    Set Variable    ${tracematrix_data}[TraceMatrixTitle] Trace Matrix ${TRACEMATRIX_NO} has been created
    RETURN    ${EXPECTED_SUCCESSMESSAGE}

Select Requirements From Content Table And Verify Displayed Details_Prerequisite
    [Arguments]    ${row_no}    ${table_with_list}
    [Documentation]    This keyword is used to Select Requirements From Content Table Reference Column and Verify displayed details in Reference cell
    Wait Until Element Is Visible    (${icon.content.author.content_library.table.reference.search_icon})[${row_no}]    ${MEDIUM_WAIT}    Search icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{selected_requirements}    Create List
    @{table_list}    Split String    ${table_with_list}    |
    FOR    ${key}    IN    @{table_list}
        Click Element   (${icon.content.author.content_library.table.reference.search_icon})[${row_no}]
        Wait Until Element Is Visible    ${dropdown.content.author.content_library.table.reference.select_requirements}    ${MEDIUM_WAIT}    Select table dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        @{list}    Split String    ${key}    -
        ${table}    Set Variable    ${list}[0]
        ${select_req_list}    Set Variable    ${list}[1]
        @{req_list}    Split String    ${select_req_list}    ,
        Select From List By Label    ${dropdown.content.author.content_library.table.reference.select_requirements}    ${table}
        Wait Until Time    2
        FOR    ${value}    IN    @{req_list}
            ${checkbox.content.author.content_library.table.reference.newselect_requirements}    Update Dynamic Value    ${checkbox.content.author.content_library.table.reference.select_requirements}    ${value}
            Wait Until Element Is Visible    ${checkbox.content.author.content_library.table.reference.newselect_requirements}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
            Select Checkbox    ${checkbox.content.author.content_library.table.reference.newselect_requirements}
        END
        Click Element    ${button.content.author.content_library.table.search.save}
        Verify Notification Popup    Reference saved successfully    btnConfirmOk
        Click Button In VLMS    Close
        Append To List    ${selected_requirements}    @{req_list}
    END
    Log    ${selected_requirements}
    Wait Until Element Is Visible    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[4]    ${MEDIUM_WAIT}    Reference cell is not visible after waiting for ${MEDIUM_WAIT} seconds