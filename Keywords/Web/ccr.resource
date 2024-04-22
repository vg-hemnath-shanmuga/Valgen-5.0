*** Settings ***
Documentation     This CCR resource file has all the CCR keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Navigate To Initiate CCR Page
    [Documentation]    This keyword is used to navigate to the initiate CCR page
    Unselect Frame
    Navigate To Module Tab    Change    Initiate    CCR    Select Initiated CCR    True
    Click Button In VLMS    Initiate CCR

Enter Pre-requisite Details In Initiate CCR
    [Arguments]    ${ccr_data}
    [Documentation]    This keyword is used to enter pre-requisite details in initiate ccr page
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Initiate CCR
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Initiate CCR page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'ChangeControl' in ${ccr_data}    Select Value For Radio Button    Mode    ${ccr_data}[ChangeControl]
    IF    'LevelofChange' in ${ccr_data}    Select Value For Radio Button    LevelofChange    ${ccr_data}[LevelofChange]
    Wait Until Time    3
    IF    'Summary' in ${ccr_data}    Enter Text In Mandatory Fields    ChangeDesc    ${ccr_data}[Summary]
    IF    'Justification' in ${ccr_data}    Enter Text In Mandatory Fields    Justification    ${ccr_data}[Justification]
    IF    'TypeOfChange' in ${ccr_data}
        Select Value From Dropdown    select2-ddlCodeType-container    ${ccr_data}[TypeOfChange]
        Verify CCR Number Is Displayed
    END
    Wait Until Time    2
    IF   'ChangeType' in ${ccr_data}    Select Value From Dropdown    select2-ddlChangeType-container    ${ccr_data}[ChangeType]
    Wait Until Time    4
    IF   'ClosureDate' in ${ccr_data}
        Click Calendar Icon In Vlms    ${button.content.initiate.ccr.calendar}
        Select Target Date    ${ccr_data}[ClosureDate]    txtBoxClosureDate    txtBoxClosureDate_DrpPnl_Calendar1_506    txtBoxClosureDate_DrpPnl_Calendar1_504    ${ccr_data}[Year]    ${ccr_data}[Month]    ${ccr_data}[Date]
    END
    IF   'Priority' in ${ccr_data}    Select Value From Dropdown    select2-ddlPriority-container    ${ccr_data}[Priority]
    IF   'Severity' in ${ccr_data}    Select Value For Radio Button    severity    ${ccr_data}[Severity]
    IF   'FunctionalGroup' in ${ccr_data}    Select Value From Dropdown    select2-ddlFnGroup-container    ${ccr_data}[FunctionalGroup]
    IF    'Entity' in ${ccr_data}
        Select Entity/Entity Type Using Filter    ${ccr_data}[Entity]
        Wait Until Time    2
        Verify Entity Details In Selected Entity Fields    ${ccr_data}[Entity]
    END
    IF    'Button' in ${ccr_data}
        ${button.newsubmit/reset}    Update Dynamic Value    ${button.submit/reset}    ${ccr_data}[Button]
        Javascript Click    ${button.newsubmit/reset}
        Wait Until Time    2
        Verify Select Document/Content Library Dropdown Status
    END
    Wait Until Time    3

Verify CCR Number Is Displayed
    [Documentation]    This Keyword is used to Verify ccr number is displayed after selecting the change type as new.
    ${label.change.initiate.newccrno}    Update Dynamic Value    ${label.content.create.tracematrix}    lblChangeNoValue
    Wait Until Element Is Visible    ${label.change.initiate.newccrno}    ${MEDIUM_WAIT}    CCR NO. is not displayed after waiting for ${MEDIUM_WAIT} sec
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${CCR_NO}    Get Text    ${label.change.initiate.newccrno}
    Set Test Variable    ${CCR_NO}
    ${actual_result}    Set Variable    ${CCR_NO} is displayed
    ${expected_result}    Set Variable    ${CCR_NO} should be displayed
    # Log Actual And Expected Results    ${actual_result}    ${expected_result}

Verify Entity Details In Selected Entity Fields
    [Arguments]    ${entity_name}
    [Documentation]    This keyword is used to Verify entity details after selecting the entity from list.
    ${label.ccr.newselectedentity}    Update Dynamic Value    ${label.ccr.selectedentity}    ${entity_name}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.ccr.newselectedentity}    ${MEDIUM_WAIT}    ${entity_name} is not displayed after waiting for ${MEDIUM_WAIT} sec
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${actual_result}    Set Variable    Selected ${entity_name} details are displayed
    ${expected_result}    Set Variable    Selected ${entity_name} details should be displayed
    # Log Actual And Expected Results    ${actual_result}    ${expected_result}

Verify Select Document/Content Library Dropdown Status
    [Documentation]    This keyword is used to Verify the enabled status of "Select Document/ Content Library" Dropdown.
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${dropdown.ccr.initiate.impactdeliveriables}    ${MEDIUM_WAIT}    Select Document/ Content Library Dropdown is not displayed after waiting for ${MEDIUM_WAIT} sec
    Run Keyword And Continue On Failure    Wait Until Element Is Enabled    ${dropdown.ccr.initiate.impactdeliveriables}    ${MEDIUM_WAIT}    Select Document/ Content Library Dropdown Status is not enabled after waiting for ${MEDIUM_WAIT} sec
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${actual_result}    Set Variable    Select link is displayed in the enabled status
    ${expected_result}    Set Variable    Select link should be displayed in the enabled status
    # Log Actual And Expected Results    ${actual_result}    ${expected_result}

Verify Impact Analysis Requirements Page
    [Documentation]    This keyword is used to Verify the Impact Analysis - Requirements page after clicking on the select link.
    Wait Until Time    4
    Select Frame    ${iframe.library_frame.screen}
    ${label.ccr.initiate.select.notification.newmessage}    Update Dynamic Value    ${label.notification.message}    Impact Analysis - Requirements
    Wait Until Time    1
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.ccr.initiate.select.notification.newmessage}    ${MEDIUM_WAIT}    Impact Analysis - Requirements is not displayed after waiting for ${MEDIUM_WAIT} sec
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Impacted Deliverables Under Documents Table
    [Documentation]    This keyword is used to Verify Initiate CCR page display and impacted deliverables under documents table.
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.ccr.initiate.select.frsdocumentno}    ${MEDIUM_WAIT}
    ${FRS_DOCUMENT_NO}    Get Text    ${label.ccr.initiate.select.frsdocumentno}
    Set Suite Variable    ${FRS_DOCUMENT_NO}
    ${label.module.tab.content.newpage}    Update Dynamic Value    ${label.module.tab.content.page}    Initiate CCR
    Wait Until Time    2
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.module.tab.content.newpage}    ${MEDIUM_WAIT}    Initiate CCR page is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${label.ccr.initiate.newselecteddocument}    Update Dynamic Value    ${label.ccr.initiate.selecteddocument}    ${FRS_DOCUMENT_NO}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.ccr.initiate.newselecteddocument}    ${MEDIUM_WAIT}    ${FRS_DOCUMENT_NO} is not visible after waiting for ${MEDIUM_WAIT} sec
    ${actual_result}    Set Variable    ${FRS_DOCUMENT_NO} document is displayed under documents table
    ${expected_result}    Set Variable    ${FRS_DOCUMENT_NO} document should be displayed under documents table
    # Log Actual And Expected Results    ${actual_result}    ${expected_result}

