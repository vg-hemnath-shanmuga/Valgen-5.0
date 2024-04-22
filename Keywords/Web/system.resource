*** Settings ***
Documentation     This system resource file has all the system keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Create Entity
    # robocop: disable=too-many-calls-in-keyword
    [Arguments]    ${entity_data}    ${user_name}    ${password}
    [Documentation]    This Keyword will create entity
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create Entity
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create Entity page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'Category' in ${entity_data}    Select Value From Dropdown    ddlCategory-container    ${entity_data}[Category]
    Wait Until Time    ${SHORT_WAIT}
    IF    'SubCategory' in ${entity_data}    Select Value From Dropdown    ddlSubCategory1-container    ${entity_data}[SubCategory]
    Wait Until Time    ${SHORT_WAIT}
    IF    'SystemAssessment' in ${entity_data}    Select Value For Radio Button   ValidationAssessmentReq    ${entity_data}[SystemAssessment]
    Wait Until Time    2
    IF    'AssignSystem' in ${entity_data}    Select Value For Radio Button    ValAssignYes    ${entity_data}[AssignSystem]
    Wait Until Time    2
    IF    'ScheduleAssessment' in ${entity_data}    Select Value For Radio Button   ScheduleAssessmentReq    ${entity_data}[ScheduleAssessment]
    Wait Until Time    4
    IF    'EntityName' in ${entity_data}    Enter Text In Mandatory Fields    EntityName    ${entity_data}[EntityName]
    Select Value From Dropdown    select2-ddlEntityType-container    ${ENTITY_TYPE_NAME}
    Wait Until Time    2
    IF    'EntityNo' in ${entity_data}    Enter Text In Mandatory Fields    EntityNO    ${entity_data}[EntityNo]
    IF    'AssessmentPlanTemplate' in ${entity_data}    Select Value From Dropdown    select2-ddlValidationTemplate-container    ${entity_data}[AssessmentPlanTemplate]
    IF    'Description' in ${entity_data}    Enter Comments/Description    txtDescription    ${entity_data}[Description]
    IF    'SystemOwner' in ${entity_data}    Select Dropdown Value With Partial Text    select2-ddlSysOwner-container    ${entity_data}[SystemOwner]
    IF    'BusinessOwner' in ${entity_data}    Enter Comments/Description    txtBusinessOwner    ${entity_data}[BusinessOwner]
    IF    'IntendedUse' in ${entity_data}    Select Value From Dropdown    ddlIntendedUse_I    ${entity_data}[IntendedUse]
    IF    'AssessmentName' in ${entity_data}    Enter Comments/Description    txtValAssName    ${entity_data}[AssessmentName]
    IF    'Assignment' in ${entity_data}    Choose Assignee Type    ${entity_data}[Assignment]    ${entity_data}[AssignTo]
    IF    'Design' in ${entity_data}    Select Value For Radio Button   rbtDesignManagerNo    ${entity_data}[Design]
    IF    'StatusAlertGroup' in ${entity_data}    Swipe Values Between Groups    ${entity_data}[StatusAlertGroup]    lstAvailbleGroup    lstAssinGroup
    Wait Until Time    4
    IF    'SelectedGroup' in ${entity_data}    Swipe Values Between Groups    ${entity_data}[SelectedGroup]    lstAssinGroup    lstAvailbleGroup
    Wait Until Time    2
    IF    'Button' in ${entity_data}    Select Submit/Reset Button    ${entity_data}[Button]
    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${ENTITY}    Set Variable    ${entity_data}[EntityName]
    Set Suite Variable    ${ENTITY}
    ${ENTITY_NO}    Set Variable    ${entity_data}[EntityNo]
    Set Suite Variable    ${ENTITY_NO}

Create Entity prerequiste
    # robocop: disable=too-many-calls-in-keyword
    [Arguments]    ${entitytype_data}    ${user_name}    ${password}
    [Documentation]    This Keyword will create entity
    ${count}    Get Length    ${entitytype_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${entity_data}    Set Variable     ${entitytype_data}[${key}]
        Click Button In VLMS    Create
        ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create Entity
        Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create Entity page is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    'Category' in ${entity_data}    Select Value From Dropdown    ddlCategory_chosen    ${entity_data}[Category]
        Wait Until Time    3
        IF    'SubCategory' in ${entity_data}    Select Value From Dropdown    ddlSubCat_chosen    ${entity_data}[SubCategory]
        Wait Until Time    3
        IF    'SystemAssessment' in ${entity_data}    Select Value For Radio Button   ValidationAssessmentReq    ${entity_data}[SystemAssessment]
        IF    'AssignSystem' in ${entity_data}    Select Value For Radio Button    ValAssignYes    ${entity_data}[AssignSystem]
        IF    'ScheduleAssessment' in ${entity_data}    Select Value For Radio Button   ScheduleAssessmentReq    ${entity_data}[ScheduleAssessment]
        Wait Until Time    2
        IF    'EntityName' in ${entity_data}    Enter Text In Mandatory Fields    EntityName    ${entity_data}[EntityName]
        Select Value From Dropdown    ddlEntityType_chosen    ${entity_data}[EntityType]
        Wait Until Time    2
        IF    'EntityNo' in ${entity_data}    Enter Text In Mandatory Fields    EntityNO    ${entity_data}[EntityNo]
        IF    'AssessmentPlanTemplate' in ${entity_data}    Select Value From Dropdown    select2-ddlValidationTemplate-container    ${entity_data}[AssessmentPlanTemplate]
        IF    'Description' in ${entity_data}    Enter Comments/Description    txtDescription    ${entity_data}[Description]
        IF    'SystemOwner' in ${entity_data}    Enter Text In Mandatory Fields    SysOwner    [${user_name}]
        IF    'BusinessOwner' in ${entity_data}    Enter Comments/Description    txtBusinessOwner    ${user_name}
        IF    'IntendedUse' in ${entity_data}    Select Value From Dropdown    ddlIntendedUse_I    ${entity_data}[IntendedUse]
        IF    'AssessmentName' in ${entity_data}    Enter Comments/Description    txtValAssName    ${entity_data}[AssessmentName]
        IF    'Assignment' in ${entity_data}    Choose Assignee Type    ${entity_data}[Assignment]    ${entity_data}[AssignTo]
        IF    'Design' in ${entity_data}    Select Value For Radio Button   DesignManager    ${entity_data}[Design]
        Wait Until Time    ${SHORT_WAIT}
        IF    'StatusAlertGroup' in ${entity_data}    Select Value From Dropdown    lstGroup_chosen        ${entity_data}[StatusAlertGroup]
        Wait Until Time    4
        IF    'SelectedGroup' in ${entity_data}    Swipe Values Between Groups_Prerequisite    ${entity_data}[SelectedGroup]    lstAssinGroup    lstAvailbleGroup
        Wait Until Time    2
        IF    'Button' in ${entity_data}    Select Submit/Reset Button    ${entity_data}[Button]
        Handle Electronic Sign    ${user_name}    ${password}    Submit
        ${Expected_Result}    Set Variable    ${entity_data}[EntityName] entity ${entity_data}[EntityNo] has been created
        Get Value From Toast Message    ${Expected_Result}
    END

Navigate To Create Entity Type
    [Documentation]    This keyword is used to navigate to the create entity type page
    Menu Navigation_5.0    System    Entity    Entity Type
    Click Button In VLMS    Create

Get Entity Type ID
    [Documentation]    This keyword is used to get the entity type id
    Wait Until Element Is Visible    ${label.system.create.entity_type}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_entity_type_id}    Get Text    ${label.system.create.entity_type_code}
    #${updated_entity_type_id}    Remove String    ${actual_entity_type_id}    <    >
    ${ENTITY_TYPE_ID}    Set Variable    ${actual_entity_type_id}
    Set Suite Variable    ${ENTITY_TYPE_ID}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Enter Pre-requisite Details In Create Entity Type
    [Arguments]    ${system_entity_data}
    [Documentation]    This keyword is used to enter pre-requisite details in create entity type
    IF    'TaskType' in ${system_entity_data}    Select Value For Radio Button    DocType    ${system_entity_data}[TaskType]
    IF    'SelectEntityType' in ${system_entity_data}    Select Value From Dropdown    ddlRevisedEntType    ${system_entity_data}[SelectEntityType]
    IF    'EntityTypeName' in ${system_entity_data}    Input Text    ${textbox.system.create.entity_type}    ${system_entity_data}[EntityTypeName]
    IF    'Prefix' in ${system_entity_data}    Input Text    ${textbox.system.create.entity.prefix}    ${system_entity_data}[Prefix]
    IF    '${system_entity_data}[EntityNoType]'=='ConfigAutomated' or '${system_entity_data}[EntityNoType]'=='ConfigHybrid'
        Select Value For Radio Button    EntConfig    ${system_entity_data}[EntityNoType]
        Enter Unique ID Configuration Details    ${system_entity_data}
    END
    IF    'EntityNoType' in ${system_entity_data} or '${system_entity_data}[EntityNoType]'=='ConfigManual'
        Select Value For Radio Button    EntConfig    ${system_entity_data}[EntityNoType]
    END
    IF    'DepartmentRequired' in ${system_entity_data}    Select Value For Radio Button    DepartmentReq    ${system_entity_data}[DepartmentRequired]
    Wait Until Time    3
    IF    'VersioningRequired' in ${system_entity_data}    Select Value For Radio Button    VerReq    ${system_entity_data}[VersioningRequired]
    Wait Until Time    2
    IF    'VersionFormat' in ${system_entity_data}    Select Value From Dropdown    ddlVersionFormat    ${system_entity_data}[VersionFormat]
    Wait Until Time    3
    IF    'EntityFormType' in ${system_entity_data}    Select Value From Dropdown    EntTypeSelect-container    ${system_entity_data}[EntityFormType]
    ${ENTITY_TYPE_NAME}    Set Variable    ${system_entity_data}[EntityTypeName]
    Set Suite Variable    ${ENTITY_TYPE_NAME}

Enter Unique ID Configuration Details
    [Arguments]    ${configuration_details}
    [Documentation]    This keyword is used to enter details in Unique Id Configuration
    Wait Until Time    3
    IF    'StartingNo' in ${configuration_details}    Enter Text In Mandatory Fields    EntityStartingNo    ${configuration_details}[StartingNo]
    IF    'SelectedTags' in ${configuration_details}    Swipe Values Between Groups    ${configuration_details}[SelectedTags]    lstEntAvailTag    lstEntSelectTag
    IF    'DeselectTags' in ${configuration_details}    Swipe Values Between Groups    ${configuration_details}[DeselectTags]    lstEntSelectTag    lstEntAvailTag
    IF    'Separator' in ${configuration_details}    Select Value From Dropdown    ddlEntSepartor    ${configuration_details}[Separator]
    IF    'SerialNolength' in ${configuration_details}    Select Value From Dropdown    ddlEntSNoLength    ${configuration_details}[SerialNolength]

Enter Standard Form Details In Create Entity Type
    [Arguments]    ${system_entity_data}    ${assessment_template}
    [Documentation]    This keyword is used to enter standard form details(Getting Framework Name variable from Create Framework keyword)
    IF    'AssessmentRequired' in ${system_entity_data}    Select Value For Radio Button    SystemAssessmentRequired    ${system_entity_data}[AssessmentRequired]
    IF    'AssessmentTemplate' in ${system_entity_data}    Select Dropdown Value With Partial Text    ddlPlanAssessmentSelect    ${assessment_template}
    Wait Until Time    4
    IF    'Framework' in ${system_entity_data}
        Select Framework    ${FRAMEWORK_NAME}
        Set Validation Rule For Framework    ${system_entity_data}[CriteriaBasedOn]    ${system_entity_data}[EntityStatusValidation]
        Validation Criteria    ${system_entity_data}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Create Entity Type
    [Arguments]    ${system_entity_data}    ${assessment_template}=None
    [Documentation]     This keyword is used to create new entity type
    Get Entity Type ID
    Enter Pre-requisite Details In Create Entity Type    ${system_entity_data}
    Enter Standard Form Details In Create Entity Type    ${system_entity_data}    ${assessment_template}
    IF    'ApprovalRequired' in ${system_entity_data}    Select Value For Radio Button    check    ${system_entity_data}[ApprovalRequired]
    IF    'WorkFlow' in ${system_entity_data}    Select Value From Dropdown    ddlWorkFlow    ${system_entity_data}[WorkFlow]
    IF    'RouteFor' in ${system_entity_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${system_entity_data}[RouteFor]
    IF    'Comments' in ${system_entity_data}    Enter Comments/Description    txtComments    ${system_entity_data}[Comments]
    IF    'Button' in ${system_entity_data}    Select Submit/Reset Button    ${system_entity_data}[Button]
    Wait Until Time    2

Verify Entity Type
    [Arguments]    ${username}    ${password}    ${system_entity_data}
    [Documentation]    This keyword is used to Verify entity type id
    IF    '${system_entity_data}[ApprovalRequired]'=='rdoAppYes' or '${system_entity_data}[ApprovalRequired]'=='rdoYes'
        Verify Document Is Routed For Peer Review/Review/Approval    ${username}    ${password}    ${system_entity_data}[EntityTypeName] entity type ${ENTITY_TYPE_ID} has been routed for ${system_entity_data}[RouteFor]
    ELSE IF    '${system_entity_data}[ApprovalRequired]'=='rdoAppNo' or '${system_entity_data}[ApprovalRequired]'=='rdoNo'
        Verify Document Is Routed For Peer Review/Review/Approval    ${username}    ${password}    ${system_entity_data}[EntityTypeName] entity type ${ENTITY_TYPE_ID} has been created
    END

Swipe Values Between Groups
    [Arguments]    ${groups_values}    ${source_group}    ${destination_group}
    [Documentation]    This keyword is used to swipe values between source and destination groups
    ${groups_list_items}    Split String    ${groups_values}    ,
    ${count}    Get Length    ${groups_list_items}
    FOR    ${key}    IN RANGE   0    ${count}
        ${label.system.entity.newgroups_selection}    Update Dynamic Values    ${label.system.entity.groups_selection}    ${source_group}    ${groups_list_items}[${key}]
        ${source_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.system.entity.newgroups_selection}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    '${source_status}'=='True'
            Click Element    ${label.system.entity.newgroups_selection}
            Click Element    ${label.system.entity.newgroups_selection}
            Wait Until Time    1
            Double Click Element    ${label.system.entity.newgroups_selection}
            ${label.system.entity.newgroups_selection}    Update Dynamic Values    ${label.system.entity.groups_selection}    ${destination_group}    ${groups_list_items}[${key}]
            Wait Until Element Is Visible    ${label.system.entity.newgroups_selection}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible.
        END
    END

Verify Document Details And Status
    [Arguments]    ${expected}
    [Documentation]    It is used to Verify document status
    ${entity}    Set Variable    ${ENTITY_NAME} (${ENTITY_NUMBER})
    Click Button In VLMS    ${entity}
    Select Frame    ${iframe.home.inventory_details}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.home.inventory.entity.validation_status}    ${MEDIUM_WAIT}    Status is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_status}    Run Keyword And Continue On Failure    Get Text    ${label.home.inventory.entity.validation_status}
    ${label.home.inventory.entity.newdocument_number}    Update Dynamic Value    ${label.home.inventory.entity.document_number}    ${ENTITY_ID}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.home.inventory.entity.newdocument_number}    ${MEDIUM_WAIT}    ${ENTITY_ID} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Verify String Should Be Equal    ${actual_status}    ${expected}
    Scroll Element Into View    ${label.home.inventory.entity.newdocument_number}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Navigate To Create Form Page
    [Documentation]    This keyword will navigate to Create Form Page
    Navigate To Module Tab    System    Create    Form    Select Form List
    Click Button In VLMS    Create

