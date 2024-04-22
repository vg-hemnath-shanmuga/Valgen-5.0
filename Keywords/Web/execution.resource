*** Settings ***
Documentation     This execution resource file has all the execution keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Navigate To Initiate Execution Page
    [Documentation]    This keyword is used to navigate to the initiate execution page
    Get Login Username
    Get Timezone
    Navigate To Module Tab    Execution    Assign    Execution    Select Execution Task To Assign
    Click Button In VLMS    Initiate
    Wait Until Element Is Visible    ${label.execution.assign.initiate_execution}    ${MEDIUM_WAIT}    Initiate Execution page is not visible after waiting for ${MEDIUM_WAIT} seconds

Select Execution Dropdown
    [Arguments]    ${exception_data}    ${document_no}
    [Documentation]    It is used to select execution dropdown
    Unselect Frame
    Click Top Menu Icons    Refresh
    Select Frame    ${iframe.framecontent}
    IF    'Entity' in ${exception_data}    Select Value From Table Dropdown    ${exception_data}[Entity]
    IF    'ContentType' in ${exception_data}    Select Value From Dropdown    ValidationType    ${exception_data}[ContentType]
    Select Value From Dropdown    ddlMappingList    ${document_no}
    Wait Until Time    2

Enter Initiate Execution Details
    [Arguments]    ${exception_data}    ${document_no}
    [Documentation]    This keyword is used to enter details in initiate execution page
    IF    'Entity' in ${exception_data}    Select Value From Table Dropdown    ${exception_data}[Entity]
    IF    'ContentType' in ${exception_data}    Select Value From Dropdown    ValidationType    ${exception_data}[ContentType]
    ${status}    Run Keyword And Return Status    Select Value From Dropdown    ddlMappingList    ${document_no}
    IF    '${status}'=='False'    Wait Until Keyword Succeeds    4 min    ${SHORT_WAIT}    Select Execution Dropdown    ${exception_data}    ${document_no}
    Wait Until Time    2
    ${document_title}    Get Text    ${label.execution.assign.initiate.document_title}
    IF    'AssignNow' in ${exception_data}    Select Value For Radio Button    radio    ${exception_data}[AssignNow]
    Click Button In VLMS    Submit
    Wait Until Time    2
    ${INITIATE_EXECUTION_SUCCESS_MSG}    Set Variable    ${document_title} Document Execution Task has been initiated
    Set Test Variable    ${INITIATE_EXECUTION_SUCCESS_MSG}

Get Execution Task Entity
    [Documentation]    This keyword is used to get execution task entity
    ${ENTITY}    Get Text    ${label.execution.assign.entity_name}
    Set Suite Variable    ${ENTITY}
    ${entity_no}    Get Text    ${label.execution.assign.entity_no}
    ${EXECUTION_TASK_ENTITY}    Set Variable    ${ENTITY} - ${entity_no}
    Set Suite Variable    ${EXECUTION_TASK_ENTITY}

Navigate To Assign Task Execution Page
    [Arguments]    ${execution_no}
    [Documentation]    This keyword is used to navigate to assign task execution page
    Navigate To Module Tab    Execution    Assign    Execution    Select Execution Task To Assign
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Search And Select The Value From The Section    ${execution_no}

Enter Assign Execution Task Details
    [Arguments]    ${execution_data}    ${username}    ${document_no}
    [Documentation]    This keyword is used to enter details in Assign Execution Task Page
    IF    '${execution_data}[AssignNow]'=='rbtnAssignNo'
        Wait Until Time    2
        Navigate To Assign Task Execution Page    ${document_no}
    END
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.execution.assign}    ${MEDIUM_WAIT}    Assign Execution Task screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Wait Until Time    2
    ${execution_id}    Get Text    ${label.execution.assign.EXECUTION_ID}
    Set Suite Variable    ${EXECUTION_ID}
    Get Execution Task Entity
    Click Calendar Icon In Vlms    ${label.execution.assign.calendar}
    Select Custom Date From Calendar    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${execution_data}[Year]    ${execution_data}[Month]    ${execution_data}[Date]
    IF    'GroupAssignment' in ${execution_data}    Select Value For Radio Button    radio    ${execution_data}[GroupAssignment]
    IF    'EsignRequired' in ${execution_data}    Select Value For Radio Button    radio    ${execution_data}[EsignRequired]
    IF    'WorkFlow' in ${execution_data}    Select Value From Dropdown    ddWorkFlow    ${execution_data}[WorkFlow]
    IF    'AssignExecutionComment' in ${execution_data}    Enter Comments/Description    txtComments    ${execution_data}[AssignExecutionComment]
    Wait Until Time    2
    Wait Until Element Is Clickable And Click    ${button.execution.assign.submit}    10
    ${user}    Set Variable    [${username}]
    ${ASSIGN_EXECUTION_SUCCESS_MSG}    Set Variable    ${execution_data}[ContentType] document execution task ${EXECUTION_ID} for ${EXECUTION_TASK_ENTITY} has been Assigned to ${LOGIN_NAME}${user} .
    Set Test Variable    ${ASSIGN_EXECUTION_SUCCESS_MSG}

Verify Document Is Ready To Execute
    [Documentation]    It is used to verify the document is ready to execute
    Click Using Javascript    ${label.execution.execute.electronic_execution.alert}
    Search And Select The Value From The Section    ${EXECUTION_ID}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    lblreviewed    ${MEDIUM_WAIT}

Enter Task Details And Navigate To Electronic Execution
    [Arguments]    ${execution_data}
    [Documentation]    This keyword is used to enter the task details and navigate to electronic execution
    Select The Section    Electronic Execution Tasks
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Search And Select The Value From The Section    ${EXECUTION_ID}
    ${status}    Run Keyword And Return Status     Wait Until Element Is Visible    lblreviewed
    IF    '${status}'=='False'    Wait Until Keyword Succeeds    ${PDF_LOADING_TIME}    10    Verify Document Is Ready To Execute
    IF    'SplitExecution' in ${execution_data}    Select Value For Radio Button    radio    ${execution_data}[SplitExecution]
    Navigate To Page Title Tab    Electronic Execution

Enter Row No
    [Arguments]    ${row_no}
    [Documentation]    This keyword is used to enter row number
    Input Text    ${textbox.execution.execute.electronic_execution.row}    ${row_no}
    Wait Until Time    2
    Mouse Over    ${label.execution.execute.electronic_execution.go}
    Wait Until Time    2
    Click Element    ${label.execution.execute.electronic_execution.go}

Click Execution Status
    [Arguments]    ${execution_status}
    [Documentation]    This keyword is used to click execution status
    ${button.execution.execute.electronic_execution.newstatus}    Update Dynamic Value    ${button.execution.execute.electronic_execution.status}    ${execution_status}
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.execution.execute.electronic_execution.newstatus}    ${MEDIUM_WAIT}    ${execution_status} button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${button.execution.execute.electronic_execution.newstatus}    10

Enter Execution Actual Result
    [Arguments]    ${frame_locator}    ${input_locator}    ${actual_result}
    [Documentation]    This keyword is used to enter execution actual result
    Wait Until Time    2
    Select Frame    ${frame_locator}
    ${text}    Get Text    ${input_locator}
    Wait Until Time    2
    IF    '${text}'!=''    Clear Element Text    ${input_locator}
    Press Keys    ${input_locator}    ${actual_result}
    Switch To Parent Frame

Upload Image For Electronic Execution
    [Documentation]    This keyword is used to upload an image to Electronic Execution
    Wait Until Time    2
    Click Element    ${button.execution.execute.electronic_execution.image}
    Wait Until Time    2
    Print Screen
    Press Keys    mycanvas    CTRL+v
    Wait Until Time    3
    Click Button    ${button.execution.execute.electronic_execution.image_capture}

Verify Uploaded Img In Electronic Execution
    [Arguments]    ${frame_locator}
    [Documentation]    This keyword is used to Verify uploaded image to Electronic Execution under evidence
    Select Frame   ${frame_locator}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.img_evidence}    ${MEDIUM_WAIT}    Img is not uploaded under evidence after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.evidence_cross}    ${MEDIUM_WAIT}    X button is not visible under evidence after waiting for ${MEDIUM_WAIT} seconds
    ${imgs_count}    Get Element Count    ${label.execution.execute.electronic_execution.img_evidence}
    ${IMGS_NAME}    Create List
    IF    ${imgs_count}>1
        FOR    ${count}    IN RANGE    1    ${imgs_count}+1
            ${img_name}    Get Text    (${label.execution.execute.electronic_execution.img_evidence})[${count}]
            Append To List    ${IMGS_NAME}    ${img_name}
        END
    ELSE
        ${img}    Get Text    ${label.execution.execute.electronic_execution.img_evidence}
        Append To List    ${IMGS_NAME}    ${img}
    END
    Set Suite Variable    ${IMGS_NAME}
    Switch To Parent Frame
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Execute And Verify Electronic Execution
    # robocop: disable=too-long-keyword
    [Arguments]    ${login_user}    ${login_password}    ${execution_data}
    [Documentation]    This keyword is used to enter and Verify electronic execution tasks
    Wait Until Time    4
    Select Frame    ${iframe.execution.execute.electronic_execution}
    ${splitted_execution_data}    Split String    ${execution_data}[ExecutionData]    |
    ${splitted_execution_data_count}    Get Length    ${splitted_execution_data}
    FOR    ${count}    IN RANGE    0    ${splitted_execution_data_count}
        ${execution_details}    Split String    ${splitted_execution_data}[${count}]    ,
        ${row_no}    Set Variable    ${execution_details}[0]
        ${execution_status}    Set Variable    ${execution_details}[1]
        ${actual_result}    Set Variable    ${execution_details}[2]
        Enter Row No    ${row_no}
        IF    '${execution_status}'=='Pass'
            Click Execution Status    ${execution_status}
            Enter Execution Actual Result    ${iframe.execution.execute.electronic_execution.actual_result}    ${textbox.execution.execute.electronic_execution.actual_result}    ${actual_result}
            ${evidence}    Set Variable    ${execution_details}[3]
            IF    '${evidence}'=='Image'
                Wait Until Time    2
                Upload Image For Execution    ${button.execution.execute.electronic_execution.image}
                Verify Success Message    Picture Uploaded Successfully    btnimgok
                Verify Uploaded Img In Electronic Execution    ${iframe.execution.execute.electronic_execution.evidence}
            END
            Click Element    ${button.execution.execute.electronic_execution.record}
            Verify Actual Result And Pass/Fail    ${row_no}    ${actual_result}    ${execution_status}
        END
        IF    '${execution_status}'=='Fail'
            ${evidence}    Set Variable    ${execution_details}[3]
            IF    '${evidence}'=='Image'
                Wait Until Time    2
                Upload Image For Execution    ${button.execution.execute.electronic_execution.image}
                Verify Success Message    Picture Uploaded Successfully    btnimgok
                Verify Uploaded Img In Electronic Execution    ${iframe.execution.execute.electronic_execution.evidence}
            END
            IF    '${evidence}'=='File'
                Click Element    ${button.execution.execute.electronic_execution.file}
                Upload Attachment For Electronic Execution    ${execution_data}    ${execution_data}[DocumentNo]
                Verify Uploaded File In Electronic Execution    ${iframe.execution.execute.electronic_execution.evidence}    ${execution_data}[DocumentNo]
            END
            Click Execution Status    ${execution_status}
            Enter Execution Actual Result    ${iframe.execution.execute.electronic_execution.actual_result}    ${textbox.execution.execute.electronic_execution.actual_result}    ${actual_result}
            Click Element    ${button.execution.execute.electronic_execution.record}
            ${expected_fail_message}    Set Variable    Test step:${row_no} has been Failed, please initiate Deviations and execute the next step
            Set Test Variable    ${EXPECTED_FAIL_MESSAGE}
            Verify Failed Execution    ${EXPECTED_FAIL_MESSAGE}
            Enter Details In Initiate Deviations    ${execution_data}
            Submit Electronic Sign And Verify Notification Message    ${login_user}    ${login_password}    ${DEVIATION_SUCCESS_MESSAGE}
        END
    END
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    Select Frame    ${iframe.execution.execute.electronic_execution}
    Verify Success Message    No Executable Rows Remaining for Execution    btnerrok
    Wait Until Time    4