Add Documents Under Define Document Deliverables
    [Arguments]    ${ccr_data}
    [Documentation]    This keyword is used to add the additional documents under Define Document Deliverables tab.
    ${button.notification.newadd}    Update Dynamic Value    ${button.notification.ok/cancel}    btnAdddeliverables
    Click Element    ${button.notification.newadd}
    Select Value From Dropdown    select2-grvValidatiotype_ctl02_ddlENT-container    ${ccr_data}[Entity]
    Wait Until Time    2
    IF    'ContentType' in ${ccr_data}    Select Value From Dropdown    select2-grvValidatiotype_ctl02_ddlVT-container    ${ccr_data}[ContentType]
    IF    'Action' in ${ccr_data}    Select Value From Dropdown    select2-grvValidatiotype_ctl02_ddlAction-container    ${ccr_data}[Action]
    Wait Until Time    3
    Click Element    ${button.content.initiate.ccr.additionaldeliverables.save}
    Verify Additional Deliverables Under Defined Delivery Schedule    ${ccr_data}

Verify Additional Deliverables Under Defined Delivery Schedule
    [Arguments]    ${ccr_data}
    [Documentation]    This keyword is used to Verify the Additional Deliverables under defined delivery schedule.
    ${label.ccr.initiate.newdelivery}    Update Dynamic Values    ${label.ccr.initiate.delivery}    grvDeliverable_ctl02_lblentityvalue    ${ccr_data}[Entity]
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.ccr.initiate.newdelivery}    ${MEDIUM_WAIT}    ${ccr_data}[Entity] is not displayed after waiting for ${MEDIUM_WAIT} seconds
    ${actual_result}    Set Variable    ${ccr_data}[Entity] is displayed under documents table
    ${expected_result}    Set Variable    ${ccr_data}[Entity] document should be displayed under documents table
    # Log Actual And Expected Results    ${actual_result}    ${expected_result}

Initiate CCR
    [Arguments]    ${ccr_data}    ${user_name}    ${password}
    [Documentation]    This keyword is used to selecct the group and submit the initiate ccr
    Select Value For Radio Button    grpCCR    ${ccr_data}[NotifyBy]
    Wait Until Time    2
    Select Value From Dropdown    select2-ddlAssessorGroup-container    ${ccr_data}[SelectGroup]
    Click Button In VLMS    Submit
    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.ccr.intiate_ccr.submit.popup}    ${SHORT_WAIT}
    IF    '${status}'=='True'
        Verify Notification Popup    CCR No. must be unique    val1_btnerrorok
        Wait Until Time    4
        ${label.change.initiate.newccrno}    Update Dynamic Value    ${label.content.create.tracematrix}    lblChangeNoValue
        Scroll Till Element Is Visible    ${label.change.initiate.newccrno}
        Wait Until Time    2
        Wait Until Element Is Visible    ${label.change.initiate.newccrno}    ${MEDIUM_WAIT}
        ${ccr_number}    Get Text    ${label.change.initiate.newccrno}
        ${CCR_NO}    Set Variable    ${ccr_number}
        Set Test Variable    ${CCR_NO}
        Click Button In VLMS    Submit
        Handle Electronic Sign    ${user_name}    ${password}    Submit
    END
    ${EXPECTED_MESSAGE}    Set Variable    CCR ${CCR_NO} has been initiated.
    Set Test Variable    ${EXPECTED_MESSAGE}
    Wait Until Time    3

Select FRS Document From Document/ Content Library
    [Arguments]    ${ccr_data}
    [Documentation]    Select FRS documents from Document/ Content Library.
    ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    select2-ddlDocument-container
    Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    select2-ddlDocument-container dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    4
    Select Dropdown Value With Partial Text    select2-ddlDocument-container    ${ccr_data}[ContentLibrary]
    ${label.ccr.document.newselect}    Update Dynamic Value    ${label.content.create.tracematrix}    val1_grdAlertGrid_ctl02_lblGridAlert
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.ccr.document.newselect}    ${SHORT_WAIT}
    IF    '${status}'=='True'
        ${button.notification.newok}    Update Dynamic Value    ${button.notification.ok/cancel}    val1_btnAlertOk
        Click Element    ${button.notification.newok}
        Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    10
    END

Navigate To Select CCR For Stakeholder Assessment
    [Arguments]    ${PREVIOUS_CCR_NO}
    [Documentation]    This keyword is used to navigate Select CCR For Stakeholder Assessment page.
    Navigate To Module Tab    Change    Assess    Stakeholder    Select CCR for Stakeholder Assessment    True
    Wait Until Time    3
    Search And Select The Value From The Section    ${PREVIOUS_CCR_NO}

Submit CCR From Stakeholder Assessment
    [Arguments]    ${ccr_data}    ${CCR_NO}    ${username}    ${userpassword}
    [Documentation]    This keyword is used to navigate submit CCR from Stakeholder Assessment page.
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Stakeholder Assessment
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Stakeholder Assessment page is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Visible    ${button.ccr.stakeholder.stakeholderassessment.sec1}    ${MEDIUM_WAIT}    "Sec1" is not displayed after waiting for ${MEDIUM_WAIT} Seconds
    Click Element    ${button.ccr.stakeholder.stakeholderassessment.sec1}
    IF    'TB1' in ${ccr_data}    Enter Comments/Description    gvCurSH_ctl02_gvCurSHDetails_ctl02_txtFiled    ${ccr_data}[TB1]
    IF    'TransferTask' in ${ccr_data}    Select Value For Radio Button    CCRTransfer    ${ccr_data}[TransferTask]
    IF    'TransferTo' in ${ccr_data}    Select Value From Dropdown    select2-ddlTransferTo-container    ${ccr_data}[TransferTo]
    IF    'Comments' in ${ccr_data}    Enter Comments/Description    txtComments    ${ccr_data}[Comments]
    Click Button In VLMS    Submit
    Handle Electronic Sign    ${username}    ${userpassword}    Submit
    ${EXPECTED_MESSAGE}    Set Variable     Stakeholder Assessment for CCR ${CCR_NO} has been completed
    Set Test Variable    ${EXPECTED_MESSAGE}

Navigate To CCR Owner Page
    [Documentation]    This keyword is used to navigate to the Select CCR for CCR Owner page.
    Navigate To Module Tab    Change    Assess    CCR Owner    Select CCR for CCR Owner    True

Approve CCR
    [Arguments]    ${ccr_data}    ${CCR_NO}    ${username}    ${userpassword}
    [Documentation]    This keyword is used to approve the ccr.
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    CCR Ready for Routing
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    CCR Ready for Routing page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'RouteBackToStakeholders' in ${ccr_data}    Select Value For Radio Button    StakeHolders    ${ccr_data}[RouteBackToStakeholders]
    ${checkbox.select.routeback.selectstakeholder}    Update Dynamic Value    ${checkbox.select}    gvSelectStakeholder_ctl02_chkSelect
    IF    '${ccr_data}[RouteBackToStakeholders]'=='rdoSHYes'    Select Checkbox    ${checkbox.select.routeback.selectstakeholder}
    IF    'Comments' in ${ccr_data}    Enter Comments/Description    txtComments    ${ccr_data}[Comments]
    Click Button In VLMS    Submit
    Handle Electronic Sign    ${username}    ${userpassword}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    CCR ${CCR_NO} has been assessed and accepted by CCR Owner
    Set Test Variable    ${EXPECTED_MESSAGE}

