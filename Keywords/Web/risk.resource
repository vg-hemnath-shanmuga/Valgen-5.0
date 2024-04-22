*** Settings ***
Documentation     This risk resource file has all the risk module keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Navigate To Risk Assessment Page
    [Documentation]    This keyword will navigate to Risk Assessment Page
    Navigate To Module Tab    Risk    Assess    Risk Assessment    Select Risk Assessment    True
    Click Button In VLMS    Create

Create Risk Assessment
    [Arguments]    ${risk_assess_data}    ${doc_no}    ${riskmodel_name}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Risk Assessment
    IF    'Wait' in ${risk_assess_data}    Wait Until Time    ${risk_assess_data}[Wait]
    Wait Until Element Is Visible    ${label.risk.assess.risk_assessment.header}    ${MEDIUM_WAIT}    Risk Assessment header is not visible after waiting for ${MEDIUM_WAIT} seconds
    Enter Details In Risk Assessment Page    ${risk_assess_data}    ${riskmodel_name}
    Wait Until Time    1
    IF    'DocNo' in ${risk_assess_data}
        ${status}    Run Keyword And Return Status    Select Value From Dropdown    ddlDocument    ${doc_no}
        IF    '${status}'=='False'
            Click Top Menu Icons    Refresh
            Select Frame    ${iframe.framecontent}
            Enter Details In Risk Assessment Page    ${risk_assess_data}    ${riskmodel_name}
            Wait Until Time    1
            Select Value From Dropdown    ddlDocument    ${doc_no}
        END
        Wait Until Element Is Visible    ${label.risk.assess.risk_assessment.risk_level_grid}    ${MEDIUM_WAIT}    Select Risk Level Grid is not visible after waiting for ${MEDIUM_WAIT} seconds
        # Log Actual And Expected Results    "Select Risk Level" Grid is Displayed    "Select Risk Level" Grid should be Displayed
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END
    ${risk_assessment_id}    Get Text    ${label.risk.assess.risk_assessment.risk_id}
    IF    'ReferenceList' in ${risk_assess_data}    Enter Details In Risk Level Grid    ${risk_assess_data}
    IF    'Approval' in ${risk_assess_data}
        Select Value For Radio Button    WorkflowReq    ${risk_assess_data}[Approval]
        IF    '${risk_assess_data}[Approval]'=='rbtnWorkflowYes'
            IF    'WorkFlow' in ${risk_assess_data}    Select Value From Dropdown    ddlWorkflow    ${risk_assess_data}[WorkFlow]
            IF    'RouteTaskFor' in ${risk_assess_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${risk_assess_data}[RouteTaskFor]
        END
    END
    IF    'Comments' in ${risk_assess_data}    Enter Comments/Description    txtComments    ${risk_assess_data}[Comments]
    IF    'Button' in ${risk_assess_data}    Select Submit/Reset Button    ${risk_assess_data}[Button]
    IF    'eSign' in ${risk_assess_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit    ${risk_assess_data}[Reason]
    ${EXPECTED_MESSAGE}    Set Variable    Risk Assessment - ${risk_assess_data}[RiskAssessmentName] for ${risk_assessment_id} has been created
    RETURN    ${EXPECTED_MESSAGE}

Enter Details In Risk Assessment Page
    [Arguments]    ${risk_assess_data}    ${riskmodel_name}
    [Documentation]    This Keyword is used to Enter Details in Risk Assessment Page
    IF    'TaskType' in ${risk_assess_data}    Select Value For Radio Button    DocumentType    ${risk_assess_data}[TaskType]
    IF    '${risk_assess_data}[TaskType]'=='rbtRevision'
        IF    'SelectRiskAssessmentID' in ${risk_assess_data}    Select Value From Dropdown    ddlParentCode    ${risk_assess_data}[SelectRiskAssessmentID]
        Wait Until Time    2
    END
    IF    'RiskAssessmentName' in ${risk_assess_data}    Enter Text In Mandatory Fields    GroupName    ${risk_assess_data}[RiskAssessmentName]
    IF    'RiskAssessmentForm' in ${risk_assess_data}    Select Value From Dropdown    ddlGroupType    ${risk_assess_data}[RiskAssessmentForm]
    IF    'IsRiskRequired' in ${risk_assess_data}
        Wait Until Time    2
        Wait Until Element Is Visible    ${textbox.risk.assess.risk_assessment.risk_required}    ${MEDIUM_WAIT}    Risk Required textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
        Input Text    ${textbox.risk.assess.risk_assessment.risk_required}    ${risk_assess_data}[IsRiskRequired]
    END
    IF    'IsRiskFrameworkRequired' in ${risk_assess_data}    Input Text    ${textbox.risk.assess.risk_assessment.risk_framework_required}    ${risk_assess_data}[IsRiskFrameworkRequired]
    IF    'RiskBasedApproach' in ${risk_assess_data}    Select Value From Dropdown    ddlProcessbased    ${risk_assess_data}[RiskBasedApproach]
    IF    'RiskModel' in ${risk_assess_data}
        Select Dropdown Value With Partial Text    ddlRiskType    ${riskmodel_name}
        IF    'AutoPopulatedFields' in ${risk_assess_data}    Verify Multiple Texts In A Page    ${risk_assess_data}[AutoPopulatedFields]
    END
    IF    'EntitySelection' in ${risk_assess_data}
        Click Element    ${label.content.assign.document.initiate.entity_search}
        Input Text    ${label.content.assign.document.initiate.entity_search}    ${risk_assess_data}[EntitySelection]
        ${label.content.assign.document.initiate.newentity}    Update Dynamic Value    ${label.content.assign.document.initiate.entity}    ${risk_assess_data}[EntitySelection]
        Wait Until Time    3
        Wait Until Element Is Visible    ${label.content.assign.document.initiate.newentity}    ${MEDIUM_WAIT}    ${risk_assess_data}[EntitySelection] is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${label.content.assign.document.initiate.newentity}
    END
    IF    'FoundationContentType' in ${risk_assess_data}    Select Value From Dropdown    ddlValType    ${risk_assess_data}[FoundationContentType]

Enter Details In Risk Level Grid
    [Arguments]    ${risk_assess_data}
    [Documentation]    This Keyword is used to Enter Details in Risk Level Grid
    ${index}    Set Variable    0
    @{Severities_list}    Split String    ${risk_assess_data}[Severities]    ,
    @{Probabilities_list}    Split String    ${risk_assess_data}[Probabilities]    ,
    @{Detectabilities_list}    Split String    ${risk_assess_data}[Detectabilities]    ,
    @{ref_list}    Split String    ${risk_assess_data}[ReferenceList]    ,
    FOR    ${key}    IN    @{ref_list}
        ${label.risk.assess.risk_assessment.risk_level_grid.newref_row}    Update Dynamic Value    ${label.risk.assess.risk_assessment.risk_level_grid.ref_row}    ${key}
        ${row}    Get Element Attribute    ${label.risk.assess.risk_assessment.risk_level_grid.newref_row}    fpkey
        Scroll Element Into View    ${label.risk.assess.risk_assessment.risk_level_grid.newref_row}
        Wait Until Time    2
        Select Values For The Fields Under Deliverable Section    ${row}    ${risk_assess_data}[SeverityColumn]    ${Severities_list}[${index}]
        Wait Until Time    3
        Select Values For The Fields Under Deliverable Section    ${row}    ${risk_assess_data}[ProbabilityColumn]    ${Probabilities_list}[${index}]
        Wait Until Time    3
        Select Values For The Fields Under Deliverable Section    ${row}    ${risk_assess_data}[DetectabilityColumn]    ${Detectabilities_list}[${index}]
        Wait Until Time    2
        ${index}    Evaluate    ${index}+1
        ${label.risk.assess.risk_assessment.risk_level_grid.ref_row.newrisk_process}    Update Dynamic Value    ${label.risk.assess.risk_assessment.risk_level_grid.ref_row.risk_process}    ${row}
        Wait Until Time    3
        Press Keys    ${label.risk.assess.risk_assessment.risk_level_grid.ref_row.newrisk_process}    BACKSPACE
        ${risk_process_Id}    Get Text    ${label.risk.assess.risk_assessment.risk_level_grid.ref_row.newrisk_process}
        Log    Risk Process ${risk_process_Id} is displayed for ${key} under Process Condition column
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Create Custom Risk Model
    [Arguments]    ${riskmodel_data}    ${username}    ${password}
    [Documentation]    This keyword is used to create custom risk model
    Enter Details In Create Risk Model Page    ${riskmodel_data}
    IF    'ProcessModel' in ${riskmodel_data}    Select Value From Dropdown    select2-ddlProcessbased-container    ${riskmodel_data}[ProcessModel]
    Enter And Verify Details In Business Rule For Requirement Level Section    ${riskmodel_data}
    IF    'AdditionalFactorLevel' in ${riskmodel_data}    Select Value From Dropdown    select2-ddlNoofCustomfactor-container    ${riskmodel_data}[AdditionalFactorLevel]
    IF    'FactorLevelNames' in ${riskmodel_data}
        Enter Details In Select Additional Factors Section    ${riskmodel_data}
        Click Button In VLMS    Save Additional Factor
        Wait Until Time    2
    END
    IF    'AdditionalSectionDetails' in ${riskmodel_data}
        @{add_section_details}    Split String    ${riskmodel_data}[AdditionalSectionDetails]    ||
        FOR    ${key}    IN    @{add_section_details}
            @{section_list}    Split String    ${key}    -
            ${section_name}    Set Variable    ${section_list}[0]
            ${no_of_rows}    Set Variable    ${section_list}[1]
            ${section_details}    Set Variable    ${section_list}[2]
            Select The Section And Enter Number Of Rows    ${section_name}    ${no_of_rows}
            Enter Values In Added Additional Factor Level Grid    ${section_name}    ${section_details}
            Verify Entered Details Under Added Additional Factor Level Grid    ${section_name}    ${no_of_rows}    ${section_details}
        END
    END
    IF    'Button' in ${riskmodel_data}    Select Submit/Reset Button    ${riskmodel_data}[Button]
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Handle Electronic Sign    ${username}    ${password}    Submit    Create
    ${RISKMODEL_NAME}    Set Variable    ${riskmodel_data}[RiskModelName]
    Set Suite Variable    ${RISKMODEL_NAME}
    ${EXPECTED_MESSAGE}    Set Variable    ${riskmodel_data}[RiskModelName] Risk Model has been created
    Set Test Variable    ${EXPECTED_MESSAGE}

Verify Additional Factor Level Dropdown Field Is Displayed
    [Documentation]    This keyword is used to Verify fields No. of Additional Factor Levels under Select Additional Factor(s).
    Run Keyword And Continue On Failure    Wait Until Element Is Visible   ${label.risk.create.riskmodel.additionalfactor}    ${MEDIUM_WAIT}    No. of Additional Factor field is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Number Of Rows Dropdown Field Is Displayed
    [Arguments]    ${sectionname}
    [Documentation]    This keyword is used to Verify the No. of rows dropdown field under a section
    ${dropdown.risk.create.riskmodel.newnoof_rows}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.noof_rows}    ${sectionname}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible   ${dropdown.risk.create.riskmodel.newnoof_rows}    ${MEDIUM_WAIT}    No. of rows dropdown field is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Get Values From A Section In Create Risk Model Page
    [Arguments]    ${section_name}    ${fieldname}    ${row}
    [Documentation]    This Keyword is used to get values from the section in Create Risk Model Page
    ${textbox.risk.create.riskmodel.severity.newlevelname}    Update Dynamic Values   (${textbox.risk.create.riskmodel.severity.levelname})[${row}]    ${section_name}    ${fieldname}
    ${value}    Get Value    ${textbox.risk.create.riskmodel.severity.newlevelname}
    RETURN    ${value}

Verify Value For Dropdown Fields
    [Arguments]    ${expected_value}    ${dropdown_id}
    [Documentation]    This keyword is used to get the text from the dropdowns and Verify for the fields under Business Rule for Requirement level section
    ${label.risk.create.riskmodel.severity.newno_ofrows}    Update Dynamic Value    ${label.content.create.tracematrix}   ${dropdown_id}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.risk.create.riskmodel.severity.newno_ofrows}    ${MEDIUM_WAIT}
    ${actual_value}    Run Keyword And Continue On Failure    Get Text    ${label.risk.create.riskmodel.severity.newno_ofrows}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Be Equal    ${actual_value}    ${expected_value}