Verify Actual Result And Pass/Fail
    [Arguments]    ${row_no}    ${expected_result}    ${expected_status}
    [Documentation]    This keyword is used to Verify actual result and pass or fail text under table
    Wait Until Time    3
    ${label.execution.execute.electronic_execution.newtable_actual_result}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table_actual_result}    ${row_no}
    ${actual_result}    Get Text    ${label.execution.execute.electronic_execution.newtable_actual_result}
    ${label.execution.execute.electronic_execution.newtable_pass/fail}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table_pass/fail}    ${row_no}
    ${actual_pass/fail}    Get Text    ${label.execution.execute.electronic_execution.newtable_pass/fail}
    Verify String Should Be Equal    ${expected_result}    ${actual_result}
    Verify String Should Be Equal    ${expected_status}    ${actual_pass/fail}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Failed Execution
    [Arguments]    ${expected_fail_message}
    [Documentation]    This keyword is used to Verify failed execution task alert
    Wait Until Time    7
    ${actual_fail_message}    Get Text    ${label.execution.execute.electronic_execution.failed_message}
    Verify String Should Be Equal    ${expected_fail_message}    ${actual_fail_message}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Wait Until Time    3
    Click Button In VLMS    Initiate Exception

Enter Details In Initiate Deviations
    [Arguments]    ${exception_data}
    [Documentation]    This keyword is used to enter details in initiate deviations for failed tasks
    Unselect Frame
    Wait Until Time    3
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.deviation_no}    ${LONG_WAIT}    Deviation number is not visible after waiting for ${LONG_WAIT} seconds
    ${deviation_no}    Get Text   ${label.execution.execute.electronic_execution.deviation_no}
    Set Suite Variable    ${DEVIATION_NO}
    Wait Until Time    2
    IF    'DiscrepencyForm' in ${exception_data}    Select Value From Dropdown    ddlGroupType    ${exception_data}[DiscrepencyForm]
    Wait Until Time    6
    Wait Until Element Is Visible    ${iframe.execution.execute.electronic_execution.exception_template}    ${MEDIUM_WAIT}
    Select Frame    ${iframe.execution.execute.electronic_execution.exception_template}
    Wait Until Time    3
    IF    'ExceptionComment' in ${exception_data}    Input Text    ${textbox.execution.execute.electronic_execution.execution_template_textarea}    ${exception_data}[ExceptionComment]
    Switch To Parent Frame
    IF    'DeviationGroupAssignment' in ${exception_data}    Select Value For Radio Button    radio    ${exception_data}[DeviationGroupAssignment]
    IF    'ExceptionComment' in ${exception_data}    Enter Comments/Description    txtComments    ${exception_data}[ExceptionComment]
    Click Button In VLMS    Submit
    ${DEVIATION_SUCCESS_MESSAGE}    Set Variable    Exception ${DEVIATION_NO} has been created
    Set Test Variable    ${DEVIATION_SUCCESS_MESSAGE}

Enter Assess Exception
    [Arguments]    ${decision}    ${re_execute_row_no}=None
    [Documentation]    This keyword is used to enter assess exception details
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.execution.execute.exception.open_exception}    ${MEDIUM_WAIT}    Open Exception grid is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Click Button In VLMS    Assess
    Wait Until Element Is Visible    ${label.execution.execute.exception.exception_assessment_template}    ${MEDIUM_WAIT}    Exception Assessment Template Screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Wait Until Time    3
    IF    '${decision}'=='More Information Required'
        Select Frame    ${iframe.execution.execute.electronic_execution.exception_template}
        Input Text    ${textbox.execution.execute.electronic_execution.execution_template_textarea}    More Information Needed
        Switch To Parent Frame
        Wait Until Time    2
        Select Value From Dropdown    ddlDecision    ${decision}
        Click Button In VLMS    Submit
        ${ASSESS_EXCEPTION_MESSAGE}    Set Variable    More Information Exception Assessment for Exception ${DEVIATION_NO} has been initiated
        Set Test Variable    ${ASSESS_EXCEPTION_MESSAGE}
    END
    IF    '${decision}'=='Re-Execute' and '${re_execute_row_no}'!='None'
        Select Value From Dropdown    ddlDecision    ${decision}
        Wait Until Time    2
        Scroll Element Into View    ${textbox.execution.execute.electronic_execution.re_execution_rows}
        Input Text    ${textbox.execution.execute.electronic_execution.re_execution_rows}    ${re_execute_row_no}
        Click Button In VLMS    Submit
        ${RE_EXECUTE_EXCEPTION_MESSAGE}    Set Variable    Re-Execute Exception Assessment for Exception ${DEVIATION_NO} has been initiated
        Set Test Variable    ${RE_EXECUTE_EXCEPTION_MESSAGE}
    END

Navigate To Exception Assessment Page
    [Arguments]    ${exception_no}
    [Documentation]    This keyword is used to navigate to the exception assessment page
    Navigate To Module Tab     Execution    Execute    Exception    Exception Assessment
    Search And Select The Value From The Section    ${exception_no}

Submit Assess Exception
    [Arguments]    ${exception_data}
    [Documentation]    This keyword is used to submit assess re-execute exception
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.execution.execute.exception.open_exception}    ${MEDIUM_WAIT}    Open Exception grid is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Click Button In VLMS    Assess
    Wait Until Element Is Visible    ${label.execution.execute.exception.exception_assessment_template}    ${MEDIUM_WAIT}    Exception Assessment Template Screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Wait Until Time    1
    IF    'WorkFlow' in ${exception_data}    Select Value From Dropdown    ddWorkFlow    ${exception_data}[WorkFlow]
    Wait Until Time    3
    Scroll Till Element Is Visible    ${dropdown.execution.execute.exception.assess.route_for}
    IF    'RouteFor' in ${exception_data}    Select From List By Label    ${dropdown.execution.execute.exception.assess.route_for}    ${exception_data}[RouteFor]
    Wait Until Time    2
    IF    'Comments' in ${exception_data}    Enter Comments/Description    txtComments    ${exception_data}[Comments]
    ${RE_EXECUTE_SUCCESS_MESSAGE}    Set Variable    Re-Execute Exception Assessment for Exception ${DEVIATION_NO} has been routed for ${exception_data}[RouteFor]
    Set Test Variable    ${RE_EXECUTE_SUCCESS_MESSAGE}
    Click Button In VLMS    Submit

Enter Details In Returned Deviations Page
    [Arguments]    ${exception_data}
    [Documentation]    This keyword is used to enter all returned deviations details
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.execution.execute.returned_deviation}    ${MEDIUM_WAIT}    More Information Decision page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Click Button In VLMS    More Info
    IF    'ReturnedDeviationsComment' in ${exception_data}    Enter Comments/Description    txtComments    ${exception_data}[ReturnedDeviationsComment]
    ${MORE_INFORMATION_REQUIRED_MESSAGE}    Set Variable    More Information has been Provided for Exception ${DEVIATION_NO} for ${EXECUTION_TASK_ENTITY} .
    Set Test Variable    ${MORE_INFORMATION_REQUIRED_MESSAGE}
    Click Button In VLMS    Submit
    Wait Until Time    2

Navigate To Returned Deviations Page
    [Arguments]    ${exception_no}
    [Documentation]    This keyword is used to navigate to the returened deviations page
    Navigate To Module Tab    Execution    Execute    Returned Deviations    Deviations Returned
    Search And Select The Value From The Section    ${exception_no}

Navigate To Re-Execute Electronic Exception Page
    [Documentation]    This keyword is used to navigate to the re-execution exception page
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.deviations.re_execute}    ${MEDIUM_WAIT}    Re-Execute Exception page is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Click Element    ${dropdown.execution.execute.electronic_execution.deviations.action}
    Wait Until Time    2
    Click Button In VLMS    Re-Execute

