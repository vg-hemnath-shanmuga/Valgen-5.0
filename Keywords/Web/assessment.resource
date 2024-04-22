*** Settings ***
Documentation     This assessment resource file has all the assessment keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Navigate To Create Validation Framework
    [Documentation]    This keyword will navigate to create validation framework page
    Menu Navigation_5.0    System    Framework
    Click Button In VLMS    Create

Create Framework
    [Documentation]    This keyword will create the framework
    [Arguments]    ${create_data}    ${user_name}    ${password}
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create Validation Framework
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create Validation Framework page is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${framework_doc_no}    Get Text    ${label.assessment.framework.document_no}
    ${framework_doc_no}    Remove String    ${framework_doc_no}    <    >
    IF    'FrameworkType' in ${create_data}    Select Value For Radio Button    rbtNew    ${create_data}[FrameworkType]
    IF    'SelectFramework' in ${create_data}    Select Value From Dropdown    select2-ddlInheritVal-container    ${create_data}[SelectFramework]
    Wait Until Time    2
    IF    'FrameworkName' in ${create_data}    Enter Text In Mandatory Fields    VPtitle    ${create_data}[FrameworkName]
    IF    'FrameworkForm' in ${create_data}    Select Value From Dropdown    select2-ddlPlanTemplate-container    ${create_data}[FrameworkForm]
    Wait Until Time    5
    IF    'Description' in ${create_data}    Enter Description For Framework    ${create_data}
    Wait Until Time    3
    Select Frame    ${iframe.framecontent}
    IF    'DeliverableName' in ${create_data}    Select Deliverable Name And Condition    ${create_data}
    IF    'Approval' in ${create_data}    Select Value For Radio Button    WFRequired    ${create_data}[Approval]
    IF    'Workflow' in ${create_data}    Select Value From Dropdown    select2-ddWorkFlow-container    ${create_data}[Workflow]
    IF    'Comments' in ${create_data}    Enter Comments/Description    txtComments    ${create_data}[Comments]
    IF    'RouteFor' in ${create_data}    Select Value From Dropdown    select2-ddlWFStatus-container    ${create_data}[RouteFor]
    Wait Until Time    2
    IF    'Button' in ${create_data}    Select Submit/Reset Button    ${create_data}[Button]
    Handle Electronic Sign    ${user_name}    ${password}    Submit
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${FRAMEWORK_NAME}    Set Variable    ${create_data}[FrameworkName]
    Set Suite Variable    ${FRAMEWORK_NAME}
    Set Test Variable    ${FRAMEWORK_DOC_NO}