Enter Details In Select Additional Factors Section
    [Arguments]    ${risk_data}
    [Documentation]    This keyword is used to enter data for fields under select additional factors section
    @{factorlevel_names}    Split String    ${risk_data}[FactorLevelNames]    ,
    @{factorlevel_descriptions}    Split String    ${risk_data}[FactorLevelDescriptions]    ,
    @{field_types}    Split String    ${risk_data}[FieldTypes]    ,
    ${count}    Get Length    ${factorlevel_names}
    ${index}    Set Variable    1
    FOR    ${key}    IN RANGE    0    ${count}
        IF    '${factorlevel_names}[${key}]'!='None'
            Wait Until Element Is Visible    (${textbox.risk.create.riskmodel.select_additional_factors.factorlevel_name})[${index}]    ${MEDIUM_WAIT}    Factor Level Name is not visible after waiting for ${MEDIUM_WAIT} seconds
            Input Text    (${textbox.risk.create.riskmodel.select_additional_factors.factorlevel_name})[${index}]    ${factorlevel_names}[${key}]
        END
        Wait Until Time    1
        IF    '${factorlevel_descriptions}[${key}]'!='None'
            Wait Until Element Is Visible    (${textbox.risk.create.riskmodel.select_additional_factors.description})[${index}]    ${MEDIUM_WAIT}    Description is not visible after waiting for ${MEDIUM_WAIT} seconds
            Input Text    (${textbox.risk.create.riskmodel.select_additional_factors.description})[${index}]    ${factorlevel_descriptions}[${key}]
        END
        IF    '${field_types}[${key}]'!='None'
            ${radiobutton.risk.riskmodel.additional_factors.newfield_type}    Update Dynamic Value    ${radiobutton.risk.riskmodel.additional_factors.field_type}    ${field_types}[${key}]
            Click Element    (${radiobutton.risk.riskmodel.additional_factors.newfield_type})[${index}]
        END
        ${index}    Evaluate    ${index}+1
    END