Enter Details For Electronic Re-Execution
    [Arguments]    ${execution_data}
    [Documentation]    This keyword is used to re-execute and Verify electronic re-execution tasks
    ${splitted_execution_data}    Split String    ${execution_data}[ReExecutionData]    |
    ${splitted_execution_data_count}    Get Length    ${splitted_execution_data}
    FOR    ${count}    IN RANGE    0    ${splitted_execution_data_count}
        ${execution_details}    Split String    ${splitted_execution_data}[${count}]    ,
        ${row_no}    Set Variable    ${execution_details}[0]
        ${execution_status}    Set Variable    ${execution_details}[1]
        ${actual_result}    Set Variable    ${execution_details}[2]
        Wait Until Time    2
        Select From List By Label    ${dropdown.execution.execute.electronic_execution.row}    ${row_no}
        Click Element    ${label.execution.execute.electronic_execution.go}
        Wait Until Time    2
        Click Element    ${button.execution.execute.electronic_execution.file}
        Upload Attachment For Electronic Execution    ${execution_data}    ${execution_data}[UploadedDocument]
        Wait Until Time    3
        Run Keyword And Continue On Failure    Verify Evidence Files    ${execution_data}[UploadedDocument]    ${execution_data}[DownloadedDocument]
        Click Execution Status    ${execution_status}
        Enter Execution Actual Result    ${iframe.execution.execute.electronic_execution.actual_result}    ${textbox.execution.execute.electronic_execution.actual_result}    ${actual_result}
        Click Element    ${button.execution.execute.electronic_execution.record}
        Verify Success Message    No Executable Rows Remaining for Execution    btnerrok
        Verify Re-Executed Electronic Execution Details    ${row_no}    ${execution_data}[UploadedDocument]    ${DEVIATION_NO}    ${execution_status}
    END
    Wait Until Time    2
    Click Button In VLMS    Back
    Wait Until Time    2
    Click Button In VLMS    Submit
    Wait Until Time    2
    ${RE_EXECUTED_SUCCESS_MESSAGE}    Set Variable    Test Steps have been Re-Executed for Exception ${DEVIATION_NO} for ${EXECUTION_TASK_ENTITY} .
    Set Test Variable    ${RE_EXECUTED_SUCCESS_MESSAGE}

Verify Evidence Files
    [Arguments]    ${document_id}    ${file_name}
    [Documentation]    This keyword is used to Verify evidence files under Evidence grid
    Select Frame    ${iframe.execution.execute.electronic_execution.evidence}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.img_evidence}    ${MEDIUM_WAIT}    img label is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.execution.execute.electronic_execution.img_evidence}
    Wait Until Time    2
    Switch To Parent Frame
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.img_screenshot}    ${MEDIUM_WAIT}    img is not opened after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Click Element    ${label.execution.execute.electronic_execution.img_evidence.close}
    Select Frame    ${iframe.execution.execute.electronic_execution.evidence}
    ${label.execution.execute.electronic_execution.newfile_evidence}    Update Dynamic Value    ${label.execution.execute.electronic_execution.file_evidence}    ${document_id}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.newfile_evidence}    ${MEDIUM_WAIT}    file label is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.execution.execute.electronic_execution.newfile_evidence}
    Switch To Parent Frame
    Wait Until Time    4
    Get Downloads Folder Path
    Wait Until Keyword Succeeds    30s    2s    File Should Exist    ${DOWNLOADS_FOLDER}\\${file_name}
    Remove File    ${DOWNLOADS_FOLDER}\\${file_name}

Upload Attachment For Electronic Execution
    [Arguments]    ${exception_data}    ${document_id}
    [Documentation]    This keyword is used to upload attachment for execution
    Wait Until Time    3
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.library_frame.screen}
    IF    '${exception_data}[DocumentOption]'=='rbtnExternal'
        Select Value For Radio Button    radio    ${exception_data}[DocumentOption]
        Wait Until Time    5
        Choose File    ${textbox.execution.execute.electronic_execution.pdf.choose_file}    ${EXECDIR}\\ImportFiles\\${exception_data}[File]
        ${textbox.execution.execute.electronic_execution.pdf.newattachment_name}    Update Dynamic Value    ${textbox.execution.execute.electronic_execution.pdf.attachment_name}    ${exception_data}[File]
        Wait Until Element Is Visible    ${textbox.execution.execute.electronic_execution.pdf.newattachment_name}
        Input Text    ${textbox.execution.execute.electronic_execution.file.attachment_name}   ${document_id}
        Wait Until Time    5
        Click Button In VLMS    Upload
        Wait Until Time    3
        ${checkbox.execution.execute.electronic_execution.file.iniate_deviation.newinsert_document}    Update Dynamic Value    ${checkbox.execution.execute.electronic_execution.file.initiate_deviation.insert_document}    ${exception_data}[AttachmentName]
        Select Checkbox    ${checkbox.execution.execute.electronic_execution.file.iniate_deviation.newinsert_document}
    ELSE
        Select Value For Radio Button    radio    ${exception_data}[DocumentOption]
        Expand Tree View    trvLibMenu    ${exception_data}[TreeView]    None
        ${checkbox.execution.execute.electronic_execution.file.iniate_deviation.newdocument}    Update Dynamic Value    ${checkbox.execution.execute.electronic_execution.file.initiate_deviation.document}    ${document_id}
        Wait Until Time    3
        Wait Until Element Is Visible    ${checkbox.execution.execute.electronic_execution.file.iniate_deviation.newdocument}    ${MEDIUM_WAIT}    ${document_id} ia not visible after waiting for ${MEDIUM_WAIT} seconds
        Select Checkbox    ${checkbox.execution.execute.electronic_execution.file.iniate_deviation.newdocument}
        Click Button In VLMS    Save
        Verify Success Message    Saved Successfully    btnMessageOk
        Wait Until Time    3
        ${checkbox.execution.execute.electronic_execution.file.iniate_deviation.newinsert_document}    Update Dynamic Value    ${checkbox.execution.execute.electronic_execution.file.initiate_deviation.insert_document}    ${document_id}
        Select Checkbox    ${checkbox.execution.execute.electronic_execution.file.iniate_deviation.newinsert_document}
    END
    Click Button In VLMS    Insert
    Wait Until Time    3
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Verify Uploaded File In Electronic Execution
    [Arguments]    ${frame_locator}    ${file_name}
    [Documentation]    This keyword is used to Verify uploaded file in the electronic execution
    Select Frame    ${frame_locator}
    ${label.execution.execute.electronic_execution.newfile_evidence}    Update Dynamic Value    ${label.execution.execute.electronic_execution.file_evidence}    ${file_name}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.newfile_evidence}    ${MEDIUM_WAIT}    File is not uploded under evidence after wating ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.evidence_cross}    ${MEDIUM_WAIT}    X button is not visible under evidence after wating ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Switch To Parent Frame

Verify Re-Executed Electronic Execution Details
    [Arguments]    ${row_no}    ${document_no}    ${expected_exception_no}    ${expected_re_executed_value}
    [Documentation]    This keyword is used to Verify re-executed electronic execution details under table
    Wait Until Time    3
    ${label.execution.execute.returned_deviations.re_execute.table.newexception_no}    Update Dynamic Value    ${label.execution.execute.returned_deviations.re_execute.table.exception_no}    ${row_no}
    ${actual_exception_no}    Get Text    ${label.execution.execute.returned_deviations.re_execute.table.newexception_no}
    ${label.execution.execute.returned_deviations.re_execute.table.newre_executed_value}    Update Dynamic Values    ${label.execution.execute.returned_deviations.re_execute.table.re_executed_value}    ${row_no}    ${row_no}
    ${actual_re_executed_value}    Get Text    ${label.execution.execute.returned_deviations.re_execute.table.newre_executed_value}
    ${link.execution.execute.electronic_execution.newtable_file_evidence}    Update Dynamic Value    ${link.execution.execute.electronic_execution.table_file_evidence}    ${document_no}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${link.execution.execute.electronic_execution.newtable_file_evidence}    ${MEDIUM_WAIT}    File evidence link in table is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Page Should Contain Link    ${link.execution.execute.electronic_execution.newtable_file_evidence}
    Verify String Should Be Equal    ${expected_exception_no}    ${actual_exception_no}
    Verify String Should Be Equal    ${expected_re_executed_value}    ${actual_re_executed_value}

Navigate To Approve Exception Page
    [Arguments]    ${exception_no}
    [Documentation]    This keyword is used to navigate to the approve exception page
    Navigate To Module Tab    Execution    Approve    Exception    Select Exception To Approve
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Search And Select The Value From The Section    ${exception_no}

Approve Exception
    [Arguments]    ${exception_data}
    [Documentation]    This keyword is used to approve exception
    Click Accept Button And Accept The Popup    Approve Exception has been accepted
    Wait Until Time    2
    IF    'Approval' in ${exception_data}    Select Value For Radio Button    radio    ${exception_data}[Approval]
    Click Button In VLMS    Submit
    ${EXCEPTION_APPROVAL_MESSAGE}    Set Variable    Exception ${DEVIATION_NO} for ${EXECUTION_TASK_ENTITY} has been Approved
    Set Test Variable    ${EXCEPTION_APPROVAL_MESSAGE}

Navigate To Execute Document Page
    [Arguments]    ${execution_no}
    [Documentation]    This keyword is used to navigate to the execute document page
    Get Timezone
    Navigate To Module Tab    Execution    Execute    Electronic    Select Document to Execute
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Search And Select The Value From The Section    ${execution_no}

Enter Summary Details
    [Arguments]    ${execution_data}
    [Documentation]    This keyword is used to enter details in summary report of execution
    Click Element    btnSummary
    Wait Until Time    3
    Unselect Frame
    Select Frame    ${iframe.view_icon.view_details.frame}
    Select Frame    ${iframe.execution.execute.electronic_execution.summary.execution_summary}
    Input Text    ${textbox.execution.execute.electronic_execution.execution_template_textarea}    ${execution_data}[ExecutionSummary]
    Switch To Parent Frame
    Select Frame    ${iframe.execution.execute.electronic_execution.summary.analysis}
    Input Text    ${textbox.execution.execute.electronic_execution.execution_template_textarea}    ${execution_data}[Analysis]
    Switch To Parent Frame
    Select Frame    ${iframe.execution.execute.electronic_execution.summary.conclusion}
    Input Text    ${textbox.execution.execute.electronic_execution.execution_template_textarea}    ${execution_data}[Conclusion]
    Switch To Parent Frame