Create Framework_Prerequisite
    [Documentation]    This keyword will create the framework
    [Arguments]    ${reason_data}    ${user_name}    ${password}
    ${count}    Get Length    ${reason_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${create_data}    Set Variable    ${reason_data}[${key}]
        ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create Validation Framework
        Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create Validation Framework page is not visible after waiting for ${MEDIUM_WAIT} seconds
        ${framework_doc_no}    Get Text    ${label.assessment.framework.document_no}
        ${framework_doc_no}    Remove String    ${framework_doc_no}    <    >
        IF    'FrameworkType' in ${create_data}    Select Value For Radio Button    rbtNew    ${create_data}[FrameworkType]
        IF    'SelectFramework' in ${create_data}    Select Value From Dropdown    select2-ddlInheritVal-container    ${create_data}[SelectFramework]
        Wait Until Time    2
        IF    'FrameworkName' in ${create_data}    Enter Text In Mandatory Fields    VPtitle    ${create_data}[FrameworkName]
        IF    'FrameworkForm' in ${create_data}    Select Value From Dropdown    ddlPlanTemplate_chosen    ${create_data}[FrameworkForm]
        Wait Until Time    3
        IF    'Description' in ${create_data}    Enter Description For Framework    ${create_data}
        Wait Until Time    2
        IF    'DeliverableName' in ${create_data}    Select Deliverable Name And Condition    ${create_data}
        IF    'Approval' in ${create_data}    Select Value For Radio Button    WFRequired    ${create_data}[Approval]
        IF    'Workflow' in ${create_data}    Select Value From Dropdown    select2-ddWorkFlow-container    ${create_data}[Workflow]
        IF    'Comments' in ${create_data}    Enter Comments/Description    txtComments    ${create_data}[Comments]
        IF    'RouteFor' in ${create_data}    Select Value From Dropdown    select2-ddlWFStatus-container    ${create_data}[RouteFor]
        Wait Until Time    2
        IF    'Button' in ${create_data}    Select Submit/Reset Button    ${create_data}[Button]
        Handle Electronic Sign    ${user_name}     ${password}   Submit
        ${ExpectedResult}    Set Variable    ${create_data}[FrameworkName] validation framework ${framework_doc_no} has been created
        Get Value From Toast Message    ${ExpectedResult}
        Click Button In VLMS    Create
    END

Select Deliverable Name And Condition
    [Arguments]    ${create_data}
    [Documentation]    This keyword be used to select the Deliverable name and condition(ex:mandatory or optional)
    @{deliverable_types}    Split String    ${create_data}[DeliverableName]    ,
    @{deliverable_names}    Split String    ${create_data}[DeliverableCondition]    ,
    ${count}    Get Length    ${deliverable_types}
    FOR    ${key}    IN RANGE    0    ${count}
        ${button.assessment.create.framework.newdelivrable_option}    Update Dynamic Values    ${button.assessment.create.framework.delivrable_option}    ${deliverable_types}[${key}]    ${deliverable_names}[${key}]
        Wait Until Time    1
        Wait Until Element Is Visible    ${button.assessment.create.framework.newdelivrable_option}
        Click Element    ${button.assessment.create.framework.newdelivrable_option}
    END

Enter Description For Framework
    [Arguments]    ${create_data}
    [Documentation]    This keyword will enter the description
    Wait Until Element Is Visible    ${iframe.assessment.create.framework}    ${MEDIUM_WAIT}
    Select Frame    ${iframe.assessment.create.framework}
    Wait Until Element Is Visible    ${textbox.assessment.framework.description}    ${MEDIUM_WAIT}
    Input Text    ${textbox.assessment.framework.description}    ${create_data}[Description]
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Verify Created Framework Pop Up Message
    [Arguments]    ${option}    ${popupmessage}    ${created_item}    ${create_data}
    [Documentation]    This will Verify framework name, document number & Handle Notification pop-up by clicking with Ok or Home button
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.notification_popup}    ${MEDIUM_WAIT}
    Wait Until Element Is Visible    ${label.notification.doc_no}    ${MEDIUM_WAIT}
    ${framework_name}    Get Text    ${label.assessment.framework.create.pop_up.framework_name}
    ${document_number}    Get Text    ${label.notification.doc_no}
    ${framework_expected_msg}    IF    '${created_item}'=='framework' and '${create_data}[Approval]'=='rbtWFNo'    Set Variable    ${framework_name} ${popupmessage} ${FRAMEWORK_DOC_NO} has been created    ELSE IF    '${created_item}'=='framework' and '${create_data}[Approval]'=='rbtWFYes'    Set Variable    ${framework_name} ${popupmessage} ${FRAMEWORK_DOC_NO} has been routed for ${create_data}[RouteFor]
    ${entity_expected_msg}    IF    '${created_item}'=='entity'    Set Variable    ${framework_name} ${popupmessage} ${document_number} has been created
    IF   '${created_item}'=='framework'    Verify Confirmation Popup    ${framework_expected_msg}    ${option}
    IF   '${created_item}'=='entity'    Verify Confirmation Popup    ${entity_expected_msg}    ${option}

