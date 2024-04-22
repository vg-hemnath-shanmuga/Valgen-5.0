*** Settings ***
Documentation     This entity assessment resource file has all the entity with assessment keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Navigate To Create Assessment Template Page
    [Documentation]    This keyword will navigate to Create Assessment Template Page
    Menu Navigation_5.0    Assessment    Assessment Setup    Assessment Template
    Wait Until Time    3
    Click Button In VLMS    Create

Enter Details In Create Assessment Template Page
    [Arguments]    ${assessment_data}
    [Documentation]    This Keyword is used to Enter Details In Create Assessment Template Page
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.assessment.create.template.page_heading}    ${MEDIUM_WAIT}    Create Assessment Template screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'Action' in ${assessment_data}    Select Value For Radio Button    rbtnNewAction    ${assessment_data}[Action]
    IF    '${assessment_data}[Action]'=='rbtnRevisionAction'
        IF    'AssessmentTemplate' in ${assessment_data}   Select Value From Dropdown    ddlRevisedAssessment    ${assessment_data}[AssessmentTemplate]
    END
    IF    'GxPRequired' in ${assessment_data}    Select Value For Radio Button    GxP    ${assessment_data}[GxPRequired]
    Wait Until Time    3
    IF    'BusinessRuleRequired' in ${assessment_data}    Select Value For Radio Button    GxPNo    ${assessment_data}[BusinessRuleRequired]
    IF    'AssessmentTemplateName' in ${assessment_data}
        Input Text    ${textbox.assessment.create.template.template_name}    ${assessment_data}[AssessmentTemplateName]
        ${ASSESSMENT_TEMPLATE_NAME}    Set Variable    ${assessment_data}[AssessmentTemplateName]
        Set Suite Variable    ${ASSESSMENT_TEMPLATE_NAME}
    END
    IF    'InheritAssessmentTemplate' in ${assessment_data}   Select Value From Dropdown    ddlInherit_chosen    ${assessment_data}[InheritAssessmentTemplate]
    IF    'GxPSection' in ${assessment_data}
        Select Value From Dropdown    ddlAddSections_chosen    ${assessment_data}[GxPSection]
        IF    'GxPAdd' in ${assessment_data}    Wait Until Element Is Clickable And Click    ${link.assessment.create.template.section_name.add}    10
        IF    'Description' in ${assessment_data}    Input Text    ${textbox.assessment.create.template.gxp_section.description}    ${assessment_data}[Description]
        IF    'GxPSelectAssessors' in ${assessment_data}   Select Value From Dropdown    grdSections_ctl02_lstAssinGroup_chosen    ${assessment_data}[GxPSelectAssessors]
        IF    'GxPDeselectAssessors' in ${assessment_data}   
            ${label.assessment.assessor.newgroupname}    Update Dynamic Value    ${label.assessment.assessor.groupname}    ${assessment_data}[GxPDeselectAssessors]
            Click Element    ${label.assessment.assessor.newgroupname}
        END
        IF    'GxPDecisionTree' in ${assessment_data}   Select Value From Dropdown    grdSections_ctl02_ddlDecisionTree_chosen    ${assessment_data}[GxPDecisionTree]
    END
    IF    'RiskSection' in ${assessment_data}
        Select Value From Dropdown    ddlAddSections    ${assessment_data}[RiskSection]
        IF    'RiskAdd' in ${assessment_data}    Wait Until Element Is Clickable And Click    ${link.assessment.create.template.section_name.add}    10
        IF    'RiskSelectAssessors' in ${assessment_data}   Select Value From Dropdown    grdSections_ctl02_lstAssinGroup_chosen    ${assessment_data}[RiskSelectAssessors]
        IF    'RiskDeselectAssessors' in ${assessment_data}   Swipe Values Between Groups    ${assessment_data}[RiskDeselectAssessors]    grdSections_ctl02_lstAssinGroup    grdSections_ctl02_lstAvailbleGroup
        IF    'RiskDecisionTree' in ${assessment_data}   Select Value From Dropdown    ddlDecisionTree    ${assessment_data}[RiskDecisionTree]
    END
    IF    'ValidationSection' in ${assessment_data}
        Select Value From Dropdown    ddlAddSections    ${assessment_data}[ValidationSection]
        IF    'ValidationAdd' in ${assessment_data}    Wait Until Element Is Clickable And Click    ${link.assessment.create.template.section_name.add}    10
        IF    'ValidationSelectAssessors' in ${assessment_data}   Swipe Values Between Groups    ${assessment_data}[ValidationSelectAssessors]    grdSections_ctl02_lstAvailbleGroup    grdSections_ctl02_lstAssinGroup
        IF    'ValidationDeselectAssessors' in ${assessment_data}   Swipe Values Between Groups    ${assessment_data}[ValidationDeselectAssessors]    grdSections_ctl02_lstAssinGroup    grdSections_ctl02_lstAvailbleGroup
        IF    'ValidationDecisionTree' in ${assessment_data}   Select Value From Dropdown    ddlDecisionTree    ${assessment_data}[ValidationDecisionTree]
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Enter Details In Define Business Rule For Section Sequence
    [Arguments]    ${assessment_data}
    [Documentation]    This Keyword is used to Enter details in "Define Business Rule For Section Sequence" grid in Create Assessment Template Screen
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.assessment.create.template.gxp_section}    ${MEDIUM_WAIT}    GxP Section is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.assessment.create.template.gxp_section}
    Wait Until Time    1
    Wait Until Element Is Visible    ${link.assessment.create.template.business_rule.gxp_impact.add}    ${MEDIUM_WAIT}    Add Link is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'GxPImpactAdd' in ${assessment_data}
        ${index}    Set Variable    1
        @{gxp_impact_sections}    Split String    ${assessment_data}[GxPImpactSectionNames]    ,
        ${count}    Get Length    ${gxp_impact_sections}
        @{gxp_impact_serial_parallel}    Split String    ${assessment_data}[GxPImpactSerial/Parallel]    ,
        FOR    ${key}    IN RANGE    0    ${count}
            Wait Until Time    2
            Click Element    ${link.assessment.create.template.business_rule.gxp_impact.add}
            Wait Until Time    1
            Wait Until Element Is Visible    (${dropdown.assessment.create.template.business_rule.gxp_impact.section_name})[${index}]    ${MEDIUM_WAIT}    Section name dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
            Select From List By Label    (${dropdown.assessment.create.template.business_rule.gxp_impact.section_name})[${index}]    ${gxp_impact_sections}[${key}]
            Wait Until Time    1
            Wait Until Element Is Visible    (${dropdown.assessment.create.template.business_rule.gxp_impact.serial_parallel})[${index}]    ${MEDIUM_WAIT}    Serial/Parallel dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
            Select From List By Label    (${dropdown.assessment.create.template.business_rule.gxp_impact.serial_parallel})[${index}]    ${gxp_impact_serial_parallel}[${key}]
            ${index}    Evaluate    ${index}+1
        END
    END
    IF    'GxPNoImpactAdd' in ${assessment_data}
        ${index}    Set Variable    1
        @{gxp_noimpact_sections}    Split String    ${assessment_data}[GxPNoImpactSectionNames]    ,
        ${count1}    Get Length    ${gxp_noimpact_sections}
        @{gxp_noimpact_serial_parallel}    Split String    ${assessment_data}[GxPNoImpactSerial/Parallel]    ,
        FOR    ${key}    IN RANGE    0    ${count1}
            Click Element    ${link.assessment.create.template.business_rule.gxp_no_impact.add}
            Wait Until Time    1
            Wait Until Element Is Visible    (${dropdown.assessment.create.template.business_rule.gxp_no_impact.section_name})[${index}]    ${MEDIUM_WAIT}    Section name dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
            Select From List By Label    (${dropdown.assessment.create.template.business_rule.gxp_no_impact.section_name})[${index}]    ${gxp_noimpact_sections}[${key}]
            Wait Until Time    1
            Wait Until Element Is Visible    (${dropdown.assessment.create.template.business_rule.gxp_no_impact.serial_parallel})[${index}]    ${MEDIUM_WAIT}    Serial/Parallel dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
            Select From List By Label    (${dropdown.assessment.create.template.business_rule.gxp_no_impact.serial_parallel})[${index}]    ${gxp_noimpact_serial_parallel}[${key}]
            ${index}    Evaluate    ${index}+1
        END
    END
    IF    'SaveBusinessRule' in ${assessment_data}    Click Element    ${button.assessment.create.template.business_rule.save}
    Wait Until Element Is Visible    ${label.assessment.create.template.businessrule_for_assessment}    ${MEDIUM_WAIT}    Define Business Rule for Assessment Section is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Enter Details In Define Business Rule For Assessment Section
    [Arguments]    ${assessment_data}
    [Documentation]    This Keyword is used to Enter details in "Define Business Rule for Assessment section" in Create Assessment Template Screen
    IF    'BusinessRuleFor' in ${assessment_data}    Select Value For Radio Button    BusinessRule    ${assessment_data}[BusinessRuleFor]
    IF    'BusinessRuleName' in ${assessment_data}    Enter Text In Mandatory Fields    BusinessRuleName    ${assessment_data}[BusinessRuleName]
    IF    'BusinessRuleAdd' in ${assessment_data}    Click Element    ${link.assessment.create.template.business_rule_assessment.add}
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.assessment.create.template.business_rule_assessment.save}    ${MEDIUM_WAIT}    Business Rule for Assessment Save button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Scroll Element Into View    ${button.assessment.create.template.business_rule_assessment.save}
    IF    'BusinessSection' in ${assessment_data}    Select Value From Dropdown    ctl02_grvBusinessRuleDetail_ctl02_ddlSystemSections    ${assessment_data}[BusinessSection]
    IF    'AssessmentResult' in ${assessment_data}    Select Value From Dropdown    ctl02_grvBusinessRuleDetail_ctl02_ddlResult    ${assessment_data}[AssessmentResult]
    IF    'RAassessmentResult' in ${assessment_data}
        Wait Until Time    3
        Wait Until Element Is Visible    ${dropdown.assessment.create.template.business_rule_assessment.select_ra_assessment}    ${MEDIUM_WAIT}
        Select From List By Label    ${dropdown.assessment.create.template.business_rule_assessment.select_ra_assessment}    ${assessment_data}[RAassessmentResult]
    END
    IF    'VAassessmentResult' in ${assessment_data}
        Wait Until Time    3
        Wait Until Element Is Visible    ${textbox.assessment.create.template.business_rule_assessment.va_assessment_result}    ${MEDIUM_WAIT}    VA Assessment Result is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${textbox.assessment.create.template.business_rule_assessment.va_assessment_result}
        Select From List By Label    ${dropdown.assessment.create.template.business_rule_assessment.select_va_assessment}    ${assessment_data}[VAassessmentResult]
    END
    IF    'FrameworkList1' in ${assessment_data}
        Select Framework    ${assessment_data}[FrameworkList1]
        Set Validation Rule For Framework    ${assessment_data}[CriteriaBasedOn1]    ${assessment_data}[EntityStatusValidation1]    ${assessment_data}[TaskDependency1]
        Validation Criteria    ${assessment_data}    ${assessment_data}[ValFrameworkList1]
        Wait Until Time    3
        Wait Until Element Is Visible    ${button.assessment.create.template.business_rule_assessment.save}    ${MEDIUM_WAIT}    Business Rule for Assessment Save button is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${button.assessment.create.template.business_rule_assessment.save}
    END
    IF    'FrameworkList2' in ${assessment_data}
        IF    'DefaultBusinessRule' in ${assessment_data}    Select Value For Radio Button    BusinessRule    ${assessment_data}[DefaultBusinessRule]
        Wait Until Time    2
        IF    'BusinessRuleAdd' in ${assessment_data}    Click Element    ${link.assessment.create.template.business_rule_assessment.add}
        Select Framework    ${assessment_data}[FrameworkList2]
        Set Validation Rule For Framework    ${assessment_data}[CriteriaBasedOn2]    ${assessment_data}[EntityStatusValidation2]    ${assessment_data}[TaskDependency2]
        Validation Criteria    ${assessment_data}    ${assessment_data}[ValFrameworkList2]
        Wait Until Time    3
        Wait Until Element Is Visible    ${button.assessment.create.template.business_rule_assessment.save}    ${MEDIUM_WAIT}    Business Rule for Assessment Save button is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${button.assessment.create.template.business_rule_assessment.save}
    END