Navigate To Ad Hoc Report Page
    [Documentation]    This keyword is used to navigate Ad Hoc Report page.
    Navigate To Module Tab    Report    Generate    Ad Hoc Report    Ad Hoc Report    True

Generate Pre-Approved CCR Preview
    [Arguments]    ${report_data}    ${CCR_NO}
    [Documentation]    This keyword is used to configure details to view ccr under preview tab.
    IF    'ReportTitle' in ${report_data}    Enter Text In Mandatory Fields    ReportTitle    ${report_data}[ReportTitle]
    IF    'AcccessMode' in ${report_data}    Select Value For Radio Button    AccessMode    ${report_data}[AcccessMode]
    IF    'ReportType' in ${report_data}    Select Value From Dropdown    select2-UltraWebTab1_TabPanel1_ddlReportType-container    ${report_data}[ReportType]
    Wait Until Time    2
    Select Status From Data Source    Pre-Approved
    Navigate To Page Title Tab    Filters
    Enter Comments/Description    UltraWebTab1_TabPanel2_txtPrompt    ${CCR_NO}
    Wait Until Time    2
    Navigate To Page Title Tab    Fields
    Wait Until Time    2
    IF    'CCRProcessForms' in ${report_data}    Swipe Values Between Groups    ${report_data}[CCRProcessForms]    UltraWebTab1_TabPanel3_lstMultiFormsLeft    UltraWebTab1_TabPanel3_lstMultiFormsRight
    Wait Until Time    2
    ${selectedformfields}    Click Fields Dropdown And Get Values    ddlFormFields    ddlFormFields_B-1    ddlFormFields_DDD_DDTC_listBox_LBI0C    ddlFormFields_DDD_DDTC_listBox_0_D    ddlFormFields_DDD_DDTC_ASPxbtnSave_I
    Wait Until Time    2
    IF    'CCRChangeForms' in ${report_data}    Swipe Values Between Groups    ${report_data}[CCRChangeForms]    UltraWebTab1_TabPanel3_lstCCRChangeFormsLeft    UltraWebTab1_TabPanel3_lstCCRChangeFormsRight
    Wait Until Time    3
    ${selectedccrformfields}    Click Fields Dropdown And Get Values    ddlCRChangeFormFields    ddlCRChangeFormFields_B-1    ddlCRChangeFormFields_DDD_DDTC_listBox_LBI0C    ddlCRChangeFormFields_DDD_DDTC_listBox_0_D    ddlCRChangeFormFields_DDD_DDTC_ASPxbtnSave_I
    ${fieldstodisplay}    Combine Lists    ${selectedformfields}    ${selectedccrformfields}
    IF   'FieldsToCheck' in ${report_data}
        @{fieldstoselect}    Split String    ${report_data}[FieldsToCheck]    ,
        ${count}    Get Length    ${fieldstoselect}
        FOR    ${element}    IN    @{fieldstoselect}
            ${checkbox.report.adhocreport.newfields}    Update Dynamic Value    ${checkbox.report.adhocreport.fields}    ${element}
            Wait Until Time    2
            Select Checkbox    ${checkbox.report.adhocreport.newfields}
        END
    END
    @{FIELDSSELECTED}    Combine Lists    ${fieldstoselect}    ${fieldstodisplay}
    Set Suite Variable    @{FIELDSSELECTED}

Verify Selected Fields Under Preview Tab
    [Documentation]    This keyword is used to Verify the selected fields under preview tab.
    Navigate To Page Title Tab    Preview
    FOR    ${element}    IN    @{FIELDSSELECTED}
        ${label.report.adhocreport.preview}    Update Dynamic Value    ${label.report.adhocreport.preview}    ${element}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.report.adhocreport.preview}    ${MEDIUM_WAIT}    ${element} is not visible after waiting for ${MEDIUM_WAIT} seconds
        # Log Actual And Expected Results    ${element} is displayed under Preview Tab    ${element} is displayed under Preview Tab
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Click Fields Dropdown And Get Values
    [Arguments]    ${tableid}    ${dropdownid}    ${checkboxtdid}    ${checkboxspanid}    ${buttonid}
    [Documentation]    This keyword is used to click on the fields dropdown from adhoc report page and to get selected values from that.
    ${dropdown.report.adhocreport.newfields}    Update Dynamic Values    ${dropdown.report.adhocreport.fields}    ${tableid}    ${dropdownid}
    Click Element    ${dropdown.report.adhocreport.newfields}
    Wait Until Time    4
    ${checkbox.report.adhocreport.fields.newselectall}    Update Dynamic Values    ${checkbox.report.adhocreport.fields.selectall}    ${checkboxtdid}    ${checkboxspanid}
    Wait Until Time    2
    Javascript Click    ${checkbox.report.adhocreport.fields.newselectall}
    ${lable.report.adhocreport.newselectedfields}    Update Dynamic Value    ${lable.report.adhocreport.selectedfields}    ${tableid}
    ${count}    Get Element Count    ${lable.report.adhocreport.newselectedfields}
    @{form_fields}    Create List
    Wait Until Time    4
    FOR    ${key}    IN RANGE    2    ${count}+1
        ${form_field}    Get Text    (${lable.report.adhocreport.newselectedfields})[${key}]
        Append To List    ${form_fields}    ${form_field}
    END
    ${button.report.adhocreport.fields.formfields.newsave}    Update Dynamic Value    ${button.report.adhocreport.fields.formfields.save}    ${buttonid}
    Javascript Click    ${button.report.adhocreport.fields.formfields.newsave}
    RETURN    ${form_fields}

Verify CCR Under Preview Tab
    [Arguments]    ${CCR_NO}
    [Documentation]    This keyword is used to Verify the CCR number under Preview tab.
    ${label.report.generate.adhocreport.preview.newccr}    Update Dynamic Value    ${label.report.generate.adhocreport.preview.ccr}    ${CCR_NO}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.report.generate.adhocreport.preview.newccr}    ${MEDIUM_WAIT}    ${CCR_NO} is not displayed after waiting for ${MEDIUM_WAIT} seconds.
    # Log Actual And Expected Results    ${CCR_NO} is displayed under preview tab    ${CCR_NO} should be displayed under preview tab
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Navigate To CCR Owner Assessment Screen
    [Arguments]    ${ccr_no}
    [Documentation]    This Keyword is used to navigate to CCR Owner Assessment Screen
    Navigate To Module Tab    Change   Assess    CCR Owner    Select CCR for CCR Owner    True
    Search And Select The Value From The Section    ${ccr_no}