Enter Value For The Selected Section TextField
    [Arguments]    ${section_name}    ${field_name}    ${row}    ${value}
    [Documentation]    This Keyword is used to enter data into the text field
    ${textbox.risk.create.riskmodel.severity.newlevel}    Update Dynamic Values     ${textbox.risk.create.riskmodel.severity.levelname}    ${section_name}    ${field_name}
    IF    '${value}'!='None'
        Wait Until Element Is Visible    (${textbox.risk.create.riskmodel.severity.newlevel})[${row}]    ${MEDIUM_WAIT}    ${field_name} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    1
        Input Text    (${textbox.risk.create.riskmodel.severity.newlevel})[${row}]    ${value}
    END

Enter Details In Create Risk Model Page
    # robocop: disable=too-long-keyword
    [Arguments]    ${riskmodel_data}
    [Documentation]    This keyword is used to enter details in Create Risk Model Page
    ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create Risk Model Levels
    Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create Risk Model Levels page is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    3
    IF    'RiskModelName' in ${riskmodel_data}    Enter Text In Mandatory Fields    RiskType    ${riskmodel_data}[RiskModelName]
    IF    'Justification' in ${riskmodel_data}    Enter Comments/Description    txtJustify    ${riskmodel_data}[Justification]
    IF    'Description' in ${riskmodel_data}    Enter Comments/Description    txtDescription    ${riskmodel_data}[Description]
    IF    'RiskModel' in ${riskmodel_data}    Select Value From Dropdown    ddlRiskModel    ${riskmodel_data}[RiskModel]
    Verify Additional Factor Level Dropdown Field Is Displayed
    Enter Details In Select Risk Factors Section    ${riskmodel_data}
    Enter Details In Derivative Factor Section    ${riskmodel_data}
    IF    'RFSectionDetails' in ${riskmodel_data}
        @{rf_section_details}    Split String    ${riskmodel_data}[RFSectionDetails]    ||
        FOR    ${key}    IN    @{rf_section_details}
            @{section_list}    Split String    ${key}    -
            ${section_name}    Set Variable    ${section_list}[0]
            ${no_of_rows}    Set Variable    ${section_list}[1]
            ${section_details}    Set Variable    ${section_list}[2]
            Select The Section And Enter Number Of Rows    ${section_name}    ${no_of_rows}
            Enter Values In Added Risk Factor Level Grid    ${section_name}    ${section_details}
            Verify Entered Details Under Added Risk Factor Level Grid    ${section_name}    ${no_of_rows}    ${section_details}
        END
    END
    IF    'DFSectionDetails' in ${riskmodel_data}
        @{der_section_details}    Split String    ${riskmodel_data}[DFSectionDetails]    ||
        FOR    ${key}    IN    @{der_section_details}
            @{section_list}    Split String    ${key}    -
            ${section_name}    Set Variable    ${section_list}[0]
            ${no_of_rows}    Set Variable    ${section_list}[1]
            ${section_details}    Set Variable    ${section_list}[2]
            Select The Section And Enter Number Of Rows    ${section_name}    ${no_of_rows}
            Enter Details In Added Derivative Factor Grid    ${section_name}    ${section_details}
        END
    END

Enter Details In Select Risk Factors Section
    [Arguments]    ${riskmodel_data}
    [Documentation]    This keyword is used to enter details in "Select Risk Factors" Section
    IF  'RiskFactorLevel' in ${riskmodel_data}    Select Value From Dropdown    ddlNoofRiskType    ${riskmodel_data}[RiskFactorLevel]
    IF    'RiskFactorLevelNames' in ${riskmodel_data}
        ${index}    Set Variable    1
        @{factor_level_names}    Split String    ${riskmodel_data}[RiskFactorLevelNames]    ,
        ${count}    Get Length    ${factor_level_names}
        @{factor_level_descriptions}    Split String    ${riskmodel_data}[RiskFactorLevelDescriptions]    ,
        FOR    ${key}    IN RANGE    0    ${count}
            IF    '${factor_level_names}[${key}]'!='None'
                Wait Until Element Is Visible    (${textbox.risk.create.riskmodel.select_risk_factors.factorlevel_name})[${index}]    ${MEDIUM_WAIT}    Factor Level Name is not visible after waiting for ${MEDIUM_WAIT} seconds
                Input Text    (${textbox.risk.create.riskmodel.select_risk_factors.factorlevel_name})[${index}]    ${factor_level_names}[${key}]
            END
            Wait Until Time    1
            IF    '${factor_level_descriptions}[${key}]'!='None'
                Wait Until Element Is Visible    (${textbox.risk.create.riskmodel.select_risk_factors.factorlevel_description})[${index}]    ${MEDIUM_WAIT}    Factor Level Description is not visible after waiting for ${MEDIUM_WAIT} seconds
                Input Text    (${textbox.risk.create.riskmodel.select_risk_factors.factorlevel_description})[${index}]    ${factor_level_descriptions}[${key}]
            END
            ${index}    Evaluate    ${index}+1
        END
    END
    Click Element    ${button.risk.create.riskmodel.select_risk_factors.save_risk_factor}