Navigate To Create Assessment Page
    [Documentation]    This keyword is used to navigate to the create assessment page
    Navigate To Module Tab    Assessment    Create    Assessment    Create Assessment
    Click Button In VLMS    Create

Create Assessment
    [Arguments]    ${assessment_data}    ${username}    ${password}
    [Documentation]    This keyword is used to create the assessment.
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create Assessment
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create Assessment page is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    3
    IF    'AssessmentType' in ${assessment_data}    Select Value For Radio Button    DocType    ${assessment_data}[AssessmentType]
    IF    'AssessmentName' in ${assessment_data}    Enter Text In Mandatory Fields    ValAssName    ${assessment_data}[AssessmentName]
    ${ASSESSMENT_NAME}    Set Variable    ${assessment_data}[AssessmentName]
    Set Suite Variable    ${ASSESSMENT_NAME}
    IF    'EntityType' in ${assessment_data}    Select Value From Dropdown    select2-ddlEntityType-container    ${ENTITY_TYPE_NAME}
    IF    'AssessmentPlanTemplate' in ${assessment_data}    Select Value From Dropdown    select2-ddlValidationTemplate-container    ${assessment_data}[AssessmentPlanTemplate]
    IF    'EntitySelection' in ${assessment_data}    Select Entity/Entity Type Using Filter    ${ENTITY}    ASPxGridLookup1_B-1    ASPxGridLookup1
    IF    'Description' in ${assessment_data}    Enter Comments/Description    grdSections_ctl02_FrmFields_gvMain_ctl02_gvIni_ctl02_txtFiled    ${assessment_data}[Description]
    IF    'SectionAssignment' in ${assessment_data}    Select Value For Radio Button    grdSections$ctl02$AssignTypeSection    ${assessment_data}[SectionAssignment]
    IF    '${assessment_data}[SectionAssignment]'=='grdSections_ctl02_rbtnassignUserSection'
        IF    'AssignTo' in ${assessment_data}    Select Value From Dropdown    select2-grdSections_ctl02_ddAssignToSection-container    ${assessment_data}[AssignTo]
    END
    @{section_names}    Split String    ${assessment_data}[Sections]    ,
    FOR   ${key}    IN    @{section_names}
        IF    '${key}'=='GxP Section'    Swipe Values Between Groups    ${assessment_data}[SelectAssessors]    grdSections_ctl02_lstAvailbleGroup    grdSections_ctl02_lstAssinGroup
        ${link.assessment.create.assessment.newsection_name}    Update Dynamic Value    ${link.assessment.create.assessment.section_name}    ${key}
        Wait Until Time    4
        IF    '${key}'!='GxP Section'
            Wait Until Time    1
            Wait Until Element Is Visible    ${link.assessment.create.assessment.newsection_name}    ${MEDIUM_WAIT}
            Javascript Click    ${link.assessment.create.assessment.newsection_name}
        END
        IF    '${key}'=='RA Section'    Swipe Values Between Groups    ${assessment_data}[SelectAssessors]    grdSections_ctl03_lstAvailbleGroup    grdSections_ctl03_lstAssinGroup
        IF    '${key}'=='VA Section'    Swipe Values Between Groups    ${assessment_data}[SelectAssessors]    grdSections_ctl04_lstAvailbleGroup    grdSections_ctl04_lstAssinGroup
    END
    IF    'Assignment' in ${assessment_data}    Select Value For Radio Button    AssignType    ${assessment_data}[Assignment]
    IF    'Comments' in ${assessment_data}    Enter Comments/Description    txtComments    ${assessment_data}[Comments]
    Click Button In VLMS    Submit
    Handle Electronic Sign    ${username}    ${password}    Submit