Remove Documents From The Section
    [Arguments]    ${section}    ${Content_type_list}
    [Documentation]    This Keyword is used to Remove Documents from the section based on content type
    ${icon.change.assess.ccr_owner.section.newremove}    Update Dynamic Value    ${icon.change.assess.ccr_owner.section.remove}    ${section}
    Wait Until Element Is Visible    ${icon.change.assess.ccr_owner.section.newremove}    ${MEDIUM_WAIT}    Remove Icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{list}    Split String    ${Content_type_list}    ,
    FOR    ${key}    IN    @{list}
        Wait Until Time    2
        ${checkbox.change.assess.ccr_owner.content_type.newdocs_checkboxes}    Update Dynamic Values    ${checkbox.change.assess.ccr_owner.content_type.docs_checkboxes}    ${section}    ${key}
        ${count}    Get Element Count    ${checkbox.change.assess.ccr_owner.content_type.newdocs_checkboxes}
        IF    ${count}>0
            FOR    ${index}    IN RANGE    1    ${count}+1
                Select Checkbox    (${checkbox.change.assess.ccr_owner.content_type.newdocs_checkboxes})[${index}]
            END
        END
    END
    Wait Until Time    2
    IF    ${count}>0
        Click Element    ${icon.change.assess.ccr_owner.section.newremove}
        Submit/Cancel The Termination    Terminate    TermYes
    END

 Submit/Cancel The Termination
    [Arguments]    ${comments}    ${button_option}
    [Documentation]    This Keyword is used to Submit/Cancel The Termination
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.change.assess.ccr.select_ccr.remove_doc.popup}    ${MEDIUM_WAIT}    Termination is not visible after waiting for ${MEDIUM_WAIT} seconds
    Enter Comments/Description    val1_txtReason    ${comments}
    Select Submit/Reset Button    ${button_option}

Verify Documents Are Removed Under The Section
    [Arguments]    ${section}    ${Content_type_list}
    [Documentation]    This Keyword is used to Verify Documents are removed under the Section
    @{list}    Split String    ${Content_type_list}    ,
    Wait Until Time    2
    FOR    ${key}    IN    @{list}
        ${label.change.assess.ccr_owner.content_type.newdocs}    Update Dynamic Values    ${label.change.assess.ccr_owner.content_type.docs}    ${section}    ${key}
        ${count}    Get Element Count    ${label.change.assess.ccr_owner.content_type.newdocs}
        FOR    ${index}    IN RANGE    1    ${count}+1
            ${icon.change.assess.ccr_owner.section.content_type.doc.newremove}    Update Dynamic Values    ${icon.change.assess.ccr_owner.section.content_type.doc.remove}    ${section}    ${key}
            Run Keyword And Continue On Failure    Wait Until Element Is Visible    (${icon.change.assess.ccr_owner.section.content_type.doc.newremove})[${index}]    ${SHORT_WAIT}
        END
    END

Accept CCR And Remove Documents From The Section
    [Arguments]    ${doc_content_types}    ${defined_content_types}
    [Documentation]    This Keyword is used to Accept CCR And Remove Documents from the section based on content type
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.change.assess.ccr.select_ccr.accept_ccr}    ${MEDIUM_WAIT}    Accept CCR Assessment is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Visible    ${label.change.assess.ccr.select_ccr.accept_ccr.ccr_no}    ${MEDIUM_WAIT}    CCR No Assessment is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${ccr_no}    Get Text    ${label.change.assess.ccr.select_ccr.accept_ccr.ccr_no}
    ${expected_message}    Set Variable    CCR ${ccr_no} has been accepted.
    ${button.common.newbtn_name}    Update Dynamic Value    ${button.common.btn_name}    Accept
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.common.newbtn_name}    ${SHORT_WAIT}
    IF    '${status}'=='True'
        Click Button In VLMS    Accept
        Wait Until Time    2
        Verify Confirmation Popup   ${expected_message}    btnMessageOk
        Search And Select The Value From The Section    ${ccr_no}
    END
    Remove Documents From The Section    Documents    ${doc_content_types}
    Verify Documents Are Removed Under The Section    Documents    ${doc_content_types}
    Select The Section    Defined Delivery Schedule
    Remove Documents From The Section    Defined Delivery Schedule    ${defined_content_types}
    Verify Documents Are Removed Under The Section    Defined Delivery Schedule    ${defined_content_types}

Enter Details In CCR Owner Assessment
    [Arguments]    ${ccr_data}    ${username}    ${userpassword}    ${CCR_NO}
    [Documentation]    This keyword is used to enter details In CCR Owner Assessment
    IF    'AssessmentDecision' in ${ccr_data}    Select Value For Radio Button    Decision    ${ccr_data}[AssessmentDecision]
    IF    '${ccr_data}[AssessmentDecision]'=='rdoDefer'
        IF    'ScheduleDate' in ${ccr_data}
            Click Calendar Icon In Vlms    ${icon.change.assess.ccr_owner.calendar}
            Select Target Date    ${ccr_data}[DateType]    WebDateChooser2    WebDateChooser2_DrpPnl_Calendar1_506    WebDateChooser2_DrpPnl_Calendar1_504    ${ccr_data}[Year]    ${ccr_data}[Month]    ${ccr_data}[Date]
        END
        IF    'FrequencyAlert' in ${ccr_data}    Enter Text In Mandatory Fields    Alert    ${ccr_data}[FrequencyAlert]
        IF    'FrequencyType' in ${ccr_data}    Select Value From Dropdown    ddlFrequencyType    ${ccr_data}[FrequencyType]
    END
    Wait Until Time    4
    IF    'ProcessMap' in ${ccr_data}
        Select Value From Dropdown    ddlProcessMap    ${ccr_data}[ProcessMap]
        Wait Until Time    3
        Select The Section    Pre-Implementation Process Flow and Approval Configurations
        IF    'StakeholderGroup' in ${ccr_data}    Select Value From Dropdown    ddlStakeGroup    ${ccr_data}[StakeholderGroup]
        Wait Until Time    2
        IF    'StakeholderUser' in ${ccr_data}    Select Dropdown Value With Partial Text    ddlStakeuser    ${ccr_data}[StakeholderUser]
    END
    IF    'SummaryRequired' in ${ccr_data}    Select Value For Radio Button    ccsummary    ${ccr_data}[SummaryRequired]
    IF    '${ccr_data}[SummaryRequired]'=='rbtnValidationSummaryYes'
        IF    'SummaryExecutable' in ${ccr_data}    Select Value For Radio Button    ccsummaryexe    ${ccr_data}[SummaryExecutable]
        IF    'BatchApproval' in ${ccr_data}    Select Value For Radio Button    batch    ${ccr_data}[BatchApproval]
    END
    IF    'Approval' in ${ccr_data}    Select Value For Radio Button    WFReqCCR    ${ccr_data}[Approval]
    IF    '${ccr_data}[Approval]'=='rdoApprovalReqYes'
        IF    'Workflow' in ${ccr_data}    Select Value From Dropdown    ddlWorkflow    ${ccr_data}[Workflow]
    END
    IF    'Comments' in ${ccr_data}    Enter Text In Mandatory Fields    Comments    ${ccr_data}[Comments]
    ${button.newsubmit/reset}    Update Dynamic Value    ${button.submit/reset}    ${ccr_data}[Button]
    Javascript Click    ${button.newsubmit/reset}
    Wait Until Time    3
    Handle Electronic Sign    ${username}    ${userpassword}    Submit    Assess
    ${EXPECTED_MESSAGE}    Set Variable    CCR ${CCR_NO} has been assessed and Accepted by CCR Owner
    Set Test Variable    ${EXPECTED_MESSAGE}