Verify Summary Report Details And Submit
    [Arguments]    ${expected_no_of_test}    ${expected_rows_executed}
    [Documentation]    Verify summary report details and submit summary report
    Wait Until Time    3
    Scroll Element Into View    ${label.execution.execute.electronic_execution.summary.metrics}
    Mouse Over    ${label.execution.execute.electronic_execution.summary.metrics}
    Wait Until Time    1
    Click Element With Offset    ${label.execution.execute.electronic_execution.summary.metrics}    -3.38    5.5
    ${actual_metrics_no_of_test}    Get Text    ${label.execution.execute.electronic_execution.summary.metrics.tool_tip}
    Wait Until Time    1
    Click Element With Offset    ${label.execution.execute.electronic_execution.summary.metrics}    -18.18    5.5
    ${actual_metrics_rows_executed}    Get Text    ${label.execution.execute.electronic_execution.summary.metrics.tool_tip}
    Scroll To Element    ${label.execution.execute.electronic_execution.summary.table.tests_executed}
    ${actual_table_no_of_test}    Get Text    ${label.execution.execute.electronic_execution.summary.table.no_of_tests}
    ${actual_table_rows_executed}    Get Text    ${label.execution.execute.electronic_execution.summary.table.tests_executed}
    Verify String Should Be Equal    ${expected_no_of_test}    ${actual_table_no_of_test}
    Verify String Should Contain    ${expected_no_of_test}    ${actual_metrics_no_of_test}
    Verify String Should Be Equal    ${expected_rows_executed}    ${actual_table_rows_executed}
    Verify String Should Contain    ${expected_rows_executed}    ${actual_metrics_rows_executed}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${EXECUTION_SUMMARY_MESSAGE}    Set Variable    Execution Summary Report has been Saved
    Set Test Variable    ${EXECUTION_SUMMARY_MESSAGE}
    Click Button In VLMS    Submit
    Verify Success Message    ${EXECUTION_SUMMARY_MESSAGE}    btnClosediv
    # Verify Confirmation Popup    ${EXECUTION_SUMMARY_MESSAGE}    btnClosediv
    Unselect Frame
    Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}
    Select Frame    ${iframe.framecontent}

Verify Textbox Limit
    [Arguments]    ${comment}    ${permissible_limit}
    [Documentation]    Verify textbox limit by getting tooltip text
    Wait Until Time    2
    ${comment_text_length}    Get Length    ${comment}
    ${expected_comment_text_length}    Set Variable    ${comment_text_length}/${permissible_limit}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.comment.tool_tip}    ${MEDIUM_WAIT}    Comments tool tip text is not visible after waiting for ${MEDIUM_WAIT}seconds
    ${actual_comment_text_length}    Get Text    ${label.execution.execute.electronic_execution.comment.tool_tip}
    Verify String Should Contain    ${expected_comment_text_length}    ${actual_comment_text_length}

Route The Execution To Approval/Review
    [Arguments]    ${execution_data}
    [Documentation]    This keyword to used to route the execution to approval
    Wait Until Time    3
    Wait Until Element Is Visible    ${checkbox.execution.execute.electronic_execution.confirm_routing}    ${MEDIUM_WAIT}    Confirm routing checkbox is not visible after waiting for ${MEDIUM_WAIT}seconds
    Select Checkbox    ${checkbox.execution.execute.electronic_execution.confirm_routing}
    IF    'RouteFor' in ${execution_data}    Select Value From Dropdown    ddlRoute    ${execution_data}[RouteFor]
    IF    'Comments' in ${execution_data}    Input Text    ${textbox.execution.execute.electronic_execution.approval.comment}    ${execution_data}[Comments]
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Verify Textbox Limit    ${execution_data}[Comments]    1000
    Click Button In VLMS    Submit
    ${EXECUTION_SUCCESS_MESSAGE}    Set Variable    Operational Qualification execution ${EXECUTION_ID} for ${EXECUTION_TASK_ENTITY} has been routed for ${execution_data}[RouteFor]
    Set Test Variable    ${EXECUTION_SUCCESS_MESSAGE}

Get Document Details
    [Arguments]    ${document_no}
    [Documentation]    Get document details from task list in home page
    Click Top Menu Icons    Home
    Search Task Under My Task List    ${document_no}
    Wait Until Time    3
    ${ACTUAL_ACTIVITY}    Get Text    ${label.home.search.document.activity}
    Set Test Variable    ${ACTUAL_ACTIVITY}
    ${ACTUAL_SITE}    Get Text    ${label.home.search.document.site}
    Set Test Variable    ${ACTUAL_SITE}
    ${ACTUAL_TASK_DETAILS}    Get Text By Using Javascript    ${label.home.search.document.task}
    Set Test Variable    ${ACTUAL_TASK_DETAILS}
    ${ACTUAL_ASSIGNED_ON}    Get Text    ${label.home.search.document.assigned_on}
    Set Test Variable    ${ACTUAL_ASSIGNED_ON}
    ${ACTUAL_TARGET_DATE}    Get Text    ${label.home.search.document.target_date}
    Set Test Variable    ${ACTUAL_TARGET_DATE}

Verify Tooltip Details Of Task List Data
    [Arguments]    ${task_no}
    [Documentation]    Verify document tool tip details from my task list
    Get Document Details    ${task_no}
    ${label.home.my_task.newcontent}    Update Dynamic Value    ${label.home.my_task.content}    ${task_no}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.home.my_task.newcontent}    ${MEDIUM_WAIT}    ${task_no} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Mouse Over    ${label.home.my_task.newcontent}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${label.home.search.document.tool_tip.newactivity}    Update Dynamic Value    ${label.home.search.document.tool_tip.activity}    ${ACTUAL_ACTIVITY}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.home.search.document.tool_tip.newactivity}    ${MEDIUM_WAIT}    activity is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${label.home.search.document.tool_tip.newsite}    Update Dynamic Value    ${label.home.search.document.tool_tip.site}    ${ACTUAL_SITE}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.home.search.document.tool_tip.newsite}    ${MEDIUM_WAIT}    Site is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${expected_task_details}    Get Text    ${label.home.search.document.tool_tip.task}
    Verify String Should Be Equal    ${expected_task_details}    ${actual_task_details}
    ${label.home.search.document.tool_tip.newassigned_on}    Update Dynamic Value    ${label.home.search.document.tool_tip.assigned_on}    ${ACTUAL_ASSIGNED_ON}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.home.search.document.tool_tip.newassigned_on}    ${MEDIUM_WAIT}    Assigned on is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${label.home.search.document.tool_tip.newtarget_date}    Update Dynamic Value    ${label.home.search.document.tool_tip.target_date}    ${ACTUAL_TARGET_DATE}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.home.search.document.tool_tip.newtarget_date}    ${MEDIUM_WAIT}    Target date is not visible after waiting for ${MEDIUM_WAIT} seconds

Select Chart
    [Arguments]    ${layout_no}    ${charts}
    [Documentation]    This keyword is used to select the chart to generate chart
    ${splitted_charts}    Split String    ${charts}    ,
    ${chart_length}    Get Length    ${splitted_charts}
    ${chart_length}    Convert To Integer    ${chart_length}
    ${layout_no}    Convert To Integer    ${layout_no}
    IF    ${chart_length}==${layout_no}
        FOR    ${chart}    IN RANGE    0    ${chart_length}
            ${label.home.dashboard.newchart_type}    Update Dynamic Value    ${label.home.dashboard.chart_type}    ${splitted_charts}[${chart}]
            Drag And Drop    ${label.home.dashboard.newchart_type}    ${label.home.dashboard.selected_charts}
        END
    ELSE
        Run Keyword And Continue On Failure    Fail And Take Screenshot    Chart length ${chart_length} is not equal to layout number ${layout_no}
    END

Select Layout
    [Arguments]    ${layout}
    [Documentation]    This keyword is used to select layout to generate charts
    Select Frame    ${iframe.framecontent}
    Click Element    ${button.home.dashboard.settings}
    IF    '${layout}'=='1'
        ${layout_no}    Set Variable    1
        ${label.home.dashboard.chart.newlayout}    Update Dynamic Value    ${label.home.dashboard.chart.layout}    ${layout}
        Click Element    ${label.home.dashboard.chart.newlayout}
    ELSE IF    '${layout}'=='2' or '${layout}'=='2a' or '${layout}'=='2b'
        ${layout_no}    Set Variable    2
        ${label.home.dashboard.chart.newlayout}    Update Dynamic Value    ${label.home.dashboard.chart.layout}    ${layout}
        Click Element    ${label.home.dashboard.chart.newlayout}
    ELSE IF    '${layout}'=='3' or '${layout}'=='3a' or '${layout}'=='3b' or '${layout}'=='3c'
        ${layout_no}    Set Variable    3
        ${label.home.dashboard.chart.newlayout}    Update Dynamic Value    ${label.home.dashboard.chart.layout}    ${layout}
        Click Element    ${label.home.dashboard.chart.newlayout}
    ELSE IF    '${layout}'=='4'
        ${layout_no}    Set Variable    4
        ${label.home.dashboard.chart.newlayout}    Update Dynamic Value    ${label.home.dashboard.chart.layout}    ${layout}
        Click Element    ${label.home.dashboard.chart.newlayout}
    END
    RETURN    ${layout_no}

Generate Chart
    [Arguments]    ${layout}    ${chart}
    [Documentation]    This keyword is used to generate charts
    Unselect Frame
    Navigate To Dashboard Title Tabs    Dashboard
    ${layout_no}    Select Layout    ${layout}
    Wait Until Time    4
    Select Chart    ${layout_no}    ${chart}
    Click Button    ${button.home.dashboard.chart.generate}
    Wait Until Element Is Visible    ${label.home.dashboard.chart}    ${MEDIUM_WAIT}    Chart is not visible after waiting for ${MEDIUM_WAIT} seconds

Navigate To Execution Approval Document
    [Arguments]    ${expected_execution_id}
    [Documentation]    This keyword is used to  navigate to the execution approval view document page
    Wait Until Time    3
    Click Element    ${label.home.dashboard.chart.approver}
    Wait Until Time    3
    Click Element    ${label.home.dashboard.chart.execution_approval}
    Unselect Frame
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.home.document.chart.wip.execution_approval}    ${MEDIUM_WAIT}    Execution Approval screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${label.home.document.chart.newexecution_id}    Update Dynamic Value    ${label.home.document.chart.view_document.execution_id}    ${expected_execution_id}
    Click Element    ${label.home.document.chart.newexecution_id}
    Wait Until Element Is Visible    ${label.home.document.chart.execution.view_document}    ${MEDIUM_WAIT}    View Document screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.home.document.chart.execution.view_document}
    Wait Until Time    3
    Click Element    ${label.home.document.chart.execution.view_document.pre_execution_approval}

