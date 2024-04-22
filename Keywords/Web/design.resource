*** Settings ***
Documentation     This design resource file has all the design manager keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Navigate To Module Tab In Design Manager
    [Arguments]    ${module}    ${tab_option}    ${js_click}=False
    [Documentation]    Navigate to Module Tab in Design Manager
    Unselect Frame
    Navigate To Main Menu    ${module}    ${js_click}
    Navigate To Menu Tab In Design Manager    ${tab_option}

Navigate To Menu Tab In Design Manager
    [Arguments]    ${tab_option}
    [Documentation]    It is used to select menu tab option in Design Manager
    ${button.design.newmenu_tab}    Update Dynamic Value    ${button.design.menu_tab}    ${tab_option}
    Select Frame    ${iframe.framecontent}
    Wait Until Element Is Visible    ${button.design.newmenu_tab}    ${MEDIUM_WAIT}    ${tab_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.design.newmenu_tab}

Navigate To Link Tab In Design Manager
    [Arguments]    ${link_tab}
    [Documentation]    It is used to select link tab option in Design Manager
    ${link.design.newtablink}    Update Dynamic Value    ${link.design.tablink}    ${link_tab}
    Wait Until Element Is Visible    ${link.design.newtablink}    ${MEDIUM_WAIT}    ${link_tab} tab is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${link.design.newtablink}    10

Select Entity In Design Manager
    [Arguments]    ${entity}    ${version}
    [Documentation]    This keyword is used to select entity from list of entities in Design manager
    Wait Until Element Is Visible    ${dropdown.design.select_entity}    ${MEDIUM_WAIT}    Select Entity is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Click Element    ${dropdown.design.select_entity}
    Input Text    ${dropdown.design.select_entity}    ${entity}
    Wait Until Time    2
    ${dropdown.design.select_entity.newentity_name}    Update Dynamic Values    ${dropdown.design.select_entity.entity_name}    ${entity}    ${version}
    Wait Until Element Is Visible    ${dropdown.design.select_entity.newentity_name}    ${MEDIUM_WAIT}    ${entity} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Scroll Element Into View    ${dropdown.design.select_entity.newentity_name}
    Wait Until Time    2
    Set Focus To Element    ${dropdown.design.select_entity.newentity_name}
    Click Element    ${dropdown.design.select_entity.newentity_name}
    Wait Until Time    2

Select Option From Action Dropdown
    [Arguments]    ${option}
    [Documentation]    This keyword is used to Select an Option From Action Dropdown in Design manager
    Wait Until Element Is Visible    ${dropdown.design.action}    ${MEDIUM_WAIT}    Action dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Click Element    ${dropdown.design.action}
    ${dropdown.design.action.newoption}    Update Dynamic Value    ${dropdown.design.action.option}    ${option}
    Wait Until Time    2
    Wait Until Element Is Visible    ${dropdown.design.action.newoption}    ${SHORT_WAIT}    ${option} option is not visible after waiting for ${SHORT_WAIT} seconds
    Click Element    ${dropdown.design.action.newoption}

Navigate To Create Feature Request Page
    [Arguments]    ${entity}    ${version}
    [Documentation]    This keyword will select entity and navigate to Create Feature Request Page
    Navigate To Module Tab In Design Manager    Design    Feature Request
    Select Entity In Design Manager    ${entity}    ${version}
    Select Option From Action Dropdown    Create