Navigate To Plan Implementation Page
    [Arguments]    ${ccr_number}
    [Documentation]    This keyword is used to navigate to Plan Implementation Page
    Unselect Frame
    Navigate To Module Tab    Change    Plan    Implementation Items    Select CCR to Implement    True
    Search And Select The Value From The Section    ${ccr_number}

Select And Enter Details In Impact Analysis Requirements Page
    [Arguments]    ${ccr_data}    ${selectedccr_no}=None
    [Documentation]    This keyword is used to select the fields in Impact Analaysis Requirements page
    Wait Until Time    3
    Wait Until Element Is Visible    ${link.ccr.intitiate.entity.selecteddocument.select}    ${MEDIUM_WAIT}
    Click Element    ${link.ccr.intitiate.entity.selecteddocument.select}
    Unselect Frame
    Wait Until Time    4
    Verify Impact Analysis Requirements Page
    IF   'TypeOfChangeImpact' in ${ccr_data}    Select Value For Radio Button    grpCCR    ${ccr_data}[TypeOfChangeImpact]
    Wait Until Time    4
    ${rtm_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${dropdown.ccr.initiate.select.rtm}    ${SHORT_WAIT}
    IF    '${rtm_status}'=='True'    Select Dropdown Value With Partial Text    select2-ddlRTM-container    ${ccr_data}[RTM]
    Wait Until Time    2
    IF   'NewContentLibrary' in ${ccr_data}    Select Value For Radio Button    grpTestFunctionReq    ${ccr_data}[NewContentLibrary]
    IF    '${selectedccr_no}'=='None'
        Select Requirement Checkboxes From Impact Analysis Requirements Page    ${ccr_data}
        Click Button In VLMS    Save and Close
        Verify Success Message    Updated Successfully    btnMessageOk
        Wait Until Time    4
        Unselect Frame
        Select Frame    ${iframe.framecontent}
    ELSE
        Verify Selected Requirements Status And Tooltip    ${selectedccr_no}    ${ccr_data}
    END

Verify Selected Requirements Status And Tooltip
    [Arguments]    ${selectedccr_no}    ${ccr_data}
    [Documentation]    This keyword is used to Verify the selected requirements checkbox status and CCR Number in the tooltip
    @{doc_names}    Split String    ${ccr_data}[ImpactAnalysisRequirmentDocuments]   ,
    FOR    ${key}    IN    @{doc_names}
        ${checkbox.change.initiate.select.frs.newcheckbox_status}    Update Dynamic Value    ${checkbox.change.initiate.select.frs.checkbox_status}    ${key}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${checkbox.change.initiate.select.frs.newcheckbox_status}    ${MEDIUM_WAIT}    ${key} checkbox is not displayied in the disabled status after waiting for ${MEDIUM_WAIT} seconds
        IF   '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        ${label.change.ccr.select.frs.newselected_document}    Update Dynamic Value    ${label.change.ccr.select.frs.selected_document}    ${key}
        Wait Until Time    1
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.change.ccr.select.frs.newselected_document}    ${MEDIUM_WAIT}
        Run Keyword And Continue On Failure    Mouse Over    ${label.change.ccr.select.frs.newselected_document}
        ${selected_ccr}    Get Element Attribute    ${label.change.ccr.select.frs.newselected_document}    title
        IF   '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        Run Keyword And Continue On Failure    Should Contain    ${selected_ccr}    ${selectedccr_no}
    END
    ${actual_result}    Set Variable    ${selected_ccr} is displayed in the tooltip
    ${expected_result}    Set Variable    ${selectedccr_no} should be displayed in the tooltip
    # Log Actual And Expected Results    ${actual_result}    ${expected_result}

Select Requirement Checkboxes From Impact Analysis Requirements Page
    [Arguments]    ${ccr_data}
    [Documentation]    This keyword is used to select the required documents from the Table on Impact Analysis Requirements page.
    Wait Until Time    2
    @{doc_names}    Split String    ${ccr_data}[ImpactAnalysisRequirmentDocuments]   ,
    FOR    ${key}    IN    @{doc_names}
        ${checkbox.change.initiate.select.frs.newcheckbox}    Update Dynamic Value    ${checkbox.change.initiate.select.frs.checkbox}    ${key}
        Wait Until Time    3
        Wait Until Element Is Visible    ${checkbox.change.initiate.select.frs.newcheckbox}    ${MEDIUM_WAIT}    ${key} is not displaying after waiting for ${MEDIUM_WAIT} seconds
        Scroll Element Into View    ${checkbox.change.initiate.select.frs.newcheckbox}
        ${status}    Run Keyword And Return Status    Checkbox Should Be Selected    ${checkbox.change.initiate.select.frs.newcheckbox}
        IF    '${status}'=='False'
            Wait Until Time    2
            Javascript Click    ${checkbox.change.initiate.select.frs.newcheckbox}
        END
        ${SELECTED_REQ_DOC}    Set Variable    ${key}
        Set Suite Variable    ${SELECTED_REQ_DOC}
    END

Verify Plan Implementation Items Page
    [Documentation]    This keyword is used to Verify the Plan Implementation Items page
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Plan Implementation Items
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Plan Implementation Items page is not visible after waiting for ${MEDIUM_WAIT} seconds

Navigate To Develop Maintain Deliverable Page
    [Documentation]    This keyword is used to navigate to the Develop Maintain Deliverable page by selecting the document in Impacted Deliverables page
    Unselect Frame
    Wait Until Time    5
    Navigate To Module Tab    Content    Author    Impacted Deliverable    Select Deliverable to Maintain
    Search And Select The Value From The Section    ${FRS_DOCUMENT_NO}

Enter Values For The Text Fields Under Deliverable Section
    [Arguments]    ${row_number}    ${locator}    ${text}=None
    [Documentation]    This keyword is used to enter the text for the fields under Deliverables section
    Wait Until Time    4
    ${row_number}    Convert To String    ${row_number}
    ${locator_new}    Update Dynamic Value    ${locator}    ${row_number}
    Wait Until Element Is Visible    ${locator_new}   ${LONG_WAIT}    ${locator} is not displayed after waiting for ${MEDIUM_WAIT} seconds
    Double Click Element    ${locator_new}
    Wait Until Time    2
    IF    '${text}'!='None'
        Wait Until Time    1
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${textbox.content.author.impacteddeliverables.deliverables}    ${SHORT_WAIT}
        IF    '${status}'=='False'    Double Click Element    ${locator_new}
        Click Element    ${textbox.content.author.impacteddeliverables.deliverables}
        Clear Element Text    ${textbox.content.author.impacteddeliverables.deliverables}
        Input Text    ${textbox.content.author.impacteddeliverables.deliverables}   ${text}
    END