Verify Execution Approval Document Results
    [Arguments]    ${expected_execution_id}    ${expected_execution_results}
    [Documentation]    This keyword is used to Verify execution approval document result details
    Wait Until Time    2
    Scroll Down In Document    6
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${splitted_execution_results}    Split String    ${expected_execution_results}    ,
    ${execution_results_count}    Get Length    ${splitted_execution_results}
    ${id's}    Create List    13    40
    FOR    ${key}    IN RANGE    0   ${execution_results_count}
        ${label.home.document.chart.execution.view_document.newresult}    Update Dynamic Value    ${label.home.document.chart.execution.view_document.result}    ${id's}[${key}]
        ${actual_text}    Get Text    ${label.home.document.chart.execution.view_document.newresult}
        Verify String Should Be Equal    ${splitted_execution_results}[${key}]    ${actual_text}
    END
    Switch To Parent Frame
    Navigate To Page Title Tab    Accept Approve Execution Task Details
    ${actual_execution_id}    Get Text    ${label.home.document.chart.execution._id}
    Verify String Should Be Equal    ${expected_execution_id}    ${actual_execution_id}
    Unselect Frame
    Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}

Navigate To Approve Execution Page
    [Arguments]    ${execution_no}
    [Documentation]    This keyword is used to navigate to the approve execution page
    Navigate To Module Tab    Execution    Approve    Execution    Select Execution to Approve
    Search And Select The Value From The Section    ${execution_no}

Navigate To Review Execution Page
    [Arguments]    ${exception_no}
    [Documentation]    This keyword is used to navigate to the review execution page
    Navigate To Module Tab    Execution    Review    Execution    Select Execution to Review
    Search And Select The Value From The Section    ${exception_no}

Approve Execution
    [Arguments]    ${execution_data}    ${message}    ${page_title_tab}
    [Documentation]    This keyword is used to approve execution
    Click Accept Button And Accept The Popup    ${message}
    Wait Until Time    3
    Navigate To Page Title Tab    ${page_title_tab}
    Select Value For Radio Button    radio    ${execution_data}[Approval]
    Click Button In VLMS    Submit
    ${EXECUTION_APPROVAL_MESSAGE}    Set Variable    Operational Qualification execution ${EXECUTION_ID} for ${EXECUTION_TASK_ENTITY} has been Approved
    Set Test Variable    ${EXECUTION_APPROVAL_MESSAGE}

Upload Image For Execution
    [Arguments]    ${locator}
    [Documentation]    This keyword is used to upload img for execution
    Wait Until Element Is Visible    ${locator}
    Wait Until Time    2
    Click Element     ${locator}
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.execution.execute.electronic_execution.capture_screenshot}
    Click Element    ${button.execution.execute.electronic_execution.capture_screenshot}
    Wait Until Time    2
    Click Element    ${button.execution.execute.electronic_execution.test_screensnap}
    Wait Until Element Is Not Visible    ${label.execution.execute.electronic_execution.test_img_screenshot}    ${MEDIUM_WAIT}    Captured screenshot is not visible after waiting for ${MEDIUM_WAIT} seconds

Enter Actual Results In Excel
    [Arguments]    ${actual_result1}    ${actual_result2}
    [Documentation]    It is used to enter actual resuls for Excel execution file
    Click Element    ${label.execution.execute.electronic_execution.actual_result1}
    Enter Execution Actual Result    ${iframe.execution.execute.electronic_execution.actual_result1}    ${textbox.execution.execute.electronic_execution.actual_result1}    ${actual_result1}
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.actual_result2}
    Click Element    ${label.execution.execute.electronic_execution.actual_result2}
    Enter Execution Actual Result    ${iframe.execution.execute.electronic_execution.actual_result}    ${textbox.execution.execute.electronic_execution.actual_result1}    ${actual_result2}

Execute Excel Document In Electronic Execution
    [Arguments]    ${login_user}    ${login_password}    ${no_of_rows}    ${excel_details}
    [Documentation]    It is used to execute the excel document in electronic execution page
    Select Frame    ${iframe.execution.execute.electronic_execution}
    ${excel_details}    Set Variable    ${excel_details}
    ${splitted_excel_to_row_details}    Split String    ${excel_details}    |
    ${excel_to_row_details}    Set Variable    ${splitted_excel_to_row_details}
    FOR    ${row_no}    IN RANGE    1    ${no_of_rows}
        ${updated_row_no}    Evaluate    ${row_no}-1
        ${key1}    Evaluate    ${row_no}+1
        ${row_details}    Set Variable    ${excel_to_row_details}[${updated_row_no}]
        ${splitted_updated_excel_details}    Split String    ${row_details}    ,
        ${actual_result1}    Set Variable    ${splitted_updated_excel_details}[0]
        ${actual_result2}    Set Variable    ${splitted_updated_excel_details}[1]
        Enter Row No    ${row_no}
        Wait Until Time    1
        Upload Image For Execution    ${button.execution.execute.electronic_execution.test.excel_image}
        Verify Success Message    Picture Uploaded Successfully    btnimgok
        Enter Actual Results In Excel    ${actual_result1}    ${actual_result2}
        Wait Until Time    1
        Wait Until Element Is Visible    ${button.execution.execute.electronic_execution.record}
        Click Element    ${button.execution.execute.electronic_execution.record}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${textbox.electronic_sign.user}
        IF    '${status}'=='True'
            Handle Electronic Sign    ${login_user}    ${login_password}    Submit
            Verify Success Message    No Executable Rows Remaining for Execution    btnerrok
            Wait Until Time    1
        END
        Verify Excel Execution    ${login_user}    ${key1}    ${row_details}    Pass
    END
    Switch To Parent Frame
    Navigate To Page Title Tab    Task Details

Verify Actual Results In Excel
    [Arguments]    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    [Documentation]    It is used to verify the excel file actual results
    ${row_no}    Convert To String    ${row_no}
    ${label.execution.execute.electronic_execution.table.newactual_result1}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.actual_result1}    ${row_no}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.newactual_result1}
    ${actual_actual_result1}    Get Text    ${label.execution.execute.electronic_execution.table.newactual_result1}
    Verify String Should Be Equal    ${expected_actual_result1}    ${actual_actual_result1}
    ${label.execution.execute.electronic_execution.table.newactual_result2}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.actual_result2}    ${row_no}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.newactual_result2}
    ${actual_actual_result2}    Get Text    ${label.execution.execute.electronic_execution.table.newactual_result2}
    Verify String Should Be Equal    ${expected_actual_result2}    ${actual_actual_result2}

Verify Sum Of Actual Results
    [Arguments]    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    [Documentation]    It is used to verify the sum of excel file actual results
    ${row_no}    Convert To String    ${row_no}
    ${sum_of_actual_results}    Evaluate    ${expected_actual_result1}+${expected_actual_result2}
    ${sum_of_actual_results}    Convert To Number    ${sum_of_actual_results}
    ${label.execution.execute.electronic_execution.table.newactual_result}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.actual_result}    ${row_no}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.newactual_result}
    ${actual_actual_result1}    Get Text    ${label.execution.execute.electronic_execution.table.newactual_result}
    ${actual_actual_result1}    Convert To Number    ${actual_actual_result1}
    Verify String Should Be Equal    ${sum_of_actual_results}    ${actual_actual_result1}

Verify Max Value Of Actual Results
    [Arguments]    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    [Documentation]    It used to verify the max of actual result of excel file
    ${row_no}    Convert To String    ${row_no}
    IF    ${expected_actual_result1}>${expected_actual_result2}
        ${max_num}    Set Variable    ${expected_actual_result1}
        ${max_num}    Convert To Number    ${max_num}
    ELSE
        ${max_num}    Set Variable    ${expected_actual_result2}
        ${max_num}    Convert To Number    ${max_num}
    END
    ${label.execution.execute.electronic_execution.table.newactual_result}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.actual_result}    ${row_no}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.newactual_result}
    ${actual_actual_result1}    Get Text    ${label.execution.execute.electronic_execution.table.newactual_result}
    ${actual_actual_result1}    Convert To Number   ${actual_actual_result1}
    Verify String Should Be Equal    ${max_num}    ${actual_actual_result1}

Verify Avg Value Of Actual Results
    [Arguments]    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    [Documentation]    It used to verify the avg of actual result of excel file
    ${row_no}    Convert To String    ${row_no}
    ${sum_of_actual_results}    Evaluate    ${expected_actual_result1}+${expected_actual_result2}
    ${avg_result}    Evaluate    ${sum_of_actual_results}/2
    ${label.execution.execute.electronic_execution.table.newactual_result}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.actual_result}    ${row_no}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.newactual_result}
    ${actual_actual_result1}    Get Text    ${label.execution.execute.electronic_execution.table.newactual_result}
    ${actual_actual_result1}    Convert To Number    ${actual_actual_result1}
    Verify String Should Be Equal    ${avg_result}    ${actual_actual_result1}

Verify Result Values
    [Arguments]    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    [Documentation]    It is used to verify the excel result values
    ${updated_row}    Evaluate    ${row_no}-1
    IF    ${updated_row}==1 or ${updated_row}==4
        Verify Sum Of Actual Results    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    ELSE IF    ${updated_row}==2 or ${updated_row}==5
        Verify Max Value Of Actual Results    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    ELSE IF    ${updated_row}==3 or ${updated_row}==6
        Verify Avg Value Of Actual Results    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    END

Verify Pass/Fail And Comments
    [Arguments]    ${row_no}    ${username}    ${status}
    [Documentation]    It is used to verify the status of excel file
    ${time}    Get Current Date    result_format=%d/%m/%Y
    ${user}    Set Variable    (${username})
    ${executed_by}    Set Variable    ${LOGIN_NAME} ${user}- ${time}
    ${row_no}    Convert To String    ${row_no}
    ${label.execution.execute.electronic_execution.table.newpass_fail}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.pass_fail}    ${row_no}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.newpass_fail}
    ${actual_pass/fail}    Get Text    ${label.execution.execute.electronic_execution.table.newpass_fail}
    Verify String Should Contain    ${executed_by}    ${actual_pass/fail}
    Verify String Should Contain    ${status}    ${actual_pass/fail}
    Verify String Should Contain    IST    ${actual_pass/fail}
    ${label.execution.execute.electronic_execution.table.newcomments}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.comments}    ${row_no}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.newcomments}
    ${actual_comments}    Get Text    ${label.execution.execute.electronic_execution.table.newcomments}
    Verify String Should Contain    No Comments    ${actual_comments}
    Verify String Should Contain    ${executed_by}    ${actual_comments}