Enter Details In Derivative Factor Section
    [Arguments]    ${riskmodel_data}
    [Documentation]    This keyword is used to enter data for fields under Derivative Factor Section
    Wait Until Element Is Visible    ${link.risk.create.riskmodel.derivative_factor.add}    ${MEDIUM_WAIT}    Add Link is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    IF    'DerivativeFactors' in ${riskmodel_data}
        @{derivative_factors}    Split String    ${riskmodel_data}[DerivativeFactors]    |
        FOR    ${key}    IN    @{derivative_factors}
            @{list}    Split String    ${key}    =
            ${der_factor_name}    Set Variable    ${list}[0]
            ${factor_operators}    Set Variable    ${list}[1]
            @{factor_oper_list}    Split String    ${factor_operators}    ,
            Wait Until Element Is Visible    ${textbox.risk.create.riskmodel.derivative_factor.factor_name}    ${MEDIUM_WAIT}    Factor Name is not visible after waiting for ${MEDIUM_WAIT} seconds
            Input Text    ${textbox.risk.create.riskmodel.derivative_factor.factor_name}    ${der_factor_name}
            Click Element    ${link.risk.create.riskmodel.derivative_factor.add}
            Wait Until Time    1
            ${index}    Set Variable    1
            FOR    ${key1}    IN    @{factor_oper_list}
                @{list}    Split String    ${key1}    $
                ${factor_name}    Set Variable    ${list}[0]
                ${add_link}    Set Variable    ${list}[1]
                ${operator}    Set Variable    ${list}[2]
                ${dropdown.risk.create.riskmodel.derivative_factor.newfactor}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.derivative_factor.factor}    ${der_factor_name}
                Wait Until Element Is Visible    (${dropdown.risk.create.riskmodel.derivative_factor.newfactor})[${index}]    ${MEDIUM_WAIT}    Factor dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
                Select From List By Label    (${dropdown.risk.create.riskmodel.derivative_factor.newfactor})[${index}]    ${factor_name}
                Wait Until Time    1
                IF    '${add_link}'=='Add'
                    ${link.risk.create.riskmodel.derivative_factor.factor_name.newadd}    Update Dynamic Value    ${link.risk.create.riskmodel.derivative_factor.factor_name.add}    ${der_factor_name}
                    Wait Until Element Is Visible    (${link.risk.create.riskmodel.derivative_factor.factor_name.newadd})[${index}]    ${MEDIUM_WAIT}    Add link is not visible after waiting for ${MEDIUM_WAIT} seconds
                    Click Element    (${link.risk.create.riskmodel.derivative_factor.factor_name.newadd})[${index}]
                    Wait Until Time    2
                    ${dropdown.risk.create.riskmodel.derivative_factor.newoperator}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.derivative_factor.operator}    ${der_factor_name}
                    Wait Until Element Is Visible    (${dropdown.risk.create.riskmodel.derivative_factor.newoperator})[${index}]    ${MEDIUM_WAIT}    Operator dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
                    Select From List By Label    (${dropdown.risk.create.riskmodel.derivative_factor.newoperator})[${index}]    ${operator}
                    Wait Until Time    1
                END
                ${index}    Evaluate    ${index}+1
            END
        END
    END
    Click Button In VLMS    Save Risk Factor

Enter Values In Added Risk Factor Level Grid
    [Arguments]    ${section_name}    ${section_details}
    [Documentation]    This keyword is used to enter values for fields under Added Risk Factor level Grid
    @{section_values}    Split String    ${section_details}    |
    ${rows}    Get Length    ${section_values}
    FOR    ${row}    IN RANGE    1    ${rows}+1
        ${index}    Evaluate    ${row}-1
        ${row_values}    Split String    ${section_values}[${index}]    ,
        Enter Value For The Selected Section TextField    ${section_name}    txtFieldTitle    ${row}    ${row_values}[0]
        Enter Value For The Selected Section TextField    ${section_name}    txtFrom    ${row}    ${row_values}[1]
        Enter Value For The Selected Section TextField    ${section_name}    txtTo    ${row}    ${row_values}[2]
        Enter Value For The Selected Section TextField    ${section_name}    txtFieldDesc    ${row}    ${row_values}[3]
    END

Verify Entered Details Under Added Risk Factor Level Grid
    [Arguments]    ${section_name}    ${no_of_rows}    ${section_details}
    [Documentation]    This keyword is used to Verify Entered Details Under Added Risk Factor Level Grid
    ${dropdown.risk.create.riskmodel.newnoof_rows}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.noof_rows}    ${section_name}
    ${selected_rows}    Get Selected List Label    ${dropdown.risk.create.riskmodel.newnoof_rows}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Be Equal    ${selected_rows}    ${no_of_rows}
    @{section_values}    Split String    ${section_details}    |
    ${rows}    Get Length    ${section_values}
    FOR    ${row}    IN RANGE    1    ${rows}+1
        ${index}    Evaluate    ${row}-1
        ${row_values}    Split String    ${section_values}[${index}]    ,
        ${value1}    Get Values From A Section In Create Risk Model Page    ${section_name}    txtFieldTitle    ${row}
        ${value2}    Get Values From A Section In Create Risk Model Page    ${section_name}    txtFrom    ${row}
        ${value3}    Get Values From A Section In Create Risk Model Page    ${section_name}    txtTo    ${row}
        ${value4}    Get Values From A Section In Create Risk Model Page    ${section_name}    txtFieldDesc    ${row}
        @{list1}    Create List    ${value1}    ${value2}    ${value3}    ${value4}
        Remove Values From List    ${list1}    ${EMPTY}
        Remove Values From List    ${row_values}    None
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        Run Keyword And Continue On Failure    Lists Should Be Equal    ${list1}    ${row_values}
    END

Select The Section And Enter Number Of Rows
    [Arguments]    ${section_name}    ${no_of_rows}
    [Documentation]    This keyword is used to Select the Section and Enter Number of Rows in Create Risk Model Page
    ${label.risk.riskmodel.newsection}    Update Dynamic Value    ${label.risk.riskmodel.section}    ${section_name}
    Wait Until Element Is Visible    ${label.risk.riskmodel.newsection}    ${MEDIUM_WAIT}    ${section_name} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Click Element    ${label.risk.riskmodel.newsection}
    Verify Number Of Rows Dropdown Field Is Displayed    ${section_name}
    ${dropdown.risk.create.riskmodel.newnoof_rows}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.noof_rows}    ${section_name}
    IF    '${no_of_rows}'!='None'    Select From List By Label    ${dropdown.risk.create.riskmodel.newnoof_rows}    ${no_of_rows}
    Wait Until Time    3

Enter Details In Added Derivative Factor Grid
    [Arguments]    ${section_name}    ${section_details}
    [Documentation]    This keyword is used to enter values for fields under Added Derivative Factor Grid
    @{severity_values}    Split String    ${section_details}    |
    ${rows}    Get Length    ${severity_values}
    Wait Until Time    2
    FOR    ${row}    IN RANGE    1    ${rows}+1
        ${index}    Evaluate    ${row}-1
        ${row_values}    Split String    ${severity_values}[${index}]    ,
        Enter Value For The Selected Section TextField    ${section_name}    txtFieldTitle    ${row}    ${row_values}[0]
        Enter Value For The Selected Section TextField    ${section_name}    txtFrom    ${row}    ${row_values}[1]
        Enter Value For The Selected Section TextField    ${section_name}    txtTo    ${row}    ${row_values}[2]
        ${dropdown.risk.create.riskmodel.added_der_factor_section.newcolor_code}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.added_der_factor_section.color_code}    ${section_name}
        IF    '${row_values}[3]'!='None'    Select From List By Label    (${dropdown.risk.create.riskmodel.added_der_factor_section.newcolor_code})[${row}]    ${row_values}[3]
        Enter Value For The Selected Section TextField    ${section_name}    txtFieldDesc    ${row}    ${row_values}[4]
    END