Select Values For The Fields Under Deliverable Section
    [Arguments]    ${rowno}    ${dropdownno}    ${dropdown_value}=None
    [Documentation]    This keyword is used to select values for dropdowns under Deliverables section
    Wait Until Time    4
    IF    '${dropdown_value}'!='None'
        ${dropdown.content.author.impacteddeliverables.deliverables.newfields}    Update Dynamic Value    (${dropdown.content.author.impacteddeliverables.deliverables.cols.fields})[${dropdownno}]    ${rowno}
        ${dropdownelement}    Update Dynamic Value    (${dropdown.content.author.impacteddeliverables.deliverables.cols})[${dropdownno}]    ${rowno}
        Wait Until Element Is Visible    ${dropdownelement}    ${MEDIUM_WAIT}
        Click Element    ${dropdownelement}
        Wait Until Time    3
        Wait Until Element Is Visible    ${dropdown.content.author.impacteddeliverables.deliverables.newfields}    ${MEDIUM_WAIT}
        Set Focus To Element    ${dropdown.content.author.impacteddeliverables.deliverables.newfields}
        Double Click Element    ${dropdown.content.author.impacteddeliverables.deliverables.newfields}
        Wait Until Time    4
        ${dropdown.content.author.impacteddeliverables.newdeliverables}    Update Dynamic Value    ${dropdown.content.author.impacteddeliverables.deliverables}    ${rowno}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${dropdown.content.author.impacteddeliverables.newdeliverables}    ${SHORT_WAIT}
        IF    '${status}'=='False'    Double Click Element    ${dropdown.content.author.impacteddeliverables.deliverables.newfields}
        Wait Until Time    2
        Wait Until Element Is Visible    ${dropdown.content.author.impacteddeliverables.newdeliverables}    ${MEDIUM_WAIT}
        Click Element    ${dropdown.content.author.impacteddeliverables.newdeliverables}
        Wait Until Time    4
        ${dropdown.content.author.impacteddeliverables.deliverables.newvalues}    Update Dynamic Values    ${dropdown.content.author.impacteddeliverables.deliverables.values}   ${rowno}    ${dropdown_value}
        Wait Until Element Is Visible    ${dropdown.content.author.impacteddeliverables.deliverables.newvalues}    ${MEDIUM_WAIT}
        Click Element    ${dropdown.content.author.impacteddeliverables.deliverables.newvalues}
    END

Add/Update Content In Deliverable Table
    [Arguments]    ${ccr_data}    ${function}
    [Documentation]    This keyword is used to add rows and edit the content in Deliverables table.
    @{values}    Split String    ${ccr_data}[URS]   |
    ${rows}    Get Length    ${values}
    FOR    ${row}    IN RANGE    1    ${rows}+1
        ${newrow}    Evaluate    ${row}-1
        ${newrow}    Convert To String    ${newrow}
        ${row}    Convert To String    ${row}
        ${row_values}    Split String    ${values}[${newrow}]    ,
        IF    '${function}'=='Update'   Enter Details In Deliverable Table    ${row_values}    ${newrow}
        IF    '${function}'=='Add'
            ${row_count}    Add/Insert A Row In The Table    0    Add
            ${TOTALROWS}    Set Variable    ${row_count}
            Set Suite Variable    ${TOTALROWS}
            ${add_row}    Evaluate    ${TOTALROWS}-1
            ${add_row}    Convert To String    ${add_row}
            Enter Details In Deliverable Table    ${row_values}    ${add_row}
        END
    END

Enter Details In Deliverable Table
    [Arguments]    ${row_values}    ${row}
    [Documentation]    This keyword is used to enter details for the deliverable table
    ${urs}    Set Variable    ${row_values}[0]
    ${urs_description}    Set Variable    ${row_values}[1]
    ${user_storyid}    Set Variable    ${row_values}[2]
    ${severity}    Set Variable    ${row_values}[3]
    ${probability}    Set Variable    ${row_values}[4]
    ${detectability}    Set Variable    ${row_values}[5]
    ${impact}    Set Variable    ${row_values}[6]
    ${processcondition}    Set Variable    ${row_values}[7]
    Wait Until Time    5
    Enter Values For The Text Fields Under Deliverable Section    ${row}    (${textbox.content.author.impacteddeliverables.deliverables.fields})[2]   ${urs}
    Enter Values For The Text Fields Under Deliverable Section    ${row}     (${textbox.content.author.impacteddeliverables.deliverables.fields})[3]    ${urs_description}
    Enter Values For The Text Fields Under Deliverable Section    ${row}    (${textbox.content.author.impacteddeliverables.deliverables.fields})[4]   ${user_storyid}
    Wait Until Time    3
    Select Values For The Fields Under Deliverable Section    ${row}    1    ${severity}
    Wait Until Time    3
    Select Values For The Fields Under Deliverable Section    ${row}    2    ${probability}
    Wait Until Time    4
    Select Values For The Fields Under Deliverable Section    ${row}    3    ${detectability}
    Select Values For The Fields Under Deliverable Section    ${row}    4    ${impact}
    Wait Until Time    4
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${link.content.author.impacteddeliverables.deliverables.processcondition}    ${SHORT_WAIT}
    IF    '${status}'=='True'
        Wait Until Time    2
        Wait Until Element Is Visible    ${link.content.author.impacteddeliverables.deliverables.processcondition}    ${MEDIUM_WAIT}
        Click Element    ${link.content.author.impacteddeliverables.deliverables.processcondition}
        ${processcondition}    Remove String    ${processcondition}    [    ]
        @{conditions}    Split String    ${processcondition}   -
        FOR    ${key}    IN    @{conditions}
            Wait Until Time    2
            ${checkbox.content.author.impacteddeliverables.deliverables.newprocesscondition}    Update Dynamic Value    ${checkbox.content.author.impacteddeliverables.deliverables.processcondition}    ${key}
            Select Checkbox    ${checkbox.content.author.impacteddeliverables.deliverables.newprocesscondition}
        END
        ${button.content.author.impacteddeliverables.deliverables.newprocesscondition}    Update Dynamic Value    ${button.notification.ok/cancel}    btnSaveRef
        Wait Until Time    2
        Wait Until Element Is Visible    ${button.content.author.impacteddeliverables.deliverables.newprocesscondition}    ${MEDIUM_WAIT}
        Click Element    ${button.content.author.impacteddeliverables.deliverables.newprocesscondition}
    END

Enter Deliverable Details For Table2
    [Arguments]    ${ccr_update_data}    ${ccr_add_data}
    [Documentation]    This keyword is used to add and delete rows in Table2
    Add/Update Content In Deliverable Table    ${ccr_update_data}    Update
    Wait Until Time    4
    Add/Update Content In Deliverable Table    ${ccr_add_data}    Add