Create Form
    [Arguments]    ${form_data}    ${field_data1}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Form
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.system.create.form.header}    ${MEDIUM_WAIT}    Create Form header is not visible after waiting for ${MEDIUM_WAIT} seconds
    Enter Details In Create Form Page    ${form_data}
    IF    'ValidateFieldTypes' in ${form_data}    Verify Field Types In Control Creation Screen    ${form_data}[ValidateFieldTypes]
    ${form_field_details}    Create Dictionary
    IF    'FieldType' in ${form_data}
        Drag And Drop Field Types To Form Field Details Grid    ${form_data}[FieldType]    ${form_data}[CellIndex]
        Add Settings To Form Fields    ${form_data}
        Verify Form Field Is Displayed Under Form Field Details Grid    ${form_data}
        Set To Dictionary    ${form_field_details}    ${form_data}[Label]    ${form_data}[FieldType]
    END
    IF    'FieldType' in ${field_data1}
        Drag And Drop Field Types To Form Field Details Grid    ${field_data1}[FieldType]    ${field_data1}[CellIndex]
        Add Settings To Form Fields    ${field_data1}
        Verify Form Field Is Displayed Under Form Field Details Grid    ${field_data1}
        Set To Dictionary    ${form_field_details}    ${field_data1}[Label]    ${field_data1}[FieldType]
    END
    Click Element    ${button.system.create.form.control_creation.save}
    Verify Form Field Details Grid In Create Form Page    ${form_field_details}
    IF    'Button' in ${form_data}    Select Submit/Reset Button    ${form_data}[Button]
    IF    'eSign' in ${form_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    ${form_data}[FormName] Form has been created
    RETURN    ${EXPECTED_MESSAGE}

Create Form prerequsite
    [Arguments]    ${dic_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Form
    ${rows}   Get Length    ${dic_data}
    FOR    ${key}    IN RANGE    0   ${rows}
        ${dict_data}    Set Variable    ${dic_data}[${key}]
        Click Button In VLMS    Create
        IF    '${dict_data}[FormType]'=='Standard Form'     Standard form creation prerequisite    ${dict_data}   ${user_name}    ${password}
        IF   '${dict_data}[FormType]'=='Exception Form'     Exception form creation prerequiste    ${dict_data}   ${user_name}    ${password}
        IF   '${dict_data}[FormType]'=='Discrepancy Form'     Exception form creation prerequiste    ${dict_data}   ${user_name}    ${password}
        IF   '${dict_data}[FormType]'=='Deviation Form'     Exception form creation prerequiste    ${dict_data}   ${user_name}    ${password}        
        IF    '${dict_data}[FormType]'=='Framework Form'    Framework and Project Form creation with Textbox Control     ${dict_data}   ${user_name}    ${password}
        IF    '${dict_data}[FormType]'=='Project Form'    Framework and Project Form creation with Textbox Control     ${dict_data}   ${user_name}    ${password}
        IF    '${dict_data}[FormType]'=='Internal Process Map'    IPM form cration for prerequiste    ${dict_data}   ${user_name}    ${password}
        IF    'Button' in ${dict_data}    Select Submit/Reset Button    ${dict_data}[Button]
        Handle Electronic Sign    ${user_name}    ${password}    Submit
        Wait Until Element Clickable    //input[@id='btnCreate']
        ${Expected_Result}    Set Variable    ${dict_data}[FormName] Form has been created
        Get Value From Toast Message    ${Expected_Result}
        #Verify Confirmation Popup    ${dict_data}[FormName] Form has been created    btnMessageOk
    END

Enter Details In Create Form Page
    [Arguments]    ${form_data}
    [Documentation]    This Keyword is used to Enter Details In Create Form Page
    Wait Until Time    2
    IF    'FormType' in ${form_data}
        Wait Until Element Is Visible    ${textbox.system.create.form.form_type}    ${MEDIUM_WAIT}    Form type is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${textbox.system.create.form.form_type}
        Input Text    ${textbox.system.create.form.form_type}    ${form_data}[FormType]
        ${label.system.create.form.newform_type}    Update Dynamic Value    ${label.system.create.form.form_type}    ${form_data}[FormType]
        Wait Until Time    2
        Wait Until Element Is Visible    ${label.system.create.form.newform_type}    ${MEDIUM_WAIT}    ${form_data}[FormType] is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${label.system.create.form.newform_type}
        Wait Until Time    3
    END
    IF    'FormName' in ${form_data}    Enter Text In Mandatory Fields    FormName    ${form_data}[FormName]
    IF    'FormApplicableTo' in ${form_data}
        Wait Until Time    1
        Wait Until Element Is Visible    ${checkbox.system.create.form.form_applicable.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    '${form_data}[FormApplicableTo]'=='SelectAll'
            Select Checkbox    ${checkbox.system.create.form.form_applicable.select_all}
        ELSE
            @{select_list}    Split String    ${form_data}[FormApplicableTo]    ,
            FOR    ${key}    IN    @{select_list}
                ${checkbox.system.create.form.form_applicable_to.newtype}    Update Dynamic Value    ${checkbox.system.create.form.form_applicable_to.type}    ${key}
                Wait Until Time    1
                Wait Until Element Is Visible    ${checkbox.system.create.form.form_applicable_to.newtype}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
                Select Checkbox    ${checkbox.system.create.form.form_applicable_to.newtype}
            END
        END
    END
    IF    'Description' in ${form_data}    Enter Comments/Description    txtDescription    ${form_data}[Description]
    IF    'InheritFields' in ${form_data}    Select Value From Dropdown    ddlInherit    ${form_data}[InheritFields]
    IF    'AddControls' in ${form_data}    Click Button In VLMS    Add Controls
    IF    'CreateControls' in ${form_data}
        Wait Until Time    1
        Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation}    ${MEDIUM_WAIT}    Control Creation is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    'Row' in ${form_data}    Select Value From Dropdown    ddlRows    ${form_data}[Row]
        IF    'Column' in ${form_data}    Select Value From Dropdown    ddlColumns    ${form_data}[Column]
        IF    'CreateControls' in ${form_data}    Click Button In VLMS    Create Controls
    END

Verify Field Types In Control Creation Screen
    [Arguments]    ${fields_list}
    [Documentation]    This Keyword is used to Verify Field Types in Control Creation Screen in Create Form Page.
    @{list}    Split String    ${fields_list}    ,
    FOR    ${key}    IN    @{list}
        ${label.system.create.form.add_controls.control_creation.newfield}    Update Dynamic Value    ${label.system.create.form.add_controls.control_creation.fields}    ${key}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation.newfield}    ${SHORT_WAIT}    ${key} is not visible after waiting for ${SHORT_WAIT} seconds
        # Log Actual And Expected Results    ${key} is Displayed    ${key} should be Displayed
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Drag And Drop Field Types To Form Field Details Grid
    [Arguments]    ${field_type}    ${cell_index}
    [Documentation]    This Keyword is used to Verify Field Types in Control Creation in Create Form Screen.
    ${label.system.create.form.add_controls.control_creation.newfield}    Update Dynamic Value    ${label.system.create.form.add_controls.control_creation.fields}    ${field_type}
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation.newfield}    ${SHORT_WAIT}    ${field_type} is not visible after waiting for ${SHORT_WAIT} seconds
    ${textbox.system.create.form.add_controls.control_creation.form_field_details.newcell}    Update Dynamic Value    ${textbox.system.create.form.add_controls.control_creation.form_field_details.cell}    ${cell_index}
    Drag And Drop    ${label.system.create.form.add_controls.control_creation.newfield}    ${textbox.system.create.form.add_controls.control_creation.form_field_details.newcell}

Add Settings To Form Fields
    [Arguments]    ${form_data}
    [Documentation]    This Keyword is used to Add Settings To Form Fields
    ${icon.system.create.form.add_controls.control_creation.field.newsettings}    Update Dynamic Value    ${icon.system.create.form.add_controls.control_creation.field.settings}    ${form_data}[CellIndex]
    Wait Until Time    2
    Wait Until Element Is Visible    ${icon.system.create.form.add_controls.control_creation.field.newsettings}    ${MEDIUM_WAIT}    Settings Icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${icon.system.create.form.add_controls.control_creation.field.newsettings}
    IF    'Label' in ${form_data}    Enter Text In Mandatory Fields    LabelValue1    ${form_data}[Label]
    IF    'EnterOptions' in ${form_data}
        @{options}    Split String    ${form_data}[EnterOptions]    ,
        FOR    ${key}    IN    @{options}
            Enter Text In Mandatory Fields    Options    ${key}
            Click Element    ${link.system.create.form.control_creation.settings.add}
            ${label.system.create.form.control_creation.settings.newselected_option}    Update Dynamic Value    ${label.system.create.form.control_creation.settings.selected_option}    ${key}
            Wait Until Element Is Visible    ${label.system.create.form.control_creation.settings.newselected_option}    ${SHORT_WAIT}    Selected option ${key} is not visible after waiting for ${SHORT_WAIT} seconds
        END
    END
    IF    'Mandatory' in ${form_data}    Select Value For Radio Button    grpRequired    ${form_data}[Mandatory]
    IF    'TranslationRequired' in ${form_data}
        ${radiobutton.system.create.form.control_creation.settings.newtranslation_req}    Update Dynamic Value    ${radiobutton.system.create.form.control_creation.settings.translation_req}    ${form_data}[TranslationRequired]
        Wait Until Time    1
        Wait Until Element Is Visible    ${radiobutton.system.create.form.control_creation.settings.newtranslation_req}    ${MEDIUM_WAIT}
        Click Element    ${radiobutton.system.create.form.control_creation.settings.newtranslation_req}
    END
    IF    'HelpText' in ${form_data}
        Select Frame    ${iframe.system.create.form.control_creation.settings.helptext}
        Input Text    ${textbox.system.create.form.control_creation.settings.helptext}    ${form_data}[HelpText]
        Switch To Parent Frame
    END
    Click Element    ${button.system.create.form.control_creation.settings.save}
    Wait Until Time    2

Add Settings To Form Fields for prerequiste
    [Arguments]    ${form_data}    ${cell values}=None    
    [Documentation]    This Keyword is used to Add Settings To Form Fields
    IF    '${cell values}' == 'None'
        ${icon.system.create.form.add_controls.control_creation.field.newsettings}    Update Dynamic Value    ${icon.system.create.form.add_controls.control_creation.field.settings}    ${form_data}[CellIndex]
        Wait Until Element Is Visible    ${icon.system.create.form.add_controls.control_creation.field.newsettings}    ${MEDIUM_WAIT}    Settings Icon is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${icon.system.create.form.add_controls.control_creation.field.newsettings}   
    ELSE
        ${icon.system.create.form.add_controls.control_creation.field.newsettings}    Update Dynamic Value    ${icon.system.create.form.add_controls.control_creation.field.settings}    ${cell values}
        Wait Until Element Is Visible    ${icon.system.create.form.add_controls.control_creation.field.newsettings}    ${MEDIUM_WAIT}    Settings Icon is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${icon.system.create.form.add_controls.control_creation.field.newsettings}
    END
    IF    'Label' in ${form_data}    Enter Text In Mandatory Fields    LabelValue    ${form_data}[Label]
    Select Value For Radio Button    rdoRequiredNo    ${form_data}[Textbox Mandatory]
    Select Value For Radio Button    tbTransNotRequired    ${form_data}[Textbox Translation]
    Wait Until Time    3
    Double Click Element       //*[@id="txtLength"]
    Input Text    //*[@id="txtLength"]    ${form_data}[Textbox Length]
    IF    'HelpText' in ${form_data}
        Select Frame    ${iframe.system.create.form.control_creation.settings.helptext}
        Input Text    ${textbox.system.create.form.control_creation.settings.helptext}    ${form_data}[HelpText]
        Switch To Parent Frame
    END
    Scroll Element Into View    //input[@id="btnSaveSettings"]
    Click Element   //input[@id="btnSaveSettings"]
    Wait Until Time    2      