Enter And Verify Details In Business Rule For Requirement Level Section
    # robocop: disable=too-long-keyword
    [Arguments]    ${riskmodel_data}
    [Documentation]    This keyword is used to enter the values for the fields under business rule for requirement level section
    Wait Until Element Is Visible    ${label.risk.riskmodel.business_rule_section}    ${MEDIUM_WAIT}    Business Rule For Requirement Level is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    IF    'BusinessRuleDetails' in ${riskmodel_data}
        @{business_rule_details}    Split String    ${riskmodel_data}[BusinessRuleDetails]    ||
        FOR    ${key}    IN    @{business_rule_details}
            @{list}    Split String    ${key}    =
            ${business_rule_index}     Set Variable    ${list}[0]
            ${process_condition}    Set Variable    ${list}[1]
            ${business_details}    Set Variable    ${list}[2]
            ${add_rule}    Set Variable    ${list}[3]
            @{details}    Split String    ${business_details}    |
            Wait Until Time    1
            ${index}    Set Variable    1
            FOR    ${key1}    IN    @{details}
                @{row_list}    Split String    ${key1}    ,
                ${risk_factor}    Set Variable    ${row_list}[0]
                ${condition}    Set Variable    ${row_list}[1]
                ${score_from}    Set Variable    ${row_list}[2]
                ${score_to}    Set Variable    ${row_list}[3]
                ${add_link}    Set Variable    ${row_list}[4]
                ${operator}    Set Variable    ${row_list}[5]
                IF    '${risk_factor}'!='None'
                    ${dropdown.risk.create.riskmodel.business_rule.newriskfactor}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.business_rule.riskfactor}    ${business_rule_index}
                    Wait Until Element Is Visible    (${dropdown.risk.create.riskmodel.business_rule.newriskfactor})[${index}]    ${MEDIUM_WAIT}    Risk Factor dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
                    Wait Until Time    1
                    Select From List By Label    (${dropdown.risk.create.riskmodel.business_rule.newriskfactor})[${index}]    ${risk_factor}
                END
                IF    '${condition}'!='None'
                    ${dropdown.risk.create.riskmodel.business_rule.newcondition}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.business_rule.condition}    ${business_rule_index}
                    Wait Until Time    1
                    Select From List By Label    (${dropdown.risk.create.riskmodel.business_rule.newcondition})[${index}]    ${condition}
                END
                Wait Until Time    1
                IF    '${score_from}'!='None'
                    ${textbox.risk.create.riskmodel.business_rule.newscore_from}    Update Dynamic Value    ${textbox.risk.create.riskmodel.business_rule.score_from}    ${business_rule_index}
                    Input Text    (${textbox.risk.create.riskmodel.business_rule.newscore_from})[${index}]    ${score_from}
                END
                IF    '${score_to}'!='None'
                    ${textbox.risk.create.riskmodel.business_rule.newscore_to}    Update Dynamic Value    ${textbox.risk.create.riskmodel.business_rule.score_to}    ${business_rule_index}
                    Input Text    (${textbox.risk.create.riskmodel.business_rule.newscore_to})[${index}]    ${score_to}
                END
                IF    '${add_link}'=='Add'
                    ${link.risk.create.riskmodel.business_rule.operator.newadd}    Update Dynamic Value    ${link.risk.create.riskmodel.business_rule.operator.add}    ${business_rule_index}
                    Wait Until Element Is Visible    (${link.risk.create.riskmodel.business_rule.operator.newadd})[${index}]    ${MEDIUM_WAIT}    Add link is not visible after waiting for ${MEDIUM_WAIT} seconds
                    Click Element    (${link.risk.create.riskmodel.business_rule.operator.newadd})[${index}]
                    Wait Until Time    2
                    ${dropdown.risk.create.riskmodel.business_rule.newoperator}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.business_rule.operator}    ${business_rule_index}
                    Wait Until Element Is Visible    (${dropdown.risk.create.riskmodel.business_rule.newoperator})[${index}]    ${MEDIUM_WAIT}    Operator dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
                    Wait Until Time    1
                    Select From List By Label    (${dropdown.risk.create.riskmodel.business_rule.newoperator})[${index}]    ${operator}
                END
                @{row_values}    Create List    ${risk_factor}    ${condition}    ${score_from}    ${score_to}
                Verify Business Rule For Requirement Level Section Fields    ${business_rule_index}    ${index}    ${row_values}
                ${index}    Evaluate    ${index}+1
            END
            IF    '${process_condition}'!='None'
                ${dropdown.risk.create.riskmodel.business_rule.newprocess_condition}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.business_rule.process_condition}    ${business_rule_index}
                Wait Until Element Is Visible    ${dropdown.risk.create.riskmodel.business_rule.newprocess_condition}    ${MEDIUM_WAIT}    Process condition dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
                Wait Until Time    1
                Select From List By Label    ${dropdown.risk.create.riskmodel.business_rule.newprocess_condition}   ${process_condition}
            END
            IF    '${add_rule}'=='AddRule'
                ${link.risk.create.riskmodel.business_rule.process_cond.newadd}    Update Dynamic Value    ${link.risk.create.riskmodel.business_rule.process_cond.add}    ${business_rule_index}
                Wait Until Element Is Visible    ${link.risk.create.riskmodel.business_rule.process_cond.newadd}    ${MEDIUM_WAIT}    Add link is not visible after waiting for ${MEDIUM_WAIT} seconds
                Click Element    ${link.risk.create.riskmodel.business_rule.process_cond.newadd}
                Wait Until Time    2
            END
        END
    END

Verify Business Rule For Requirement Level Section Fields
    [Arguments]    ${business_rule_index}    ${index}    ${row_values}
    [Documentation]    This keyword is used to Verify fields under business rule for requirement section
    ${dropdown.risk.create.riskmodel.business_rule.newriskfactor}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.business_rule.riskfactor}    ${business_rule_index}
    ${value1}    Get Selected List Label    (${dropdown.risk.create.riskmodel.business_rule.newriskfactor})[${index}]
    ${dropdown.risk.create.riskmodel.business_rule.newcondition}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.business_rule.condition}    ${business_rule_index}
    ${value2}    Get Selected List Label    (${dropdown.risk.create.riskmodel.business_rule.newcondition})[${index}]
    ${textbox.risk.create.riskmodel.business_rule.newscore_from}    Update Dynamic Value    ${textbox.risk.create.riskmodel.business_rule.score_from}    ${business_rule_index}
    ${value3}    Get Value    (${textbox.risk.create.riskmodel.business_rule.newscore_from})[${index}]
    ${textbox.risk.create.riskmodel.business_rule.newscore_to}    Update Dynamic Value    ${textbox.risk.create.riskmodel.business_rule.score_to}    ${business_rule_index}
    ${value4}    Get Value    (${textbox.risk.create.riskmodel.business_rule.newscore_to})[${index}]
    @{list1}    Create List    ${value1}    ${value2}    ${value3}    ${value4}
    Remove Values From List    ${list1}    ${EMPTY}
    Remove Values From List    ${row_values}    None
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${list1}    ${row_values}