Create Feature Request
    [Arguments]    ${feature_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Feature Request
    Wait Until Element Is Visible    ${label.design.feature_request.action.create.header}    ${MEDIUM_WAIT}    Create Feature Request Page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'SelectEpic' in ${feature_data}    Select Value From Dropdown    ddlSelectEpic    ${feature_data}[SelectEpic]
    IF    'UserStory' in ${feature_data}
        Wait Until Time    2
        Wait Until Element Is Visible    ${textbox.design.feature_request.action.create.user_story}    ${MEDIUM_WAIT}    User Story textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
        Input Text   ${textbox.design.feature_request.action.create.user_story}    ${feature_data}[UserStory]
    END
    IF    'AcceptanceCriteria' in ${feature_data}
        Select Frame    ${iframe.design.feature_request.action.create.accept_criteria}
        Input Text    ${textbox.system.create.form.control_creation.settings.helptext}    ${feature_data}[AcceptanceCriteria]
        Switch To Parent Frame
    END
    ${FEATURE_REQ_ID}    Get Text    ${label.design.feature_request.action.create.header_id}
    Set Suite Variable    ${FEATURE_REQ_ID}
    IF    'Button' in ${feature_data}    Select Submit/Reset Button    ${feature_data}[Button]
    IF    'eSign' in ${feature_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit    ${feature_data}[Reason]
    ${EXPECTED_MESSAGE}    Set Variable    ${FEATURE_REQ_ID} Feature Request has been created
    RETURN    ${EXPECTED_MESSAGE}

Approve Feature Request
    [Arguments]    ${entity}    ${version}    ${feature_data}    ${user_name}    ${password}    ${feature_request_checkboxes}=None
    [Documentation]    This Keyword is used to Select Entity and Approve Feature Request
    Wait Until Element Is Visible    ${dropdown.design.select_entity}    ${MEDIUM_WAIT}    Select Entity is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Entity In Design Manager    ${entity}    ${version}
    IF    'Tab' in ${feature_data}    Navigate To Link Tab In Design Manager    ${feature_data}[Tab]
    IF    'Checkbox' in ${feature_data}
        Wait Until Element Is Visible    ${checkbox.design.select_all}    ${MEDIUM_WAIT}    Select All checkbox is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    '${feature_data}[Checkbox]'=='SelectAll'
            Select Checkbox    ${checkbox.design.select_all}
        ELSE IF    '${feature_data}[Checkbox]'!='SelectAll'
            @{select_list}    Split String    ${feature_request_checkboxes}    ,
            FOR    ${key}    IN    @{select_list}
                ${checkbox.design.feature_request.accept.feature_req_id.newcheckbox}    Update Dynamic Value    ${checkbox.design.feature_request.accept.feature_req_id.checkbox}    ${key}
                Wait Until Time    1
                Wait Until Element Is Visible    ${checkbox.design.feature_request.accept.feature_req_id.newcheckbox}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
                Select Checkbox    ${checkbox.design.feature_request.accept.feature_req_id.newcheckbox}
            END
        END
    END
    IF    'Action' in ${feature_data}    Select Option From Action Dropdown    ${feature_data}[Action]
    IF    'Comments' in ${feature_data}    Enter Comments/Description    txtActionComment    ${feature_data}[Comments]
    IF    'Button' in ${feature_data}    Select Submit/Reset Button    ${feature_data}[Button]
    IF    'eSign' in ${feature_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit

Navigate To Story Point Assessment Screen
    [Arguments]    ${entity}    ${version}    ${feature_req_id}
    [Documentation]    This keyword will navigate to Story Point Assessment Screen
    Navigate To Module Tab In Design Manager    Design    Feature Request
    Select Entity In Design Manager    ${entity}    ${version}
    Navigate To Link Tab In Design Manager    Backlog
    Wait Until Element Is Visible    ${label.design.feature_request.backlog.story_point_column}    ${MEDIUM_WAIT}    Story Point column is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Input Text    ${textbox.design.feature_request.search_box}    ${feature_req_id}
    Wait Until Time    2
    Click Element    ${icon.design.feature_request.backlog.search_icon}
    ${link.design.feature_request.backlog.newstory_point}    Update Dynamic Value    ${link.design.feature_request.backlog.story_point}    ${feature_req_id}
    Wait Until Element Is Visible    ${link.design.feature_request.backlog.newstory_point}    ${MEDIUM_WAIT}    Story Point link is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${link.design.feature_request.backlog.newstory_point}    10
    Wait Until Element Is Visible    ${label.design.feature_request.backlog.storypoint_assessment_screen}    ${MEDIUM_WAIT}    Story Point Assessment Screen is not visible after waiting for ${SHORT_WAIT} seconds

Edit/Update Story Point Assessment Details
    [Arguments]    ${feature_data}
    [Documentation]    This Keyword is used to Edit/Update Story Point Assessment Details
    Select Frame    ${iframe.design.feature_request.story_point_assessment}
    IF    'StoryPointDetails' in ${feature_data}
        @{grid_list}    Split String    ${feature_data}[StoryPointDetails]    |
        FOR    ${key}    IN    @{grid_list}
            @{list}    Split String    ${key}    -
            ${grid_header}    Set Variable    ${list}[0]
            ${story_point}    Set Variable    ${list}[1]
            ${checkbox.design.feature_request.backlog.story_point_assessment.newstory_point}    Update Dynamic Values    ${checkbox.design.feature_request.backlog.story_point_assessment.story_point}    ${grid_header}    ${story_point}
            Wait Until Time    1
            Wait Until Element Is Visible    ${checkbox.design.feature_request.backlog.story_point_assessment.newstory_point}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
            Select Checkbox    ${checkbox.design.feature_request.backlog.story_point_assessment.newstory_point}
        END
    END
    IF    'Comments' in ${feature_data}    Enter Comments/Description    txtComments    ${feature_data}[Comments]
    IF    'Button' in ${feature_data}    Select Submit/Reset Button    ${feature_data}[Button]

Navigate To Create Release Plan Page
    [Documentation]    This keyword will navigate to Create Release Plan Page
    Navigate To Module Tab In Design Manager    Design    Release Plan
    Click Button In VLMS    Create

Enter Details In Create Release Plan Page
    [Arguments]    ${release_plan_data}    ${entity}    ${version}
    [Documentation]    This Keyword is used to Enter Details in Create Release Plan Page
    IF    'SelectEntity' in ${release_plan_data}    Select Entity In Design Manager    ${entity}    ${version}
    IF    'ReleasePlanName' in ${release_plan_data}    Enter Text In Mandatory Fields    ReleasePlanName    ${release_plan_data}[ReleasePlanName]
    IF    'Description' in ${release_plan_data}    Enter Comments/Description    txtDescription    ${release_plan_data}[Description]
    IF    'EstimatedStartDate' in ${release_plan_data}
        Click Calendar Icon In Vlms    ${icon.design.create_release_plan.estimated_start_date.calendar}
        Select Target Date    ${release_plan_data}[EstimatedStartDate]    txtEstimatedStartDate    txtEstimatedStartDate_DrpPnl_Calendar1_506    txtEstimatedStartDate_DrpPnl_Calendar1_504    ${release_plan_data}[StartYear]    ${release_plan_data}[StartMonth]    ${release_plan_data}[StartDate]
    END
    IF    'EstimatedTargetDate' in ${release_plan_data}
        Click Calendar Icon In Vlms    ${icon.design.create_release_plan.estimated_target_date.calendar}
        Select Target Date    ${release_plan_data}[EstimatedTargetDate]    txtEstimatedEndDate    txtEstimatedEndDate_DrpPnl_Calendar1_506    txtEstimatedEndDate_DrpPnl_Calendar1_504    ${release_plan_data}[EndYear]    ${release_plan_data}[EndMonth]    ${release_plan_data}[EndDate]
    END
    IF    'ExternalCCR' in ${release_plan_data}    Enter Text In Mandatory Fields    CCRNO    ${release_plan_data}[ExternalCCR]
    IF    'ExternalReleaseplanID' in ${release_plan_data}    Enter Text In Mandatory Fields    DevOpsID    ${release_plan_data}[ExternalReleaseplanID]
    IF    'SprintsRequired' in ${release_plan_data}    Select Value For Radio Button    rdoSprintGroup    ${release_plan_data}[SprintsRequired]
    IF    'SprintDependency' in ${release_plan_data}    Select Value For Radio Button    rdoSprintTypeGroup    ${release_plan_data}[SprintDependency]
    IF    'TraceModel' in ${release_plan_data}    Select Value From Dropdown    ddlTracemodel    ${release_plan_data}[TraceModel]
    IF    'Deliverables' in ${release_plan_data}
        Select Value From Dropdown    ddlDesignDeliverables    ${release_plan_data}[Deliverables]
        Click Element    ${link.design.create_release_plan.deliverables.add}
        Wait Until Time    2
    END
    IF    'RiskFramework' in ${release_plan_data}    Select Value From Dropdown    ddlRiskFramework    ${release_plan_data}[RiskFramework]
    IF    'ReleaseSummaryRequired' in ${release_plan_data}    Select Value For Radio Button    rdoReleaseGroup    ${release_plan_data}[ReleaseSummaryRequired]
    IF    'ReleaseSummaryForm' in ${release_plan_data}    Select Value From Dropdown    ddlReleaseSummary   ${release_plan_data}[ReleaseSummaryForm]
    IF    'Groups' in ${release_plan_data}    Select Multiple Values From A Dropdown List    ddlGroup    ${release_plan_data}[Groups]
    IF    'Resources' in ${release_plan_data}    Select Multiple Values From A Dropdown List    ddlResource    ${release_plan_data}[Resources]
    IF    'Responsibility' in ${release_plan_data}    Select Value From Dropdown     ddlResponsibility    ${release_plan_data}[Responsibility]
    IF    'ResourceSave' in ${release_plan_data}
        Click Element    ${button.design.create_release_plan.resource.save}
        Verify Success Message    Resources has been saved    btnMessageOk
    END

Create Release Plan
    # robocop: disable=too-long-keyword
    [Arguments]    ${release_plan_data}    ${entity}    ${version}    ${feature_requests}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Release Plan
    Wait Until Element Is Visible    ${label.design.release_plan.create.header}    ${MEDIUM_WAIT}    Create Release Plan header is not visible after waiting for ${MEDIUM_WAIT} seconds
    Enter Details In Create Release Plan Page    ${release_plan_data}    ${entity}    ${version}
    IF    'ReviewerGroups' in ${release_plan_data}    Select Multiple Values From A Dropdown List    ddlRevGroups    ${release_plan_data}[ReviewerGroups]
    IF    'ReviewerUsers' in ${release_plan_data}    Select Multiple Values From A Dropdown List    ddlRevUsers    ${release_plan_data}[ReviewerUsers]
    IF    'ApproverGroups' in ${release_plan_data}    Select Multiple Values From A Dropdown List    ddlAppGroups    ${release_plan_data}[ApproverGroups]
    IF    'ApproverUsers' in ${release_plan_data}
        Scroll Element Into View    ${button.design.create_release_plan.feature_req.add}
        Select Multiple Values From A Dropdown List    ddlAppUsers    ${release_plan_data}[ApproverUsers]
    END
    IF    'DefectApproverGroups' in ${release_plan_data}    Select Multiple Values From A Dropdown List    ddlDefectGroups    ${release_plan_data}[DefectApproverGroups]
    IF    'DefectApproverUsers' in ${release_plan_data}    Select Multiple Values From A Dropdown List    ddlDefectUsers    ${release_plan_data}[DefectApproverUsers]
    IF    'FeatureRequest' in ${release_plan_data}
        Click Element    ${button.design.create_release_plan.feature_req.add}
        Wait Until Time    2
        Wait Until Element Is Visible    ${checkbox.design.select_all}    ${MEDIUM_WAIT}    Select All checkbox is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    '${release_plan_data}[FeatureRequest]'=='SelectAll'
            Select Checkbox    ${checkbox.design.select_all}
        ELSE IF    '${release_plan_data}[FeatureRequest]'!='SelectAll'
            @{select_list}    Split String    ${feature_requests}    ,
            FOR    ${key}    IN    @{select_list}
                ${checkbox.design.create_release_plan.feature_req_id.newcheckbox}    Update Dynamic Value    ${checkbox.design.create_release_plan.feature_req_id.checkbox}    ${key}
                Wait Until Time    1
                Wait Until Element Is Visible    ${checkbox.design.create_release_plan.feature_req_id.newcheckbox}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
                Select Checkbox    ${checkbox.design.create_release_plan.feature_req_id.newcheckbox}
            END
        END
        Close Screen In Design Manager    Select Feature Request
    END
    IF    'Approval' in ${release_plan_data}
        Select Value For Radio Button    check    ${release_plan_data}[Approval]
        IF    '${release_plan_data}[Approval]'=='rdoAppYes'
            IF    'WorkFlow' in ${release_plan_data}    Select Value From Dropdown    ddlWorkFlow-container    ${release_plan_data}[WorkFlow]
            IF    'RouteTaskFor' in ${release_plan_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${release_plan_data}[RouteTaskFor]
        END
    END
    IF    'Comments' in ${release_plan_data}    Enter Comments/Description    txtComments    ${release_plan_data}[Comments]
    ${RELEASE_PLAN_ID}    Get Text    ${label.design.release_plan.create.header_id}
    Set Suite Variable    ${RELEASE_PLAN_ID}
    IF    'Button' in ${release_plan_data}    Select Submit/Reset Button    ${release_plan_data}[Button]
    IF    'eSign' in ${release_plan_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit    ${release_plan_data}[Reason]
    ${EXPECTED_MESSAGE}    Set Variable    ${release_plan_data}[ReleasePlanName] Release Plan ${RELEASE_PLAN_ID} has been created
    RETURN    ${EXPECTED_MESSAGE}

Select Multiple Values From A Dropdown List
    [Arguments]    ${dropdown_name}    ${options}
    [Documentation]    This keyword is used to Select Multiple Values From A Dropdown List
    ${dropdown.design.common.newselect}    Update Dynamic Value    ${dropdown.design.common.select}    ${dropdown_name}
    Wait Until Element Is Visible    ${dropdown.design.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${dropdown.design.common.newselect}    10
    @{option_list}    Split String    ${options}    ,
    FOR    ${key}    IN    @{option_list}
        Click Element    ${dropdown.design.common.newselect}
        Wait Until Time    2
        Input Text    ${dropdown.design.common.newselect}    ${key}
        ${dropdown.design.common.select.newvalue}    Update Dynamic Values    ${dropdown.design.common.select.value}    ${dropdown_name}    ${key}
        Scroll Till Element Is Visible    ${dropdown.design.common.select.newvalue}
        Wait Until Element Is Visible    ${dropdown.design.common.select.newvalue}    ${MEDIUM_WAIT}    ${key} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Scroll Element Into View    ${dropdown.design.common.select.newvalue}
        Wait Until Element Is Clickable And Click    ${dropdown.design.common.select.newvalue}    10
    END

Navigate To Create Task Screen
    [Arguments]    ${entity}    ${version}    ${release_plan_id}
    [Documentation]    This keyword will select entity and navigate to Create Task Screen
    Navigate To Module Tab In Design Manager    Design    Release Plan
    Select Entity In Design Manager    ${entity}    ${version}
    ${icon.design.release_plan.newmanage_task}    Update Dynamic Value    ${icon.design.release_plan.manage_task}    ${release_plan_id}
    Wait Until Element Is Visible    ${icon.design.release_plan.newmanage_task}    ${MEDIUM_WAIT}    Manage Task icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Wait Until Element Is Clickable And Click    ${icon.design.release_plan.newmanage_task}    5
    Click Button In VLMS    Create / Edit Task

Create Task
    [Arguments]    ${task_data}    ${feature_req_id}
    [Documentation]    This keyword is used to Create Task
    Wait Until Element Is Visible    ${label.design.release_plan.manage_task.create_edit.screen}    ${MEDIUM_WAIT}    Create Task is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'FeatureRequest' in ${task_data}    Select Value From Dropdown    ddlFeatureRequest    ${feature_req_id}
    Wait Until Element Is Visible    ${textbox.design.release_plan.create_task.estimated_hours}    ${MEDIUM_WAIT}    Estimated Hours is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'Description' in ${task_data}
        Wait Until Time    2
        Select Frame    ${iframe.design.release_plan.create_task.description}
        Wait Until Element Is Visible    ${textbox.design.frame.description}    ${MEDIUM_WAIT}    Description is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Keyword Succeeds    8s    2s    Input Text    ${textbox.design.frame.description}    ${task_data}[Description]
        Switch To Parent Frame
    END
    IF    'EstimatedHours' in ${task_data}
        Input Text    ${textbox.design.release_plan.create_task.estimated_hours}    ${task_data}[EstimatedHours]
    END
    IF    'Responsibility' in ${task_data}    Select Value From Dropdown     ddlResponsibility    ${task_data}[Responsibility]
    IF    'AssignTo' in ${task_data}    Select Value From Dropdown     ddlAssignTo    ${task_data}[AssignTo]
    IF    'Button' in ${task_data}    Select Submit/Reset Button    ${task_data}[Button]

Close Screen In Design Manager
    [Arguments]    ${screen_name}
    [Documentation]    This keyword is used to Close Screen In Design Manager
    ${icon.design.screen.newclose}    Update Dynamic Value    ${icon.design.screen.close}    ${screen_name}
    Wait Until Time    2
    Wait Until Element Is Visible    ${icon.design.screen.newclose}    ${MEDIUM_WAIT}    ${screen_name} close icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${icon.design.screen.newclose}

Navigate Back From Manage Task Page
    [Documentation]    This keyword is used to navigate back from Manage Task Page
    Close Screen In Design Manager    Task
    Wait Until Time    2
    Click Element    ${icon.design.redirection_arrow}

Navigate To Create Sprint Page
    [Documentation]    This keyword will navigate to Create Sprint Page
    Navigate To Module Tab In Design Manager    Design    Sprint
    Click Button In VLMS    Create

Create Sprint
    # robocop: disable=too-long-keyword
    [Arguments]    ${sprint_data}    ${entity}    ${version}    ${feature_requests}    ${user_name}    ${password}
    [Documentation]    This keyword is used to Create Sprint
    Wait Until Element Is Visible    ${label.design.sprint.create.header_id}    ${MEDIUM_WAIT}    Create Sprint Page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'SelectEntity' in ${sprint_data}    Select Entity In Design Manager    ${entity}    ${version}
    IF    'ReleasePlan' in ${sprint_data}    Select Value From Dropdown    ddlReleasePlan    ${sprint_data}[ReleasePlan]
    IF    'SprintName' in ${sprint_data}    Enter Text In Mandatory Fields    Sprint    ${sprint_data}[SprintName]
    IF    'Description' in ${sprint_data}    Enter Comments/Description    txtDescription    ${sprint_data}[Description]
    IF    'EstimatedStartDate' in ${sprint_data}
        Click Calendar Icon In Vlms    ${icon.design.create_release_plan.estimated_start_date.calendar}
        Select Target Date    ${sprint_data}[EstimatedStartDate]    txtEstimatedStartDate    txtEstimatedStartDate_DrpPnl_Calendar1_506    txtEstimatedStartDate_DrpPnl_Calendar1_504    ${sprint_data}[StartYear]    ${sprint_data}[StartMonth]    ${sprint_data}[StartDate]
    END
    IF    'Duration' in ${sprint_data}
        Input Text    ${textbox.design.release_plan.create_task.estimated_hours}    ${sprint_data}[Duration]
        Click Element    ${label.design.sprint.create.header_id}
        Wait Until Time    2
    END
    IF    'DurationType' in ${sprint_data}    Select Value From Dropdown    ddlDuration    ${sprint_data}[DurationType]
    Wait Until Time    2
    IF    'AuthorUsers' in ${sprint_data}    Select Multiple Values From A Dropdown List    ddlTesterUser    ${sprint_data}[AuthorUsers]
    IF    'ReviewerUsers' in ${sprint_data}    Select Multiple Values From A Dropdown List    ddlRevUsers    ${sprint_data}[ReviewerUsers]
    IF    'ApproverUsers' in ${sprint_data}    Select Multiple Values From A Dropdown List    ddlAppUsers    ${sprint_data}[ApproverUsers]
    IF    'ScrumMaster' in ${sprint_data}
        Wait Until Time    2
        Scroll Element Into View    ${button.design.create_release_plan.feature_req.add}
        Select Value From Dropdown    ddlScrumMaster    ${sprint_data}[ScrumMaster]
    END
    IF    'FeatureRequest' in ${sprint_data}
        Click Element    ${button.design.create_release_plan.feature_req.add}
        Wait Until Element Is Visible    ${checkbox.design.select_all}    ${MEDIUM_WAIT}    Select All checkbox is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    '${sprint_data}[FeatureRequest]'=='SelectAll'
            Select Checkbox    ${checkbox.design.select_all}
        ELSE IF    '${sprint_data}[FeatureRequest]'!='SelectAll'
            @{select_list}    Split String    ${feature_requests}    ,
            FOR    ${key}    IN    @{select_list}
                ${checkbox.design.create_release_plan.feature_req_id.newcheckbox}    Update Dynamic Value    ${checkbox.design.create_release_plan.feature_req_id.checkbox}    ${key}
                Wait Until Time    1
                Wait Until Element Is Visible    ${checkbox.design.create_release_plan.feature_req_id.newcheckbox}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
                Select Checkbox    ${checkbox.design.create_release_plan.feature_req_id.newcheckbox}
            END
        END
        Close Screen In Design Manager    Select Feature Request
    END
    IF    'Comments' in ${sprint_data}    Enter Comments/Description    txtComments    ${sprint_data}[Comments]
    Wait Until Time    2
    ${SPRINT_ID}    Get Text    ${label.design.sprint.create.header_id}
    IF    'Button' in ${sprint_data}    Select Submit/Reset Button    ${sprint_data}[Button]
    IF    'eSign' in ${sprint_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit    ${sprint_data}[Reason]
    Set Suite Variable    ${SPRINT_ID}
    ${EXPECTED_MESSAGE}    Set Variable    ${SPRINT_ID} Sprint has been created
    RETURN    ${EXPECTED_MESSAGE}

Start Sprint
    [Arguments]    ${sprint_id}    ${sprint_data}
    [Documentation]    This keyword is used to Start Sprint
    ${link.design.sprint.status.newawaiting}    Update Dynamic Value    ${link.design.sprint.status.awaiting}    ${sprint_id}
    Wait Until Time    2
    Wait Until Element Is Visible    ${link.design.sprint.status.newawaiting}    ${MEDIUM_WAIT}    Awaiting to Start link is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${link.design.sprint.status.newawaiting}
    Verify Success Message    ${sprint_data}[ExpectedMessage]    ${sprint_data}[ButtonOption1]
    ${EXP_MESSAGE}    Set Variable    ${sprint_data}[SprintName] Sprint ${sprint_id} has been started
    RETURN    ${EXP_MESSAGE}

Select Task Based On Value
    [Arguments]    ${value}    ${index}
    [Documentation]    This keyword is used to select Task based on value
    ${link.design.value.newtask_id}    Update Dynamic Value    ${link.design.value.task_id}   ${value}
    Wait Until Element Is Visible    (${link.design.value.newtask_id})[${index}]    ${MEDIUM_WAIT}    Task is not visible after waiting for ${MEDIUM_WAIT} seconds
    Scroll Element Into View    (${link.design.value.newtask_id})[${index}]
    Wait Until Time    2
    Click Element    (${link.design.value.newtask_id})[${index}]

Select Task Based On ID
    [Arguments]    ${task_id}
    [Documentation]    This keyword is used to select Task based on ID
    ${link.design.newtask_id}    Update Dynamic Value    ${link.design.task_id}    ${task_id}
    Wait Until Element Is Visible    ${link.design.newtask_id}    ${MEDIUM_WAIT}    ${task_id} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Scroll Element Into View    ${link.design.newtask_id}
    Wait Until Time    2
    Wait Until Element Is Clickable And Click    ${link.design.newtask_id}    8

Navigate To Create Requirement Category Screen
    [Arguments]    ${entity}    ${version}    ${require_data}
    [Documentation]    This keyword will select entity and navigate to Create Requirement Category Screen
    Navigate To Module Tab In Design Manager    Design    Requirements
    Select Entity In Design Manager    ${entity}    ${version}
    Select Task Based On Value    ${require_data}[Value]    ${require_data}[Index]
    Select Option From Action Dropdown    Create Requirement Category

Create Requirement Category
    [Arguments]    ${require_data}
    [Documentation]    This keyword is used to Create Requirement Category
    Wait Until Element Is Visible    ${label.design.requirements.create_req_category}    ${MEDIUM_WAIT}    Create Requirement Category is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Select Frame    ${iframe.design.requirements.create_req_category}
    IF    'RequirementCategoryName' in ${require_data}    Enter Text In Mandatory Fields    RTLName    ${require_data}[RequirementCategoryName]
    IF    'SpreadTemplate' in ${require_data}    Select Value From Dropdown    ddlSpreadTemplate    ${require_data}[SpreadTemplate]
    IF    'RequirementCategoryForm' in ${require_data}    Select Value From Dropdown    ddlSelectRTL    ${require_data}[RequirementCategoryForm]
    IF    'Description' in ${require_data}
        Wait Until Element Is Visible    ${label.design.description}    ${MEDIUM_WAIT}    Description is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    2
        Select Frame    ${iframe.design.release_plan.create_task.description}
        Wait Until Element Is Visible    ${textbox.design.frame.description}    ${MEDIUM_WAIT}    Description text field is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Keyword Succeeds    6s    2s    Input Text    ${textbox.design.frame.description}    ${require_data}[Description]
        Switch To Parent Frame
    END
    IF    'Button' in ${require_data}    Select Submit/Reset Button    ${require_data}[Button]
    ${EXP_MESSAGE}    Set Variable    ${require_data}[RequirementCategoryName] Requirement Category has been created
    RETURN    ${EXP_MESSAGE}

Lock FRS
    # robocop: disable=too-long-keyword
    [Arguments]    ${require_data}    ${feature_requests}
    [Documentation]    This keyword is used to Lock FRS
    Wait Until Time    2
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    Wait Until Element Is Visible    ${label.design.requirements.task_id.req_table.canvas}    ${LONG_WAIT}    Requirements Table is not visible after waiting for ${LONG_WAIT} seconds
    Wait Until Time    2
    @{reference_list}    Split String    ${feature_requests}    ,
    ${index}    Set Variable    0
    @{selected_req}    Create List
    @{row_details}    Split String    ${require_data}[CanvasDetails]    |
    FOR    ${key}    IN    @{row_details}
        @{details}    Split String    ${key}    ,
        ${description}    Set Variable    ${details}[1]
        ${reference}    Set Variable    ${reference_list}[${index}]
        IF    "${description}"!="None"
            Enter Canvas Description    ${label.design.requirements.task_id.req_table.canvas}    ${description}
            Wait Until Time    2
        END
        IF    "${reference}"!="None"
            Select Reference    ${label.design.requirements.task_id.req_table.canvas}
            Wait Until Element Is Visible    ${label.design.requirements.create_req_category}    ${MEDIUM_WAIT}    Add Reference is not visible after waiting for ${MEDIUM_WAIT} seconds
            ${header}    Get Text    ${label.design.requirements.create_req_category}
            ${ref_frs_id}    Remove String    ${header}    Add Reference for    ${SPACE}
            Wait Until Time    1
            Select Frame    ${iframe.design.requirements.create_req_category}
            Navigate To Link Tab In Design Manager    ${require_data}[Tab]
            ${radiobutton.design.requirements.canvas.reference.newid}    Update Dynamic Value    ${radiobutton.design.requirements.canvas.reference.id}    ${reference}
            Wait Until Element Is Visible    ${radiobutton.design.requirements.canvas.reference.newid}    ${MEDIUM_WAIT}    Reference id is not visible after waiting for ${MEDIUM_WAIT} seconds
            Wait Until Element Is Clickable And Click    ${radiobutton.design.requirements.canvas.reference.newid}    10
            Switch To Parent Frame
            Close Screen In Design Manager    Add Reference
            Append To List    ${selected_req}    ${ref_frs_id}
        END
        ${index}    Evaluate    ${index}+1
        Wait Until Time    2
        Move To Next Row    ${label.design.requirements.task_id.req_table.canvas}
    END
    Wait Until Time    2
    Move To First Row    ${label.design.requirements.task_id.req_table.canvas}
    FOR    ${key}    IN    @{row_details}
        @{details}    Split String    ${key}    ,
        ${checkbox}    Set Variable    ${details}[0]
        IF    "${checkbox}"=="Select"
            Select Canvas Checkbox    ${label.design.requirements.task_id.req_table.canvas}
            Wait Until Time    2
        END
        Move To Next Row    ${label.design.requirements.task_id.req_table.canvas}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    IF    'Action' in ${require_data}    Select Option From Action Dropdown    ${require_data}[Action]
    ${FRS_ID}    Set Variable    ${selected_req}[0]
    Set Suite Variable    ${FRS_ID}
    ${EXP_MESSAGE}    Set Variable    has been Locked
    RETURN    ${EXP_MESSAGE}

Navigate To Conduct Risk Assessment Page
    [Arguments]    ${entity}    ${version}    ${risk_data}
    [Documentation]    This keyword will select entity and navigate to Conduct Risk Assessment Page
    Navigate To Module Tab In Design Manager    Design    Risk Assessment
    Select Entity In Design Manager    ${entity}    ${version}
    Navigate To Link Tab In Design Manager    Risk Assessment
    Select Task Based On Value    ${risk_data}[Value]    ${risk_data}[Index]

Create Risk Assessment In Design Manager
    [Arguments]    ${risk_data}    ${req_id}    ${user_name}    ${password}
    [Documentation]    This keyword is used to Create Risk Assessment In Design Manager
    Wait Until Element Is Visible    ${label.design.risk_assessment.risk_id.header}    ${MEDIUM_WAIT}    Conduct Risk Assessment page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'RequirementID' in ${risk_data}    Select Task Based On ID    ${req_id}
    IF    'RiskFactorValues' in ${risk_data}
        @{riskfactor_values}    Split String    ${risk_data}[RiskFactorValues]    ,
        ${index}    Set Variable    1
        FOR    ${key}    IN    @{riskfactor_values}
            Wait Until Time    1
            Wait Until Element Is Visible    (${dropdown.design.risk_assessment.risk_factor.value})[${index}]    ${MEDIUM_WAIT}    Risk Factor dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
            Select From List By Label    (${dropdown.design.risk_assessment.risk_factor.value})[${index}]    ${key}
            ${index}    Evaluate    ${index}+1
        END
    END
    IF    'Justification' in ${risk_data}    Input Text    ${textbox.design.risk_assessment.justification}    ${risk_data}[Justification]
    IF    'SaveButton' in ${risk_data}    Click Element    ${button.design.risk_assessment.risk_id.risk_assessment.save}
    IF    'ExpectedMessage1' in ${risk_data}    Verify Confirmation Popup    ${risk_data}[ExpectedMessage1]    ${risk_data}[ButtonOption1]
    Wait Until Time    2
    IF    'Comments' in ${risk_data}    Enter Comments/Description    txtComments    ${risk_data}[Comments]
    IF    'Button' in ${risk_data}    Select Submit/Reset Button    ${risk_data}[Button]
    IF    'eSign' in ${risk_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit

Route Requirement For Approval/Approve Requirement
    [Arguments]    ${require_data}    ${entity}    ${version}    ${user_name}    ${password}
    [Documentation]    This keyword is used to Route Requirement For Approval/Approve Requirement
    Select Entity In Design Manager    ${entity}    ${version}
    IF    '${require_data}[Action]'=='Route for Approval'    Select Task Based On Value    ${require_data}[Value]    ${require_data}[Index]
    IF    '${require_data}[Action]'=='Approve' and 'Value' in ${require_data}
        ${link.design.testcase.newtask_id}    Update Dynamic Value    ${link.design.testcase.task_id}    ${require_data}[Value]
        Wait Until Element Is Visible    ${link.design.testcase.newtask_id}    ${MEDIUM_WAIT}    Task is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    2
        Click Element    ${link.design.testcase.newtask_id}
    END
    Wait Until Element Is Visible    ${label.design.requirements.task_id.req_table.canvas}    ${MEDIUM_WAIT}    Requirements Table is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    @{checkboxes_list}    Split String    ${require_data}[CanvasCheckboxes]    ,
    FOR    ${key}    IN    @{checkboxes_list}
        IF    "${key}"=="Select"    Select Canvas Checkbox    ${label.design.requirements.task_id.req_table.canvas}
        Move To Next Row    ${label.design.requirements.task_id.req_table.canvas}
    END
    Select Option From Action Dropdown    ${require_data}[Action]
    IF    '${require_data}[Action]'=='Route for Approval'
        Verify Success Message    ${require_data}[ExpectedMessage1]    ${require_data}[ButtonOption1]
        ${EXPECTED_MESSAGE}    Set Variable    has been sent for approval
    END
    IF    '${require_data}[Action]'=='Approve'
        ${EXPECTED_MESSAGE}    Set Variable    has been approved
    END
    Handle Electronic Sign    ${user_name}    ${password}    Submit
    RETURN    ${EXPECTED_MESSAGE}

Navigate To Create Test Case Page
    [Arguments]    ${entity}    ${version}    ${testcase_data}
    [Documentation]    This keyword will select entity and navigate to Create Test Case Page
    Navigate To Module Tab In Design Manager    Design    Test Case
    Select Entity In Design Manager    ${entity}    ${version}
    Select Task Based On Value    ${testcase_data}[Value]    ${testcase_data}[Index]
    Select Option From Action Dropdown    Create Test Case

Create Test Case
    [Arguments]    ${testcase_data}    ${req_ids}
    [Documentation]    This keyword is used to Create Test Case
    Wait Until Element Is Visible    ${label.design.create_testcase.header}    ${MEDIUM_WAIT}    Create Test Case page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'TestCaseName' in ${testcase_data}    Enter Text In Mandatory Fields    TestCaseName    ${testcase_data}[TestCaseName]
    IF    'SpreadTemplate' in ${testcase_data}    Select Value From Dropdown    ddlSpreadTemplate    ${testcase_data}[SpreadTemplate]
    IF    'Description' in ${testcase_data}    Enter Comments/Description    txtDescription    ${testcase_data}[Description]
    IF    'PreRequisite' in ${testcase_data}    Enter Text In Mandatory Fields    PreRequisite    ${testcase_data}[PreRequisite]
    IF    'Reference' in ${testcase_data}
        Wait Until Time    2
        Click Element    ${link.design.create_testcase.reference}
        Wait Until Time    2
        Select Frame    ${iframe.design.requirements.create_req_category}
        @{select_list}    Split String    ${req_ids}    ,
        FOR    ${key}    IN    @{select_list}
            ${checkbox.design.create_release_plan.feature_req_id.newcheckbox}    Update Dynamic Value    ${checkbox.design.create_release_plan.feature_req_id.checkbox}    ${key}
            Wait Until Element Is Visible    ${checkbox.design.create_release_plan.feature_req_id.newcheckbox}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
            Select Checkbox    ${checkbox.design.create_release_plan.feature_req_id.newcheckbox}
        END
        Switch To Parent Frame
        Close Screen In Design Manager    Add References
    END
    IF    'Button' in ${testcase_data}    Select Submit/Reset Button    ${testcase_data}[Button]
    ${header_text}    Get Text    ${label.design.create_testcase.header}
    ${TC_ID}    Remove String    ${header_text}    Create Test Case -    ${SPACE}
    ${EXP_MESSAGE}    Set Variable    ${testcase_data}[TestCaseName] - ${TC_ID} Test Case has been created
    ${TEST_CASE_NAME}    Set Variable    ${testcase_data}[TestCaseName]
    Set Suite Variable    ${TEST_CASE_NAME}
    RETURN    ${EXP_MESSAGE}

Enter Details In Test Case Canvas Table
    [Arguments]    ${testcase_data}    ${tc_name}
    [Documentation]    This keyword is used to Enter Details In Test Case Table
    IF    'TestCase' in ${testcase_data}    Select Value From Dropdown    DdlTestCase    ${tc_name}
    Wait Until Element Is Visible    ${label.design.testcase.task_id.tc_table.canvas}    ${MEDIUM_WAIT}    Test Case Canvas Table is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    @{row_details}    Split String    ${testcase_data}[CanvasDetails]    |
    FOR    ${key}    IN    @{row_details}
        @{details}    Split String    ${key}    ,
        ${checkbox}    Set Variable    ${details}[0]
        ${description}    Set Variable    ${details}[1]
        ${test_step}    Set Variable    ${details}[2]
        ${tc_expected_result}    Set Variable    ${details}[3]
        IF    "${checkbox}"=="Select"
            Select Canvas Checkbox    ${label.design.testcase.task_id.tc_table.canvas}
            Wait Until Time    2
        END
        IF    "${description}"!="None"
            Enter Canvas Description    ${label.design.testcase.task_id.tc_table.canvas}    ${description}
            Wait Until Time    2
        END
        IF    "${test_step}"!="None"
            Enter Test Step    ${label.design.testcase.task_id.tc_table.canvas}    ${test_step}
            Wait Until Time    2
        END
        IF    "${tc_expected_result}"!="None"
            Enter Expected Result    ${label.design.testcase.task_id.tc_table.canvas}    ${tc_expected_result}
            Wait Until Time    2
        END
        Move To Next Row    ${label.design.testcase.task_id.tc_table.canvas}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Route Test Case For Approval
    [Arguments]    ${testcase_data}    ${tc_name}    ${route_tcs}    ${user_name}    ${password}
    [Documentation]    This keyword is used to Route Test Case For Approval
    IF    'TestCase' in ${testcase_data}    Select Value From Dropdown    DdlTestCase    ${tc_name}
    IF    'Action' in ${testcase_data}
        Select Option From Action Dropdown    ${testcase_data}[Action]
        Verify Success Message    ${testcase_data}[ExpectedMessage1]    ${testcase_data}[ButtonOption1]
    END
    IF    'SelectTestCase' in ${testcase_data}
        Wait Until Time    2
        Wait Until Element Is Visible    ${dropdown.design.testcase.route_for_approval.select_tc}    ${MEDIUM_WAIT}    Select TestCase is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${dropdown.design.testcase.route_for_approval.select_tc}
        IF    '${testcase_data}[SelectTestCase]'=='SelectAll'
            Wait Until Time    2
            Wait Until Element Is Visible    ${link.design.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    ${link.design.select_all}
        ELSE IF    '${testcase_data}[SelectTestCase]'!='SelectAll'
            @{tc_list}    Split String    ${route_tcs}    ,
            FOR    ${key}    IN    @{tc_list}
                ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}    Update Dynamic Value    ${checkbox.design.testcase.route_for_approval.select_tc.tc_name}    ${key}
                Wait Until Element Is Visible    ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}    ${MEDIUM_WAIT}    TestCase is not visible after waiting for ${MEDIUM_WAIT} seconds
                Select Checkbox    ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}
            END
        END
        Click Element    ${dropdown.design.testcase.route_for_approval.select_tc}
    END
    IF    'Comments' in ${testcase_data}    Enter Comments/Description    txtComments    ${testcase_data}[Comments]
    IF    'Button' in ${testcase_data}    Select Submit/Reset Button    ${testcase_data}[Button]
    IF    'eSign' in ${testcase_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    has been sent for Approval
    RETURN    ${EXPECTED_MESSAGE}

Approve Test Case
    [Arguments]    ${testcase_data}    ${entity}    ${version}    ${tc_name}    ${approve_tcs}    ${user_name}    ${password}
    [Documentation]    This keyword is used to Approve Test Case
    Select Entity In Design Manager    ${entity}    ${version}
    IF    'Value' in ${testcase_data}
        ${link.design.testcase.newtask_id}    Update Dynamic Value    ${link.design.testcase.task_id}    ${testcase_data}[Value]
        Wait Until Element Is Visible    ${link.design.testcase.newtask_id}    ${MEDIUM_WAIT}    Task is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    2
        Click Element    ${link.design.testcase.newtask_id}
    END
    IF    'TestCase' in ${testcase_data}    Select Value From Dropdown    DdlTestCase    ${tc_name}
    Wait Until Element Is Visible    ${label.design.testcase.task_id.tc_table.canvas}    ${MEDIUM_WAIT}    Test Case Canvas Table is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'Action' in ${testcase_data}    Select Option From Action Dropdown    ${testcase_data}[Action]
    IF    'SelectTestCase' in ${testcase_data}
        Wait Until Time    2
        Wait Until Element Is Visible    ${dropdown.design.testcase.route_for_approval.select_tc}    ${MEDIUM_WAIT}    Select TestCase is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${dropdown.design.testcase.route_for_approval.select_tc}
        IF    '${testcase_data}[SelectTestCase]'=='SelectAll'
            Wait Until Time    2
            Wait Until Element Is Visible    ${link.design.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    ${link.design.select_all}
        ELSE IF    '${testcase_data}[SelectTestCase]'!='SelectAll'
            @{tc_list}    Split String    ${approve_tcs}    ,
            FOR    ${key}    IN    @{tc_list}
                ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}    Update Dynamic Value    ${checkbox.design.testcase.route_for_approval.select_tc.tc_name}    ${key}
                Wait Until Element Is Visible    ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}    ${MEDIUM_WAIT}    TestCase is not visible after waiting for ${MEDIUM_WAIT} seconds
                Select Checkbox    ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}
            END
        END
        Click Element    ${dropdown.design.testcase.route_for_approval.select_tc}
    END
    IF    'Comments' in ${testcase_data}    Enter Comments/Description    txtComments    ${testcase_data}[Comments]
    IF    'Button' in ${testcase_data}    Select Submit/Reset Button    ${testcase_data}[Button]
    IF    'eSign' in ${testcase_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    has been approved
    RETURN    ${EXPECTED_MESSAGE}

Navigate To Assign Execution Task Page
    [Arguments]    ${entity}    ${version}
    [Documentation]    This keyword will select entity and navigate to Assign Execution Task Page
    Navigate To Module Tab In Design Manager    Design    Test lab
    Select Entity In Design Manager    ${entity}    ${version}
    Click Button In VLMS    Initiate

Initiate Execution Task
    [Arguments]    ${testlab_data}
    [Documentation]    This keyword is used to Initiate Execution Task
    Wait Until Element Is Visible    ${label.design.testlab.initiate.assign_task_header}    ${MEDIUM_WAIT}    Assign Execution Task Page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'ReleasePlan' in ${testlab_data}    Select Value From Dropdown    ddlReleasePlan    ${testlab_data}[ReleasePlan]
    IF    'Sprint' in ${testlab_data}    Select Value From Dropdown    ddlSprint    ${testlab_data}[Sprint]
    IF    'TypeOfTesting' in ${testlab_data}    Select Value From Dropdown    ddlContent-container    ${testlab_data}[TypeOfTesting]
    IF    'ContentType' in ${testlab_data}    Select Value From Dropdown    ddlContentType   ${testlab_data}[ContentType]
    IF    'Title' in ${testlab_data}    Enter Text In Mandatory Fields    Title    ${testlab_data}[Title]
    IF    'Description' in ${testlab_data}    Enter Comments/Description    txtDescription    ${testlab_data}[Description]
    IF    'TargetDate' in ${testlab_data}
        Click Calendar Icon In Vlms    ${icon.design.create_release_plan.estimated_start_date.calendar}
        Select Target Date    ${testlab_data}[TargetDate]    txtEstimatedStartDate    txtEstimatedStartDate_DrpPnl_Calendar1_506    txtEstimatedStartDate_DrpPnl_Calendar1_504    ${testlab_data}[Year]    ${testlab_data}[Month]    ${testlab_data}[Date]
    END
    IF    'Assignment' in ${testlab_data}    Select Value For Radio Button    AssignType    ${testlab_data}[Assignment]
    IF    'AssignTo' in ${testlab_data}    Select Value From Dropdown     ddAssignTo    ${testlab_data}[AssignTo]
    IF    'Groups' in ${testlab_data}    Select Multiple Values From A Dropdown List    ddlUserGroups    ${testlab_data}[Groups]
    IF    'Reviewers' in ${testlab_data}    Select Multiple Values From A Dropdown List    ddlReviewers    ${testlab_data}[Reviewers]
    IF    'ReviewerUsers' in ${testlab_data}    Select Multiple Values From A Dropdown List    ddlRevUsers    ${testlab_data}[ReviewerUsers]
    IF    'Approvers' in ${testlab_data}    Select Multiple Values From A Dropdown List    ddlApprovers    ${testlab_data}[Approvers]
    IF    'ApproverUsers' in ${testlab_data}    Select Multiple Values From A Dropdown List    ddlAppUsers    ${testlab_data}[ApproverUsers]
    IF    'Comments' in ${testlab_data}    Enter Comments/Description    txtComments    ${testlab_data}[Comments]
    IF    'Button' in ${testlab_data}    Select Submit/Reset Button    ${testlab_data}[Button]
    ${header_text}    Get Text    ${label.design.testlab.initiate.assign_task_header}
    ${EXECUTION_TASK_ID}    Remove String    ${header_text}    Assign Execution Task -    ${SPACE}
    Set Suite Variable    ${EXECUTION_TASK_ID}
    ${EXPECTED_MESSAGE}    Set Variable    Execution Task ${EXECUTION_TASK_ID} has been initiated
    RETURN    ${EXPECTED_MESSAGE}

Route Test Execution For Approval
    [Arguments]    ${route_testlab_data}    ${task_id}    ${tc_name}    ${route_tcs}    ${user_name}    ${password}
    [Documentation]    This keyword is used to Route Test Execution For Approval
    IF    'TaskID' in ${route_testlab_data}    Select Task Based On ID    ${task_id}
    IF    'TestCase' in ${route_testlab_data}    Select Value From Dropdown    DdlTestCase    ${tc_name}
    IF    'CanvasDetails' in ${route_testlab_data}    Enter Details In Test Lab Canvas Table    ${route_testlab_data}
    IF    'Action' in ${route_testlab_data}    Select Option From Action Dropdown    ${route_testlab_data}[Action]
    IF    'SelectTestCase' in ${route_testlab_data}
        Wait Until Time    2
        Wait Until Element Is Visible    ${dropdown.design.testcase.route_for_approval.select_tc}    ${MEDIUM_WAIT}    Select TestCase is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${dropdown.design.testcase.route_for_approval.select_tc}
        IF    '${route_testlab_data}[SelectTestCase]'=='SelectAll'
            Wait Until Time    2
            Wait Until Element Is Visible    ${link.design.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    ${link.design.select_all}
        ELSE IF    '${route_testlab_data}[SelectTestCase]'!='SelectAll'
            @{tc_list}    Split String    ${route_tcs}    ,
            FOR    ${key}    IN    @{tc_list}
                ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}    Update Dynamic Value    ${checkbox.design.testcase.route_for_approval.select_tc.tc_name}    ${key}
                Wait Until Element Is Visible    ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}    ${MEDIUM_WAIT}    TestCase is not visible after waiting for ${MEDIUM_WAIT} seconds
                Select Checkbox    ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}
            END
        END
        Click Element    ${dropdown.design.testcase.route_for_approval.select_tc}
    END
    IF    'Comments' in ${route_testlab_data}    Enter Comments/Description    txtComments    ${route_testlab_data}[Comments]
    IF    'Button' in ${route_testlab_data}    Select Submit/Reset Button    ${route_testlab_data}[Button]
    IF    'eSign' in ${route_testlab_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    Test Lab Selected test execution has been sent for Approval
    RETURN    ${EXPECTED_MESSAGE}

Enter Details In Test Lab Canvas Table
    [Arguments]    ${route_testlab_data}
    [Documentation]    This keyword is used to Enter Details in Test Lab Canvas Table
    Wait Until Element Is Visible    ${label.design.testlab.task_id.table.canvas}    ${MEDIUM_WAIT}    Test lab Canvas Table is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    @{row_details}    Split String    ${route_testlab_data}[CanvasDetails]    |
    FOR    ${key}    IN    @{row_details}
        Wait Until Element Is Visible    ${label.design.testlab.task_id.table.canvas}    ${MEDIUM_WAIT}    Test lab Canvas Table is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    2
        @{details}    Split String    ${key}    ,
        ${actual_result}    Set Variable    ${details}[0]
        ${test_result}    Set Variable    ${details}[1]
        IF    "${actual_result}"!="None"
            Enter Actual Result    ${label.design.testlab.task_id.table.canvas}    ${actual_result}
            Wait Until Time    2
        END
        IF    "${test_result}"!="None"
            Select Test Result    ${label.design.testlab.task_id.table.canvas}
            Wait Until Time    2
            Click Element    ${dropdown.design.testlab.task_id.canvas_table.result}
            ${dropdown.design.testlab.task_id.canvas_table.test_result.newvalue}    Update Dynamic Value    ${dropdown.design.testlab.task_id.canvas_table.test_result.value}    ${test_result}
            Wait Until Element Is Visible    ${dropdown.design.testlab.task_id.canvas_table.test_result.newvalue}    ${MEDIUM_WAIT}    ${test_result} is not visible after waiting for ${MEDIUM_WAIT} seconds
            Wait Until Time    1
            Click Element    ${dropdown.design.testlab.task_id.canvas_table.test_result.newvalue}
            Wait Until Time    2
        END
        Move To Next Row    ${label.design.testlab.task_id.table.canvas}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Approve Test Execution
    # robocop: disable=too-many-arguments
    [Arguments]    ${approve_testlab_data}    ${entity}    ${version}    ${task_id}    ${tc_name}    ${approve_tcs}    ${user_name}    ${password}
    [Documentation]    This keyword is used to Approve Test Execution
    Select Entity In Design Manager    ${entity}    ${version}
    IF    'Value' in ${approve_testlab_data}
        ${link.design.testlab.newtask_id}    Update Dynamic Values    ${link.design.testlab.task_id}   ${approve_testlab_data}[Value]    ${task_id}
        Wait Until Element Is Visible    ${link.design.testlab.newtask_id}    ${MEDIUM_WAIT}    Task is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    3
        Click Element    ${link.design.testlab.newtask_id}
    END
    IF    'TestCase' in ${approve_testlab_data}    Select Value From Dropdown    DdlTestCase    ${tc_name}
    IF    'Action' in ${approve_testlab_data}    Select Option From Action Dropdown    ${approve_testlab_data}[Action]
    IF    'SelectTestCase' in ${approve_testlab_data}
        Wait Until Time    2
        Wait Until Element Is Visible    ${dropdown.design.testcase.route_for_approval.select_tc}    ${MEDIUM_WAIT}    Select TestCase is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${dropdown.design.testcase.route_for_approval.select_tc}
        IF    '${approve_testlab_data}[SelectTestCase]'=='SelectAll'
            Wait Until Time    2
            Wait Until Element Is Visible    ${link.design.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    ${link.design.select_all}
        ELSE IF    '${approve_testlab_data}[SelectTestCase]'!='SelectAll'
            @{tc_list}    Split String    ${approve_tcs}    ,
            FOR    ${key}    IN    @{tc_list}
                ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}    Update Dynamic Value    ${checkbox.design.testcase.route_for_approval.select_tc.tc_name}    ${key}
                Wait Until Element Is Visible    ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}    ${MEDIUM_WAIT}    TestCase is not visible after waiting for ${MEDIUM_WAIT} seconds
                Select Checkbox    ${checkbox.design.testcase.route_for_approval.select_tc.newtc_name}
            END
        END
        Click Element    ${dropdown.design.testcase.route_for_approval.select_tc}
    END
    IF    'Comments' in ${approve_testlab_data}    Enter Comments/Description    txtComments    ${approve_testlab_data}[Comments]
    IF    'Button' in ${approve_testlab_data}    Select Submit/Reset Button    ${approve_testlab_data}[Button]
    IF    'eSign' in ${approve_testlab_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    Test Lab Selected test execution has been approved
    RETURN    ${EXPECTED_MESSAGE}

Create Actual Task
    [Arguments]    ${actual_task_data}    ${feature_req_id}
    [Documentation]    This keyword is used to Create Actual Task
    Wait Until Element Is Visible    ${label.design.release_plan.manage_task.create_edit.screen}    ${MEDIUM_WAIT}    Create Task is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'FeatureRequest' in ${actual_task_data}    Select Value From Dropdown    ddlFeatureRequest    ${feature_req_id}
    Wait Until Element Is Visible    ${textbox.design.release_plan.create_task.estimated_hours}    ${MEDIUM_WAIT}    Estimated Hours is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'EstimatedTaskID' in ${actual_task_data}
        ${task_id}    Set Variable    ${feature_req_id} - ${actual_task_data}[Index]
        Select Task Based On ID    ${task_id}
        Wait Until Time    3
    END
    Scroll Element Into View    ${dropdown.design.release_plan.create_task.feature_req}
    Wait Until Time    2
    IF    'Tab' in ${actual_task_data}
        ${link.design.release_plan.manage_task.newtab}    Update Dynamic Value    ${link.design.release_plan.manage_task.tab}    ${actual_task_data}[Tab]
        Click Element    ${link.design.release_plan.manage_task.newtab}
    END
    IF    'ActualTaskID' in ${actual_task_data}
        ${actual_task_id}    Set Variable    ${feature_req_id} - ${actual_task_data}[Index]
        Select Value From Dropdown    ddlActualTaskID    ${actual_task_id}
        Wait Until Time    2
    END
    IF    'Actuals' in ${actual_task_data}    Enter Text In Mandatory Fields    Actual    ${actual_task_data}[Actuals]
    IF    'ActualTargetDate' in ${actual_task_data}
        Click Calendar Icon In Vlms    ${icon.design.release_plan.manage_task.create_actual_task.calendar}
        Select Target Date    ${actual_task_data}[ActualTargetDate]    txtTaskStartDate    txtTaskStartDate_DrpPnl_Calendar1_506    txtTaskStartDate_DrpPnl_Calendar1_504    ${actual_task_data}[ActualYear]    ${actual_task_data}[ActualMonth]    ${actual_task_data}[ActualDate]
    END
    IF    'Responsibility' in ${actual_task_data}    Select Value From Dropdown     ddlActualResponsibility    ${actual_task_data}[Responsibility]
    IF    'AssignTo' in ${actual_task_data}    Select Value From Dropdown     ddlActualAssignTo    ${actual_task_data}[AssignTo]
    IF    'Status' in ${actual_task_data}    Select Value From Dropdown     ddlActualStatus    ${actual_task_data}[Status]
    IF    'Button' in ${actual_task_data}    Select Submit/Reset Button    ${actual_task_data}[Button]

Navigate To Manage Release Page
    [Arguments]    ${entity}    ${version}    ${task_id}
    [Documentation]    This keyword will select entity and navigate to Manage Release Page
    Navigate To Module Tab In Design Manager    Design    Release Plan
    Select Entity In Design Manager    ${entity}    ${version}
    Select Task Based On ID    ${task_id}

Route Release Plan For Approval
    [Arguments]    ${release_plan_data}    ${rel_plan_id}    ${user_name}    ${password}
    [Documentation]    This keyword is used to Route Release Plan For Approval
    Wait Until Element Is Visible    ${label.design.release_plan.manage_release_page}    ${MEDIUM_WAIT}    Manage Release Page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'ReleaseCheckbox' in ${release_plan_data}
        Scroll Till Element Is Visible    ${checkbox.design.release_plan.manage_release.checkbox}
        Wait Until Time    2
        Select Checkbox    ${checkbox.design.release_plan.manage_release.checkbox}
    END
    ${rel_plan_name}    Get Element Attribute    ${label.design.release_plan.approve_release.name}    value
    IF    'WorkFlow' in ${release_plan_data}    Select Value From Dropdown    ddlWorkFlow-container    ${release_plan_data}[WorkFlow]
    Wait Until Time    2
    IF    'RouteTaskFor' in ${release_plan_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${release_plan_data}[RouteTaskFor]
    IF    'Button' in ${release_plan_data}    Select Submit/Reset Button    ${release_plan_data}[Button]
    IF    'eSign' in ${release_plan_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    ${rel_plan_name} Manage Release ${rel_plan_id} has been routed for approval
    RETURN    ${EXPECTED_MESSAGE}

Navigate To Approve Manage Release Page
    [Arguments]    ${entity}    ${version}    ${rel_plan_id}
    [Documentation]    This keyword will select entity and navigate to Approve Manage Release Page
    Navigate To Module Tab In Design Manager    Design    Release Plan
    Select Entity In Design Manager    ${entity}    ${version}
    ${link.design.release_plan.newselect_plan}    Update Dynamic Values    ${link.design.release_plan.select_plan}   Post Pending Approve    ${rel_plan_id}
    Wait Until Element Is Visible    ${link.design.release_plan.newselect_plan}   ${MEDIUM_WAIT}    Release Plan is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Click Element    ${link.design.release_plan.newselect_plan}

Approve Release Plan
    [Arguments]    ${approve_plan_data}    ${user_name}    ${password}
    [Documentation]    This keyword is used to Approve Release Plan
    Wait Until Element Is Visible    ${label.design.release_plan.approve_manage_release_page}    ${MEDIUM_WAIT}    Approve Manage Release Page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'AcceptButton' in ${approve_plan_data}    Click Accept Button And Accept The Popup    ${approve_plan_data}[ExpectedMessage]
    IF    'Transfer' in ${approve_plan_data}    Select Value For Radio Button    rbtntransfer    ${approve_plan_data}[Transfer]
    IF    '${approve_plan_data}[Transfer]'=='rbtnTransferYes'
        IF    'TransferTo' in ${approve_plan_data}    Select Value From Dropdown    ddlTransferto    ${approve_plan_data}[TransferTo]
    END
    IF    'Approve' in ${approve_plan_data}    Select Value For Radio Button    ReviewReq    ${approve_plan_data}[Approve]
    IF    'Comments' in ${approve_plan_data}    Enter Comments/Description    txtComments    ${approve_plan_data}[Comments]
    ${rel_plan_name}    Get Element Attribute    ${label.design.release_plan.approve_release.name}    value
    IF    'Button' in ${approve_plan_data}    Select Submit/Reset Button    ${approve_plan_data}[Button]
    IF    'eSign' in ${approve_plan_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${EXPECTED_MESSAGE}    Set Variable    ${rel_plan_name} Release Plan has been approved
    RETURN    ${EXPECTED_MESSAGE}


Enter The Details To Create And Submit A New Epic
    [Arguments]    ${epic_data}    ${User}    ${USER_PASSWORD}
    [Documentation]    This is to enter the details to create the department
    Wait Until Element Is Visible    txtSearchEntity_B-1    ${SHORT_WAIT}
    Select Value From Dropdown For Epic   txtSearchEntity_B-1    ${epic_data}[Entity]
    Wait Until Element Is Visible    txtepic    ${SHORT_WAIT}
    Enter Text In Mandatory Fields    epic    ${epic_data}[EpicName]
    Select Submit/Reset Button    ${epic_data}[Button]
    Handle Electronic Sign    ${User}    ${USER_PASSWORD}    Submit    ${epic_data}[Reason]

Create DM ID Configuration
    [Documentation]    This keyword is sused to create Retirement
    [Arguments]    ${dmIDconfig}    ${USER}    ${USER_PASSWORD}
    ${count}    Get Length    ${dmIDconfig}
    FOR    ${key}    IN RANGE    0    ${count}
        ${dmIDconfig_data}    Set Variable    ${dmIDconfig}[${key}]
        Click Button In VLMS    Create
        #Navigate To Page Title Tab    ${dmIDconfig_data}[PageTitle]
        Wait Until Element Is Visible    ${textbox.system.create.DMuniqueID.ConetntIDName}
        IF    'ContentIDName' in ${dmIDconfig_data}    Enter Text In Mandatory Fields    reqname    ${dmIDconfig_data}[ContentIDName]
        IF    'SelectedTags' in ${dmIDconfig_data}    Select Value From Dropdown    lstreqleft_chosen    ${dmIDconfig_data}[SelectedTags]
        IF    'Separator' in ${dmIDconfig_data}    Select Value From Dropdown    ddlreqseperator_chosen    ${dmIDconfig_data}[Separator]
        Wait Until Time    4
        IF    'SerialNo.length' in ${dmIDconfig_data}    Select Value From Dropdown    ddlreqSerialNoLength_chosen    ${dmIDconfig_data}[SerialNo.length]
        Wait Until Time    4
        Select Submit/Reset Button    reqSubmit
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        ${expected_result}    Set Variable    Content ID has been configured successfully
        Get Value From Toast Message    ${ExpectedResult}
        
    END

Create Calender
    [Documentation]    This is used to create calender
    [Arguments]    ${calender}    ${USER}    ${USER_PASSWORD}
    ${count}    Get Length    ${calender}
    FOR    ${key}    IN RANGE    0    ${count}
        ${calender_data}    Set Variable    ${calender}[${key}]
        Click Button In VLMS    Create
        Wait Until Element Is Visible    ${label.calender}    ${MEDIUM_WAIT}    calender is not visible even after waiting for ${SHORT_WAIT} sec
        ${calenderid}    Get Text    ${label.calender.id}
        IF    'Calender_Name' in ${calender_data}    Enter Text In Mandatory Fields    CalendarName    ${calender_data}[Calender_Name]
        IF    'Week starts on' in ${calender_data}    Select Value From Dropdown    ddlWeekStartsOn_chosen    ${calender_data}[Week starts on]
        IF    'Fiscal Ends on' in ${calender_data}    Select Value From Dropdown    ddlFiscalYearStartsOn_chosen    ${calender_data}[Fiscal Ends on]
        Wait Until Element Is Visible   ${textbox.system.create.calendar.starttime}
        Click Element    ${textbox.system.create.calendar.starttime}
        IF    'Default Time' in ${calender_data}    Enter Text In Mandatory Fields    DefaultStartTime_I    ${calender_data}[Default Time]
        Wait Until Time    4
        #Press Key    ${textbox.system.create.calendar.endtime}    ENTER
        #Wait Until Element Is Visible   ${textbox.system.create.calendar.endtime}
        Click Element    ${textbox.system.create.calendar.calendarname}
        IF    'DefaultEndTime' in ${calender_data}    Enter Text In Mandatory Fields    DefaultEndTime_I    ${calender_data}[DefaultEndTime]
        Select Calendar Checkboxes    ${calender_data}
        Wait Until Time    3
        IF    'HolidayDescription' in ${calender_data}
            Enter Text In Mandatory Fields    HolidayDesc    ${calender_data}[HolidayDescription]
            Scroll To Element    ${label.calender.schedule.date}
            Click Calendar    ${label.calender.schedule.date}
            Wait Until Time    5
            Select Target Date    ${calender_data}[TargetDateType]    datePickerForHoliday    datePickerForHoliday_DrpPnl_Calendar1_506    datePickerForHoliday_DrpPnl_Calendar1_504    ${calender_data}[Year]    ${calender_data}[Month]    ${calender_data}[Date]
            Wait Until Time    5
            Click Button In VLMS    Save
        END
        IF    'Approval' in ${calender_data}    Select Value For Radio Button    Approval    ${calender_data}[Approval]
        Select Submit/Reset Button    Submit
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        ${Expected_Result}    Set Variable    ${calender_data}[Calender_Name] Calendar ${calenderid} has been created
        Get Value From Toast Message    ${Expected_Result}
    END
Create User Story Estimation
    [Arguments]    ${user_story_estimation}    ${USER_STORY}    ${USER_STORY_PASSWORD}
    [Documentation]    This is to enter the details to create A New User Story Estimation
    ${count}    Get Length    ${user_story_estimation}
    FOR    ${key}    IN RANGE    0    ${count}
        ${user_story_estimation_data}    Set Variable    ${user_story_estimation}[${key}]
        Wait Until Element Is Visible    txtFrom    ${MEDIUM_WAIT}
        Enter Text In Mandatory Header Fields   txtFrom    ${user_story_estimation_data}[From]
        Wait Until Element Is Visible    txtTo    ${SHORT_WAIT}
        Enter Text In Mandatory Header Fields   txtTo    ${user_story_estimation_data}[To]
        Click Button In VLMS    Submit
        Handle Electronic Sign    ${USER_STORY}    ${USER_STORY_PASSWORD}    Submit
        ${Expected_Result}    Set Variable    User Point estimation has been created    
        Get Value From Toast Message    ${Expected_Result}
        Wait Until Time    5
        Navigate To Page Title Tab    ${user_story_estimation_data}[PageTitle]
        ${split_BasedOn}    Split String    ${user_story_estimation_data}[BasedOn]    ,
        ${split_EstimationFor}    Split String    ${user_story_estimation_data}[EstimationFor]    ,
        ${count}    Get Length    ${split_BasedOn}
        FOR    ${key}    IN RANGE    0    ${count}
            Click Button In VLMS    Create
            Select Value From Dropdown    ddlEstimationType_chosen    ${split_BasedOn}[${key}]
            Wait Until Time    3
            Enter Text In Mandatory Header Fields    txtEstimationFor    ${split_EstimationFor}[${key}]
            Wait Until Time    3
            Click Button In VLMS    Submit
            #Handle Electronic Sign    ${USER_STORY}    ${USER_STORY_PASSWORD}    Submit
            ${Expected_Result}    Set Variable    Task Estimation Test has been created
            Get Value From Toast Message    ${Expected_Result}
        END
    END