Add Additional Deliverables To The Assessment
    [Arguments]    ${perform_assessment}
    [Documentation]    This keyword is used to add the additional deliverables to assessment
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Perform Assessment
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Perform Assessment page is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    3
    IF    'ManageDeliverable' in ${perform_assessment}    Select Value From Dropdown    select2-ddlCompleteThrough-container    ${perform_assessment}[ManageDeliverable]
    Wait Until Time    3
    Wait Until Element Is Visible    ${link.assessment.perform.assessment.assigned.validatedeliverables.update}    ${MEDIUM_WAIT}    Update link is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${link.assessment.perform.assessment.assigned.validatedeliverables.update}
    Enter Details In Additional Deliverable Page    ${perform_assessment}
    ${count}    Add A New Row To The Additional Deliverable
    Delete Row In Additional Deliverable Page    ${perform_assessment}
    Verify Row Is Deleted    ${count}
    ${button.assessment.assigned.update.additionaldeliverable.newsave}    Update Dynamic Value    ${button.common.name}    btnSaveDel
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.assessment.assigned.update.additionaldeliverable.newsave}    ${MEDIUM_WAIT}    Save button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.assessment.assigned.update.additionaldeliverable.newsave}
    Verify Notification Popup    Deliverables saved    btnSavedDeliverables
    Wait Until Time    3

Enter Details In Additional Deliverable Page
    [Arguments]    ${perform_data}
    [Documentation]    This keyword is used to enter values in additional deliverables page
    ${label.module.tab.content.newpage}    Update Dynamic Value    ${label.module.tab.content.page}    Additional Deliverable
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.module.tab.content.newpage}    ${MEDIUM_WAIT}    Additional Deliverable page is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${button.assessment.assigned.update.additionaldeliverable.newadd}    Update Dynamic Value    ${button.common.name}    btnAddUpdateDeliverables
    Wait Until Time    1
    Wait Until Element Is Visible    ${button.assessment.assigned.update.additionaldeliverable.newadd}    ${MEDIUM_WAIT}    Add link is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Click Element    ${button.assessment.assigned.update.additionaldeliverable.newadd}
    @{contenttypes}    Split String    ${perform_data}[ContentType]    ,
    @{deliverabletypes}    Split String    ${perform_data}[DeliverableType]    ,
    @{justifications}    Split String    ${perform_data}[Justification]    ,
    ${count}    Get Length    ${contenttypes}
    FOR    ${element}    IN RANGE    0    ${count}
        ${index}    Evaluate    ${element}+1
        Wait Until Time    1
        ${dropdown.assessment.performassessment.update.newadditiondeliverable}    Update Dynamic Value    ${dropdown.assessment.performassessment.update.add_deliverable}    ddlValidationType
        Wait Until Time    2
        Wait Until Element Is Visible    (${dropdown.assessment.performassessment.update.newadditiondeliverable})[${index}]    ${MEDIUM_WAIT}
        Select From List By Label    (${dropdown.assessment.performassessment.update.newadditiondeliverable})[${index}]    ${contenttypes}[${element}]
        ${dropdown.assessment.performassessment.update.newdeliverabletype}    Update Dynamic Value    ${dropdown.assessment.performassessment.update.add_deliverable}    ddlDocumentDeliverableType
        Wait Until Time    2
        Wait Until Element Is Visible    (${dropdown.assessment.performassessment.update.newdeliverabletype})[${index}]    ${MEDIUM_WAIT}
        Select From List By Label    (${dropdown.assessment.performassessment.update.newdeliverabletype})[${index}]    ${deliverabletypes}[${element}]
        ${just_index}    Evaluate    ${element}+2
        ${textbox.assessment.performassessment.update.newjustification}    Update Dynamic Value    ${textbox.assessment.performassessment.update.justification}    txtJustification
        Wait Until Time    2
        Wait Until Element Is Visible    (${textbox.assessment.performassessment.update.newjustification})[${just_index}]    ${MEDIUM_WAIT}
        Input Text    (${textbox.assessment.performassessment.update.newjustification})[${just_index}]    ${justifications}[${element}]
        Wait Until Time    2
    END