Enter Values In Added Additional Factor Level Grid
    [Arguments]    ${section_name}    ${section_details}
    [Documentation]    This keyword is used to Enter Values In Added Additional Factor Level Grid
    @{section_values}    Split String    ${section_details}    |
    ${rows}    Get Length    ${section_values}
    FOR    ${row}    IN RANGE    1    ${rows}+1
        ${index}    Evaluate    ${row}-1
        ${row_values}    Split String    ${section_values}[${index}]    ,
        Enter Value For The Selected Section TextField    ${section_name}    txtFieldTitle    ${row}    ${row_values}[0]
        Enter Value For The Selected Section TextField    ${section_name}    txtFieldDesc    ${row}    ${row_values}[1]
    END

Verify Entered Details Under Added Additional Factor Level Grid
    [Arguments]    ${section_name}    ${no_of_rows}    ${section_details}
    [Documentation]    This keyword is used to Verify Entered Details Under Added Additional Factor Level Grid
    ${dropdown.risk.create.riskmodel.newnoof_rows}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.noof_rows}    ${section_name}
    ${selected_rows}    Get Selected List Label    ${dropdown.risk.create.riskmodel.newnoof_rows}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Be Equal    ${selected_rows}    ${no_of_rows}
    @{section_values}    Split String    ${section_details}    |
    ${rows}    Get Length    ${section_values}
    FOR    ${row}    IN RANGE    1    ${rows}+1
        ${index}    Evaluate    ${row}-1
        ${row_values}    Split String    ${section_values}[${index}]    ,
        ${value1}    Get Values From A Section In Create Risk Model Page    ${section_name}    txtFieldTitle    ${row}
        ${value2}    Get Values From A Section In Create Risk Model Page    ${section_name}    txtFieldDesc    ${row}
        @{list1}    Create List    ${value1}    ${value2}
        Remove Values From List    ${list1}    ${EMPTY}
        Remove Values From List    ${row_values}    None
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        Run Keyword And Continue On Failure    Lists Should Be Equal    ${list1}    ${row_values}
    END

Create Risk Process
    [Documentation]    Fill the risk Process
    [arguments]    ${tg_data}    ${USER}    ${USER_PASSWORD}
    ${count}    Get Length    ${tg_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${create_data}    Set Variable    ${tg_data}[${key}]
        Click Button In VLMS    Create
        IF    'ProcessName' in ${create_data}    Enter Text In Mandatory Fields    ProcessName    ${create_data}[ProcessName]
        # ${riskprocess.processlevel}    Update Dynamic Value    ${riskprocess.common}    Requirement/Functional Level
        # Click Element    ${riskprocess.processlevel}
        Wait Until Time    3
        ${list_of_processconditions}    Split String    ${create_data}[ProcessConditions]    ,
        ${count}    Get Length    ${list_of_processconditions}
        FOR    ${key}    IN RANGE    0    ${count}
            Select Value From Dropdown    lstlskValTestSteps_chosen    ${list_of_processconditions}[${key}]
            # ${riskprocess.processcondition}    Update Dynamic Value    ${riskprocess.common}    ${list_of_processconditions}[${key}]
            # Click Element    ${riskprocess.processcondition}
        END
        ${list_of_contenttype}    Split String    ${create_data}[ContentType]    ,
        ${count}    Get Length    ${list_of_contenttype}
        FOR    ${key}    IN RANGE    0    ${count}
            Select Value From Dropdown    lstlsValTestCaseSteps_chosen    ${list_of_contenttype}[${key}]
            # ${riskprocess.contenttype}    Update Dynamic Value    ${riskprocess.common}    ${list_of_contenttype}[${key}]
            # Click Element    ${riskprocess.contenttype}
        END
        Wait Until Time   5
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        ${Expected_Result}    Set Variable    Risk Process has been created
        Get Value From Toast Message    ${Expected_Result}
    END

Create Custom Risk Model_Prerequisite
    # robocop: disable=too-long-keyword
    [Arguments]    ${table_name_list}    ${username}    ${password}
    [Documentation]    This keyword is used to create custom risk model
    ${count}    Get Length    ${table_name_list}
    FOR    ${key}    IN RANGE    0    ${count}
        ${riskmodel_data}    Set Variable     ${table_name_list}[${key}]
        Click Button In VLMS    Create
        IF    'RiskModelName' in ${riskmodel_data}    Enter Text In Mandatory Fields    RiskType    ${riskmodel_data}[RiskModelName]
        IF    'Justification' in ${riskmodel_data}    Enter Comments/Description    txtJustify    ${riskmodel_data}[Justification]
        IF    'Description' in ${riskmodel_data}    Enter Comments/Description    txtDescription    ${riskmodel_data}[Description]
        IF    'RiskModel' in ${riskmodel_data}    Select Value For Radio Button    TaskType    ${riskmodel_data}[RiskModel]
        IF    '${riskmodel_data}[RiskModel]'=='Custom'    Enter Custom Risk Model Details_Prerequisite    ${riskmodel_data}
        IF    '${riskmodel_data}[RiskModel]'=='FMEA'    Enter FMEA Risk Model Details_Prerequisite    ${riskmodel_data}
        ${button.common.newname}    Update Dynamic Value    ${button.common.name}    btnSubmit
        Wait Until Element Is Visible    ${button.common.newname}    ${MEDIUM_WAIT}
        Click Element    ${button.common.newname}
        Handle Electronic Sign    ${username}    ${password}    Submit    Create
        ${Expected_Result}    Set Variable    ${riskmodel_data}[RiskModelName] Risk Model has been created
        Get Value From Toast Message    ${Expected_Result}
    END

Enter FMEA Risk Model Details_Prerequisite
    # robocop: disable=too-long-keyword
    [Arguments]    ${riskmodel_data}
    [Documentation]    This keyword is used to create custom risk model
    Wait Until Time    3
    ${factorlevel_names}    Split String    ${riskmodel_data}[FactorLevelNames]    ,
    ${factor_count}    Get Length    ${factorlevel_names}
    ${row_no}    Set Variable    2
    FOR    ${counter}    IN RANGE    0    ${factor_count}
        Select The FMEA Section    ${factorlevel_names}[${counter}]
        Wait Until Time    3
        Select Value From Dropdown    select2-gvMain_ctl0${row_no}_ddlRows-container    ${riskmodel_data}[No.ofRows]
        IF    '${factorlevel_names}[${counter}]'=='Severity'    Enter Values in Section For FMEA_Prerequisite    ${riskmodel_data}[SeverityValues]    ${row_no}
        IF    '${factorlevel_names}[${counter}]'=='Probability'    Enter Values in Section For FMEA_Prerequisite    ${riskmodel_data}[ProbabilityValues]    ${row_no}
        IF    '${factorlevel_names}[${counter}]'=='Detectability'    Enter Values in Section For FMEA_Prerequisite    ${riskmodel_data}[DetectabilityValues]    ${row_no}
        ${row_no}    Evaluate    ${row_no}+1
    END
    Select The FMEA Section    Risk Class
    Wait Until Time    3
    Select Value From Dropdown    select2-gvMain_ctl05_ddlRows-container    ${riskmodel_data}[No.ofRows]
    Wait Until Time    3
    Enter Values in Risk Class Section For FMEA_Prerequisite    ${riskmodel_data}[RiskClassValues]
    Select The FMEA Section    Risk Priority Number
    Wait Until Time    3
    Select Value From Dropdown    select2-gvMain_ctl06_ddlRows-container    ${riskmodel_data}[No.ofRows]
    Wait Until Time    3
    Enter Values in Risk Priority Number Section For FMEA_Prerequisite    ${riskmodel_data}[RiskPriorityNumberValues]
    IF    'ProcessModel' in ${riskmodel_data}    Select Value From Dropdown    select2-ddlProcessbased-container    ${riskmodel_data}[ProcessModel]

Select The FMEA Section
    [Arguments]    ${section_name}
    [Documentation]    Navigate to the section
    ${label.newsection}    Update Dynamic Value    ${label.section.FMEA}    ${section_name}
    Wait Until Element Is Visible    ${label.newsection}    ${MEDIUM_WAIT}    ${section_name} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.newsection}