Update Deliverable Details In Table1 And Table2
    [Arguments]    ${ccr_update_data}    ${ccr_add_data}    ${ccr2_update_data}
    [Documentation]    This keyword is used to update data and add/delete rows in Table1 and Table2.
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Develop Maintain Deliverable
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Develop Maintain Deliverable page is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${content.plan.impacteddeliverables.newdeliverables}    Update Dynamic Value    ${label.section}    Deliverables
    Wait Until Time    2
    Wait Until Element Is Visible    ${content.plan.impacteddeliverables.newdeliverables}    ${MEDIUM_WAIT}
    Select Value For Radio Button    grpReq    rbtnImpactedReq
    Add/Update Content In Deliverable Table    ${ccr_update_data}    Update
    Add/Update Content In Deliverable Table    ${ccr_add_data}    Add
    ${TOTALROWS}    Convert To String    ${TOTALROWS}
    Delete A Row From The Table    ${TOTALROWS}
    Wait Until Time    4
    Wait Until Element Is Visible    ${button.content.author.deliverables.impactdeliveriables.table2}    ${MEDIUM_WAIT}
    Click Element    ${button.content.author.deliverables.impactdeliveriables.table2}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.content.author.content_library.create.content_table.rows}    ${SHORT_WAIT}
    IF    '${status}'=='True'
        Enter Deliverable Details For Table2    ${ccr2_update_data}    ${ccr_add_data}
        ${TOTALROWS}    Convert To String    ${TOTALROWS}
        Delete A Row From The Table    ${TOTALROWS}
    END
    ${button.content.plan.impacteddeliverables.deliverables.newsave}    Update Dynamic Value    ${button.common.name}    btnSave
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.content.plan.impacteddeliverables.deliverables.newsave}    ${MEDIUM_WAIT}
    Click Element    ${button.content.plan.impacteddeliverables.deliverables.newsave}
    ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    btnMessageOk
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.notification.newok/cancel}    ${MEDIUM_WAIT}    btnMessageOk is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.notification.newok/cancel}

Submit Deliverables
    [Arguments]    ${username}    ${password}
    [Documentation]    This keyword is used to submit and Verify the changes in the devlop maintian deliverables page.
    ${label.module.tab.content.newpage}    Update Dynamic Value    ${label.module.tab.content.page}    Develop Maintain Deliverable
    Wait Until Element Is Visible    ${label.module.tab.content.newpage}    ${MEDIUM_WAIT}    Develop Maintain Deliverable is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${button.content.plan.impacteddeliverables.deliverables.newsubmit}    Update Dynamic Value    ${button.common.name}    btnSubmit
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.content.plan.impacteddeliverables.deliverables.newsubmit}    ${MEDIUM_WAIT}
    Click Element    ${button.content.plan.impacteddeliverables.deliverables.newsubmit}
    Handle Electronic Sign    ${username}    ${password}    Submit
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.success_alert.ok}
    Click Element    ${button.success_alert.ok}

Verify Document Under Completed Deliverable Section
    [Documentation]    This keyword is used to Verify the document under completed deliverables section
    ${label.module.tab.content.newpage}    Update Dynamic Value    ${label.module.tab.content.page}    Select Deliverable to Maintain
    Wait Until Time    3
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.module.tab.content.newpage}    ${MEDIUM_WAIT}    Select Deliverable to Maintain is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Select The Section    Completed Deliverables
    ${link.content.selecteddeliverabletomaintain.newcompleteddeliverable}    Update Dynamic Value    ${link.content.selecteddeliverabletomaintain.completeddeliverable}    ${FRS_DOCUMENT_NO}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${link.content.selecteddeliverabletomaintain.newcompleteddeliverable}    ${MEDIUM_WAIT}    ${FRS_DOCUMENT_NO} is not displayed under completed deliverables after waiting for ${MEDIUM_WAIT} seconds

Approve Impacted Document
    [Arguments]    ${username}    ${password}    ${document_id}    ${entity}    ${updated_data}
    [Documentation]    This keyword is used to approve the document
    ${button.mytasks.document.newapprovedocument}    Update Dynamic Value    ${button.common.name}    btnAccept
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.mytasks.document.newapprovedocument}    ${MEDIUM_WAIT}
    Click Element    ${button.mytasks.document.newapprovedocument}
    Verify Success Message    Approve Authoring has been accepted    btnMessageOk
    Select The Section    Approve Document
    ${button.mytasks.document.newapproval}    Update Dynamic Value    ${button.notification.ok/cancel}    rdoApprovalYes
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.mytasks.document.newapproval}    ${MEDIUM_WAIT}
    Select Value For Radio Button    Approval    rdoApprovalYes
    Wait Until Time    3
    Select The Section    Additional Information
    Wait Until Time    3
    Navigate To Page Title Tab    Impacted Documents
    Wait Until Time    4
    Wait Until Element Is Visible    ${icon.mytasks.document.approvedocument.impacteddocument}    ${MEDIUM_WAIT}
    Click Element    ${icon.mytasks.document.approvedocument.impacteddocument}
    Wait Until Time    4
    Verify Content In Maintain Deliverable Page    ${updated_data}[URS]    ${SELECTED_REQ_DOC}
    Wait Until Time    3
    ${button.mytasks.document.approvedocument.newsubmit}    Update Dynamic Value    ${button.common.name}    btnSubmit
    Wait Until Element Is Visible    ${button.mytasks.document.approvedocument.newsubmit}    ${MEDIUM_WAIT}
    Click Element    ${button.mytasks.document.approvedocument.newsubmit}
    Handle Electronic Sign    ${username}    ${password}    Submit
    ${modifiedentity}    Remove String    ${entity}    [    ]
    ${entity}    Replace String    ${modifiedentity}    **    ${SPACE}-${SPACE}
    ${EXPECTED_MESSAGE}    Set Variable    Change Control Validation Summary Report document ${document_id} for ${entity} has been Approved
    Set Test Variable    ${EXPECTED_MESSAGE}

Verify Content In Maintain Deliverable Page
    [Arguments]    ${impacteddata}    ${doc}
    [Documentation]    This keyword is used to Verify the updated details for the document
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Time    2
    @{impactednewdata}    Split String    ${impacteddata}    ,
    FOR    ${element}    IN    @{impactednewdata}
        IF    '${element}'!='None'
            ${label.mytasks.approvaldocument.impacteddocument.newmaintaindeliverables}    Update Dynamic Values    ${label.mytasks.approvaldocument.impacteddocument.maintaindeliverables}    ${doc}    ${element}
            ${label.mytasks.approvaldocument.impacteddocument.newmaintaindeliverables.newseverity}    Update Dynamic Values    ${label.mytasks.approvaldocument.impacteddocument.maintaindeliverables.severity}    ${doc}    ${element}
            ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.mytasks.approvaldocument.impacteddocument.newmaintaindeliverables}    ${SHORT_WAIT}
            ${visibility}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.mytasks.approvaldocument.impacteddocument.newmaintaindeliverables.newseverity}    ${SHORT_WAIT}
            IF    '${status}'=='True' and '${visibility}'=='True'    Capture Allure Screenshot
        END
    END
    Unselect Frame
    Wait Until Time    2
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}    ${MEDIUM_WAIT}
    Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}
    Select Frame    ${iframe.framecontent}