Verify Excel Execution
    [Arguments]    ${username}    ${row_no}    ${excel_details}    ${status}
    [Documentation]    Verify all the execution details of excel file
    ${excel_details}    Set Variable    ${excel_details}
    ${splitted_excel_details}    Split String    ${excel_details}    ,
    ${expected_actual_result1}    Set Variable    ${splitted_excel_details}[0]
    ${expected_actual_result2}    Set Variable    ${splitted_excel_details}[1]
    Wait Until Time    3
    Verify Actual Results In Excel    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    Verify Result Values    ${row_no}    ${expected_actual_result1}    ${expected_actual_result2}
    Verify Pass/Fail And Comments    ${row_no}    ${username}    ${status}
    ${row_no}    Convert To String    ${row_no}
    ${label.execution.execute.electronic_execution.table.newimage}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.image}    ${row_no}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.newimage}
    ${actual_image}    Get Text    ${label.execution.execute.electronic_execution.table.newimage}
    ${link.execution.execute.electronic_execution.table.newimage}    Update Dynamic Value    ${link.execution.execute.electronic_execution.table.image}    ${actual_image}
    IF   '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Page Should Contain Link    ${link.execution.execute.electronic_execution.table.newimage}

Upload Evidence
    [Arguments]    ${evidence}    ${execution_data}    ${downloaded_file}=None
    [Documentation]    It is used to upload the evidence and verify the uploaded file under evidence
    IF    '${evidence}'=='Image'
        Wait Until Element Is Visible    ${button.execution.execute.electronic_execution.test.pdf_image}
        Upload Image For Execution    ${button.execution.execute.electronic_execution.test.pdf_image}
        Verify Success Message    Picture Uploaded Successfully    btnimgok
        Verify Uploaded Img In Electronic Execution    ${iframe.execution.execute.electronic_execution.test.pdf_evidence}
    ELSE IF    '${evidence}'=='File' and '${downloaded_file}'!='None'
        Click Element    ${button.execution.execute.electronic_execution.test.pdf_file}
        Upload Attachment For Electronic Execution    ${execution_data}    ${downloaded_file}
        Select Frame    ${iframe.execution.execute.electronic_execution}
        Verify Uploaded File In Electronic Execution    ${iframe.execution.execute.electronic_execution.test.pdf_evidence}    ${downloaded_file}
    ELSE IF    '${evidence}'=='Image&File' and '${downloaded_file}'!='None'
        Wait Until Element Is Visible    ${button.execution.execute.electronic_execution.test.pdf_image}
        Upload Image For Execution    ${button.execution.execute.electronic_execution.test.pdf_image}
        Verify Success Message    Picture Uploaded Successfully    btnimgok
        Verify Uploaded Img In Electronic Execution    ${iframe.execution.execute.electronic_execution.test.pdf_evidence}
        Click Element    ${button.execution.execute.electronic_execution.test.pdf_file}
        Upload Attachment For Electronic Execution    ${execution_data}    ${downloaded_file}
        Verify Uploaded File In Electronic Execution    ${iframe.execution.execute.electronic_execution.test.pdf_evidence}    ${downloaded_file}
    END

Verify PDF Table Cell Textbox Values
    [Arguments]    ${content_author_data}
    [Documentation]    It is used to verify the pdf table textbox values
    ${textbox_properties}    Set Variable    ${content_author_data}[TextboxProperties]
    ${splitted_textbox_properties}    Split String    ${textbox_properties}    ,
    ${splitted_textbox_properties_count}    Get Length    ${splitted_textbox_properties}
    FOR    ${textbox_property}    IN RANGE    0    ${splitted_textbox_properties_count}-1
        Wait Until Time    1
        ${updated_key}    Evaluate    (${textbox_property}+1)
        IF    ${textbox_property}>5
            ${updated_key}    Evaluate    ${updated_key}+1
        END
        ${updated_key}    Convert To String    ${updated_key}
        ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    Update Dynamic Value    ${textbox.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
        Verify Execution Table Tooltip Text    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    ${splitted_textbox_properties}[${textbox_property}]
        Wait Until Time    1
    END

Verify PDF Image Evidence
    [Documentation]    It is used to verify the PDF evidence
    ${imgs_count}    Get Length   ${IMGS_NAME}
    FOR    ${key}    IN RANGE    0    ${imgs_count}
        ${link.execution.execute.electronic_execution.table.cell.newimage}    Update Dynamic Value    ${link.execution.execute.electronic_execution.table.cell.image}    ${IMGS_NAME}[${key}]
        Wait Until Time    1
        Wait Until Element Is Visible    ${link.execution.execute.electronic_execution.table.cell.newimage}
        Javascript Click    ${link.execution.execute.electronic_execution.table.cell.newimage}
        Wait Until Time    2
        ${img}    Remove String    ${IMGS_NAME}[${key}]    ]
        ${splitted_uploaded_image}    Split String    ${img}    _
        ${image_name}    Set Variable    ${splitted_uploaded_image}[1]_${splitted_uploaded_image}[2]_${splitted_uploaded_image}[3]
        ${windows_tiles}    Get Window Handles
        Switch Window    ${windows_tiles}[1]
        ${label.execution.execute.electronic_execution.table.cell.newimage}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.cell.image}    ${image_name}
        ${img_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.cell.newimage}
        Wait Until Time    1
        IF    '${img_status}'=='True'    Close Window
        Switch Window    ${windows_tiles}[0]
        Select Frame    ${iframe.framecontent}
        Select Frame    ${iframe.execution.execute.electronic_execution}
        Wait Until Time    1
    END

Verify PDF Table Cell Dropdown Values
    [Arguments]    ${content_author_data}    ${column_types}
    [Documentation]    It is used to verify the pdf table dropdown values
    Select Frame    ${iframe.execution.execute.electronic_execution}
    Wait Until Time    3
    Click Element    ${label.execution.execute.electronic_execution.pdf_document}
    Scroll Down In Document    10
    ${column_types}    Set Variable    ${column_types}
    ${splitted_column_types}    Split String    ${column_types}    ,
    ${splitted_column_types_count}    Get Length    ${splitted_column_types}
    ${dropdown_textbox_properties}    Set Variable    ${content_author_data}[DropdownTextboxProperties]
    ${splitted_dropdown_textbox_properties}    Split String    ${dropdown_textbox_properties}    ,
    ${splitted_dropdown_textbox_properties_count}    Get Length    ${splitted_dropdown_textbox_properties}
    FOR    ${dropdown_textbox_property}    IN RANGE    1    ${splitted_dropdown_textbox_properties_count}+1
        ${key}    Evaluate    ${dropdown_textbox_property}-1
        ${updated_key}    Evaluate    ${dropdown_textbox_property}*${splitted_column_types_count}
        ${updated_key}    Convert To String    ${updated_key}
        Wait Until Time    1
        ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}    Update Dynamic Value    ${dropdown.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
        Wait Until Element Is Visible    ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}
        Verify Execution Table Tooltip Text    ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}    ${splitted_dropdown_textbox_properties}[${key}]
        Wait Until Time    1
    END

Verify Execution Table Tooltip Text
    [Arguments]    ${locator}    ${expected_value}
    [Documentation]    It is used to verify the execution table cell tooltip values
    Set Focus To Element    ${locator}
    Wait Until Time    1
    Mouse Over    ${locator}
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.cell.tooltip}
    ${actual_cell_tooltip_value}    Get Text    ${label.execution.execute.electronic_execution.table.cell.tooltip}
    Verify String Should Contain    ${expected_value}    ${actual_cell_tooltip_value}
    Wait Until Time    1

Verify PDF Textbox Execution Details
    [Arguments]    ${row_no}    ${column_types}    ${username}    ${actual_result}    ${textbox_evidence}    ${downloaded_file}
    [Documentation]    It is used to verify the pdf textbox execution
    ${column_types}    Set Variable    ${column_types}
    ${splitted_column_types}    Split String    ${column_types}    ,
    ${splitted_column_types_count}    Get Length    ${splitted_column_types}
    FOR    ${key}    IN RANGE    0    ${splitted_column_types_count}
        Wait Until Time    1
        ${updated_key}    Evaluate    (${key}+1)
        IF    '${splitted_column_types}[${key}]'=='Textbox Executable'
            IF    ${row_no}>1
                ${updated_row_no}    Evaluate    ${row_no}-1
                ${updated_key}    Evaluate    (${updated_row_no}+1)*(${splitted_column_types_count}-1)+1
            END
            ${time}    Get Current Date    result_format=%d/%m/%Y
            ${user}    Set Variable    (${username})
            ${time_zone}    Set Variable    (${TIME_ZONE})
            ${executed_by}    Set Variable    ${LOGIN_NAME} ${user}- ${time}
            ${updated_key}    Convert To String    ${updated_key}
            ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    Update Dynamic Value    ${textbox.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
            Verify Execution Table Tooltip Text    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    ${actual_result}
            Verify Execution Table Tooltip Text    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    ${executed_by}
            Verify Execution Table Tooltip Text    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    ${time}
            Verify Execution Table Tooltip Text    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    ${time_zone}
            IF     '${textbox_evidence}'!='None' and '${textbox_evidence}'=='Image'
                Verify PDF Image Evidence
            ELSE IF    '${downloaded_file}'!='None' and '${textbox_evidence}'=='File'
                ${link.execution.execute.electronic_execution.table.cell.newfile}    Update Dynamic Value    ${link.execution.execute.electronic_execution.table.cell.image}    ${downloaded_file}
                IF   '${SCREENSHOT}'=='True'    Capture Allure Screenshot
                Run Keyword And Continue On Failure    Page Should Contain Link    ${link.execution.execute.electronic_execution.table.cell.newfile}
            END
        END
    END

Verify PDF Dropdown Execution Details
    [Arguments]    ${row_no}    ${column_types}    ${username}    ${Status}    ${dropdown_evidence}    ${downloaded_file}
    [Documentation]    It is used to verify the PDF dropdown execution
    ${column_types}    Set Variable    ${column_types}
    ${splitted_column_types}    Split String    ${column_types}    ,
    ${splitted_column_types_count}    Get Length    ${splitted_column_types}
    FOR    ${key}    IN RANGE    0    ${splitted_column_types_count}
        Wait Until Time    1
        ${updated_key}    Evaluate    (${key}+1)
        ${updated_key}    Convert To String    ${updated_key}
        IF    '${splitted_column_types}[${key}]'=='Dropdown Result'
            ${time}    Get Current Date    result_format=%d/%m/%Y
            ${user}    Set Variable    (${username})
            IF    ${row_no}>1
                ${updated_row_no}    Evaluate    ${row_no}-1
                ${updated_key}    Evaluate    (${updated_row_no}+1)*(${splitted_column_types_count})
                ${updated_key}    Convert To String    ${updated_key}
            END
            ${executed_by}    Set Variable    ${LOGIN_NAME} ${user}- ${time}
            ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}    Update Dynamic Value    ${dropdown.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
            Verify Execution Table Tooltip Text    ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}    ${Status}
            Verify Execution Table Tooltip Text    ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}    ${executed_by}
            Verify Execution Table Tooltip Text    ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}    ${time}
            IF     '${dropdown_evidence}'!='None' and '${dropdown_evidence}'=='Image'
                Verify PDF Image Evidence
            ELSE IF    '${downloaded_file}'!='None' and '${dropdown_evidence}'=='File'
                ${link.execution.execute.electronic_execution.table.cell.newfile}    Update Dynamic Value    ${link.execution.execute.electronic_execution.table.cell.image}    ${downloaded_file}
                IF   '${SCREENSHOT}'=='True'    Capture Allure Screenshot
                Run Keyword And Continue On Failure    Page Should Contain Link    ${link.execution.execute.electronic_execution.table.cell.newfile}
            END
        END
    END