Enter Custom Risk Model Details_Prerequisite
    # robocop: disable=too-long-keyword
    [Arguments]    ${riskmodel_data}
    [Documentation]    This keyword is used to create custom risk model
    #Select Value From Dropdown    ddlNoofRiskType    ${riskmodel_data}[RiskFactorLevel]
    IF    'FactorLevelName' in ${riskmodel_data}    Enter Comments/Description    gvCstmFctrLvl_ctl02_txtName    ${riskmodel_data}[FactorLevelName]
    IF    'FactorLevelDescription' in ${riskmodel_data}    Enter Comments/Description     gvCstmFctrLvl_ctl02_txtDescription    ${riskmodel_data}[FactorLevelDescription]
    Click Button In VLMS    Save Risk Factor
    Select The Section    ${riskmodel_data}[FactorLevelName]
    IF    'Rows' in ${riskmodel_data}    Select Value From Dropdown    select2-gvMain_ctl02_ddlRows-container    ${riskmodel_data}[Rows]
    Enter Values For Severity Section_Prerequisite    ${riskmodel_data}
    Wait Until Time    3
    Enter Details In Business Rule For Requirement Level Section_Prerequisite    ${riskmodel_data}
    IF    'AdditionalFactorLevel' in ${riskmodel_data}    Select Value From Dropdown    select2-ddlNoofCustomfactor-container    ${riskmodel_data}[AdditionalFactorLevel]
    Enter Details In Select Additional Factor Section_Prerequisite    ${riskmodel_data}
    Click Button In VLMS    Save Additional Factor
    Wait Until Time    2
    @{factorlevel_names}    Split String    ${riskmodel_data}[FactorLevelNames]    ,
    Select The Section    ${factorlevel_names}[0]
    Verify Number Of Rows Dropdown Field Is Displayed    ${factorlevel_names}[0]
    Select The Section    ${factorlevel_names}[1]
    Verify Number Of Rows Dropdown Field Is Displayed    ${factorlevel_names}[1]
    Wait Until Time    3
    Select Rows And Enter Level Name_Prerequisite   ${riskmodel_data}[DetectabilityValues]    select2-gvMainCustom_ctl02_ddlRowsCustom-container    gvMainCustom_ctl02_gvFieldSaveCustom_ctl02_txtFieldTitle    gvCustomFactorLevel_ctl02_txtDescription
    Wait Until Time    2
    Select Rows And Enter Level Name_Prerequisite    ${riskmodel_data}[ProbabilityValues]    select2-gvMainCustom_ctl03_ddlRowsCustom-container    gvMainCustom_ctl03_gvFieldSaveCustom_ctl02_txtFieldTitle    gvCustomFactorLevel_ctl03_txtDescription

Enter Values For Severity Section_Prerequisite
    [Arguments]    ${risk_data}
    [Documentation]    This keyword is used to enter values for fields under severity section
    @{severity_values}    Split String    ${risk_data}[SeverityValues]    |
    ${rows}    Get Length    ${severity_values}
    FOR    ${row}    IN RANGE    0    ${rows}
        ${row_values}    Split String    ${severity_values}[${row}]    ,
        ${line}    Set Variable    ${row}+1
        Enter Value For The Selected Section TextField    gvMain    txtFieldTitle    ${line}    ${row_values}[0]
        Enter Value For The Selected Section TextField    gvMain    txtFrom    ${line}    ${row_values}[1]
        Enter Value For The Selected Section TextField    gvMain    txtTo    ${line}    ${row_values}[2]
        Enter Value For The Selected Section TextField    gvMain    txtFieldDesc    ${line}    ${row_values}[3]
    END
    IF    'ProcessModel' in ${risk_data}    Select Value From Dropdown    select2-ddlProcessbased-container    ${risk_data}[ProcessModel]

Enter Values in Section For FMEA_Prerequisite
    [Arguments]    ${risk_data}    ${field_No}
    [Documentation]    This keyword is used to enter values for fields under severity section
    ${severity_values}    Split String    ${risk_data}    |
    ${rows}    Get Length    ${severity_values}
    FOR    ${row}    IN RANGE    0    ${rows}
        ${row_values}    Split String    ${severity_values}[${row}]    ,
        ${line}    Set Variable    ${row}+1
        Enter Value For The Selected Section TextField    gvMain_ctl0${field_No}    txtFieldTitle    ${line}    ${row_values}[0]
        Enter Value For The Selected Section TextField    gvMain_ctl0${field_No}    txtFrom    ${line}    ${row_values}[1]
        Enter Value For The Selected Section TextField    gvMain_ctl0${field_No}    txtTo    ${line}    ${row_values}[2]
        Enter Value For The Selected Section TextField    gvMain_ctl0${field_No}    txtFieldDesc    ${line}    ${row_values}[3]
        Wait Until Time    3
    END