Prepare Implementation Items
    [Arguments]    ${ccr_data}    ${username}    ${password}    ${PREVIOUS_CCR_NO}
    [Documentation]    This keyword is used to prepare Plan Implementation Items
    Verify Plan Implementation Items Page
    IF    'Approval' in ${ccr_data}    Select Value For Radio Button    WFReqCCR    ${ccr_data}[Approval]
    IF    '${ccr_data}[Approval]'=='rdoApprovalReqYes'
        IF    'Workflow' in ${ccr_data}    Select Value From Dropdown    ddlWorkflow    ${ccr_data}[Workflow]
    END
    IF    'Comments' in ${ccr_data}    Enter Text In Mandatory Fields    Comments    ${ccr_data}[Comments]
    ${button.change.plan.implementationitems.newsubmit}    Update Dynamic Value    ${button.common.name}    btnSubmit
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.change.plan.implementationitems.newsubmit}    ${MEDIUM_WAIT}
    Click Element    ${button.change.plan.implementationitems.newsubmit}
    Handle Electronic Sign    ${username}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    Implementation Items for CCR ${PREVIOUS_CCR_NO} have been prepared
    Set Test Variable    ${EXPECTED_MESSAGE}

Submit CCR Ready For Routing
    [Arguments]    ${ccr_data}    ${username}    ${password}    ${PREVIOUS_CCR_NO}
    [Documentation]    This Keyword is used to submit in ccr ready for routing page
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Approved CCR Ready for Routing
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Approved CCR Ready for Routing page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'Comments' in ${ccr_data}    Enter Text In Mandatory Fields    Comments    ${ccr_data}[Comments]
    ${button.change.plan.implementationitems.ccrreadyforrouting.newsubmit}    Update Dynamic Value    ${button.common.name}    btnSubmit
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.change.plan.implementationitems.ccrreadyforrouting.newsubmit}    ${MEDIUM_WAIT}
    Click Element    ${button.change.plan.implementationitems.ccrreadyforrouting.newsubmit}
    Handle Electronic Sign    ${username}    ${password}   Submit
    ${EXPECTED_MESSAGE}    Set Variable    Implementation Items for CCR ${PREVIOUS_CCR_NO} have been completed
    Set Test Variable    ${EXPECTED_MESSAGE}

Add CCVS Content To The Document
    [Arguments]    ${ccvs_no}
    [Documentation]    This keyword is used to navigate to the additional inforamtion section in approve document page
    Navigate To Module Tab    Content    Author    Document    Select Document to Author
    Search And Select The Value From The Section    ${ccvs_no}
    Select Icon From Plugins Tab    ${ccvs_no}    CCVS
    Wait Until Time    2
    Handle Alert    ACCEPT
    Navigate To Page Title Tab    Author Document
    Wait Until Time    3
    Select The Section    Additional Information

Assign Impacted Deliverables
    # robocop: disable=too-long-keyword
    [Arguments]    ${ccr_data}    ${username}    ${userpassword}    ${contenttype}    ${assign_doc_data}=False
    [Documentation]    This keyword is used to assign impacted deliverables
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Plan Implementation Items
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Plan Implementation Items page is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${label.change.plan.implementationitems.authoring.newentity}    Update Dynamic Value    ${label.change.plan.implementationitems.authoring.entity}    grvDevelopment_ctl02_lblEntityValue
    Wait Until Element Is Visible    ${label.change.plan.implementationitems.authoring.newentity}    ${MEDIUM_WAIT}    Entity is not displayed under Authoring table after waiting for ${MEDIUM_WAIT} seconds
    ${entity}    Get Text    ${label.change.plan.implementationitems.authoring.newentity}
    ${label.change.plan.implementationitems.authoring.newcontenttype}    Update Dynamic Value    ${label.change.plan.implementationitems.authoring.entity}    grvDevelopment_ctl02_lblValidationType
    Wait Until Element Is Visible    ${label.change.plan.implementationitems.authoring.newcontenttype}    ${MEDIUM_WAIT}    Content Type is not displayed under Authoring table after waiting for ${MEDIUM_WAIT} seconds
    ${button.ccr.plan.implementaionpage.authoring.contenttype.newassign}    Update Dynamic Value    ${button.ccr.plan.implementaionpage.authoring.contenttype.assign}    ${contenttype}
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.ccr.plan.implementaionpage.authoring.contenttype.newassign}    ${MEDIUM_WAIT}
    Click Element    ${button.ccr.plan.implementaionpage.authoring.contenttype.newassign}
    IF   '${contenttype}'=='Functional Requirement Specification'
        ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Assign Impacted Deliverables
        Wait Until Time    4
        Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${LONG_WAIT}    Assign Impacted Deliverables page is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    'Requirement Type' in ${ccr_data}    Select Value For Radio Button    grpReq    ${ccr_data}[Requirement Type]
        IF    'Assignment' in ${ccr_data}    Select Value For Radio Button    AssignType    ${ccr_data}[Assignment]
        IF    'Comments' in ${ccr_data}    Enter Comments/Description    txtComments    ${ccr_data}[Comments]
        ${button.change.plan.implementationitems.newsubmit}    Update Dynamic Value    ${button.common.name}    btnSubmit
        Wait Until Time    2
        Wait Until Element Is Visible    ${button.change.plan.implementationitems.newsubmit}    ${MEDIUM_WAIT}
        Click Element    ${button.change.plan.implementationitems.newsubmit}
    ELSE IF    '${contenttype}'=='Change Control Validation Summary Report'
        ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Assign Document Authoring
        Wait Until Time    2
        Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Assign Document Authoring page is not visible after waiting for ${MEDIUM_WAIT} seconds
        ${DOC_NO}    Enter Details In Assign Document Authoring    ${assign_doc_data}
        ${button.change.plan.implementationitems.newsubmit}    Update Dynamic Value    ${button.common.name}    btnSubmit
        Wait Until Time    2
        Wait Until Element Is Visible    ${button.change.plan.implementationitems.newsubmit}    ${MEDIUM_WAIT}
        Click Element    ${button.change.plan.implementationitems.newsubmit}
        Set Suite Variable    ${DOC_NO}
    END
    Handle Electronic Sign    ${username}    ${userpassword}    Submit    Assign
    ${user}    Replace String    ${LOGGEDIN_USER}    ${SPACE}\[    [
    ${user}    Split String    ${user}    -
    ${user}    Split String    ${user}[0]   ${SPACE}
    ${user2}    Set Variable    ${user}[0] ${user}[1]${user}[2]
    ${modifiedentity}    Remove String    ${entity}    [    ]
    ${entity}    Split String    ${modifiedentity}    ${SPACE}
    ${entity}    Set Variable    ${entity}[0] ${entity}[1] - ${entity}[2]
    ${ENTITY_FORMAT}    Set Variable    ${entity}
    Set Test Variable    ${ENTITY_FORMAT}
    IF    '${contenttype}'=='Functional Requirement Specification'
        ${EXPECTED_MESSAGE}    Set Variable    ${contenttype} document for ${entity} has been Assigned to ${user2}
    ELSE IF    '${contenttype}'=='Change Control Validation Summary Report'
        ${EXPECTED_MESSAGE}    Set Variable    ${contenttype} document authoring task ${DOC_NO} for ${entity} has been Assigned to ${user2}
    END
    Set Test Variable    ${EXPECTED_MESSAGE}
    Verify Confirmation Popup    ${EXPECTED_MESSAGE}    btnMessageOk