Verify Img PDF Links
    [Documentation]    It is used to verify the image links in view history
    ${imgs_count}    Get Length   ${IMGS_NAME}
    FOR    ${key}    IN RANGE    0    ${imgs_count}
        ${link.execution.execute.electronic_execution.table.cell.newimg}    Update Dynamic Value    ${link.execution.execute.electronic_execution.table.cell.image}    ${IMGS_NAME}[${key}]
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${link.execution.execute.electronic_execution.table.cell.newimg}
        Run Keyword And Continue On Failure    Page Should Contain Link    ${link.execution.execute.electronic_execution.table.cell.newimg}
    END

Enter PDF Execution Details
    # robocop: disable=too-long-keyword
    [Arguments]    ${login_user}    ${login_password}    ${execution_data}    ${column_types}    ${document_id}
    [Documentation]    It is used to enter and verify PDF execution
    ${pdf_details}    Set Variable    ${execution_data}[PDFExecutionDetails]
    ${splitted_excel_to_row_details}    Split String    ${pdf_details}    |
    ${excel_to_row_details}    Set Variable    ${splitted_excel_to_row_details}
    FOR    ${row_no}    IN RANGE    1    ${execution_data}[NoOfRows]+1
        ${updated_row_no}    Evaluate    ${row_no}-1
        ${row_details}    Set Variable    ${excel_to_row_details}[${updated_row_no}]
        ${splitted_updated_excel_details}    Split String    ${row_details}    ,
        ${actual_result}    Set Variable    ${splitted_updated_excel_details}[0]
        ${Status}    Set Variable    ${splitted_updated_excel_details}[1]
        ${textbox_evidence}    Set Variable    ${splitted_updated_excel_details}[2]
        ${dropdown_evidence}    Set Variable    ${splitted_updated_excel_details}[3]
        ${edit}    Set Variable    ${splitted_updated_excel_details}[4]
        ${column_types}    Set Variable    ${column_types}
        ${splitted_column_types}    Split String    ${column_types}    ,
        ${splitted_column_types_count}    Get Length    ${splitted_column_types}
        FOR    ${key}    IN RANGE    0    ${splitted_column_types_count}
            ${updated_key}    Evaluate    (${key}+1)
            Wait Until Time    1
            IF    '${splitted_column_types}[${key}]'=='Textbox Executable'
                IF    ${row_no}>1
                    ${updated_key}    Evaluate    (${updated_row_no}+1)*(${splitted_column_types_count}-1)+1
                END
                ${updated_key}    Convert To String    ${updated_key}
                ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    Update Dynamic Value    ${textbox.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
                Scroll Element Into View    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}
                Click Element    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}
                IF    '${textbox_evidence}'!='None'    Upload Evidence    ${textbox_evidence}    ${execution_data}    ${document_id}
                Scroll Element Into View    (${textbox.execution.execute.electronic_execution.pdf.actual_result})[1]
                Wait Until Time    1
                Input Text    (${textbox.execution.execute.electronic_execution.pdf.actual_result})[1]    ${actual_result}
            ELSE IF    '${splitted_column_types}[${key}]'=='Dropdown Result'
                IF    ${row_no}>1
                    ${updated_key}    Evaluate    (${updated_row_no}+1)*(${splitted_column_types_count})
                END
                ${updated_key}    Convert To String    ${updated_key}
                Wait Until Time    1
                ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}    Update Dynamic Value    ${dropdown.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
                Double Click Element    ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}
                Scroll Element Into View    (${textbox.execution.execute.electronic_execution.pdf.actual_result})[1]
                IF    '${dropdown_evidence}'!='None'    Upload Evidence    ${dropdown_evidence}    ${execution_data}    ${document_id}
                Input Text    (${textbox.execution.execute.electronic_execution.pdf.actual_result})[1]    ${actual_result}
                ${dropdown.execution.execute.electronic_execution.pdf.newresult}    Update Dynamic Value    ${dropdown.execution.execute.electronic_execution.pdf.result}    ${updated_key}
                Select From List By Label   ${dropdown.execution.execute.electronic_execution.pdf.newresult}    ${Status}
            END
        END
        Click Element    ${button.execution.execute.electronic_execution.test.pdf_record}
        Handle Execution Electronic Sign    ${login_user}    ${login_password}
        Verify PDF Dropdown Execution Details    ${row_no}    ${column_types}    ${login_user}    ${Status}    ${dropdown_evidence}    ${document_id}
        Verify PDF Textbox Execution Details    ${row_no}    ${column_types}    ${login_user}    ${actual_result}    ${textbox_evidence}    ${document_id}
        IF    '${edit}'=='Yes'
            Edit PDF Cells    ${TEST_USER}    ${TEST_PASSWORD}    ${execution_data}    ${column_types}    ${execution_data}[AttachmentName]
        END
    END
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    Navigate To Page Title Tab    Task Details