Verify Additional Deliverables Under Validation Deliverables Section
    [Arguments]    ${perform_data}
    [Documentation]    This keyword is used to Verify the additional deliverable mandatory and optional icons under the validation deliverables section
    @{mandatory_contenttypes}    Split String    ${perform_data}[MandatoryContentType]    ,
    @{optional_contenttypes}    Split String    ${perform_data}[OptionalContentType]    ,
    FOR    ${element}    IN    @{mandatory_contenttypes}
        ${icon.assessment.assigned.validatedeliverables.contenttype.newmandatory}    Update Dynamic Value    ${icon.assessment.assigned.validatedeliverables.contenttype.mandatory}    ${element}
        Wait Until Time    1
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${icon.assessment.assigned.validatedeliverables.contenttype.newmandatory}    ${MEDIUM_WAIT}    Red icon is not visible for mandatory field after waiting for ${MEDIUM_WAIT} seconds
        # Log Actual And Expected Results    Mandatory deliverables icon displayed in red colour    Mandatory deliverables icon should be displayed in red colour
    END
    FOR    ${element}    IN    @{optional_contenttypes}
        ${icon.assessment.assigned.validatedeliverables.contenttype.newoptioanl}    Update Dynamic Value    ${icon.assessment.assigned.validatedeliverables.contenttype.optional}    ${element}
        Wait Until Time    1
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${icon.assessment.assigned.validatedeliverables.contenttype.newoptioanl}    ${MEDIUM_WAIT}    Blue icon is not visible for mandatory field after waiting for ${MEDIUM_WAIT} seconds
        # Log Actual And Expected Results    Optional deliverables icon displayed in blue colour    Optional deliverables icon should be displayed in blue colour
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Add A New Row To The Additional Deliverable
    [Documentation]    This keyword is used to add the row in the Additional Deliverable page
    ${button.assessment.assigned.update.additionaldeliverable.newadd}    Update Dynamic Value    ${button.common.name}    btnAddUpdateDeliverables
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.assessment.assigned.update.additionaldeliverable.newadd}    ${MEDIUM_WAIT}    Add link is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.assessment.assigned.update.additionaldeliverable.newadd}
    Wait Until Time    3
    ${count}    Get Element Count    ${label.assessment.perform.assessment.validatedeliverables.update.rows}
    RETURN    ${count}

Delete Row In Additional Deliverable Page
    [Arguments]    ${perform_data}
    [Documentation]    This keyword is used to delete the row in the Additional Deliverable page
    ${checkbox.assessment.assigned.update.additionaldeliverable.newremove}    Update Dynamic Value    ${button.common.name}    ${perform_data}[DeleteRow]
    Wait Until Time    2
    Wait Until Element Is Visible    ${checkbox.assessment.assigned.update.additionaldeliverable.newremove}    ${MEDIUM_WAIT}
    Select Checkbox    ${checkbox.assessment.assigned.update.additionaldeliverable.newremove}
    Wait Until Time    2
    Wait Until Element Is Visible    ${img.assessment.assigned.validatedeliverables.update.remove}    ${MEDIUM_WAIT}    Remove icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${img.assessment.assigned.validatedeliverables.update.remove}
    Wait Until Time    3

Verify Row Is Deleted
    [Arguments]    ${count}
    [Documentation]    This keyword is used to Verify the deleted row in the Additional Deliverable page
    Wait Until Time    1
    ${after_delete}    Get Element Count    ${label.assessment.perform.assessment.validatedeliverables.update.rows}
    ${count}    Evaluate    ${count}-1
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Be Equal    ${count}    ${after_delete}