Create Assessment Template
    [Arguments]    ${assessment_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Assessment Template
    Wait Until Element Is Visible    ${label.assessment.create.template.header_id}    ${MEDIUM_WAIT}    Create Assessment Template header is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${assessment_template_id}    Get Text    ${label.assessment.create.template.header_id}
    ${ASSESSMENT_TEMPLATE_NO}    Remove String    ${assessment_template_id}    <    >
    Enter Details In Define Business Rule For Section Sequence    ${assessment_data}
    Enter Details In Define Business Rule For Assessment Section    ${assessment_data}
    IF    'Comments' in ${assessment_data}    Enter Text In Mandatory Fields    Comments    ${assessment_data}[Comments]
    IF    'Button' in ${assessment_data}    Select Submit/Reset Button    ${assessment_data}[Button]
    IF    'eSign' in ${assessment_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    Set Suite Variable   ${ASSESSMENT_TEMPLATE_NO}
    ${EXPECTED_MESSAGE}    Set Variable    ${assessment_data}[AssessmentTemplateName] Assessment Template ${ASSESSMENT_TEMPLATE_NO} has been created
    RETURN    ${EXPECTED_MESSAGE}

Navigate To Perform Assessment Page
    [Arguments]    ${assessment_name}
    [Documentation]    This Keyword is used to navigate to Perform Assessment Page
    Navigate To Module Tab    Assessment   Perform    Assessment    Select Assessment to Perform
    Search And Select The Value From The Section    ${assessment_name}

Perform The Assessment
    [Arguments]    ${perform_assessment_data}
    [Documentation]    This Keyword is used to Perform the Assessment
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.assessment.perform_assessment.header}    ${MEDIUM_WAIT}    Perform Assessment header is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'Section1' in ${perform_assessment_data}
        Perform The Assessment For A Section    ${perform_assessment_data}    ${perform_assessment_data}[Section1]
        Verify Notification Popup    ${perform_assessment_data}[Message1]    btnSubmitSecOk
    END
    IF    'Section2' in ${perform_assessment_data}
        Perform The Assessment For A Section    ${perform_assessment_data}    ${perform_assessment_data}[Section2]
        Verify Notification Popup    ${perform_assessment_data}[Message2]    btnSubmitSecOk
    END
    IF    'Section3' in ${perform_assessment_data}    Perform The Assessment For A Section    ${perform_assessment_data}    ${perform_assessment_data}[Section3]
    Wait Until Element Is Visible    ${label.assessment.perform_assessment.header_id}    ${MEDIUM_WAIT}    Assessment id is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${perform_assessment_id}    Get Text    ${label.assessment.perform_assessment.header_id}
    ${PERFORM_ASSESSMENT_NO}    Remove String    ${perform_assessment_id}    <    >
    Set Suite Variable   ${PERFORM_ASSESSMENT_NO}
    ${EXPECTED_MESSAGE}    Set Variable    Assessment ${PERFORM_ASSESSMENT_NO} has been performed
    RETURN    ${EXPECTED_MESSAGE}

Perform The Assessment For A Section
    # robocop: disable=too-long-keyword
    [Arguments]    ${perform_assessment_data}    ${section_name}
    [Documentation]    This Keyword is used to Perform the Assessment For A Section
    ${label.assessment.perform_assessment.newsection_tab}    Update Dynamic Value    ${label.assessment.perform_assessment.section_tab}    ${section_name}
    Wait Until Element Is Visible    ${label.assessment.perform_assessment.newsection_tab}    ${MEDIUM_WAIT}    ${section_name} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    3
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${button.assessment.perform_assessment.accept}    ${MEDIUM_WAIT}    Accept is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Click Element    ${button.assessment.perform_assessment.accept}
    Wait Until Element Is Visible    ${link.assessment.perform_assessment.action}    ${MEDIUM_WAIT}    Action is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${section_name}'=='GxP Section'
        Scroll Element Into View    ${link.assessment.perform_assessment.action}
        Wait Until Time    1
        Wait Until Element Is Clickable And Click    ${link.assessment.perform_assessment.action}    10
        Select Answers For Questions In Decision Tree    ${perform_assessment_data}[GxPAnswers]    ${perform_assessment_data}[DecisionTreeButton]
        IF    'DecisionTreeMessage1' in ${perform_assessment_data}    Verify Notification Popup    ${perform_assessment_data}[DecisionTreeMessage1]    ${perform_assessment_data}[DecisionTreeButton1]
        Wait Until Time    2
        Wait Until Element Is Visible    ${label.additional_information}    ${MEDIUM_WAIT}    Additional Information section is not visible after waiting for ${MEDIUM_WAIT} seconds
        Scroll Element Into View    ${label.additional_information}
        IF    'GxPButton' in ${perform_assessment_data}    Select Submit/Reset Button    ${perform_assessment_data}[GxPButton]
    END
    IF    '${section_name}'=='RA Section'
        ${index}    Set Variable    1
        @{answer_list}    Split String    ${perform_assessment_data}[RAAnswers]    ,
        FOR    ${answers}    IN    @{answer_list}
            Scroll Element Into View    ${link.assessment.perform_assessment.action}
            Wait Until Time    1
            Wait Until Element Is Clickable And Click   (${link.assessment.perform_assessment.action})[${index}]    10
            Select Answers For Questions In Decision Tree    ${answers}    ${perform_assessment_data}[DecisionTreeButton]
            IF    'DecisionTreeMessage2' in ${perform_assessment_data}    Verify Notification Popup    ${perform_assessment_data}[DecisionTreeMessage2]    ${perform_assessment_data}[DecisionTreeButton2]
            ${index}    Evaluate    ${index}+1
        END
        Wait Until Time    2
        Wait Until Element Is Visible    ${label.additional_information}    ${MEDIUM_WAIT}    Additional Information section is not visible after waiting for ${MEDIUM_WAIT} seconds
        Scroll Element Into View    ${label.additional_information}
        IF    'RAButton' in ${perform_assessment_data}    Select Submit/Reset Button    ${perform_assessment_data}[RAButton]
    END
    IF    '${section_name}'=='VA Section'
        Scroll Element Into View    ${link.assessment.perform_assessment.action}
        Wait Until Time    1
        Wait Until Element Is Clickable And Click    ${link.assessment.perform_assessment.action}    10
        Select Answers For Questions In Decision Tree    ${perform_assessment_data}[VAAnswers]    ${perform_assessment_data}[DecisionTreeButton]
        IF    'DecisionTreeMessage3' in ${perform_assessment_data}    Verify Notification Popup    ${perform_assessment_data}[DecisionTreeMessage3]    ${perform_assessment_data}[DecisionTreeButton3]
        Wait Until Time    2
        Wait Until Element Is Visible    ${label.additional_information}    ${MEDIUM_WAIT}    Additional Information section is not visible after waiting for ${MEDIUM_WAIT} seconds
        Scroll Element Into View    ${label.additional_information}
        IF    'VAButton' in ${perform_assessment_data}    Select Submit/Reset Button    ${perform_assessment_data}[VAButton]
    END