Enter Values in Risk Class Section For FMEA_Prerequisite
    [Arguments]    ${risk_data}
    [Documentation]    This keyword is used to enter values for fields under severity section
    ${risk_class}    Split String    ${risk_data}    |
    ${rows}    Get Length    ${risk_class}
    ${field}    Set Variable    2
    FOR    ${row}    IN RANGE    0    ${rows}
        ${row_values}    Split String    ${risk_class}[${row}]    ,
        ${line}    evaluate    ${row}+1
        ${line_no}    Set Variable    ${line}
        Enter Value For The Selected Section TextField    gvMain_ctl05    txtFieldTitle    ${line_no}    ${row_values}[0]
        Enter Value For The Selected Section TextField    gvMain_ctl05    txtFrom    ${line_no}    ${row_values}[1]
        Enter Value For The Selected Section TextField    gvMain_ctl05    txtTo    ${line_no}    ${row_values}[2]
        Select From List By Value    gvMain_ctl05_gvFieldSave_ctl0${field}_ddlcolor    ${row_values}[3]
        Enter Value For The Selected Section TextField    gvMain_ctl05    txtFieldDesc    ${line_no}    ${row_values}[4]
        ${field}    evaluate    ${field}+1
        Wait Until Time    3
    END

Enter Values in Risk Priority Number Section For FMEA_Prerequisite
    [Arguments]    ${risk_data}
    [Documentation]    This keyword is used to enter values for fields under severity section
    ${risk_class}    Split String    ${risk_data}    |
    ${rows}    Get Length    ${risk_class}
    ${field}    Set Variable    2
    FOR    ${row}    IN RANGE    0    ${rows}
        ${row_values}    Split String    ${risk_class}[${row}]    ,
        ${line}    evaluate    ${row}+1
        ${line_no}    Set Variable    ${line}
        Enter Value For The Selected Section TextField    gvMain_ctl06    txtFieldTitle    ${line_no}    ${row_values}[0]
        Enter Value For The Selected Section TextField    gvMain_ctl06    txtFrom    ${line_no}    ${row_values}[1]
        Enter Value For The Selected Section TextField    gvMain_ctl06    txtTo    ${line_no}    ${row_values}[2]
        Select From List By Value    gvMain_ctl06_gvFieldSave_ctl0${field}_ddlcolor    ${row_values}[3]
        Enter Value For The Selected Section TextField    gvMain_ctl06    txtFieldDesc    ${line_no}    ${row_values}[4]
        ${field}    evaluate    ${field}+1
        Wait Until Time    3
    END

Enter Details In Business Rule For Requirement Level Section_Prerequisite
    [Arguments]    ${risk_data}
    [Documentation]    This keyword is used to enter the values for the fields under business rule for requirement level section
    IF    'RiskFactor' in ${risk_data}    Select Value From Dropdown    select2-gvBusinessruleReq_ctl02_grvAddReq_ctl02_ddlRiskFactor-container    ${risk_data}[RiskFactor]
    IF    'ValidationScoreFrom' in ${risk_data}    Enter Comments/Description    gvBusinessruleReq_ctl02_grvAddReq_ctl02_txtFrom    ${risk_data}[ValidationScoreFrom]
    IF    'ValidationScoreTo' in ${risk_data}    Enter Comments/Description    gvBusinessruleReq_ctl02_grvAddReq_ctl02_txtTo   ${risk_data}[ValidationScoreTo]
    IF    'ProcessCondition' in ${risk_data}    Select Dropdown Value With Partial Text    select2-gvBusinessruleReq_ctl02_ddlProcessRequirement-container    ${risk_data}[ProcessCondition]

Enter Details In Select Additional Factor Section_Prerequisite
    [Arguments]    ${risk_data}
    [Documentation]    This keyword is used to enter data for fields under select additional factor section
    @{factorlevel_names}    Split String    ${risk_data}[FactorLevelNames]    ,
    @{factorlevel_descriptions}    Split String    ${risk_data}[FactorLevelDescriptions]    ,
    ${count}    Get Length    ${factorlevel_names}
    FOR    ${row}    IN RANGE    1    ${count}+1
        ${index}    Evaluate    ${row}-1
        Enter Value For The Selected Section TextField    gvCustomFactor    txtName    ${row}    ${factorlevel_names}[${index}]
        Enter Value For The Selected Section TextField    gvCustomFactor    txtDescription    ${row}    ${factorlevel_descriptions}[${index}]
    END

Select Rows And Enter Level Name_Prerequisite
    [Arguments]    ${sectionvalues}    ${dropdownid}    ${levelanameid}    ${descriptionid}
    [Documentation]    This keyword is used to enter number of rows and level name for the selected section
    ${sectionvalues}    Split String    ${sectionvalues}    ,
    Select Value From Dropdown    ${dropdownid}    ${sectionvalues}[0]
    Enter Comments/Description    ${levelanameid}    ${sectionvalues}[1]
    Enter Comments/Description    ${descriptionid}    ${sectionvalues}[2]

Create Risk Framework_Prerequisite
    [Arguments]    ${riskmodel_data}    ${username}    ${password}
    ${count}    Get Length    ${riskmodel_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${risk_framework_data}    Set Variable     ${riskmodel_data}[${key}]
        Click Button In VLMS    Create
        Wait Until Time    ${MEDIUM_WAIT}
        IF    'RiskFrameworkName' in ${risk_framework_data}    Enter Text In Mandatory Fields    RiskFrameWorkName    ${risk_framework_data}[RiskFrameworkName]
        IF    'TemplateType' in ${risk_framework_data}
        ${checkbox.templatetype.risk.create.riskframework.new}    Update Dynamic Value    ${checkbox.templatetype.risk.create.riskframework}    ${risk_framework_data}[TemplateType]
        Select Checkbox    ${checkbox.templatetype.risk.create.riskframework.new}
        END
        ${Risk_framework_ID}    Get Text    ${label.riskframeworkid.create.risk.framework}
        ${Risk_ID}   Remove String    ${Risk_framework_ID}    <
        ${Risk_ID1}   Remove String    ${Risk_ID}    >
        ${RiskID2}    Remove String    ${Risk_ID1}    [ ]
        Set Suite Variable    ${RiskID2}
        Click Element    ${button.nextdefine.risk.create.risk framework}
        Wait Until Element Is Visible    ${textbox.columnheader.create.risk.framework}    ${MEDIUM_WAIT}
        Input Text    ${textbox.columnheader.create.risk.framework}    ${risk_framework_data}[ColumnTitle]
        Wait Until Time    3
        Select Dropdown Value With Partial Text    gvSelectedColumn_ctl05_ddlRiskModel_chosen    ${risk_framework_data}[RiskModel]
        Click Button In VLMS    Generate
        Select Value For Radio Button    Approval    rbtnApprovalNo
        Select Submit/Reset Button    FWsubmit
        Handle Electronic Sign    ${username}    ${password}    Submit
        ${Expected_Result}    Set Variable    RiskFrameWork - ${risk_framework_data}[RiskFrameworkName] for ${RiskID2} has been created
        Get Value From Toast Message    ${Expected_Result}
    END