Add Define Deliverables And Task Dependencies For The Assessment
    [Arguments]    ${perform_data}    ${ENTITY}
    [Documentation]    This keyword is used to add Define Deliverables and Task Dependencies For The Assessment
    ${button.assessment.perform.assessment.assigned.newdefine}    Update Dynamic Value    ${button.common.name}    btnDefineAction
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.assessment.perform.assessment.assigned.newdefine}    ${MEDIUM_WAIT}    Define link is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.assessment.perform.assessment.assigned.newdefine}
    Wait Until Time    1
    Wait Until Element Is Visible    ${label.assessment.perform_assessment.define.taskdependencypage}    ${MEDIUM_WAIT}
    Navigate To Page Title Tab    Task Dependency
    Enter Values For Task Dependency Section    ${perform_data}
    Navigate To Page Title Tab    Define Deliverables
    Enter Values For Define Deliverables Section    ${perform_data}    ${ENTITY}
    ${button.assessment.performassessment.update.additiondeliverable.newsubmit}    Update Dynamic Value    ${button.common.name}    btnDefineActionSubmit
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.assessment.performassessment.update.additiondeliverable.newsubmit}    ${MEDIUM_WAIT}
    Click Element    ${button.assessment.performassessment.update.additiondeliverable.newsubmit}
    Verify Notification Popup    Actions Saved    btnSavedAction
    Wait Until Time    2
    Wait Until Element Is Visible    ${img.assessment.assigned.define.close}    ${MEDIUM_WAIT}    Close icon is not visible after waiting for ${MEDIUM_WAIT} secconds
    Click Element    ${img.assessment.assigned.define.close}

Enter Values For Task Dependency Section
    [Arguments]    ${perform_data}
    [Documentation]    This keyword is used to enter values for the task dependency fields
    @{predecessor_values}    Split String    ${perform_data}[Predecessor]    ,
    @{process_values}    Split String    ${perform_data}[Process]    ,
    @{enforced_values}    Split String    ${perform_data}[Enforcedin]    ,
    @{finishpoint_values}    Split String    ${perform_data}[FinishPoint]    ,
    ${index}    Set Variable    1
    Wait Until Time    2
    FOR    ${key}    IN    @{predecessor_values}
        ${dropdown.assessment.performassessment.define.newpredecessor}    Update Dynamic Value    ${dropdown.assessment.performassessment.update.add_deliverable}    ddlDependency
        Wait Until Time    1
        Wait Until Element Is Visible    (${dropdown.assessment.performassessment.define.newpredecessor})[${index}]    ${MEDIUM_WAIT}    Predecessor is not visible after waiting for ${MEDIUM_WAIT} seconds
        Select From List By Label    (${dropdown.assessment.performassessment.define.newpredecessor})[${index}]    ${key}
        ${index}    Evaluate    ${index}+1
        Wait Until Time    1
    END
    ${index}    Set Variable    2
    FOR    ${key}    IN    @{process_values}
        ${dropdown.assessment.performassessment.define.newprocessor}    Update Dynamic Value    ${dropdown.assessment.performassessment.update.add_deliverable}    ddlProcess
        Wait Until Time    1
        Wait Until Element Is Visible    (${dropdown.assessment.performassessment.define.newprocessor})[${index}]    ${MEDIUM_WAIT}    Process is not visible after waiting for ${MEDIUM_WAIT} seconds
        Select From List By Label    (${dropdown.assessment.performassessment.define.newprocessor})[${index}]    ${key}
        Wait Until Time    1
        ${index}    Evaluate    ${index}+1
    END
    ${index}    Set Variable    3
    FOR    ${key}    IN    @{enforced_values}
        ${dropdown.assessment.performassessment.define.newenforcedin}    Update Dynamic Value    ${dropdown.assessment.performassessment.update.add_deliverable}    ddlenforce
        Wait Until Time    1
        Wait Until Element Is Visible    (${dropdown.assessment.performassessment.define.newenforcedin})[${index}]    ${MEDIUM_WAIT}    Enforcedin is not visible after waiting for ${MEDIUM_WAIT} seconds
        Select From List By Label    (${dropdown.assessment.performassessment.define.newenforcedin})[${index}]    ${key}
        Wait Until Time    1
        ${index}    Evaluate    ${index}+1
    END
    ${index}    Set Variable    1
    FOR    ${key}    IN    @{finishpoint_values}
        ${dropdown.assessment.performassessment.define.newefinishpoint}    Update Dynamic Value    ${dropdown.assessment.performassessment.define.finishpoint}    ddlfinishpoint
        Wait Until Time    1
        Wait Until Element Is Visible    (${dropdown.assessment.performassessment.define.newefinishpoint})[${index}]    ${MEDIUM_WAIT}    FinishPoint is not visible after waiting for ${MEDIUM_WAIT} seconds
        Select From List By Label    (${dropdown.assessment.performassessment.define.newefinishpoint})[${index}]    ${key}
        Wait Until Time    1
        ${index}    Evaluate    ${index}+1
    END