Verify Form Field Is Displayed Under Form Field Details Grid
    [Arguments]    ${form_data}
    [Documentation]    This Keyword is used to Verify Form Field Is Displayed Under Form Field Details Grid in Control Creation Screen
    ${label.system.create.form.control_creation.cell.newfield_label}    Update Dynamic Value    ${label.system.create.form.control_creation.cell.field_label}   ${form_data}[CellIndex]
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.system.create.form.control_creation.cell.newfield_label}    ${MEDIUM_WAIT}    Field Label is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Wait Until Element Contains    ${label.system.create.form.control_creation.cell.newfield_label}    ${form_data}[Label]    ${MEDIUM_WAIT}
    # Log Actual And Expected Results    ${form_data}[Label] is Displayed    ${form_data}[Label] should be Displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Form Field Details Grid In Create Form Page
    [Arguments]    ${form_field_details}
    [Documentation]    This Keyword is used to Verify Form Field Details Grid In Create Form Page
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.system.create.form.form_field_details.table}    ${MEDIUM_WAIT}    Form Field details table is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{fields}    Get Dictionary Keys    ${form_field_details}
    FOR    ${key}    IN    @{fields}
        ${field_type}    Get From Dictionary    ${form_field_details}    ${key}
        ${label.system.create.form.newform_field_details}    Update Dynamic Values    ${label.system.create.form.form_field_details}    ${key}    ${field_type}
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.system.create.form.newform_field_details}    ${SHORT_WAIT}    ${key} with ${field_type} type is not visible after waiting for ${SHORT_WAIT} seconds
        # Log Actual And Expected Results    ${key} with ${field_type} type is Displayed    ${key} with ${field_type} type should be Displayed
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Enter Multiple Answers
    [Arguments]    ${answers}
    [Documentation]    It is used to enter multiple answers to each question
    ${splitted_answers}    Split String    ${answers}    ,
    ${splitted_answers_count}    Get Length    ${splitted_answers}
    FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
        ${updated_answer_key}    Evaluate    ${answer_key}+2
        ${updated_answer_key}    Convert To String    ${updated_answer_key}
        ${textbox.system.create.decision_tree.newanswer}    Update Dynamic Value    ${textbox.system.create.decision_tree.answer}    ${updated_answer_key}
        Wait Until Element Is Visible    ${textbox.system.create.decision_tree.newanswer}    ${MEDIUM_WAIT}    Answer input textbox is not visible after waiting ${MEDIUM_WAIT} seconds
        Input Text    ${textbox.system.create.decision_tree.newanswer}    ${splitted_answers}[${answer_key}]
        IF    ${answer_key}+1<${splitted_answers_count}
            Click Element    ${link.system.create.decision_tree.section.answer.add}
        END
    END

Enter Details In Decision Tree Page
    [Arguments]    ${decision_tree_data}
    [Documentation]    It is used to enter all details in decision tree page
    Wait Until Time    2
    IF    'DecisionTreeName' in ${decision_tree_data}    Input Text    ${textbox.system.create.decision_tree}    ${decision_tree_data}[DecisionTreeName]
    IF    'Prefix' in ${decision_tree_data}    Input Text    ${textbox.system.create.entity.prefix}    ${decision_tree_data}[Prefix]
    IF    'DecisionTreeFor' in ${decision_tree_data}    Select Value From Dropdown    ddlDecisionTreeFor    ${decision_tree_data}[DecisionTreeFor]
    IF    'DuplicatesOfContent' in ${decision_tree_data}    Select Value From Dropdown    ddlContentGenerationType    ${decision_tree_data}[DuplicatesOfContent]
    IF    'SectionName' in ${decision_tree_data}
        Wait Until Time    2
        Input Text    ${textbox.system.create.decision_tree.section}    ${decision_tree_data}[SectionName]
        Click Element    ${link.system.create.decision_tree.section.add}
        Select The Section    ${decision_tree_data}[SectionName]
        Save Questions And Answers In Section    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]
        Navigate To Page Title Tab    Define Action
        Enter Details In Define Action Tab    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]    ${decision_tree_data}[DecisionRequired]    ${decision_tree_data}
    END
    Click Button In VLMS    Submit
    ${DECISION_TREE_SUCCESS_MESSAGE}    Set Variable    ${decision_tree_data}[DecisionTreeName] decision tree has been created
    Set Suite Variable    ${DECISION_TREE_SUCCESS_MESSAGE}

Save Questions And Answers In Section
    [Arguments]    ${questions}    ${answers}
    [Documentation]    Its is used to save the questions and answers in the define question section
    ${splitted_questions}    Split String    ${questions}    ,
    ${splitted_questions_count}    Get Length    ${splitted_questions}
    FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
        ${question_and_questionprefix}    Split String    ${splitted_questions}[${question_key}]    -
        ${question}    Set Variable    ${question_and_questionprefix}[1]
        ${questionprefix}    Set Variable    ${question_and_questionprefix}[0]
        Wait Until Time    2
        Input Text    ${textbox.system.create.decision_tree.section.question}    ${question}
        Input Text    ${textbox.system.create.decision_tree.section.question_prefix}    ${questionprefix}
        ${splitted_answers}    Split String    ${answers}    |
        Enter Multiple Answers    ${splitted_answers}[${question_key}]
        Click Button In VLMS    Save
        ${label.system.create.decision_tree.section.newquestion}    Update Dynamic Values    ${label.system.create.decision_tree.section.question}    ${questionprefix}    ${question}
        Wait Until Element Is Visible    ${label.system.create.decision_tree.section.newquestion}    ${MEDIUM_WAIT}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Enter Details In Define Action Tab
    [Arguments]    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
    [Documentation]    It is used to enter all details in define action tab
    ${splitted_questions}    Split String    ${questions}    ,
    ${splitted_questions_count}    Get Length    ${splitted_questions}
    ${splitted_decision_required}    Split String    ${decision_required}    |
    FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
        ${updated_decision_required}    Split String    ${splitted_decision_required}[${question_key}]    ,
        Wait Until Time    2
        Select Value From Dropdown    ddlQuestionRoot    ${splitted_questions}[${question_key}]
        ${splitted_answers}    Split String    ${answers}    |
        ${updated_splitted_answers}    Split String    ${splitted_answers}[${question_key}]    ,
        ${splitted_answers_count}    Get Length    ${updated_splitted_answers}
        FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
            ${updated_answer_key}    Evaluate    ${answer_key}+1
            ${updated_question_key}    Evaluate    ${question_key}+1
            IF    ${answer_key}==1 or ${updated_question_key}==${splitted_questions_count}
                Define Question Actions    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    End Action
                IF    '${updated_decision_required}[${answer_key}]'=='rbtnYes'
                    Click Element    ${button.system.create.decision_tree.section.answer.decision_required}
                    Add Manual Content Library    Generic Based    ${decision_tree_data}[ContentLibrary]    1    1    ${decision_tree_data}[ContentLibraryNo]
                    Verify Success Message And Click Submit    Dummy    btnMessageOk    2
                    Unselect Frame
                    Wait Until Time    2
                    Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}
                    Select Frame    ${iframe.framecontent}
                END
            ELSE
                Define Question Actions    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    ${splitted_questions}[${updated_question_key}]
            END
        END
        Wait Until Time    4
        Click Button In VLMS    Complete
        Verify Confirmation Popup    Decision Action has been Completed    btnMessageOk
    END

Define Question Actions
    [Arguments]    ${decision_required}    ${key}    ${question}
    [Documentation]    It is used to define the different actions for questions
    Wait Until Time    3
    ${radiobutton.system.create.decision_tree.section.action.newdecision_required}    Update Dynamic Value    ${radiobutton.system.create.decision_tree.section.action.decision_required}    ${decision_required}
    Click Element    (${radiobutton.system.create.decision_tree.section.action.newdecision_required})[${key}]
    Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
    ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action}    ${question}
    Click Element    ${label.system.create.decision_tree.section.newaction}

Add Manual Content Library
    [Arguments]    ${tab_name}    ${content_library}    ${column}    ${index}    ${content_library_no}
    [Documentation]    It is used to add content library in define action tab
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}
    Select Frame    ${iframe.library_frame.screen}
    ${button.content_library.newtabs}    Update Dynamic Value    ${button.content_library.tabs}    ${tab_name}
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.content_library.newtabs}    ${MEDIUM_WAIT}
    Click Element    ${button.content_library.newtabs}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${dropdown.content_library.select_doc.select}
    IF    '${status}'=='True'
        Click Element    ${dropdown.content_library.select_doc.select}
    ELSE
        Click Element    ${dropdown.content_library.generic.select}
    END
    ${label.content_library.select_doc.newvalue}    Update Dynamic Value    ${label.content_library.select_doc.value}    ${content_library}
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.content_library.select_doc.newvalue}    ${MEDIUM_WAIT}
    Click Element    ${label.content_library.select_doc.newvalue}
    Verify Filter Option In Content Library Frame Screen    ${column}    ${index}    ${content_library_no}
    Wait Until Time    2
    Click Element    ${checkbox.content_library.select}
    Click Button In VLMS    Add
    Wait Until Time    3
    Click Button In VLMS    Save

Create Category
    [Arguments]    ${Category_Data}
    ${count_row}    Get Length    ${Category_Data}
    FOR    ${key}    IN RANGE    0    ${count_row}
        ${dict_data}    Set Variable    ${Category_Data}[${key}]
        Click Button in VLMS    Create
        Wait Until Time    ${SHORT_WAIT}
        Enter Text In Mandatory Fields    CatName    ${dict_data}[CategoryName]
        ${Category}    Set Variable    ${dict_data}[CategoryName]
        Enter Text In Mandatory Fields    Prefix    ${dict_data}[CategoryPrefix]
        Click Button in VLMS    Submit
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        ${ExpectedResult}    Set Variable     ${Category} category has been created
        Get Value From Toast Message    ${ExpectedResult}
    END

Create SubCategory
    [Arguments]    ${SubCategory_Data}
    ${count_row}    Get Length    ${SubCategory_Data}
    FOR    ${key}    IN RANGE    0    ${count_row}
        ${dict_data}    Set Variable    ${SubCategory_Data}[${key}]
        Click Button in VLMS    Create
        Wait Until Time    ${SHORT_WAIT}
        Select Value From Dropdown    ddlCatName_chosen    ${dict_data}[CategoryName]
        Wait Until Time    ${SHORT_WAIT}
        Enter Text In Mandatory Fields    SubCatName    ${dict_data}[SubCategoryName]
        ${SubCategory}    Set Variable    ${dict_data}[SubCategoryName]
        Set Suite Variable    ${SubCategory}
        Enter Text In Mandatory Fields    Prefix    ${dict_data}[SubCategoryPrefix]
        Click Button in VLMS    Submit
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit    created
        ${ExpectedResult}    Set Variable     ${SubCategory} Sub Category has been created
        Get Value From Toast Message    ${ExpectedResult} 
    END