Edit PDF Cells
    # robocop: disable=too-long-keyword
    [Arguments]    ${login_user}    ${login_password}    ${execution_data}    ${column_types}    ${document_id}
    [Documentation]    It is used to edit the PDF execution
    ${pdf_details}    Set Variable    ${execution_data}[EditExecutionDetails]
    ${splitted_excel_to_row_details}    Split String    ${pdf_details}    |
    ${excel_to_row_details}    Set Variable    ${splitted_excel_to_row_details}
    FOR    ${row_no}    IN RANGE    1    ${execution_data}[EditNoOfRows]+1
        ${updated_row_no}    Evaluate    ${row_no}-1
        ${row_details}    Set Variable    ${excel_to_row_details}[${updated_row_no}]
        ${splitted_updated_excel_details}    Split String    ${row_details}    ,
        ${actual_result}    Set Variable    ${splitted_updated_excel_details}[0]
        ${Status}    Set Variable    ${splitted_updated_excel_details}[1]
        ${textbox_evidence}    Set Variable    ${splitted_updated_excel_details}[2]
        ${dropdown_evidence}    Set Variable    ${splitted_updated_excel_details}[3]
        ${reason_for_edit}    Set Variable    ${splitted_updated_excel_details}[4]
        ${column_types}    Set Variable    ${column_types}
        ${splitted_column_types}    Split String    ${column_types}    ,
        ${splitted_column_types_count}    Get Length    ${splitted_column_types}
        FOR    ${key}    IN RANGE    0    ${splitted_column_types_count}
            ${updated_key}    Evaluate    (${key}+1)
            Wait Until Time    1
            IF    '${splitted_column_types}[${key}]'=='Textbox Executable'
                IF    ${row_no}>1
                    ${updated_key}    Evaluate    (${updated_row_no}+1)*(${splitted_column_types_count}-1)
                END
                ${updated_key}    Convert To String    ${updated_key}
                ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    Update Dynamic Value    ${textbox.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
                Scroll Element Into View    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}
                Click Element    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}
                Scroll Element Into View    (${textbox.execution.execute.electronic_execution.pdf.actual_result})[1]
                Click Element    (${textbox.execution.execute.electronic_execution.pdf.edit_actual_result})[6]
                IF    '${textbox_evidence}'!='None'    Upload Evidence    ${textbox_evidence}    ${execution_data}    ${document_id}
                Scroll Element Into View    (${textbox.execution.execute.electronic_execution.pdf.actual_result})[1]
                Input Text    (${textbox.execution.execute.electronic_execution.pdf.actual_result})[1]    ${reason_for_edit}
                Input Text    (${textbox.execution.execute.electronic_execution.pdf.edit_actual_result})[6]    ${actual_result}
                Modify Format And Verify History Of Textbox    ${actual_result}
                Click Element    ${button.execution.execute.electronic_execution.test.pdf_submit}
                Handle Execution Electronic Sign    ${login_user}    ${login_password}
                Open And Verify Textbox Edit History    ${row_no}    ${column_types}    ${login_user}    ${actual_result}    ${reason_for_edit}    ${textbox_evidence}    ${document_id}
            ELSE IF    '${splitted_column_types}[${key}]'=='Dropdown Result'
                IF    ${row_no}>1
                    ${updated_key}    Evaluate    (${updated_row_no}+1)*(${splitted_column_types_count})
                END
                Wait Until Time    1
                ${updated_key}    Convert To String    ${updated_key}
                ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}    Update Dynamic Value    ${dropdown.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
                Double Click Element    ${dropdown.execution.execute.electronic_execution.pdf.table.newcell}
                IF    '${dropdown_evidence}'!='None'    Upload Evidence    ${dropdown_evidence}    ${execution_data}    ${document_id}
                Scroll Element Into View    (${textbox.execution.execute.electronic_execution.pdf.actual_result})[1]
                Input Text    (${textbox.execution.execute.electronic_execution.pdf.actual_result})[1]    ${reason_for_edit}
                ${dropdown.execution.execute.electronic_execution.pdf.newresult}    Update Dynamic Value    ${dropdown.execution.execute.electronic_execution.pdf.result}    ${updated_key}
                Select From List By Label   ${dropdown.execution.execute.electronic_execution.pdf.newresult}    ${Status}
                Click Element    ${button.execution.execute.electronic_execution.test.pdf_submit}
                Handle Execution Electronic Sign    ${login_user}    ${login_password}
                Open And Verify Dropdown Edit History    ${row_no}    ${column_types}    ${login_user}    ${reason_for_edit}    ${dropdown_evidence}    ${document_id}
            END
        END
    END

Open And Verify Textbox Edit History
    [Arguments]    ${row_no}    ${column_types}    ${username}    ${actual_result}    ${expected_reason_for_edit}    ${textbox_evidence}    ${document_id}
    [Documentation]    It is used to open and verify the result column history
    ${column_types}    Set Variable    ${column_types}
    ${splitted_column_types}    Split String    ${column_types}    ,
    ${splitted_column_types_count}    Get Length    ${splitted_column_types}
    FOR    ${key}    IN RANGE    0    ${splitted_column_types_count}
        ${updated_key}    Evaluate    (${key}+1)
        Wait Until Time    2
        IF    '${splitted_column_types}[${key}]'=='Textbox Executable'
            IF    ${row_no}>1
                ${updated_row_no}    Evaluate    ${row_no}-1
                ${updated_key}    Evaluate    (${updated_row_no}+1)*(${splitted_column_types_count}-1)
            END
            ${updated_key}    Convert To String    ${updated_key}
            ${textbox.execution.execute.electronic_execution.pdf.table.newcell}    Update Dynamic Value    ${textbox.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
            Double Click Element    ${textbox.execution.execute.electronic_execution.pdf.table.newcell}
            Click Element    ${label.execution.execute.electronic_execution.pdf.actual_result.three_dot}
            Wait Until Time    2
            Scroll Element Into View    ${label.execution.execute.electronic_execution.pdf.actual_result.three_dot}
            Javascript Click    ${label.execution.execute.electronic_execution.pdf.actual_result.view_history}
            Wait Until Time    2
            ${updated_row_no}    Evaluate    ${row_no}+2
            ${updated_row_no}    Convert To String    ${updated_row_no}
            Verify Textbox History    ${username}    ${actual_result}    ${expected_reason_for_edit}    ${textbox_evidence}    ${updated_row_no}    ${document_id}
            Click Element    id=A1
        END
    END

Verify Textbox History
    [Arguments]    ${username}    ${actual_result}    ${expected_reason_for_edit}    ${textbox_evidence}    ${row_no}    ${document_id}
    [Documentation]    It is used to verify the textbox result column history details
    ${row_no}    Convert To String    ${row_no}
    ${label.execution.execute.electronic_execution.pdf.result.newhistory}    Update Dynamic Value    ${label.execution.execute.electronic_execution.pdf.result.history}    ${row_no}
    ${history}    Get Text    ${label.execution.execute.electronic_execution.pdf.result.newhistory}
    ${label.execution.execute.electronic_execution.pdf.result.newreason_for_edit}    Update Dynamic Value    ${label.execution.execute.electronic_execution.pdf.result.reason_for_edit}    ${row_no}
    ${actual_reason_for_edit}    Get Text    ${label.execution.execute.electronic_execution.pdf.result.newreason_for_edit}
    ${time}    Get Current Date    result_format=%d/%m/%Y
    ${user}    Set Variable    (${username})
    ${time_zone}    Set Variable    (${TIME_ZONE})
    ${executed_by}    Set Variable    ${LOGIN_NAME} ${user}- ${time}
    Verify String Should Contain    ${actual_result}    ${history}
    Verify String Should Contain    ${executed_by}    ${history}
    Verify String Should Contain    ${time}    ${history}
    Verify String Should Contain    ${time_zone}    ${history}
    Verify String Should Contain    ${expected_reason_for_edit}    ${actual_reason_for_edit}
    ${label.execution.execute.electronic_execution.table.cell.newbold}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.cell.bold}    ${actual_result}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.cell.newbold}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.cell.align_center}
    IF     '${textbox_evidence}'!='None' and '${textbox_evidence}'=='Image'
        Verify Img PDF Links
    ELSE IF    '${textbox_evidence}'!='None' and '${textbox_evidence}'=='File'
        ${link.execution.execute.electronic_execution.table.cell.newfile}    Update Dynamic Value    ${link.execution.execute.electronic_execution.table.cell.image}    ${document_id}
        IF   '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        Run Keyword And Continue On Failure    Page Should Contain Link    ${link.execution.execute.electronic_execution.table.cell.newfile}
    END

Verify Dropdown History
    [Arguments]    ${username}    ${expected_reason_for_edit}    ${dropdown_evidence}    ${row_no}    ${document_id}
    [Documentation]    It is used to verify the dropdown result column history details
    ${row_no}    Convert To String    ${row_no}
    ${label.execution.execute.electronic_execution.pdf.result.newhistory}    Update Dynamic Value    ${label.execution.execute.electronic_execution.pdf.result.history}    ${row_no}
    ${history}    Get Text    ${label.execution.execute.electronic_execution.pdf.result.newhistory}
    ${time}    Get Current Date    result_format=%d/%m/%Y
    ${user}    Set Variable    (${username})
    ${time_zone}    Set Variable    (${TIME_ZONE})
    ${executed_by}    Set Variable    ${LOGIN_NAME} ${user}- ${time}
    ${label.execution.execute.electronic_execution.pdf.result.newreason_for_edit}    Update Dynamic Value    ${label.execution.execute.electronic_execution.pdf.result.reason_for_edit}    ${row_no}
    ${actual_reason_for_edit}    Get Text    ${label.execution.execute.electronic_execution.pdf.result.newreason_for_edit}
    Verify String Should Contain    ${executed_by}    ${history}
    Verify String Should Contain    ${time}    ${history}
    Verify String Should Contain    ${time_zone}    ${history}
    Verify String Should Contain    ${expected_reason_for_edit}    ${actual_reason_for_edit}
    IF     '${dropdown_evidence}'!='None' and '${dropdown_evidence}'=='Image'
        Verify Img PDF Links
    ELSE IF    '${dropdown_evidence}'!='None' and '${dropdown_evidence}'=='File'
        ${link.execution.execute.electronic_execution.table.cell.newfile}    Update Dynamic Value    ${link.execution.execute.electronic_execution.table.cell.image}    ${document_id}
        IF   '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        Run Keyword And Continue On Failure    Page Should Contain Link    ${link.execution.execute.electronic_execution.table.cell.newfile}
    END

Open And Verify Dropdown Edit History
    [Arguments]    ${row_no}    ${column_types}    ${username}    ${expected_reason_for_edit}    ${dropdown_evidence}    ${document_id}
    [Documentation]    It is used to open and verify result column history
    ${column_types}    Set Variable    ${column_types}
    ${splitted_column_types}    Split String    ${column_types}    ,
    ${splitted_column_types_count}    Get Length    ${splitted_column_types}
    FOR    ${key}    IN RANGE    0    ${splitted_column_types_count}
        ${updated_key}    Evaluate    (${key}+1)
        Wait Until Time    2
        IF    '${splitted_column_types}[${key}]'=='Dropdown Result'
            IF    ${row_no}>1
                ${updated_key}    Evaluate    (${row_no})*(${splitted_column_types_count}-1)
            END
            ${updated_key}    Convert To String    ${updated_key}
            ${dropdown.execution.execute.electronic_execution.pdf.table.cell}    Update Dynamic Value    ${dropdown.execution.execute.electronic_execution.pdf.table.cell}    ${updated_key}
            Double Click Element    ${dropdown.execution.execute.electronic_execution.pdf.table.cell}
            Click Element    ${label.execution.execute.electronic_execution.pdf.result.three_dot}
            Click Button In VLMS    View History
            Wait Until Time    2
            ${updated_row_no}    Evaluate    ${row_no}+3
            ${updated_row_no}    Convert To String    ${updated_row_no}
            Verify Dropdown History    ${username}    ${expected_reason_for_edit}    ${dropdown_evidence}    ${updated_row_no}    ${document_id}
            Click Element    id=A1
        END
    END

Modify Format And Verify History Of Textbox
    [Arguments]    ${actual_result}
    [Documentation]    It is used to modify and verify the actual result column
    Wait Until Time    3
    ${label.execution.execute.electronic_execution.pdf.actual_result.newbold}    Update Dynamic Value    ${label.execution.execute.electronic_execution.pdf.actual_result.bold}    ${actual_result}
    Press Keys    ${label.execution.execute.electronic_execution.pdf.actual_result.newbold}    CONTROL+a
    Click Element    ${button.execution.execute.electronic_execution.table.cell.bold}
    ${label.execution.execute.electronic_execution.table.cell.newbold}    Update Dynamic Value    ${label.execution.execute.electronic_execution.table.cell.bold}    ${actual_result}
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.cell.newbold}    ${MEDIUM_WAIT}
    Click Element    ${label.execution.execute.electronic_execution.pdf.actual_result.three_dot}
    Wait Until Time    2
    Scroll Element Into View    ${label.execution.execute.electronic_execution.pdf.actual_result.three_dot}
    Javascript Click    ${label.execution.execute.electronic_execution.pdf.actual_result.align_center}
    Wait Until Time    2
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.execution.execute.electronic_execution.table.cell.align_center}

Verify Execution Id In Control Flow Page
    [Arguments]    ${exe_no}    ${content_author_data}
    [Documentation]    It is used to verify the execution id in content flow
    Click Top Menu Icons    Home
    Navigate To Dashboard Title Tabs    Content Flow
    Select Frame    ${iframe.framecontent}
    IF    'Entity' in ${content_author_data}
        Select Value From Table Dropdown    ${content_author_data}[Entity]
    END
    Scroll Element Into View    ${label.home.content_flow.execution}
    ${splitted_exe_no}    Split String    ${exe_no}    .
    ${updated_exe.no}    Set Variable    ${splitted_exe_no}[0].${splitted_exe_no}[1]
    ${link.home.content_flow.newexecution_id}    Update Dynamic Value    ${link.home.content_flow.execution_id}    ${updated_exe.no}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${link.home.content_flow.newexecution_id}    ${MEDIUM_WAIT}
    Click Element    ${link.home.content_flow.newexecution_id}