Enter Values For Define Deliverables Section
    [Arguments]    ${perform_data}    ${ENTITY}
    [Documentation]    This keyword is used to enter values for the Define Deliverables fields
    Select Entity/Entity Type Using Filter    ${ENTITY}    EntityGridLookup_B-1    EntityGridLookup
    Wait Until Time    2
    @{actions}    Split String    ${perform_data}[Action]    ,
    ${index}    Set Variable    1
    FOR    ${element}    IN    @{actions}
        ${dropdown.assessment.performassessment.define.newactions}    Update Dynamic Value    ${dropdown.assessment.performassessment.update.add_deliverable}    ddlAction
        Wait Until Time    1
        Wait Until Element Is Visible    (${dropdown.assessment.performassessment.define.newactions})[${index}]    ${MEDIUM_WAIT}    Enforcedin is not visible after waiting for ${MEDIUM_WAIT} seconds
        Select From List By Label    (${dropdown.assessment.performassessment.define.newactions})[${index}]    ${element}
        ${index}    Evaluate    ${index}+1
        Wait Until Time    2
    END
    ${doc_index}    Set Variable    ${perform_data}[DocumentColumn]
    ${dropdown.assessment.performassessment.define.actions.newdocumentno}    Update Dynamic Value    ${dropdown.assessment.performassessment.update.add_deliverable}    ddlValdocNo
    Wait Until Time    2
    Wait Until Element Is Visible    (${dropdown.assessment.performassessment.define.actions.newdocumentno})[${doc_index}]    ${MEDIUM_WAIT}    Document No. is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select From List By Label    (${dropdown.assessment.performassessment.define.actions.newdocumentno})[${doc_index}]    ${perform_data}[Document]
    Wait Until Time    3

Verify Action Values Under View Saved Actions
    [Arguments]    ${perform_data}
    [Documentation]    This keyword is used to Verify the selected action values under view saved actions in perform assessment page
    Wait Until Time    2
    Select The Section    View Saved Actions
    @{actions}    Split String    ${perform_data}[Action]    ,
    FOR    ${element}    IN    @{actions}
        ${label.assessment.perform_assessment.viewsavedactions.newactions}    Update Dynamic Value    ${label.assessment.perform_assessment.viewsavedactions.actions}    ${element}
        Wait Until Time    1
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.assessment.perform_assessment.viewsavedactions.newactions}    ${MEDIUM_WAIT}    ${element} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    1
    END
    ${label.assessment.perform_assessment.viewsavedactions.newdocumentno}    Update Dynamic Value    ${label.assessment.perform_assessment.viewsavedactions.documentno}    ${perform_data}[Document]
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.assessment.perform_assessment.viewsavedactions.newdocumentno}    ${MEDIUM_WAIT}    ${perform_data}[Document] is not visible under View Saved Actions sections after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${actual_result}    Set Variable    New Authoring, External Authoring and Bind Approved Documents with document number is displayed under View Saved Actions
    ${expected_result}    Set Variable    New Authoring, External Authoring and Bind Approved Documents with document number should be displayed under View Saved Actions
    # Log Actual And Expected Results    ${actual_result}    ${expected_result}