Create Entity Status
    [Arguments]    ${reason_data}    ${USER}    ${USER_PASSWORD}
    ${count}    Get Length    ${reason_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${entitystatus_data}    Set Variable    ${reason_data}[${key}]
        Click Button In VLMS    Create
        Wait Until Time    ${SHORT_WAIT}
        Select Value From Dropdown    ddlEntityStatus_chosen    ${entitystatus_data}[EntityStatus]
        Enter Text In Mandatory Fields    ValidationStatusName    ${entitystatus_data}[EntityStatusName]
        Select Value From Dropdown    ddlValidationColor_chosen    ${entitystatus_data}[EntityStatusColor]
        # Wait Until Element Is Visible    ${dropdown.statustype.assessment.create.entitystatus}
        # Click Element    ${dropdown.statustype.assessment.create.entitystatus}
        # ${dropdown.selecttype.create.system.keywwordmapping.new}    Update Dynamic Value    ${dropdown.selecttype.create.system.keywwordmapping}    ${entitystatus_data}[EntityStatus]
        # Click Element    ${dropdown.selecttype.create.system.keywwordmapping.new}
        # Enter Text In Mandatory Fields    ValidationStatusName    ${entitystatus_data}[EntityStatusName]
        # Click Element    ${dropdown.Entitystatuscolor.assessment.create.entitystatus}
        # ${dropdown.selectcolor.assessment.create.entitystatus.new}    Update Dynamic Value    ${dropdown.selectcolor.assessment.create.entitystatus}    ${entitystatus_data}[EntityStatusColor]
        # Click Element    ${dropdown.selectcolor.assessment.create.entitystatus.new}
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit    created
        ${EXPECTED_SUCCESS_MSG}    Set Variable    ${entitystatus_data} entity status has been created
        Get Value From Toast Message  ${EXPECTED_SUCCESS_MSG}
    END

Enter Standard Form Details In Create Entity Type_Prerequisite
    [Arguments]    ${system_entity_data}
    [Documentation]    This keyword is used to enter standard form details(Getting Framework Name variable from Create Framework keyword)
    IF    'AssessmentRequired' in ${system_entity_data}    Select Value For Radio Button    SystemAssessmentRequired    ${system_entity_data}[AssessmentRequired]
    IF    'AssessmentTemplate' in ${system_entity_data}    Select Value From Dropdown    ddlPlanAssessmentSelect    ${system_entity_data}[AssessmentTemplate]
    Wait Until Time    3
    IF    'Framework' in ${system_entity_data}
        Select Framework    ${system_entity_data}[Framework]
        Wait Until Time    ${SHORT_WAIT}
        Set Validation Rule For Framework_Prerequisite    ${system_entity_data}
        Validation Criteria_Prerequisite    ${system_entity_data}
    END

Create Keyword Mapping
    [Arguments]    ${Keyword_Mapping_data}
    ${count}    Get Length    ${Keyword_Mapping_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${Keyword_Mapping_data}    Set Variable    ${Keyword_Mapping_data}[${key}]
        ${Column_Header}    Split String    ${Keyword_Mapping_data}[Column Header]    ,
        @{Headercount}    Create List    ${Column_Header}
        ${Count}    Get Length    @{Headercount}
        FOR    ${key}    IN RANGE    0    ${count}
            Click Button in VLMS    Create
            Wait Until Time    ${SHORT_WAIT}
            Select Value From Dropdown    ddlMapType_chosen    ${Keyword_Mapping_data}[DocumentType]
            ${ColumnHeader}    Split String    ${Keyword_Mapping_data}[Column Header]    ,
            ${Header}    Set Variable    ${ColumnHeader}[${Key}]
            ${ColumnType}    Split String    ${Keyword_Mapping_data}[Column Type]    ,
            ${Type}    Set Variable    ${ColumnType}[${Key}]
            ${SplitedheaderType}    Combine Lists    ${ColumnHeader}    ${ColumnType}
            ##${ColumnHeader}    Set Variable    ${ColumnHeader}[${key}]    
            Enter Text In Mandatory Fields    ColHeaderName    ${Header}
            Wait Until Time    ${SHORT_WAIT}
            Select Value From Dropdown    ddlColType_chosen    ${Type}
            Select Submit/Reset Button    Submit
            Handle Electronic Sign   ${AUTHOR}   ${AUTHOR_PASSWORD}    Submit    ${Keyword_Mapping_data}[Reason]
            ${ExpectedResult}    Set Variable    Mapping Keyword has been created
            Get Value From Toast Message    ${ExpectedResult}
        END
    END

Swipe Values Between Groups_Prerequisite
    [Arguments]    ${groups_values}    ${source_group}    ${destination_group}
    [Documentation]    This keyword is used to swipe values between source and destination groups
    ${groups_list_items}    Split String    ${groups_values}    ,
    ${count}    Get Length    ${groups_list_items}
    FOR    ${key}    IN RANGE   0    ${count}
        ${label.system.entity.newgroups_selection}    Update Dynamic Values    ${label.system.entity.groups_selection}    ${source_group}    ${groups_list_items}[${key}]
        ${source_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.system.entity.newgroups_selection}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible after waiting ${MEDIUM_WAIT} seconds
        IF    '${source_status}'=='True'
            Click Element    ${label.system.entity.newgroups_selection}
            Click Element    ${label.system.entity.newgroups_selection}
            Double Click Element    ${label.system.entity.newgroups_selection}
            ${label.system.entity.newgroups_selection}    Update Dynamic Values    ${label.system.entity.groups_selection}    ${destination_group}    ${groups_list_items}[${key}]
            Wait Until Element Is Visible    ${label.system.entity.newgroups_selection}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visble.
        END
    END

Create Reason
    [Documentation]    This keyword is to anayze the excel data
    [Arguments]    ${reason_data}
    Wait Until Time    ${SHORT_WAIT}
    ${count}    Get Length    ${reason_data}
    FOR    ${key}    IN RANGE    0    ${count}
        Click Button in VLMS    Create
        ${Dict_Data}    Set Variable    ${reason_data}[${key}]
        ${Reason}    Set Variable    ${Dict_Data}[ReasonValues]    
        Select Value From Dropdown    ddlReasonType_chosen    ${Dict_Data}[ReasonValues]
        Wait Until Time    ${SHORT_WAIT}
        ${Split_Object}    Split String    ${Dict_Data}[Object]    ;
        ${count}    Get Length    ${Split_Object}
        FOR    ${key}    IN RANGE    0    ${count}
            ${Object}    Set Variable    ${Split_Object}[${key}]    
            Select Value From Dropdown    lstObjectType_chosen    ${Object}
            Wait Until Time    ${SHORT_WAIT}
        END
        IF    '${Reason}'=='Approval' or '${Reason}'=='Rejection' or '${Reason}'=='Review'
            ${Split_Role}    Split String    ${Dict_Data}[Associate Functional Role]    ;
            ${count2}    Get Length    ${Split_Role}
            FOR    ${key}    IN RANGE    0    ${count2}
                ${FunctionalRole}    Set Variable    ${Split_Role}[${key}]    
                Select Value From Dropdown    lstFunctionalRole_chosen    ${FunctionalRole}
            END    
        END
        Wait Until Time    ${SHORT_WAIT}
        Enter Text In Mandatory Fields    StandardReason    ${Dict_Data}[ReasonForEsign]
        Select Submit/Reset Button    Submit
        Handle Electronic Sign   ${USER}    ${USER_PASSWORD}    Submit
        ${ExpectedResult}    Set Variable    ${Dict_Data}[ReasonForEsign] reason has been saved    
        Get Value From Toast Message  ${ExpectedResult}
    END
    

Enetr details for Reason
    [Documentation]    This keyword is to fill the reason from based on the inputs given.
    [Arguments]    ${reason_data}    ${reason_value}    ${list_of_reasonsforEsign}
    IF    'ReasonValues' in ${reason_data}    Select Value From Dropdown    ddlReasonType_chosen    ${reason_value}
    Select Value From Dropdown    lstObjectType_chosen    ${reason_data}[Object]
    ${status}    Run Keyword And Return Status    Element Should Be Visible    //input[@id="CheckBox1"]
    IF  '${status}'=='True'        Select Value From Dropdown    lstObjectType_chosen    ${reason_data}[Object]    
    ##IF  '${status}'=='True'        Click Element    //input[@id="CheckBox1"]
    IF    'ReasonForEsign' in ${reason_data}    Enter Text In Mandatory Fields    StandardReason    ${list_of_reasonsforEsign}
    IF    'Button' in ${reason_data}    Select Submit/Reset Button    ${reason_data}[Button]
    IF    'ReasonValues'!='Create'    Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
    ${ExpectedResult}    Set Variable    ${reason_value} Reason has been created
    Get Value From Toast Message    ${ExpectedResult}

Create the Functional roles
    [Documentation]    This keyword is for creating the functinal role.
    [Arguments]    ${fnRole_data}    ${USER}    ${USER_PASSWORD}
    ${count}    Get Length    ${fnRole_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${dict_data}    Set Variable    ${fnRole_data}[${key}]
        Click Button in VLMS    Create
        Fill the Functional role form    ${dict_data}    ${dict_data}[FRName]    ${dict_data}[FRPrefix]    ${USER}    ${USER_PASSWORD}
    END

Fill the Functional role form
    [Documentation]    This keyword is for filling the functional role.
    [Arguments]    ${fnRole_data}    ${fnroles_name}    ${fnrole_prefix}    ${USER}    ${USER_PASSWORD}
    IF    'FRName' in ${fnRole_data}    Enter Text In Mandatory Fields    FnRoleName    ${fnroles_name}
    IF    'FRPrefix' in ${fnRole_data}    Enter Text In Mandatory Fields    FnRolePrefix    ${fnrole_prefix}
    Input Text    ${textarea.description.system.create.functionalrole}    Functional Role Created
    #IF    'Description' in ${fnRole_data}    Enter Text In Mandatory Fields    FnRoleDesc    ${fnRole_data}[Description]
    IF    'Button' in ${fnRole_data}    Select Submit/Reset Button    ${fnRole_data}[Button]
    Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
    ${Expected_Result}    Set Variable    Functional Role ${fnroles_name} has been created
    Get Value From Toast Message    ${Expected_Result}

Create Group
    [Documentation]    This keyword is used to Create a Group of available Users which can be applied for multiple objects
    [Arguments]    ${Group_data}    ${USERID}    ${USER_PASSWORD}
            
    Wait Until Time    2
    ${count}    Get Length    ${Group_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${dict_data}    Set Variable    ${Group_data}[${key}]
        Wait Until Time    ${SHORT_WAIT}
        Click Button in VLMS    Create
        IF    'GroupName' in ${dict_data}    Enter Text In Mandatory Fields    boxGroupName    ${dict_data}[GroupName]
        Wait Until Time    2
        IF    'GroupType' in ${dict_data}    Select Value From Dropdown    ddlGroupType_chosen    ${dict_data}[GroupType]
        Wait Until Time    ${SHORT_WAIT}
        ${split_data}    Split String    ${dict_data}[Users]    ,
        ${user_count}    Get Length    ${split_data}
        FOR    ${user}    IN RANGE    0    ${user_count}
            Wait Until Time    ${SHORT_WAIT}
            Select Value From Dropdown    lboxAssignedUser_chosen    ${split_data}[${user}]
            Wait Until Time    ${SHORT_WAIT}
            #IF    '${split_data}[${user}]' != 'All users'
                #Input Text    ${textbox.group}    ${split_data}[${user}]
                #Wait Until Time    ${SHORT_WAIT}
                #Click Element    ${checkbox.availableuser.groups}
            #ELSE
                #Click Element    ${checkbox.selectalluser.groups}
            #END
        END
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${USERID}    ${USER_PASSWORD}    Submit
        ${Expected_Result}    Set Variable    ${dict_data}[GroupName] Group has been created.
        Get Value From Toast Message    ${Expected_Result}
    END

Enter The Details To Create A New Content_Prereuisite
    [Arguments]    ${content_type_data}    ${User}    ${USER_PASSWORD}
    [Documentation]    This Is To Enter The Details To Create The Content
    Wait Until Time    ${SHORT_WAIT}
    ${count}    Get Length    ${content_type_data}
    FOR    ${key}    IN RANGE    0    ${count}
        Click Button in VLMS    Create
        ${dict_data}    Set Variable    ${content_type_data}[${key}]
        ${content_type_list}    Set Variable    ${dict_data}[ContentTypeName]
        ${content_type_prefix}    Set Variable    ${dict_data}[PrefixName]
        ${content_type_function}    Set Variable    ${dict_data}[ContentFunction]
        ${count}    Get Length    ${content_type_list}
        Enter The Details Content_Prerequisite    ${content_type_list}    ${content_type_prefix}    ${content_type_function}    ${content_type_data}     ${User}    ${USER_PASSWORD}    ${dict_data}    
    END

Enter The Details Content_Prerequisite
    [Arguments]    ${content_type_list}    ${content_type_prefix}    ${content_type_function}    ${content_type_data}    ${User}    ${USER_PASSWORD}    ${dict_data}
    [Documentation]    This Is To Enter The Details To Create The Content
    Wait Until Element Is Visible    txtTypeName    ${SHORT_WAIT}
    Enter Text In Mandatory Fields    TypeName    ${content_type_list}      
    Wait Until Element Is Visible    txtPrefix    ${SHORT_WAIT}
    Enter Text In Mandatory Fields    Prefix    ${content_type_prefix} 
    Wait Until Element Is Visible    ddlValType_chosen    ${SHORT_WAIT}
    Select Value From Dropdown    ddlValType_chosen    ${content_type_function}
    # Javascript Click   ${button.department.create.submit}
    Select Submit/Reset Button    Submit
    Handle Electronic Sign   ${User}    ${User_password}       Submit    ${dict_data}[Reason]
    ${ExpectedResult}    Set Variable    ${content_type_list} content type has been created
    Get Value From Toast Message    ${ExpectedResult}

Create Department
    [Arguments]    ${content_type_data}
    [Documentation]    This is to enter the details to create the department
    Click Button in VLMS    Create
    ${count}    Get Length    ${content_type_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${department_data}    Set Variable    ${content_type_data}[${key}]
        Wait Until Time    ${SHORT_WAIT}
        Wait Until Element Is Visible    //span[@id="lblCreateDepartment"]    ${SHORT_WAIT}
        Select Value From Dropdown   ddlSite_chosen    ${department_data}[SiteName]
        Wait Until Time    3
        Enter Text In Mandatory Fields    boxDepartmentName     ${department_data}[DepartmentName]
        Javascript Click   ${button.department.create.submit}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        ${Expected_Result}    Set Variable    ${department_data}[DepartmentName] Department has been created
        ${Sts}    Get Value From Toast Message    ${Expected_Result}
    END

Add Manual Content Library_Prerequisite
    [Arguments]    ${tab_name}    ${content_library}
    [Documentation]    It is used to add content library in define action tab
    Wait Until Time    3
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}
    Select Frame    ${iframe.library_frame.screen}
    ${button.content_library.newtabs}    Update Dynamic Value    ${button.content_library.tabs}    ${tab_name}
    Wait Until Element Is Visible    ${button.content_library.newtabs}    ${MEDIUM_WAIT}
    Click Element    ${button.content_library.newtabs}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${dropdown.content_library.select_doc.select}
    IF    '${status}'=='True'
        Click Element    ${dropdown.content_library.select_doc.select}
    ELSE
        Click Element    ${dropdown.content_library.generic.select}
    END
    ${label.content_library.select_doc.newvalue}    Update Dynamic Value    ${label.content_library.select_doc.value.pre}    ${content_library}
    Wait Until Element Is Visible    ${label.content_library.select_doc.newvalue}    ${MEDIUM_WAIT}
    Click Element    ${label.content_library.select_doc.newvalue}
    Wait Until Time    3
    Click Element    ${checkbox.content_library.select}
    Click Button In VLMS    Add
    Wait Until Time    3
    Click Button In VLMS    Save

Enter Pre-requisite Details In Create Entity Type_Prerequisite
    [Arguments]    ${system_entity_data}
    [Documentation]    This keyword is used to enter pre-requisite details in create entity type
    Log    ${system_entity_data}[TaskType]
    IF    'TaskType' in ${system_entity_data}    Select Value For Radio Button    DocType    ${system_entity_data}[TaskType]
    IF    'SelectEntityType' in ${system_entity_data}    Select Value From Dropdown    ddlRevisedEntType    ${system_entity_data}[SelectEntityType]
    IF    'EntityTypeName' in ${system_entity_data}    Input Text    ${textbox.system.create.entity_type}    ${system_entity_data}[EntityTypeName]
    ${EntityName}    Set Variable    ${system_entity_data}[EntityTypeName]
    Set Suite Variable    ${EntityName}
    IF    'Prefix' in ${system_entity_data}    Input Text    ${textbox.system.create.entity.prefix}    ${system_entity_data}[Prefix]
    # Select Value For Radio Button    rbtEntConfigManual    rbtEntConfigManual
    IF    'EntityNoType' in ${system_entity_data} or '${system_entity_data}[EntityNoType]'=='rbtEntConfigManual'
        Select Value For Radio Button    rbtEntConfigManual    ${system_entity_data}[EntityNoType]
    END
    IF    'DepartmentRequired' in ${system_entity_data}    Select Value For Radio Button    DepartmentReq    ${system_entity_data}[DepartmentRequired]
    Wait Until Time    3
    ${Status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${radio.building.system.create.EntityType}    ${SHORT_WAIT}
    IF    '${Status}'=='True'
        Select Value For Radio Button    BuildingReq    rbtBuildingReqNo
    END
    IF    'VersioningRequired' in ${system_entity_data}    Select Value For Radio Button    VerReq    ${system_entity_data}[VersioningRequired]
    Wait Until Time    2
    IF    'VersionFormat' in ${system_entity_data}    Select Value From Dropdown    ddlVersionFormat    ${system_entity_data}[VersionFormat]
    Wait Until Time    3
    IF    'EntityFormType' in ${system_entity_data}    Select Value From Dropdown    ddlEntTypeSelect_chosen    ${system_entity_data}[EntityFormType]

Create EntityType_Prerequisite
    [Arguments]    ${entitytype_data}    ${user_name}    ${password}
    [Documentation]    This Keyword will create entity type
    ${count}    Get Length    ${entitytype_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${system_entity_data}    Set Variable     ${entitytype_data}[${key}]
        Get Entity Type ID
        Enter Pre-requisite Details In Create Entity Type_Prerequisite    ${system_entity_data}
        Enter Standard Form Details In Create Entity Type_Prerequisite    ${system_entity_data}
        IF    'ApprovalRequired' in ${system_entity_data}    Select Value For Radio Button    check    ${system_entity_data}[ApprovalRequired]
        IF    'WorkFlow' in ${system_entity_data}    Select Value From Dropdown    ddlWorkFlow    ${system_entity_data}[WorkFlow]
        IF    'RouteFor' in ${system_entity_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${system_entity_data}[RouteFor]
        IF    'Comments' in ${system_entity_data}    Enter Comments/Description    txtComments    ${system_entity_data}[Comments]
        IF    'Button' in ${system_entity_data}    Select Submit/Reset Button    ${system_entity_data}[Button]
        IF    '${system_entity_data}[FrameworkRequired]'=='No'    
            Verify Notification Popup    Are you sure want to submit without framework    btnSubmitEntitytype
        END
        Handle Electronic Sign  ${USER}    ${USER_PASSWORD}    Submit
        ${ExpectedResult}    Set Variable    ${EntityName} entity type ${ENTITY_TYPE_ID} has been created              
        Get Value From Toast Message    ${ExpectedResult}
        Click Button In VLMS    Create
    END

Enter The Details To Create A New Table 
    [Arguments]    ${table_name_list}    ${User}    ${USER_PASSWORD}
    [Documentation]    This Is To Enter The Details To Create The Table
    ${count}    Get Length    ${table_name_list}
    FOR    ${key}    IN RANGE    0    ${count}
        ${table_data}    Set Variable     ${table_name_list}[${key}]
        Click Button In VLMS    Create
        Enter The Details To The Table        ${table_data}     ${User}    ${USER_PASSWORD}    
    END

Enter Text In Mandatory Header Fields
    [Arguments]    ${text_field}    ${text}
    [Documentation]    This keyword is used to enter text in mandatory textbox field
    ${textbox.header.mandatory.newtext_field}    Update Dynamic Value    ${textbox.header.mandatory.text_field}    ${text_field}
    Wait Until Element Is Visible    ${textbox.header.mandatory.newtext_field}    ${MEDIUM_WAIT}    ${text_field} is not visible after waiting ${MEDIUM_WAIT} seconds
    Javascript Click    ${textbox.header.mandatory.newtext_field}
    Wait Until Time    2
    Javascript Input Text    ${textbox.header.mandatory.newtext_field}    ${text} 

Enter The Details To The Table
    [Arguments]    ${table_data}    ${User}    ${USER_PASSWORD}
    [Documentation]    This Is To Enter The Details To Create The Content
    ${column_header}    Split String    ${table_data}[ColumnHeader]   ,
    ${column_type}    Split String    ${table_data}[ColumnType]   ,
    Wait Until Element Is Visible    txtTableName    ${SHORT_WAIT}
    Enter Text In Mandatory Fields    TableName    ${table_data}[TableName]
    Wait Until Element Is Visible    ddlTblType_chosen    ${SHORT_WAIT}
    Select Value From Dropdown    ddlTblType_chosen    ${table_data}[TableType]
    Wait Until Time    ${SHORT_WAIT}
    Select Value From Dropdown    ddlNoOfColumns_chosen    ${table_data}[NumberColumns]
    ${num_columns}    Get Length    ${column_header}
    FOR    ${index}    IN RANGE    0    ${num_columns}
        ${selector_index}    Set Variable    ${index+2}
        ${selector_index_str}    Convert To String    ${selector_index}
        ${selector_prefix}    Set Variable If    ${selector_index} < 10    l0    l
        ${element_selector}    Set Variable        grdTableTypes1$ct${selector_prefix}${selector_index_str}$txtgvColHeader
        Wait Until Element Is Visible    ${element_selector}    ${SHORT_WAIT}
        Enter Text In Mandatory Header Fields    ${element_selector}    ${column_header}[${index}]
        ${dropdown_selector}    Set Variable   grdTableTypes1_ct${selector_prefix}${selector_index_str}_ddlColType_chosen
        Wait Until Element Is Visible    ${dropdown_selector}    ${SHORT_WAIT}
        ${current_column_type}    Set Variable    ${column_type[${index}]}
        Select Value From Dropdown    ${dropdown_selector}    ${current_column_type}
    END
    Select Submit/Reset Button    Submit
    Handle Electronic Sign    ${User}    ${User_password}    Submit
    ${Expected_Result}    Set Variable    ${table_data}[TableName] content type has been created
    Get Value From Toast Message    ${Expected_Result}

Standard form creation prerequisite
    [Arguments]    ${dict_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Form
        IF    '${dict_data}[FormType]'=='Standard Form'
            Wait Until Element Is Visible    ${textbox.system.create.form.form_type}    ${MEDIUM_WAIT}    Form type is not visible after waiting ${MEDIUM_WAIT} seconds
            Click Element    ${textbox.system.create.form.form_type}
            Input Text    ${textbox.system.create.form.form_type}    ${dict_data}[FormName]
            ${label.system.create.form.newform_type}    Update Dynamic Value    ${label.system.create.form.form_type}    ${dict_data}[FormType]
            Wait Until Element Is Visible    ${label.system.create.form.newform_type}    ${MEDIUM_WAIT}    ${dict_data}[FormType] is not visible after waiting ${MEDIUM_WAIT} seconds
            Click Element    ${label.system.create.form.newform_type}
            Wait Until Time    4
            IF    'FormName' in ${dict_data}    Enter Text In Mandatory Fields    FormName    ${dict_data}[FormName]
            IF    '${dict_data}[FormApplicableTo]'== 'Select All'
                Wait Until Element Is Visible    ${dropdown.div.system.create.form.applicableTo.parentdiv}    ${MEDIUM_WAIT}    applicableTo is not visible after waiting ${MEDIUM_WAIT} seconds
                Click Element    ${dropdown.div.system.create.form.applicableTo}
                Wait Until Element Is Visible    ${list.system.create.form.form_applicable.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting ${MEDIUM_WAIT} seconds
                Click Element    ${list.system.create.form.form_applicable.select_all}
            ELSE
                @{select_list}    Split String    ${dict_data}[FormApplicableTo]    ,
                FOR    ${key}    IN    @{select_list}
                    Wait Until Element Is Visible    ${dropdown.div.system.create.form.applicableTo.parentdiv}    ${MEDIUM_WAIT}    applicableTo is not visible after waiting ${MEDIUM_WAIT} seconds
                    Click Element    ${dropdown.div.system.create.form.applicableTo}
                    Wait Until Time    2
                    Enter Text In Mandatory Fields    ${textbox.search.system.create.form.applicableTo}    ${key}
                    ${list.system.create.form.form_applicable_to.newtype}    Update Dynamic Value    ${list.system.create.form.form_applicable_to.type}    ${key}
                    Wait Until Element Is Visible    ${list.system.create.form.form_applicable_to.newtype}    ${SHORT_WAIT}    Option is not visible after waiting for ${SHORT_WAIT} seconds
                    Click Element    ${list.system.create.form.form_applicable_to.newtype}
                END
            END
            IF    'Description' in ${dict_data}    Enter Comments/Description    txtDescription    ${dict_data}[Description]
            IF    'InheritFields' in ${dict_data}    Select Value From Dropdown    ddlInherit    ${dict_data}[InheritFields]
            IF    'AddControls' in ${dict_data}    Click Button In VLMS    Add Controls
            IF    'CreateControls' in ${dict_data}    Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation}    ${MEDIUM_WAIT}    Control Creation is not visible after waiting ${MEDIUM_WAIT} seconds
            IF    'Row' in ${dict_data}    Select Value From Dropdown    ddlRows_chosen    ${dict_data}[Row]
            #IF    'Column' in ${dict_data}    Select Value From Dropdown    ddlColumns    ${dict_data}[Column]
            IF    'CreateControls' in ${dict_data}    Click Button In VLMS    Create Controls
            Wait Until Time    3
            IF    'FieldType' in ${dict_data}
                Drag And Drop Field Types To Form Field Details Grid    ${dict_data}[FieldType]    ${dict_data}[CellIndex]
                Wait Until Time    3
                Add Settings To Form Fields for prerequiste    ${dict_data}
                Wait Until Time    7
                Wait Until Element Is Visible    ${button.system.create.form.control_creation.save}    ${MEDIUM_WAIT}    Save button is not visible after waiting ${MEDIUM_WAIT} seconds
                Click Element    ${button.system.create.form.control_creation.save}
            END
        END

Exception form creation prerequiste
    [Arguments]    ${dict_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Form
    ${Cell multiple index values}    Split String    ${dict_data}[Cell multiple index]    ,
        ${multiple DD}    Get Length    ${Cell multiple index values}
        ${cell value key}    Set Variable    0
        Wait Until Element Is Visible    ${textbox.system.create.form.form_type}    ${MEDIUM_WAIT}    Form type is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${textbox.system.create.form.form_type}
        Input Text    ${textbox.system.create.form.form_type}    ${dict_data}[FormType]
        Wait Until Time    2
        ${label.system.create.form.newform_type}    Update Dynamic Value    ${label.system.create.form.form_type}    ${dict_data}[FormType]
        Wait Until Element Is Visible    ${label.system.create.form.newform_type}    ${MEDIUM_WAIT}    ${dict_data}[FormType] is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${label.system.create.form.newform_type}
        Wait Until Time    4
        IF    'FormName' in ${dict_data}    Enter Text In Mandatory Fields    FormName   ${dict_data}[FormName]
        IF    '${dict_data}[FormApplicableTo]'== 'Select All'
                Wait Until Element Is Visible    ${dropdown.div.system.create.form.applicableTo.parentdiv}    ${MEDIUM_WAIT}    applicableTo is not visible after waiting ${MEDIUM_WAIT} seconds
                Click Element    ${dropdown.div.system.create.form.applicableTo}
                Wait Until Element Is Visible    ${list.system.create.form.form_applicable.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting ${MEDIUM_WAIT} seconds
                Click Element    ${list.system.create.form.form_applicable.select_all}
        END
        IF    'Description' in ${dict_data}    Enter Comments/Description    txtDescription    ${dict_data}[Description]
        IF    'InheritFields' in ${dict_data}    Select Value From Dropdown    ddlInherit    ${dict_data}[InheritFields]
        ${exception count}    Set Variable     2
        ${index}    Set Variable    1
        FOR    ${key1}    IN RANGE    0    ${exception count}
            ${cell values}    Set Variable    ${Cell multiple index values}[${key1}] 
           Wait Until Element Is Visible    (//input[@value="Add Controls"])[${index}]    ${MEDIUM_WAIT}    Add Controls is not visible after waiting ${MEDIUM_WAIT} seconds
           Click Element    (//input[@value="Add Controls"])[${index}]
           Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation}    ${MEDIUM_WAIT}    Control Creation is not visible after waiting ${MEDIUM_WAIT} seconds
           IF    'Row' in ${dict_data}    Select Value From Dropdown    ddlRows_chosen    ${dict_data}[Row]    
           #IF    'Column' in ${dict_data}    Select Value From Dropdown    ddlColumns    ${dict_data}[Column]
           IF    'CreateControls' in ${dict_data}    Click Button In VLMS    Create Controls
           Wait Until Time    3
           Drag And Drop Field Types To Form Field Details Grid    ${dict_data}[FieldType]    ${cell values}
           Wait Until Time    3
           Add Settings To Form Fields for prerequiste    ${dict_data}    ${cell values}
           Wait Until Element Is Visible    ${button.system.create.form.control_creation.save}    ${MEDIUM_WAIT}    save button is not visible after waiting ${MEDIUM_WAIT} seconds 
           Click Element    ${button.system.create.form.control_creation.save}
           Wait Until Time    4
           Evaluate    ${index}+1
        END 

Framework and Project Form creation with Textbox Control
     [Arguments]    ${dict_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Form
        Wait Until Element Is Visible    ${textbox.system.create.form.form_type}    ${MEDIUM_WAIT}    Form type is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${textbox.system.create.form.form_type}
        Input Text    ${textbox.system.create.form.form_type}    ${dict_data}[FormType]
        ${label.system.create.form.newform_type}    Update Dynamic Value    ${label.system.create.form.form_type}    ${dict_data}[FormType]
        Wait Until Element Is Visible    ${label.system.create.form.newform_type}    ${MEDIUM_WAIT}    form type is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${label.system.create.form.newform_type}
        Wait Until Time    4
       IF    'FormName' in ${dict_data}    Enter Text In Mandatory Fields    FormName     ${dict_data}[FormName]
       IF    '${dict_data}[FormApplicableTo]'== 'SelectAll'
                Wait Until Element Is Visible    ${dropdown.div.system.create.form.applicableTo.parentdiv}    ${MEDIUM_WAIT}    applicableTo is not visible after waiting ${MEDIUM_WAIT} seconds
                Click Element    ${dropdown.div.system.create.form.applicableTo}
                Wait Until Element Is Visible    ${list.system.create.form.form_applicable.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting ${MEDIUM_WAIT} seconds
                Click Element    ${list.system.create.form.form_applicable.select_all}
        END
       IF    'Description' in ${dict_data}    Enter Comments/Description    txtDescription    ${dict_data}[Description]
       IF    'InheritFields' in ${dict_data}    Select Value From Dropdown    ddlInherit    ${dict_data}[InheritFields]
       IF    'AddControls' in ${dict_data}    Click Button In VLMS    Add Controls
       IF    'CreateControls' in ${dict_data}
            Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation}    ${MEDIUM_WAIT}    Control Creation is not visible after waiting ${MEDIUM_WAIT} seconds
            IF    'Row' in ${dict_data}    Select Value From Dropdown    ddlRows_chosen        ${dict_data}[Row]
            #IF    'Column' in ${dict_data}    Select Value From Dropdown    ddlColumns        ${dict_data}[Column]
            IF    'CreateControls' in ${dict_data}    Click Button In VLMS    Create Controls
       END 
        Wait Until Time    3
        IF    'FieldType' in ${dict_data}
        Drag And Drop Field Types To Form Field Details Grid    ${dict_data}[FieldType]    ${dict_data}[CellIndex]
        Wait Until Time    3
        Add Settings To Form Fields for prerequiste    ${dict_data}
        Wait Until Time    3
        Wait Until Element Is Visible    ${button.system.create.form.control_creation.save}    ${MEDIUM_WAIT}    Save button is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${button.system.create.form.control_creation.save}
        Wait Until Time    3
    END

IPM form cration for prerequiste
    [Arguments]    ${dict_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Form
    Framework and Project Form creation with Textbox Control   ${dict_data}   ${USER}    ${USER_PASSWORD}
    Enter Text In Mandatory Fields    Section    ${dict_data}[Section Name]
    Click Button In VLMS    Add
    Select Value For Radio Button    rbtnPre_ImpYes    ${dict_data}[Implementation Deliverables Required]
    Select Value For Radio Button    User or Group Assignment    ${dict_data}[User or Group Assignment]
    Select Value From Dropdown    select2-GridView1_ctl03_ddlSectionGroup-container   ${dict_data}[Select Group]
    Input Text    GridView1_ctl03_txtTenure    ${dict_data}[Assessment Period]
    Input Text    GridView1_ctl03_txtAlertFrequency   ${dict_data}[Notification Alert]
    Select Value From Dropdown    select2-GridView1_ctl03_ddlProcFlowtype-container   ${dict_data}[Serial / Parallel]
    #IF    'Is GXP Assessment Required' in ${dict_data}    Select Value For Radio Button    rbtnPre_ImpvalNo    ${dict_data}[Is GXP Assessment Required]
    Wait Until Element Is Visible    //input[@value="Add Controls"]  ${MEDIUM_WAIT}    Add Controls is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    //input[@value="Add Controls"]
    ${Cell index ipm}    Set Variable    ${dict_data}[Cell index ipm]    
    Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation}    ${MEDIUM_WAIT}    Control Creation is not visible after waiting ${MEDIUM_WAIT} seconds
    IF    'Row' in ${dict_data}    Select Value From Dropdown    ddlRows_chosen    ${dict_data}[Row]    
    #IF    'Column' in ${dict_data}    Select Value From Dropdown    ddlColumns    ${dict_data}[Column]
    IF    'CreateControls' in ${dict_data}    Click Button In VLMS    Create Controls
    Wait Until Time    3
    Drag And Drop Field Types To Form Field Details Grid   ${dict_data}[FieldType]    ${Cell index ipm}
    Wait Until Time    3
    Add Settings To Form Fields for prerequiste    ${dict_data}    ${Cell index ipm}
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.system.create.form.control_creation.save}    ${MEDIUM_WAIT}    save button is not visible after waiting ${MEDIUM_WAIT} seconds 
    Click Element    ${button.system.create.form.control_creation.save}

Create Decision Tree_Prerequisite
    [Arguments]    ${Tree_Prerequisite_data}    ${username}    ${password}
    ${count}    Get Length    ${Tree_Prerequisite_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${decision_tree_data}    Set Variable     ${Tree_Prerequisite_data}[${key}]
        Click Button In VLMS    Create
        Enter Name And Prefix Decision Tree Page    ${decision_tree_data}
        Select Decision Tree For Details    ${decision_tree_data}
        Enter Section Details Of Decision Tree    ${decision_tree_data}
        Navigate To Page Title Tab    Define Action
        Enter Details In Define Action Tab For Decision Tree    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]    ${decision_tree_data}[DecisionRequired]    ${decision_tree_data}
        Click Button In VLMS    Submit
        Handle Electronic Sign    ${username}    ${password}    Submit
        ${ExpectedResult}    Set Variable    ${decision_tree_data}[DecisionTreeName] decision tree has been created
        Get Value From Toast Message    ${ExpectedResult}
    END

Enter Name And Prefix Decision Tree Page
    [Arguments]    ${decision_tree_data}
    [Documentation]    It is used to enter aname and prefix details in decision tree page
    Wait Until Time    2
    IF    'DecisionTreeName' in ${decision_tree_data}    Input Text    ${textbox.system.create.decision_tree}    ${decision_tree_data}[DecisionTreeName]
    IF    'Prefix' in ${decision_tree_data}    Input Text    ${textbox.system.create.entity.prefix}    ${decision_tree_data}[Prefix]
    IF    'DecisionTreeFor' in ${decision_tree_data}    Select Value From Dropdown    divDecisionTreeFor    ${decision_tree_data}[DecisionTreeFor]

Select Decision Tree For Details
    [Arguments]    ${decision_tree_data}
    [Documentation]    It is used to select the decision for details in decision tree page
    Wait Until Time    2
    IF    '${decision_tree_data}[DecisionTreeFor]' == 'Content Generation'
        Select Value From Dropdown    divContentGenerationType    ${decision_tree_data}[DuplicatesOfContent]
    ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'GxP Assessment'
        ${button.decisiontree.newassessmentbasedon}    Update Dynamic Value    ${button.decisiontree.assessmentbasedon}    ${decision_tree_data}[AssessmentBasedOn]
        Wait Until Element Is Visible    ${button.decisiontree.newassessmentbasedon}    ${MEDIUM_WAIT}    Button is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${button.decisiontree.newassessmentbasedon}
    ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Risk Assessment'
        Select Dropdown Value With Partial Text    divRiskModel    ${decision_tree_data}[RiskModel]
    END

Enter Section Details Of Decision Tree
    [Arguments]    ${decision_tree_data}
    [Documentation]    It is used to enter section details in decision tree page
    Wait Until Time    2
    IF    '${decision_tree_data}[DecisionTreeFor]' != 'Risk Assessment'
        Wait Until Time    2
        Input Text    ${textbox.system.create.decision_tree.section}    ${decision_tree_data}[SectionName]
        Click Element    ${link.system.create.decision_tree.section.add}
        Select The Section    ${decision_tree_data}[SectionName]
        Save Questions And Answers In Section    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]
        Wait Until Time    3
    ELSE
        Wait Until Time    2
        ${itr}    Get Element Count    ${label.section.count}
        Set Global Variable    ${itr}
        @{section_list}=    Create List
        @{texttoappend.question}=    Create List
        FOR    ${section_key}    IN RANGE    0    ${itr}
            ${sectioname_toclick}    Get Text    (${sectiontext})[${section_key}+1]
            Wait Until Time    ${SHORT_WAIT}
            Select The Section    ${sectioname_toclick}
            ${answer_toclick}    Evaluate    ${section_key}+1
            #${answer_toclick}    Convert To String    ${answer_toclick}
            ${section_no}    Evaluate    ${section_key}+2
            ${section_no}    Convert To String    ${section_no}
            Save Questions And Answers In Section For Risk Assessment Decision Tree    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]    ${section_no}    ${answer_toclick}
            #Select The Section    ${sectioname_toclick}
            Append To List    ${section_list}    ${sectioname_toclick}
            Append To List    ${texttoappend.question}    ${answer_toclick}
        END
        Set Global Variable    ${section_list}
        Set Global Variable    ${texttoappend.question}
        Wait Until Time    3
    END

Save Questions And Answers In Section For Risk Assessment Decision Tree
    [Arguments]    ${questions}    ${answers}    ${section}    ${answer_toclick}
    [Documentation]    Its is used to save the questions and answers in the define question section
    ${splitted_questions}    Split String    ${questions}    ,
    ${splitted_questions_count}    Get Length    ${splitted_questions}
    FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
        ${question_and_questionprefix}    Split String    ${splitted_questions}[${question_key}]    -
        ${question}    Catenate    ${question_and_questionprefix}[1]    ${answer_toclick}
        ${questionprefix}    Catenate    ${question_and_questionprefix}[0]    ${answer_toclick}
        Wait Until Time    3
        ${textbox.system.create.decision_tree.riskassess.section.newquestion}    Update Dynamic Value    ${textbox.system.create.decision_tree.riskassess.section.question}    ${section}
        ${textbox.system.create.decision_tree.riskassess.section.newquestion_prefix}    Update Dynamic Value   ${textbox.system.create.decision_tree.riskassess.section.question_prefix}    ${section}
        Input Text    ${textbox.system.create.decision_tree.riskassess.section.newquestion}    ${question}
        Input Text    ${textbox.system.create.decision_tree.riskassess.section.newquestion_prefix}    ${questionprefix}
        ${splitted_answers}    Split String    ${answers}    |
        Enter Multiple Answers For Risk Assessment Decision Tree    ${splitted_answers}[${question_key}]    ${section}    ${answer_toclick}
        Click Element    (${button.system.create.decision_tree.riskassess.section.save})[${answer_toclick}]
        ${label.system.create.decision_tree.section.newquestion}    Update Dynamic Values    ${label.system.create.decision_tree.section.question}    ${questionprefix}    ${question}
        Wait Until Element Is Visible    ${label.system.create.decision_tree.section.newquestion}    ${MEDIUM_WAIT}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Enter Multiple Answers For Risk Assessment Decision Tree
    [Arguments]    ${answers}    ${section}    ${answer_toclick}
    [Documentation]    It is used to enter multiple answers to each question
    ${splitted_answers}    Split String    ${answers}    ,
    ${splitted_answers_count}    Get Length    ${splitted_answers}
    FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
        ${updated_answer_key}    Evaluate    ${answer_key}+2
        ${updated_answer_key}    Convert To String    ${updated_answer_key}
        ${textbox.system.create.decision_tree.riskassess.newanswer}    Update Dynamic Values    ${textbox.system.create.decision_tree.riskassess.answer}    ${updated_answer_key}    ${section}
        Wait Until Time    1
        Wait Until Element Is Visible    ${textbox.system.create.decision_tree.riskassess.newanswer}    ${MEDIUM_WAIT}    Answer input textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
        Input Text   ${textbox.system.create.decision_tree.riskassess.newanswer}    ${splitted_answers}[${answer_key}]
        IF    ${answer_key}+1<${splitted_answers_count}
            Click Element    (${link.system.create.decision_tree.riskassess.section.answer.add})[${answer_toclick}]
        END
    END

Add Validation Standard
    [Arguments]    ${validation_standard}
    [Documentation]    It is used to validation standard in define action tab
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}
    Select Frame    ${iframe.library_frame.screen}
    Click Element    ${dropdown.system.create.decision_tree.section.answer.decision_required.validation_standard}
    ${checkbox.validation_standard.newdecision_tree}    Update Dynamic Value    ${list.validation_standard.decision_tree}    ${validation_standard}
    Wait Until Time    3
    Wait Until Element Is Visible    ${checkbox.validation_standard.newdecision_tree}    ${MEDIUM_WAIT}
    ${status}    Run Keyword And Return Status    Element Attribute Value Should Be    ${checkbox.validation_standard.newdecision_tree}    class    active-result
    IF    '${status}' == 'True'
        Click Element    ${checkbox.validation_standard.newdecision_tree}
    ELSE
        ${status1}    Run Keyword And Return Status    Element Attribute Value Should Be    ${checkbox.validation_standard.newdecision_tree}    class    active-result highlighted
        IF    '${status1}' == 'True'    Click Element    ${checkbox.validation_standard.newdecision_tree}
    END
    Wait Until Time    3
    Click Button In VLMS    Save
    Wait Until Time    3
    Click Element    ${button.document.sliderclose.ValidationStandard}

Define Question Actions For Decision Tree
    [Arguments]    ${decision_required}    ${key}    ${question}    ${decision_tree_data}
    [Documentation]    It is used to define the different actions for questions
    Wait Until Time    5
    IF    '${decision_tree_data}[DecisionTreeFor]' == 'Content Generation'
        ${radiobutton.system.create.decision_tree.section.action.newdecision_required}    Update Dynamic Value    ${radiobutton.system.create.decision_tree.section.action.decision_required.pre}    ${decision_required}
        Click Element    (${radiobutton.system.create.decision_tree.section.action.newdecision_required})[${key}]
        Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
        Wait Until Time    3
        ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action}    ${question}
        Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
    ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'GxP Assessment'
        IF    '${decision_tree_data}[AssessmentBasedOn]' != 'Calculated values'
            Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
            ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action}    ${question}
            Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
        ELSE
            Select From List By Value    (${dropdown.system.creacte.decision_tree.validation_score})[${key}]    ${decision_required}    
            Wait Until Time    2
            Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
            ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action}    ${question}
            Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
        END
    ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Validation Standard Assessment'
        ${radiobutton.system.create.decision_tree.section.action.newdecision_required}    Update Dynamic Value    ${radiobutton.system.create.decision_tree.section.action.decision_required.pre}    ${decision_required}
        Click Element    (${radiobutton.system.create.decision_tree.section.action.newdecision_required})[${key}]
        Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
        ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action}    ${question}
        Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
    ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Risk Assessment'
        Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
        ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action.riskassess}    ${question}
        Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
    END

Enter Details In Define Action Tab For Decision Tree
    [Arguments]    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
    [Documentation]    It is used to enter all details in define action tab
    IF    '${decision_tree_data}[DecisionTreeFor]' == 'Content Generation'
        Define Action For Content Generator Decision Tree    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
    ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'GxP Assessment'
        Define Action For GxP Decision Tree    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
    ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Validation Standard Assessment'
        Define Action For Validation Standard Decision Tree    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
    ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Risk Assessment'
        Define Action For Risk Assessment Decision Tree    ${questions}    ${answers}    ${decision_tree_data}
    END

Define Action For Content Generator Decision Tree
    [Arguments]    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
    [Documentation]    It is used for content generator decision 
    ${splitted_questions}    Split String    ${questions}    ,
    ${splitted_questions_count}    Get Length    ${splitted_questions}
    ${splitted_decision_required}    Split String    ${decision_required}    |
    FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
        ${updated_decision_required}    Split String    ${splitted_decision_required}[${question_key}]    ,
        Wait Until Time    2
        Select Value From Dropdown    UltraWebTab1_ddlQuestionRoot_chosen    ${splitted_questions}[${question_key}]
        ${splitted_answers}    Split String    ${answers}    |
        ${updated_splitted_answers}    Split String    ${splitted_answers}[${question_key}]    ,
        ${splitted_answers_count}    Get Length    ${updated_splitted_answers}
        FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
            ${updated_answer_key}    Evaluate    ${answer_key}+1
            ${updated_question_key}    Evaluate    ${question_key}+1
            IF    ${answer_key}==1 or ${updated_question_key}==${splitted_questions_count}
                Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    End Action    ${decision_tree_data}
                IF    '${updated_decision_required}[${answer_key}]'=='rbtnYes'
                    Click Element    ${button.system.create.decision_tree.section.answer.decision_required.pre}
                    Add Manual Content Library_Prerequisite    Generic Based    ${decision_tree_data}[ContentLibrary]
                    #Verify Success Message And Click Submit    Deliverables saved    btnMessageOk    2
                    Wait Until Time    4
                    Click Element    ${button.document.sliderclose}
                    Unselect Frame
                    Select Frame    ${iframe.framecontent}
                END
            ELSE
                Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    ${splitted_questions}[${updated_question_key}]    ${decision_tree_data}
            END
        END
        Wait Until Time    4
        Click Button In VLMS    Complete
        #Verify Confirmation Popup    Decision Action has been Completed    btnMessageOk
    END

Define Action For GxP Decision Tree
    [Arguments]    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
    [Documentation]    It is used for content generator decision 
    ${splitted_questions}    Split String    ${questions}    ,
    ${splitted_questions_count}    Get Length    ${splitted_questions}
    ${splitted_decision_required}    Split String    ${decision_required}    |
    FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
        ${updated_decision_required}    Split String    ${splitted_decision_required}[${question_key}]    ,
        Wait Until Time    2
        Select Value From Dropdown    UltraWebTab1_ddlQuestionRoot_chosen    ${splitted_questions}[${question_key}]
        ${splitted_answers}    Split String    ${answers}    |
        ${updated_splitted_answers}    Split String    ${splitted_answers}[${question_key}]    ,
        ${splitted_answers_count}    Get Length    ${updated_splitted_answers}
        FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
            ${updated_answer_key}    Evaluate    ${answer_key}+1
            ${updated_question_key}    Evaluate    ${question_key}+1
            IF    ${answer_key}==1 or ${updated_question_key}==${splitted_questions_count}
                Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    End Action    ${decision_tree_data}
            ELSE
                Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    ${splitted_questions}[${updated_question_key}]    ${decision_tree_data}
            END
        END
        Wait Until Time    4
        Click Button In VLMS    Complete
        #Verify Confirmation Popup    Decision Action has been Completed    btnMessageOk
    END
    Wait Until Time    ${MEDIUM_WAIT}
    IF    '${decision_tree_data}[AssessmentBasedOn]' != 'Calculated values'
        ${question_GxP1}    Split String    ${splitted_questions}[0]    -
        ${question_GxP2}    Split String    ${splitted_questions}[1]    -
        ${result_GxP}    Split String    ${answers}    |
        ${updated_result_GxP}    Split String    ${result_GxP}[0]    ,
        Scroll To Element    //div[contains(@id,'ddlDefaultRule_')]
        Select Dropdown Value With Partial Text    RuleDetail_ctl02_ddlQuestionCombination_    ${question_GxP1}[1]
        Wait Until Time    2
        Select Dropdown Value With Partial Text    RuleDetail_ctl02_ddlResult_    ${updated_result_GxP}[0]
        Wait Until Time    2
        Select Dropdown Value With Partial Text    ReqDetail_ctl02_ddlQuestionCombination_    ${question_GxP2}[1]
        Wait Until Time    2
        Select Dropdown Value With Partial Text    ReqDetail_ctl02_ddlResult_    ${updated_result_GxP}[1]
    ELSE
        ${splitted_score}    Split String    ${decision_tree_data}[ValidationScore-Score]    |
        ${splitted_requirement}    Split String    ${decision_tree_data}[ValidationScore-Requirement]    |
        ${splitted_score_count}    Get Length    ${splitted_score}
        IF    '${decision_tree_data}[ValidationScore-Condition]' == 'Between'
            FOR    ${score_key}    IN RANGE    0    ${splitted_score_count}
                ${splitted_key}    Split String    ${splitted_score}[${score_key}]    ,
                ${updated_score_key}    Evaluate    ${score_key}+1
                Select From List By Label    (${dropdown.system.create.decision_tree.gxp_impact.condition})[${updated_score_key}]    Between
                Wait Until Time    2
                Input Text    (${dropdown.system.create.decision_tree.gxp_impact.validationscore.from})[${updated_score_key}]    ${splitted_key}[0]
                Input Text    (${dropdown.system.create.decision_tree.gxp_impact.validationscore.to})[${updated_score_key}]    ${splitted_key}[1]
                Wait Until Time    2
                Select From List By Label    (${dropdown.system.create.decision_tree.gxp_impact.requirement})[${updated_score_key}]    ${splitted_requirement}[${score_key}]
            END
        ELSE
            FOR    ${score_key}    IN RANGE    0    ${splitted_score_count}
                ${updated_score_key}    Evaluate    ${score_key}+1
                Select From List By Label    (${dropdown.system.create.decision_tree.gxp_impact.condition})[${updated_score_key}]    =
                Wait Until Time    2
                Input Text    (${dropdown.system.create.decision_tree.gxp_impact.validationscore.equalto})[${updated_score_key}]    ${splitted_score}[${score_key}]
                Wait Until Time    2
                Select From List By Label    (${dropdown.system.create.decision_tree.gxp_impact.requirement})[${updated_score_key}]    ${splitted_requirement}[${score_key}]
            END
        END
    END
    Wait Until Time    2
    Select Dropdown Value With Partial Text    ddlDefaultRule_    GxP Impact

Define Action For Validation Standard Decision Tree
    [Arguments]    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
    [Documentation]    It is used for content generator decision 
    ${splitted_questions}    Split String    ${questions}    ,
    ${splitted_questions_count}    Get Length    ${splitted_questions}
    ${splitted_decision_required}    Split String    ${decision_required}    |
    FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
        ${updated_decision_required}    Split String    ${splitted_decision_required}[${question_key}]    ,
        Wait Until Time    2
        Select Value From Dropdown    UltraWebTab1_ddlQuestionRoot_chosen    ${splitted_questions}[${question_key}]
        ${splitted_answers}    Split String    ${answers}    |
        ${updated_splitted_answers}    Split String    ${splitted_answers}[${question_key}]    ,
        ${splitted_answers_count}    Get Length    ${updated_splitted_answers}
        FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
            ${updated_answer_key}    Evaluate    ${answer_key}+1
            ${updated_question_key}    Evaluate    ${question_key}+1
            IF    ${answer_key}==1 or ${updated_question_key}==${splitted_questions_count}
                Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    End Action    ${decision_tree_data}
                IF    '${updated_decision_required}[${answer_key}]'=='rbtnYes'
                    Click Element    ${button.system.create.decision_tree.section.answer.decision_required.pre}
                    Add Validation Standard    ${decision_tree_data}[Validation Standard]
                    #Click Element    //div[@id="val1_pnlConfirmationMessage" and not(contains(@style,"display: none;"))]//following::input[@id="btnMessageOk"]
                    # Verify Confirmation Popup    Deliverables saved    btnMessageOk
                    Wait Until Time    2
                    #Click Element    ${button.document.sliderclose.ValidationStandard}
                    Unselect Frame
                    Select Frame    ${iframe.framecontent}
                END
            ELSE
                Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    ${splitted_questions}[${updated_question_key}]    ${decision_tree_data}
                IF    '${updated_decision_required}[${answer_key}]'=='rbtnYes'
                    Click Element    ${button.system.create.decision_tree.section.answer.decision_required.pre}
                    Add Validation Standard    ${decision_tree_data}[Validation Standard]

                    #Click Element    //div[@id="val1_pnlConfirmationMessage" and not(contains(@style,"display: none;"))]//following::input[@id="btnMessageOk"]
                    # Verify Confirmation Popup    Deliverables saved    btnMessageOk
                    Wait Until Time    2
                    #Click Element    ${button.document.sliderclose.ValidationStandard}
                    Wait Until Time    2
                    Unselect Frame
                    Select Frame    ${iframe.framecontent}
                END
            END
        END
        Wait Until Time    4
        Click Button In VLMS    Complete
        #Verify Confirmation Popup    Decision Action has been Completed    btnMessageOk
    END

Define Action For Risk Assessment Decision Tree
    [Arguments]    ${questions}    ${answers}    ${decision_tree_data}
    [Documentation]    It is used for risk assessment decision
    ${splitted_questions}    Split String    ${questions}    ,
    ${splitted_questions_count}    Get Length    ${splitted_questions}
    ${index_itr}    Set Variable    0
    Wait Until Time    3
    FOR    ${section_key}    IN RANGE    0    ${itr}
        Scroll To Element    //input[@id='btnSubmit']
        Select Dropdown Value With Partial Text    _ddlRiskModelSectionAction_    ${section_list}[${section_key}]
        Scroll To Element    //input[@id='btnSubmit']
        FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
            Wait Until Time    2
            ${question_and_questionprefix}    Split String    ${splitted_questions}[${question_key}]    -
            ${question}    Catenate    ${question_and_questionprefix}[1]    ${texttoappend.question}[${index_itr}]
            #${questionprefix}    Catenate    ${question_and_questionprefix}[0]    ${texttoappend.question}[${question_key}]
            Select Dropdown Value With Partial Text    UltraWebTab1_ddlQuestionRoot_chosen    ${question}
            ${splitted_answers}    Split String    ${answers}    |
            ${updated_splitted_answers}    Split String    ${splitted_answers}[${question_key}]    ,
            ${splitted_answers_count}    Get Length    ${updated_splitted_answers}
            FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
                ${updated_answer_key}    Evaluate    ${answer_key}+1
                ${updated_question_key}    Evaluate    ${question_key}+1
                IF    ${answer_key}==1 or ${updated_question_key}==${splitted_questions_count}
                    Define Question Actions For Decision Tree    None    ${updated_answer_key}    End Action    ${decision_tree_data}
                ELSE
                    ${question_and_questionprefix}    Split String    ${splitted_questions}[${updated_question_key}]    -
                    ${question}    Catenate    ${question_and_questionprefix}[1]    ${texttoappend.question}[${index_itr}]
                    Define Question Actions For Decision Tree    None    ${updated_answer_key}    ${question}    ${decision_tree_data}
                END
            END
            Wait Until Time    2
            Click Button In VLMS    Complete
            #Verify Confirmation Popup    Decision Action has been Completed    btnMessageOk
        END
    ${index_itr}    Evaluate    ${index_itr}+1    
    Wait Until Time    3
    END
    Scroll To Element    //input[@id='btnSubmit']
    FOR    ${section_key}    IN RANGE    0    ${itr}
        ${updated_section_key}    Evaluate    ${section_key}+1
        Click Element    (${tab.system.create.decision_tree.business_rule_riskassess})[${updated_section_key}]
        Wait Until Time    3
        Select First Value From Dropdown    _ddlQuestionCombination
        Wait Until Time    2
        Select First Value From Dropdown    _ddlResult
        Wait Until Time    2
        Select Specific Index Value From Dropdown    _ddlRiskFactors    3
        Wait Until Time    2
        ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    ddlDefaultRule
        Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
        Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    15
        #Javascript Input Text    ${textbox.common.select.value}    5
        Wait Until Time    2
        Click element    //div[@id='dvDefaultRule']/div//li[3]
        #Select Specific Index Value From Dropdown    ddlDefaultRule    3
    END

Bind_Decision_Tree
    [Arguments]    ${validation_standard}    ${User}    ${User_password}
    ${count}    Get Length    ${validation_standard}
    FOR    ${key}    IN RANGE    0    ${count}
        ${Bind_decision}    Set Variable    ${validation_standard}[${key}]
        IF    'BoundType' in ${Bind_decision}    Select Value For Radio Button    BindDecisionTree    ${Bind_decision}[BoundType]
        Click Element    ${dropdown.category.system.bind.decisiontree}
        Wait Until Element Is Visible    ${textbox.search.system.bind.decisiontree}
        Input Text    ${textbox.search.system.bind.decisiontree}    ${Bind_decision}[Category]
        ${checkbox.category.content.bind.decisiontree.new}    Update Dynamic Value    ${checkbox.Select.system.bind.decisiontree}    ${Bind_decision}[Category]
        Wait Until Element Is Visible    ${checkbox.category.content.bind.decisiontree.new}    ${SHORT_WAIT}
        Javascript Click    ${checkbox.category.content.bind.decisiontree.new}
        Press Keys    //label[@for='rbtnCat']    TAB
        #Scroll Element Into View    ${checkbox.category.content.bind.decisiontree.new}
        # Wait Until Time    ${SHORT_WAIT}
        # ${checkbox.category.content.bind.decisiontree.new}    Update Dynamic Value    ${checkbox.category.content.bind.decisiontree}    ${Bind_decision}[Category]
        # Scroll Element Into View    ${checkbox.category.content.bind.decisiontree.new}
        # Wait Until Time    ${SHORT_WAIT}
        # Click Element    ${checkbox.category.content.bind.decisiontree.new}
        IF    'DecisionTreeType' in ${Bind_decision}    Select Value From Dropdown    ddlDecisionTreeType_chosen    ${Bind_decision}[DecisionTreeType]
        Wait Until Time    ${SHORT_WAIT}
        Select Value From Dropdown    lstDecisionTree_chosen    ${Bind_decision}[DecisionTreeName]
        # ${checkbox.decisiontree.content.bind.decisiontree.new}    Update Dynamic Value    ${checkbox.decisiontree.content.bind.decisiontree}    ${Bind_decision}[DecisionTreeName]
        # Click Element    ${checkbox.decisiontree.content.bind.decisiontree.new}
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${User}    ${User_password}    Submit
        ${ExpectedResult}    Set Variable    Decision Tree has been bound
        Get Value From Toast Message    ${ExpectedResult}
    END

Create Spread Template
    [Documentation]    This keyword is sused to create Retirement
    [Arguments]    ${SpreadTemplate_data}    ${USER}    ${USER_PASSWORD}
    ${count}    Get Length   ${SpreadTemplate_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${dict_data}    Set Variable    ${SpreadTemplate_data}[${key}]
        Click Button In VLMS    Create
        Wait Until Element Is Visible    ${spreadtemplate.Text}
        IF    'SelectContentFunction' in ${dict_data}    Select Value From Dropdown    ddlTemplateType_chosen    ${dict_data}[SelectContentFunction]
        #Select Value From Dropdown    ddlTemplateType_chosen    ${dict_data}[SelectContentFunction]
        Wait Until Element Is Visible    ${spreadtemplate.Text}
        IF    'TemplateName' in ${dict_data}    Enter Text In Mandatory Fields    BoxName    ${dict_data}[TemplateName]
        Wait Until Time    5
        ${spreadtemplate.id}    Get Text    ${label.spreadtemplate.id}
        Wait Until Element Is Visible    ${label.spreadtemplate.id}    ${SHORT_WAIT}    ${label.spreadtemplate.id} is not visible after waiting for ${SHORT_WAIT} sec
        IF    'IDFormat' in ${dict_data}    Select Value From Dropdown    ddlSelReqIDFormat_chosen    ${dict_data}[IDFormat]
        Wait Until Time    3
        Wait Until Element Is Visible    ${icon.add}    ${SHORT_WAIT}    ${icon.add}
        Click Element    ${icon.add}
        Wait Until Time    3
        Wait Until Element Is Visible    ${icon.add}    ${SHORT_WAIT}    ${icon.add} is not visible for ${SHORT_WAIT} seconds
        IF    'ColumnLabel' in ${dict_data}        Input Text    grdTemplateFieldDetails_ctl04_txtFieldLabel    ${dict_data}[ColumnLabel]
        IF    'ColumnType' in ${dict_data}    Select Value From Dropdown    grdTemplateFieldDetails_ctl04_ddlColType_chosen    ${dict_data}[ColumnType]
        #Wait Until Element Is Visible    ${icon.add.sheet}    ${SHORT_WAIT}    ${icon.add.sheet} is not visible for ${SHORT_WAIT} seconds
        #Click Element    ${icon.add.sheet}
        #Wait Until Element Clickable    ${icon.add.sheet}
        Wait Until Time    4
        IF    'Type' in ${dict_data}    Select Value From Dropdown    ddlHierarchy_chosen    ${dict_data}[Type]
        Wait Until Time    ${SHORT_WAIT}
        IF    'InheritanceLevel' in ${dict_data}    Select Value From Dropdown    ddlHierarchyData_chosen    ${dict_data}[InheritanceLevel]
        Wait Until Time    ${SHORT_WAIT}
        #Click Element     //*[@id='Label2']
        Wait Until Time    ${SHORT_WAIT}
        Click Element     ${button.save.system.spreadtemplate.associategroup}
        Wait Until Time    ${SHORT_WAIT}
        Select Value For Radio Button    rbtnApprovalNo    ${dict_data}[ApprovalRequired]
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        Wait Until Element Is Visible    ${label.id}    ${MEDIUM_WAIT}    ${label.id} is not visible after ${MEDIUM_WAIT}
        ${Retirement.id}    Get Text    ${label.id}
        ${Expected_Result}    Set Variable    ${dict_data}[TemplateName] Spread Template ${spreadtemplate.id} has been created
        Get Value From Toast Message    ${Expected_Result}
        Set Suite Variable    ${spreadtemplate.id}
    END

Create Workflow
    [Documentation]    This keyword is used to create Workflow
    [Arguments]    ${workflow_data}    ${USER}    ${USER_PASSWORD}
    Wait Until Time    ${SHORT_WAIT}
    ${count}    Get Length    ${workflow_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${dict_data}    Set Variable    ${workflow_data}[${key}]
        Click Button in VLMS    Create
        IF    'WorkflowName' in ${dict_data}    Enter Text In Mandatory Fields    WName    ${dict_data}[WorkflowName]
        ${Assigncount}    Split String    ${dict_data}[ApplicableTo]    ,
        ${Assign}    Get Length    ${Assigncount}
        FOR    ${key}    IN RANGE    0    ${Assign}
            ${Value}    Set Variable    ${Assigncount}[${key}]
            Select Value From Dropdown    chkApplicableTo_chosen    ${Value}
        END    
        #Click Element    ${checkbox.selectall.WF}
        Wait Until Time    2
        IF    'ReviewerGroup' in ${dict_data}   
            ${Groupcount}    Split String    ${dict_data}[ReviewerGroup]    ,
            ${Group}    Get Length    ${Groupcount}
            FOR    ${key}    IN RANGE    0   ${Group}
                ${Value}    Set Variable    ${Groupcount}[${key}]
                Wait Until Time    ${SHORT_WAIT}
                Select Value From Dropdown    lstReviewer_chosen    ${Value}
            END
            #Swipe Values Between Groups_Prerequisite    ${dict_data}[ReviewerGroup]    lstReviewer    lstAssreviewer
            ${rowNo}    Set Variable    2
            ${groups}    Split String    ${dict_data}[ReviewerGroup]    ,
            ${GroupUsers}    Split String    ${dict_data}[ReviewGroup]    |
            ${splitorder}    Split String    ${dict_data}[Rorder]    ,
            ${splitFRole}    Split String    ${dict_data}[ReviewerFunctionalRole]    ,
            ${splitPeriod}    Split String    ${dict_data}[RWPeriodinDay]    ,
            ${splitFrequency}    Split String    ${dict_data}[RWFrequencyinDay]    ,
            ${splitSerial}    Split String    ${dict_data}[RWSerial/Parallel]    ,
            ${order_count}    Get Length    ${splitorder}
            FOR    ${counter}    IN RANGE    0    ${order_count}
                Wait Until Time    ${SHORT_WAIT}
                Wait Until Element Is Visible    //input[@id="grvReview_ctl0${rowNo}_txtGroupUser"]
                Click Element    //input[@id="grvReview_ctl0${rowNo}_txtGroupUser"]
                Wait Until Time    2
                ${splitgroup}    Split String    ${GroupUsers}[${counter}]    -
                IF    'Group' == '${splitorder}[${counter}]'
                    Input Text    //input[@id="txtSearchGroup"]    ${groups}[${counter}]
                    Click Element    //span[text()="${splitgroup}[0]"]/preceding-sibling::input[contains(@id,"chkGroupSel")]
                    Click Element    //input[@id="btnESave"]
                ELSE
                    Click Element    //span[text()="${splitgroup}[0]"]/preceding-sibling::a[contains(@id,"btnExpand")]
                    Wait Until Time    2
                    ${splitusers}    Split String    ${splitgroup}[1]    ,
                    ${user_count}    Get Length    ${splitusers}
                    FOR    ${rusers}    IN RANGE    0    ${user_count}
                        #Wait Until Element Is Visible    //span[text()="${splitgroup}[0]"]//following::a[contains(@id,"btnSearch")]
                        #Click Element    //span[text()="${splitgroup}[0]"]//following::a[contains(@id,"btnSearch")]
                        #Click Element    //span[text()="${splitgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]
                        #Clear Element Text    //span[text()="${splitgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]
                        #Input Text    //span[text()="${splitgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]    ${splitusers}[${rusers}]
                        Wait Until Time    2
                        Click Element    //table[contains(@id,"ddlUser")]//span[contains(text(),"${splitusers}[${rusers}]")]/preceding-sibling::div/input[contains(@id,"ddlUser")]
                    END
                    Click Element    //input[@id="btnESave"]
                END
                Wait Until Time    2
                Select Value From Dropdown for Select    //div[@id="grvReview_ctl0${rowNo}_ddlFunctionalRole_chosen"]    ${splitFRole}[${counter}]
                Wait Until Time    3
                Input Text    //input[@id='grvReview_ctl0${rowNo}_txtTenure']    ${splitPeriod}[${counter}]
                Input Text    //input[@id='grvReview_ctl0${rowNo}_txtAlert']    ${splitFrequency}[${counter}]
                Select Value From Dropdown    grvReview_ctl0${rowNo}_ddlSerial_chosen    ${splitSerial}[${counter}]
                ${status}    Evaluate    ${order_count} >= ${rowNo}
                IF    '${status}' == 'True'
                    Javascript Click   //a[@id='btnAddRview']
                    ${rowNo}    Evaluate    ${rowNo}+1
                END
            END
        END
        IF    'ApproverGroup' in ${dict_data}   
            #Swipe Values Between Groups_Prerequisite    ${dict_data}[ApproverGroup]    lstApAvailbleUser    lstApAssignUser
            ${rowNo}    Set Variable    2
            ${Agroups}    Split String    ${dict_data}[ApproverGroup]    ,
            ${AGroupUsers}    Split String    ${dict_data}[ApproveGroup]    |
            ${splitAorder}    Split String    ${dict_data}[Aorder]    ,
            ${splitAFRole}    Split String    ${dict_data}[ApproverFunctionalRole]    ,
            ${splitAPeriod}    Split String    ${dict_data}[APRPeriodinDay]    ,
            ${splitAFrequency}    Split String    ${dict_data}[APRFrequencyinDay]    ,
            ${splitASerial}    Split String    ${dict_data}[APSerial/Parallel]    ,
            ${order_Acount}    Get Length    ${splitAorder}
            FOR    ${Acounter}    IN RANGE    0    ${order_Acount}
                Wait Until Element Is Visible    //input[@id="grvApprove_ctl0${rowNo}_txtGroupUser"]
                Click Element    //input[@id="grvApprove_ctl0${rowNo}_txtGroupUser"]
                Input Text    //input[@id="txtSearchGroup"]    ${Agroups}[${Acounter}]
                ${splitAgroup}    Split String    ${AGroupUsers}[${Acounter}]    -
                IF    'Group' == '${splitAorder}[${Acounter}]'
                    Click Element    //span[text()="${splitAgroup}[0]"]/preceding-sibling::input[contains(@id,"chkGroupSel")]
                    Click Element    //input[@id="btnESave"]
                ELSE
                    Click Element    //span[text()="${splitAgroup}[0]"]/preceding-sibling::input[contains(@id,"btnExpand")]
                    Wait Until Time    2
                    ${splitAusers}    Split String    ${splitAgroup}[1]    ,
                    ${user_count}    Get Length    ${splitAusers}
                    FOR    ${ausers}    IN RANGE    0    ${user_count}
                        Wait Until Element Is Visible    //span[text()="${splitAgroup}[0]"]//following::a[contains(@id,"btnSearch")]
                        Click Element    //span[text()="${splitAgroup}[0]"]//following::a[contains(@id,"btnSearch")]
                        Click Element    //span[text()="${splitAgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]
                        Clear Element Text    //span[text()="${splitAgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]
                        Input Text    //span[text()="${splitAgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]    ${splitAusers}[${ausers}]
                        Wait Until Time    2
                        Click Element    //table[contains(@id,"ddlUser")]//span[contains(text(),"${splitusers}[${ausers}]")]/preceding-sibling::input[contains(@id,"ddlUser")]
                    END
                    Click Element    //input[@id="btnESave"]
                END
                Wait Until Time    3
                Select Value From Dropdown for Select    //div[@id="grvApprove_ctl0${rowNo}_ddlFunctionalRole_chosen"]    ${splitAFRole}[${Acounter}]
                Wait Until Time    3
                Input Text    //input[@id='grvApprove_ctl0${rowNo}_txtTenure']    ${splitAPeriod}[${Acounter}]
                Input Text    //input[@id='grvApprove_ctl0${rowNo}_txtAlert']    ${splitAFrequency}[${Acounter}]
                Wait Until Time    ${SHORT_WAIT}
                Scroll To Element    grvApprove_ctl0${rowNo}_ddlSerial_chosen
                Select Value From Dropdown    grvApprove_ctl0${rowNo}_ddlSerial_chosen    ${splitASerial}[${Acounter}]
                ${status}    Evaluate    ${order_Acount} >= ${rowNo}
                IF    '${status}' == 'True'
                    Click Element    //input[@id="btnAddApprove"]
                    ${rowNo}    Evaluate    ${rowNo}+1
                END
            END
        END
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit    created
        ${Expected_Result}    Set Variable    ${dict_data}[WorkflowName] Workflow has been created
        Get Value From Toast Message    ${Expected_Result}
    END

Select Calendar Checkboxes
    [Documentation]    Select checkboxes for calendar.
    [Arguments]    ${calender_data}
    ${index}    Set Variable    0
    Wait Until Time    5
    ${checkbox}    Split String    ${calender_data}[WorkingDays]    ,
    # @{check_box}    Create List    ${checkbox}
    # ${count}    Get Length    @{check_box}
    FOR    ${value}    IN    @{check_box}
        ${label.calender.checkboxes}    Update Dynamic Value    ${label.checkbox}    ${value}
        Scroll Element Into View    ${label.calender.checkboxes}
        Wait Until Time    2
        Select Checkbox    ${label.calender.checkboxes}
        Wait Until Time    4
    END