Approve Assessment
    [Arguments]    ${perform_data}    ${username}    ${password}
    [Documentation]    This keyword is used to approve the assessment
    Select Value For Radio Button    ApprovalReq    ${perform_data}[Approval]
    IF    '${perform_data}[Approval]'=='rdoApprovalReqYes' and 'Workflow' in ${perform_data}    Select Value From Dropdown    ddlWorkflow    ${perform_data}[Workflow]
    ${button.assessment.perform_assessment.newsubmit}    Update Dynamic Value    ${button.common.name}    btnSubmit
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.assessment.perform_assessment.newsubmit}
    Click Element    ${button.assessment.perform_assessment.newsubmit}
    Handle Electronic Sign    ${username}    ${password}    Submit
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.assessment.perform_assessment.submit.popup}    ${SHORT_WAIT}
    ${message}    Set Variable    Assessment plan document is not yet generated. Do you want to Continue?
    IF    '${status}'=='True'    Verify Notification Popup    ${message}    btnSubmitWODocument
    ${EXPECTED_MESSAGE}    Set Variable    Assessment ${PERFORM_ASSESSMENT_NO} has been approved
    Set Test Variable    ${EXPECTED_MESSAGE}

Create the Section
    [Documentation]    This keyword is to create different types of section.
    [Arguments]    ${section_data}    ${USER}    ${USER_PASSWORD}
    ${count}    Get Length    ${section_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${dict_data}    Set Variable    ${section_data}[${key}]
        Click Button In VLMS    Create
        IF    'Action' in ${dict_data}    Select Value For Radio Button    rbtNew    ${dict_data}[Action]
        IF    'SectionName' in ${dict_data}    Enter Text In Mandatory Fields    SectionName    ${dict_data}[SectionName]
        IF    'SectionType' in ${dict_data}    Select Value From Dropdown    ddlSectionTypes_chosen    ${dict_data}[SectionType]
        Wait Until Time    3
        IF    'DecisionTreeReq' in ${dict_data}    Select Value For Radio Button    rbtnIsDeciTreeReqYes    ${dict_data}[DecisionTreeReq]
        Wait Until Time    3
        IF    'DecisionTreefor' in ${dict_data}    Select Dropdown Value With Partial Text    ddlDecisionTree_chosen    ${dict_data}[DecisionTreefor]
        Wait Until Time    3
        @{list_of_SelectAssessors}    Split String    ${dict_data}[SelectAssessors]    ,
        ${count}    Get Length    ${list_of_SelectAssessors}
        FOR    ${key}    IN RANGE    0    ${count}
            Select Value From Dropdown    lstAssinGroup_chosen    ${list_of_SelectAssessors}[${key}]        
        END
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        ${Expected_Result}    Set Variable    ${dict_data}[SectionName] section has been created
        Get Value From Toast Message    ${Expected_Result}
    END

Create Validation Standard
    [Arguments]    ${validation_standard}    ${User}    ${User_password}
    ${count}    Get Length    ${validation_standard}
    FOR    ${key}    IN RANGE    0    ${count}
        ${validation_standard_data}    Set Variable    ${validation_standard}[${key}]
        Click Button In VLMS    Create
        Wait Until Element Is Visible    txtRegulationName    3
        Enter Text In Mandatory Fields    RegulationName     ${validation_standard_data}[ValidationStandardName]
        Wait Until Element Is Visible    txtPrefix    2
        Enter Text In Mandatory Fields    Prefix     ${validation_standard_data}[Prefix] 
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${User}    ${User_password}    Submit    created
        ${Expected_Result}    Set Variable    ${validation_standard_data}[ValidationStandardName] Validation Standard has been created
        Get Value From Toast Message    ${Expected_Result}
    END