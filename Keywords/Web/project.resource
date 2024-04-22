*** Settings ***
Documentation     This project resource file has all the project menu keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Navigate To Define Project Screen
    [Documentation]    This keyword is used to navigate to the Define Project screen
    Navigate To Module Tab    Project    Create    Project    Select Project
    Click Button In VLMS    Create Project
    Wait Until Element Is Visible    ${label.project.create.project_id}    ${MEDIUM_WAIT}    Define Project screen is not visible after waiting for ${MEDIUM_WAIT} seconds

Enter Prerequisite Details In Define Project Screen
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to enter prerequisite details in Define Project screen
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.project.create.project_name}    ${MEDIUM_WAIT}    Project textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'ProjectName' in ${project_data}    Input Text    ${textbox.project.create.project_name}    ${project_data}[ProjectName]
    ${PROJECT_NAME}    Set Variable    ${project_data}[ProjectName]
    Set Suite Variable    ${PROJECT_NAME}
    Select Frame    ${iframe.project.create.project_desc}
    IF    'ProjectDescription' in ${project_data}    Input Text    ${textbox.project.create.define.form_field.ta1}   ${project_data}[ProjectDescription]
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    IF    'ProjectForm' in ${project_data}    Select Value From Dropdown    ddlProjectTemplate        ${project_data}[ProjectForm]
    Wait Until Time    3

Verify Form Fields Under Project Description
    [Documentation]    This keyword is used to Verify all form fields under project description
    Wait Until Time    2
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.project.create.form_field.project_description}    ${MEDIUM_WAIT}    Project Description is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.project.create.form_field.tb1}    ${MEDIUM_WAIT}    Form field TB1 is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.project.create.form_field.ta1}    ${MEDIUM_WAIT}    Form field TA1 is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.project.create.form_field.cb1}    ${MEDIUM_WAIT}    Form field CB1 is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.project.create.form_field.dd1}    ${MEDIUM_WAIT}    Form field DD1 is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.project.create.form_field.rb1}    ${MEDIUM_WAIT}    Form field RB1 is not visible after waiting for ${MEDIUM_WAIT} seconds
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.project.create.form_field.date}    ${MEDIUM_WAIT}    Form field calendar is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Enter Project Form Field Details
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to enter all form fields in Define Project screen
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.project.create.define.form_field.tb1}    ${MEDIUM_WAIT}    Textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'TB1' in ${project_data}    Input Text    ${textbox.project.create.define.form_field.tb1}    ${project_data}[TB1]
    Select Frame    ${iframe.project.create.define.form_field}
    IF    'TA1' in ${project_data}    Input Text    ${textbox.project.create.define.form_field.ta1}    ${project_data}[TA1]
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    IF    'CB1' in ${project_data}
        ${checkbox.project.create.project.form_details.newcheckbox}    Update Dynamic Value    ${checkbox.project.create.define.form_details.checkbox}    ${project_data}[CB1]
        Click Element    ${checkbox.project.create.project.form_details.newcheckbox}
    END
    IF    'DD1' in ${project_data}    Select Value From Dropdown    ddlListLeft-container    ${project_data}[DD1]
    IF    'RB1' in ${project_data}    Select Value For Radio Button    radio    ${project_data}[RB1]
    Click Calendar Icon In Vlms    ${label.project.create.form_details.calender}
    Select Today Date From Calendar    txtBoxTargetDate

Get Entity Selection Page Count
    [Documentation]    This keyword is used to get page count of the entity selection grid
    Wait Until Time    2
    ${page_count}    Get Text    ${label.project.create.entity.page_count}
    ${splited_page_count}    Split String    ${page_count}
    ${TOTAL_PAGE_COUNT}    Set Variable    ${splited_page_count}[3]
    RETURN    ${TOTAL_PAGE_COUNT}

Select Entity Checkbox
    [Arguments]    ${entity}
    [Documentation]    This keyword is used to select entity from entity in selected entity
    ${checkbox.project.create.project.newentity}    Update Dynamic Value    ${checkbox.project.create.define.entity}    ${entity}
    Wait Until Time    2
    Wait Until Element Is Visible    ${checkbox.project.create.project.newentity}    ${MEDIUM_WAIT}    ${entity} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${checkbox.project.create.project.newentity}

Verify Selected Entities
    [Arguments]    ${entity}
    [Documentation]    This keyword is used to Verify selected entities from entity selection in Define Project Screen
    ${splitted_entities}    Split String    ${entity}    ,
    ${entity_count}    Get Length    ${splitted_entities}
    Wait Until Time    ${SHORT_WAIT}
    FOR    ${entity_key}    IN RANGE    0    ${entity_count}
        ${label.project.create.project.newselected_entity}    Update Dynamic Value    ${label.project.create.define.selected_entity}    ${splitted_entities}[${entity_key}]
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.project.create.project.newselected_entity}    ${MEDIUM_WAIT}    ${splitted_entities}[${entity_key}] is not visible after waiting for ${MEDIUM_WAIT} seconds
        Run Keyword And Continue On Failure    Scroll Element Into View    ${label.project.create.project.newselected_entity}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Enter Details In Define Project Screen
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to enter all details in Define Project Screen
    Enter Prerequisite Details In Define Project Screen    ${project_data}
    Verify Form Fields Under Project Description
    Enter Project Form Field Details    ${project_data}
    Select Entity/Entity Type Using Filter    ${project_data}[Entities]

Get Project ID
    [Documentation]    This keyword is used to get project id
    Wait Until Element Is Visible    ${textbox.project.create.project_id}    ${MEDIUM_WAIT}    Project id textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${atcual_project_id}    Get Element Attribute    ${textbox.project.create.project_id}    Value
    ${PROJECT_ID}    Set Variable    ${atcual_project_id}
    Set Suite Variable    ${PROJECT_ID}
    RETURN    ${PROJECT_ID}

Verify Project ID
    [Documentation]    This keyword is used to Verify project id field is not editable and the same ID displayed in the screen title.
    ${PROJECT_ID}    Get Project ID
    ${project_input_status}    Run Keyword And Return Status    Input Text    ${textbox.project.create.project_id}    ${textbox.assessment.framework.description}
    IF    '${project_input_status}'=='True'    Run Keyword And Continue On Failure    Fail And Take Screenshot    Project Id text field is editable
    ${actual_project_title_id}    Get Text    ${label.project.create.project_id}
    ${splitted_project_title_id}    Split String    ${actual_project_title_id}
    ${project_screen_title}    Remove String    ${splitted_project_title_id}[0]    <    >
    ${PROJECT_TITLE_ID}    Set Variable    ${project_screen_title}
    Set Suite Variable    ${PROJECT_TITLE_ID}
    Verify String Should Be Equal    ${PROJECT_TITLE_ID}    ${PROJECT_ID}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Navigate To Project Deliverables Screen
    [Documentation]    This keyword is used to navigate to Project Deliverables screen
    Click Element    ${button.project.create.define.next}
    Wait Until Element Is Visible    ${label.project.create.deliverables.step_two}    ${MEDIUM_WAIT}    Step two label is not visible after waiting for ${MEDIUM_WAIT} seconds

Get Required Deliverables
    [Documentation]    This keyword is used to get required deliverables added to entities
    ${ACTUAL_REQUIRED_DELIVERABLES}    Create List
    ${required_deliverables_count}    Get Element Count    ${label.project.create.deliverables.required_deliverables}
    FOR    ${key}    IN RANGE    1    ${required_deliverables_count}+1
        ${required_deliverables}    Get Text    (${label.project.create.deliverables.required_deliverables})[${key}]
        Append To List    ${ACTUAL_REQUIRED_DELIVERABLES}    ${required_deliverables}
    END
    ${ACTUAL_REQUIRED_DELIVERABLES}    Remove Duplicates    ${ACTUAL_REQUIRED_DELIVERABLES}
    RETURN    ${ACTUAL_REQUIRED_DELIVERABLES}

Get Deliverables
    [Arguments]    ${deliverables}
    [Documentation]    This keyword is used to get deliverables from test data for multiple entities with multiple deliverables
    ${DATA_DELIVERABLES_TYPES}    Create List
    ${multiple_deliverables_types}    Split String    ${deliverables}    |
    ${multiple_deliverables_types_count}    Get Length    ${multiple_deliverables_types}
    FOR    ${key}    IN RANGE    0    ${multiple_deliverables_types_count}
        ${deliverables_types}    Set Variable    ${multiple_deliverables_types}[${key}]
        ${splitted_data_delivarables}    Split String    ${deliverables_types}    ,
        ${splitted_data_delivarables_count}    Get Length    ${splitted_data_delivarables}
        FOR    ${count}    IN RANGE    0    ${splitted_data_delivarables_count}
            Append To List    ${DATA_DELIVERABLES_TYPES}    ${splitted_data_delivarables}[${count}]
        END
    END
    ${DATA_DELIVERABLES_TYPES}    Remove Duplicates    ${DATA_DELIVERABLES_TYPES}
    RETURN    ${DATA_DELIVERABLES_TYPES}

Select Additional Deliverables For Entities
    [Arguments]    ${entity}    ${deliverables}
    [Documentation]    This keyword is used to select additional deliverables for different entities
    ${splitted_entities}    Split String    ${entity}    ,
    ${splitted_entities_count}    Get Length    ${splitted_entities}
    ${entities_deliverables_types}    Split String    ${deliverables}    |
    FOR    ${entities_count}    IN RANGE    0    ${splitted_entities_count}
            ${entity_deliverables_types}    Set Variable    ${entities_deliverables_types}[${entities_count}]
            ${splitted_deliverables_types}    Split String    ${entity_deliverables_types}    ,
            ${splitted_deliverables_types_count}    Get Length    ${splitted_deliverables_types}
            FOR    ${deliverables_types_count}    IN RANGE    0    ${splitted_deliverables_types_count}
                ${checkbox.project.create.project.newadditional_deliverables}    Update Dynamic Values    ${checkbox.project.create.deliverables.additional_deliverables}    ${splitted_entities}[${entities_count}]    ${splitted_deliverables_types}[${deliverables_types_count}]
                Select Checkbox    ${checkbox.project.create.project.newadditional_deliverables}
            END
    END

Verify Additional Deliverables Added For Entities
    [Arguments]    ${entity}    ${deliverables}
    [Documentation]    This keyword is used to select deliverables for different entities
    ${splitted_entities}    Split String    ${entity}    ,
    ${entities_deliverables_types}    Split String    ${deliverables}    |
    ${splitted_entities_count}    Get Length    ${splitted_entities}
    FOR    ${entities_count}    IN RANGE    0    ${splitted_entities_count}
        ${entity_deliverables_types}    Set Variable    ${entities_deliverables_types}[${entities_count}]
        ${splitted_deliverables_types}    Split String    ${entity_deliverables_types}    ,
        ${splitted_deliverables_types_count}    Get Length    ${splitted_deliverables_types}
        FOR    ${deliverables_types_count}    IN RANGE    0    ${splitted_deliverables_types_count}
            ${updated_splitted_entities}    Split String    ${splitted_entities}[${entities_count}]    *
            ${label.project.create.project.newadditional_deliverables}    Update Dynamic Values    ${label.project.create.deliverables.additional_deliverables}    ${updated_splitted_entities}[0]    ${splitted_deliverables_types}[${deliverables_types_count}]
            Wait Until Element Is Visible    ${label.project.create.project.newadditional_deliverables}    ${MEDIUM_WAIT}    ${splitted_deliverables_types}[${deliverables_types_count}] is not visible after waiting for ${MEDIUM_WAIT} seconds
        END
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Enter Phase Names
    [Arguments]    ${phase_name}
    [Documentation]    This keyword is used to enter phase name details
    Wait Until Time    3
    ${splitted_phase_names}    Split String    ${phase_name}    ,
    ${phase_names_count}    Get Length    ${splitted_phase_names}
    FOR    ${key}    IN RANGE    0    ${phase_names_count}
        ${updated_key}    Evaluate    ${key}+2
        ${label.project.create.project.deliverables.newphase}    Update Dynamic Value    ${label.project.create.deliverables.phase}    ${updated_key}
        Input Text    ${label.project.create.project.deliverables.newphase}    ${splitted_phase_names}[${key}]
    END

Select And Enter Phase Details In Project Deliverables
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to select no of phases and enter phase names if phase name is required in project deliverables page
    IF    'NoOfPhases' in ${project_data}    Select Value From Dropdown    drPhases    ${project_data}[NoOfPhases]
    IF    '${project_data}[PhaseNameRequired]'=='Yes'
        Wait Until Time    2
        Wait Until Element Is Visible    ${radiobutton.project.create.deliverables.phase_name_required}    ${MEDIUM_WAIT}    Phase name required radio button is not visible after waiting for ${MEDIUM_WAIT} seconds
        ${radiobutton.project.create.project.newphase_name}    Update Dynamic Value    ${radiobutton.project.create.deliverables.phase_name}    ${project_data}[PhaseNameRequired]
        Click Element    ${radiobutton.project.create.project.newphase_name}
        Enter Phase Names    ${project_data}[PhaseNames]
    ELSE IF    '${project_data}[PhaseNameRequired]'=='No'
        Wait Until Time    2
        Wait Until Element Is Visible    ${radiobutton.project.create.deliverables.phase_name_required}    ${MEDIUM_WAIT}    Phase name required radio button is not visible after waiting for ${MEDIUM_WAIT} seconds
        ${radiobutton.project.create.project.newphase_name}    Update Dynamic Value    ${radiobutton.project.create.deliverables.phase_name}    ${project_data}[PhaseNameRequired]
        Click Element    ${radiobutton.project.create.project.newphase_name}
    END

Enter Details In Project Deliverables Screen
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to select and Verify additional deliverables and enter phase details in project deliverables screen
    Select Additional Deliverables For Entities    ${project_data}[Entities]    ${project_data}[DeliverableTypes]
    ${ACTUAL_REQUIRED_DELIVERABLES}    Get Required Deliverables
    Set Test Variable    ${ACTUAL_REQUIRED_DELIVERABLES}
    Verify Additional Deliverables Added For Entities    ${project_data}[Entities]    ${project_data}[DeliverableTypes]
    Select And Enter Phase Details In Project Deliverables    ${project_data}

Navigate To Project Phase Screen
    [Documentation]    This keyword is used to navigate to project phase screen
    Click Button In VLMS    Next
    Wait Until Element Is Visible    ${label.project.create.phase.step_three}    ${MEDIUM_WAIT}    Step three label is not visible after waiting for ${MEDIUM_WAIT} seconds

Copy Entity In Phases Of Project Deliverables
    [Arguments]    ${entity}    ${task_type}
    [Documentation]    This keyword is used to create duplicate entity under the phases of project deliverables
    Scroll Element Into View    ${label.project.create.deliverables.phases_of_project_deliverables}
    ${img.project.create.project.deliverables.newduplicate}    Update Dynamic Values    ${img.project.create.deliverables.duplicate}    ${entity}    ${task_type}
    Wait Until Element Is Visible    ${img.project.create.project.deliverables.newduplicate}    ${MEDIUM_WAIT}    Entity is not visble after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${img.project.create.project.deliverables.newduplicate}
    Wait Until Time    2

Verify Duplicated Entity In Project Schedule Screen
    [Arguments]    ${entity}    ${task_type}
    [Documentation]    This keyword is used to Verify duplicated entity in Project Schedule screen
    Wait Until Time    3
    ${label.project.create.project.deliverables.newremove}    Update Dynamic Values    ${label.project.create.schedule.entity}    ${entity}    ${task_type}
    Wait Until Element Is Visible    ${label.project.create.project.deliverables.newremove}
    ${element_count}    Get Element Count    ${label.project.create.project.deliverables.newremove}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Be True    ${element_count}>1

Verify Removed Entity In Project Schedule Screen
    # robocop: disable=expression-can-be-simplified
    [Arguments]    ${entity}    ${task_type}
    [Documentation]    This keyword is used to Verify removed entity in Project Schedule screen
    Wait Until Time    3
    ${label.project.create.project.deliverables.newremove}    Update Dynamic Values    ${label.project.create.schedule.entity}    ${entity}    ${task_type}
    ${element_count}    Get Element Count    ${label.project.create.project.deliverables.newremove}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Be True    ${element_count}==0

Remove Entity In Phases Of Project Deliverables
    [Arguments]    ${entity}    ${task_type}    ${comment}
    [Documentation]    This keyword is used to remove entity under phases of project deliverables
    Wait Until Time    1
    ${label.project.create.project.deliverables.newremove}    Update Dynamic Values    ${label.project.create.deliverables.remove}    ${entity}    ${task_type}
    Click Element    ${label.project.create.project.deliverables.newremove}
    Wait Until Time    2
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    val1_txtReason
    IF    '${status}'=='True'
        Enter Comments/Description    val1_txtReason    ${comment}
        Select Submit/Reset Button    TermYes
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Wait Until Time    2

Select Phase In Project Phase
    [Arguments]    ${entity}    ${task_type}    ${phase}    ${index}=none
    [Documentation]    This keyword is used to select phase in project phase
    ${label.project.create.schedule.newentity}    Update Dynamic Values    ${label.project.create.schedule.entity}    ${entity}    ${task_type}
    ${count}    Get Element Count    ${label.project.create.schedule.newentity}
    IF    ${count}>1 and '${index}'!='none'
        ${dropdown.project.create.phase.select_phases}    Update Dynamic Values    ${dropdown.project.create.phase.select_phases}    ${entity}    ${task_type}
        Wait Until Time    1
        Wait Until Element Is Visible    (${dropdown.project.create.phase.select_phases})[${index}]    ${MEDIUM_WAIT}    Predecessor dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    3
        Click Element    (${dropdown.project.create.phase.select_phases})[${index}]
    ELSE
        ${dropdown.project.create.phase.select_phases}    Update Dynamic Values    ${dropdown.project.create.phase.select_phases}    ${entity}    ${task_type}
        Wait Until Time    1
        Wait Until Element Is Visible    ${dropdown.project.create.phase.select_phases}    ${MEDIUM_WAIT}    Predecessor dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    3
        Click Element    ${dropdown.project.create.phase.select_phases}
    END
    ${label.project.create.project.schedule.newphase}    Update Dynamic Value    ${label.project.create.schedule.predecessor}    ${phase}
    Click Element    ${label.project.create.project.schedule.newphase}

Select Phase For Entities In Project Phase Screen
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to select phases of all project task type in project phase screen
    ${entity_and_task_type}    ${duplicated_entity_task_type}    Get Entities And Task Types
    ${entities_count}    Get Length    ${entity_and_task_type}
    ${phase_details}    Set Variable    ${project_data}[Phases]
    ${splitted_phase_details}    Split String    ${phase_details}    ,
    FOR    ${entity_count}    IN RANGE    0    ${entities_count}
        ${splitted1}    Split String    ${entity_and_task_type}[${entity_count}]    &
        ${entity}    Set Variable    ${splitted1}[0]
        ${task_type}    Set Variable    ${splitted1}[1]
        ${task_types}    Get Deliverables    ${project_data}[DeliverableTypes]
        ${expected_task_types}    Combine Lists    ${task_types}    ${ACTUAL_REQUIRED_DELIVERABLES}
        Remove Duplicates    ${expected_task_types}
        ${status}    Run Keyword And Return Status    List Should Contain Value   ${expected_task_types}    ${task_type}
        IF    '${status}'=='True'
            Select Phase In Project Phase    ${entity}    ${task_type}    ${splitted_phase_details}[${entity_count}]
        END
    END
    ${duplicated_entities_count}    Get Length    ${duplicated_entity_task_type}
    ${duplicated_phase_details}    Set Variable    ${project_data}[DuplicatePhases]
    ${splitted_duplicated_phase_details}    Split String    ${duplicated_phase_details}    ,
    FOR    ${key}    IN RANGE    0    ${duplicated_entities_count}
        ${updated_key}    Evaluate    ${key}+1
        ${splitted1}    Split String    ${duplicated_entity_task_type}[${key}]    &
        ${entity}    Set Variable    ${splitted1}[0]
        ${task_type}    Set Variable    ${splitted1}[1]
        Select Phase In Project Phase    ${entity}    ${task_type}    ${splitted_duplicated_phase_details}[${key}]    ${updated_key}
    END

Select Project Manager And Authors/Executors
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to select project manager and authors/executors users
    Swipe Values Between Groups    ${project_data}[ProjectManagers]    lstApAvailbleUser    lstApAssignUser
    Swipe Values Between Groups    ${project_data}[Groups]    lstAvailbleGroup    lstAssinGroup
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Enter Details In Project Phase Screen
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to enter details in the project phase screen
    Copy Entity In Phases Of Project Deliverables    ${project_data}[AddedEntity]    ${project_data}[AddedTaskType]
    Select Phase For Entities In Project Phase Screen    ${project_data}
    Remove Entity In Phases Of Project Deliverables    ${project_data}[RemovedEntity]    ${project_data}[RemovedTaskType]    ${project_data}[Comments]
    Select Value For Radio Button    radio    ${project_data}[SummaryRequired]
    Select Project Manager And Authors/Executors    ${project_data}

Navigate To Project Schedule Screen
    [Documentation]    This keyword is used to navigate to project schedule screen
    Click Button In VLMS    Next
    Wait Until Element Is Visible    ${label.project.create.schedule}    ${MEDIUM_WAIT}    Step four label is not visible after waiting for ${MEDIUM_WAIT} seconds

Get Entities
    [Documentation]    This keyword is used to get entity names
    ${entities}    Create List
    Wait Until Time    1
    ${entities_count}    Get Element Count    ${label.project.create.deliverables.entity}
    FOR    ${count}    IN RANGE    1    ${entities_count}
        ${updated_count}    Evaluate    ${count}+1
        Wait Until Element Is Visible    (${label.project.create.deliverables.entity})[${updated_count}]    ${LONG_WAIT}    Entities list is not visible after waiting for ${LONG_WAIT} seconds
        ${actual_entity}    Get Text    (${label.project.create.deliverables.entity})[${updated_count}]
        Append To List    ${entities}    ${actual_entity}
    END
    Set Test Variable    ${ENTITIES}

Get Task Types
    [Documentation]    This keyword is used to get all task types values
    ${task_types}    Create List
    Wait Until Time    1
    ${task_types_count}    Get Element Count    ${label.project.create.deliverables.task_type}
    FOR    ${count}    IN RANGE    1    ${task_types_count}
        ${updated_count}    Evaluate    ${count}+1
        ${actual_task_type}    Get Text    (${label.project.create.deliverables.task_type})[${updated_count}]
        Append To List    ${task_types}    ${actual_task_type}
    END
    Set Test Variable    ${TASK_TYPES}

Get Entities And Task Types
    [Documentation]    This keyword is used to get single entities with task type and duplicate entities with task types
    Get Entities
    Get Task Types
    ${entity_and_task_type}    Create List
    ${entities_count}    Get Length    ${ENTITIES}
    FOR    ${key}    IN RANGE    0    ${entities_count}
        ${entities_and_taskTypes}    Set Variable    ${ENTITIES}[${key}]&${TASK_TYPES}[${key}]
        Append To List    ${entity_and_task_type}    ${entities_and_taskTypes}
    END
    ${duplicated_entity_task_type}    Create List
    ${entity_and_task_type_count}    Get Length    ${entity_and_task_type}
    FOR    ${count}    IN RANGE    0    ${entity_and_task_type_count}
        ${item_count}    Get Count    ${entity_and_task_type}    ${entity_and_task_type}[${count}]
        IF    ${item_count}>1
            Append To List    ${duplicated_entity_task_type}    ${entity_and_task_type}[${count}]
        END
    END
    Remove Values From List    ${entity_and_task_type}    ${duplicated_entity_task_type}[0]
    RETURN    ${entity_and_task_type}    ${duplicated_entity_task_type}

Enter Duration In Days
    [Arguments]    ${entity}    ${task_type}    ${duration_in_days}    ${index}=none
    [Documentation]    This keyword is used to enter duration in days
    ${label.project.create.schedule.newentity}    Update Dynamic Values    ${label.project.create.schedule.entity}    ${entity}    ${task_type}
    ${count}    Get Element Count    ${label.project.create.schedule.newentity}
    IF    ${count}>1 and '${index}'!='none'
        ${textbox.project.create.project.schedule.newduration_in_days}    Update Dynamic Values    ${textbox.project.create.schedule.duration_in_days}    ${entity}    ${task_type}
        Wait Until Time    1
        Wait Until Element Is Visible    ${textbox.project.create.project.schedule.newduration_in_days}    ${MEDIUM_WAIT}
        Input Text    (${textbox.project.create.project.schedule.newduration_in_days})[${index}]    ${duration_in_days}
    ELSE
        ${textbox.project.create.project.schedule.newduration_in_days}    Update Dynamic Values    ${textbox.project.create.schedule.duration_in_days}    ${entity}    ${task_type}
        Wait Until Time    1
        Wait Until Element Is Visible    ${textbox.project.create.project.schedule.newduration_in_days}    ${MEDIUM_WAIT}
        Input Text    ${textbox.project.create.project.schedule.newduration_in_days}    ${duration_in_days}
    END

Select Predecessor
    [Arguments]    ${entity}    ${task_type}    ${predecessor}    ${index}=none
    [Documentation]    This keyword is used to select predecessor
    ${label.project.create.schedule.newentity}    Update Dynamic Values    ${label.project.create.schedule.entity}    ${entity}    ${task_type}
    ${count}    Get Element Count    ${label.project.create.schedule.newentity}
    IF    ${count}>1 and '${index}'!='none'
        ${dropdown.project.create.project.schedule.newpredecessor}    Update Dynamic Values    ${dropdown.project.create.schedule.predecessor}    ${entity}    ${task_type}
        Wait Until Element Is Visible    (${dropdown.project.create.project.schedule.newpredecessor})[${index}]    ${MEDIUM_WAIT}    Predecessor dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    2
        Click Element    (${dropdown.project.create.project.schedule.newpredecessor})[${index}]
    ELSE
        ${dropdown.project.create.project.schedule.newpredecessor}    Update Dynamic Values    ${dropdown.project.create.schedule.predecessor}    ${entity}    ${task_type}
        Wait Until Element Is Visible    ${dropdown.project.create.project.schedule.newpredecessor}    ${MEDIUM_WAIT}    Predecessor dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    2
        Click Element    ${dropdown.project.create.project.schedule.newpredecessor}
    END
    ${label.project.create.project.schedule.newpredecessor}    Update Dynamic Value    ${label.project.create.schedule.predecessor}    ${predecessor}
    Click Element    ${label.project.create.project.schedule.newpredecessor}

Select Activity And Document No
    # robocop: disable=too-long-keyword
    [Arguments]    ${entity}    ${task_type}    ${activity}    ${document_no}=none    ${index}=none
    [Documentation]    This keyword is used to select activity and document no for entities
    ${label.project.create.schedule.newentity}    Update Dynamic Values    ${label.project.create.schedule.entity}    ${entity}    ${task_type}
    ${count}    Get Element Count    ${label.project.create.schedule.newentity}
    IF    ${count}>1 and '${index}'!='none'
        ${dropdown.project.create.project.schedule.newactivity}    Update Dynamic Values    ${dropdown.project.create.schedule.activity}    ${entity}    ${task_type}
        Wait Until Time    2
        Wait Until Element Is Visible    (${dropdown.project.create.project.schedule.newactivity})[${index}]    ${MEDIUM_WAIT}    Activity dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    (${dropdown.project.create.project.schedule.newactivity})[${index}]
        ${label.project.create.project.schedule.newactivity}    Update Dynamic Value    ${label.project.create.schedule.activity}    ${activity}
        Wait Until Time    2
        Wait Until Element Is Visible    ${label.project.create.project.schedule.newactivity}    ${MEDIUM_WAIT}    ${activity} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${label.project.create.project.schedule.newactivity}
        Wait Until Time    4
        IF    '${document_no}'!='none'
            ${dropdown.project.create.schedule.newdocument_no}    Update Dynamic Values    ${dropdown.project.create.schedule.document_no}    ${entity}    ${task_type}
            Wait Until Time    2
            Wait Until Element Is Visible    (${dropdown.project.create.schedule.newdocument_no})[${index}]    ${MEDIUM_WAIT}    Document dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    (${dropdown.project.create.schedule.newdocument_no})[${index}]
            ${label.project.create.project.schedule.newdocument_no}    Update Dynamic Value    ${label.project.create.schedule.activity}    ${document_no}
            Wait Until Time    2
            Wait Until Element Is Visible    ${label.project.create.project.schedule.newdocument_no}    ${MEDIUM_WAIT}    ${document_no} is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    ${label.project.create.project.schedule.newdocument_no}
            Wait Until Time    2
        END
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ELSE
        ${dropdown.project.create.project.schedule.new.activity}    Update Dynamic Values    ${dropdown.project.create.schedule.activity}    ${entity}    ${task_type}
        Wait Until Time    2
        Wait Until Element Is Visible    ${dropdown.project.create.project.schedule.new.activity}    ${MEDIUM_WAIT}    Activity is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${dropdown.project.create.project.schedule.new.activity}
        ${label.project.create.project.schedule.new.activity}    Update Dynamic Value    ${label.project.create.schedule.activity}    ${activity}
        Wait Until Time    2
        Wait Until Element Is Visible    ${label.project.create.project.schedule.new.activity}    ${MEDIUM_WAIT}    ${activity} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${label.project.create.project.schedule.new.activity}
        Wait Until Time    4
        IF    '${document_no}'!='none'
            Wait Until Time    2
            ${dropdown.project.create.schedule.newdocument}    Update Dynamic Values    ${dropdown.project.create.schedule.document_no}    ${entity}    ${task_type}
            Wait Until Time    2
            Wait Until Element Is Visible    ${dropdown.project.create.schedule.newdocument}    ${MEDIUM_WAIT}    Dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    ${dropdown.project.create.schedule.newdocument}
            ${label.project.create.project.schedule.newdocument}    Update Dynamic Value    ${label.project.create.schedule.activity}    ${document_no}
            Wait Until Time    2
            Wait Until Element Is Visible    ${label.project.create.project.schedule.newdocument}    ${MEDIUM_WAIT}    ${document_no} is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    ${label.project.create.project.schedule.newdocument}
            Wait Until Time    2
        END
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Enter Schedule Details
    # robocop: disable=too-long-keyword
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to enter schedule details in project schedule screen
    Scroll Element Into View    ${label.project.create.schedule.prerequisite}
    Select Value For Radio Button    radio    ${project_data}[TaskDependency]
    Wait Until Time    6
    Click Calendar Icon In Vlms    ${label.project.create.schedule.calendar}
    Select Target Date    ${project_data}[DateType]    txtDate    txtDate_DrpPnl_Calendar1_506    txtDate_DrpPnl_Calendar1_504    ${project_data}[Year]    ${project_data}[Month]    ${project_data}[Date]
    ${entity_and_task_type}    ${duplicated_entity_task_type}    Get Entities And Task Types
    ${entities_count}    Get Length    ${entity_and_task_type}
    ${schedule_details}    Set Variable    ${project_data}[ScheduleDetails]
    ${splitted_schedule_details}    Split String    ${schedule_details}    |
    FOR    ${entity_count}    IN RANGE    0    ${entities_count}
        ${splitted1}    Split String    ${entity_and_task_type}[${entity_count}]    &
        ${entity}    Set Variable    ${splitted1}[0]
        ${task_type}    Set Variable    ${splitted1}[1]
        ${task_types}    Get Deliverables    ${project_data}[DeliverableTypes]
        ${expected_task_types}    Combine Lists    ${task_types}    ${ACTUAL_REQUIRED_DELIVERABLES}
        Remove Duplicates    ${expected_task_types}
        ${status}    Run Keyword And Return Status    List Should Contain Value    ${expected_task_types}    ${task_type}
        IF    '${status}'=='True'
            FOR    ${key}    IN    ${splitted_schedule_details}[${entity_count}]
                ${list}    Split String    ${key}    ,
                ${duration_days}    Set Variable    ${list}[0]
                ${predecessor}    Set Variable    ${list}[1]
                ${activity}    Set Variable    ${list}[2]
                ${document_no}    Set Variable    ${list}[3]
                Enter Duration In Days    ${entity}    ${task_type}    ${duration_days}
                Select Predecessor    ${entity}    ${task_type}    ${predecessor}
                Select Activity And Document No    ${entity}    ${task_type}    ${activity}    ${document_no}
            END
        END
    END
    ${duplicated_entities_count}    Get Length    ${duplicated_entity_task_type}
    ${duplicated_schedule_details}    Set Variable    ${project_data}[DuplicateScheduleDetails]
    ${splitted_schedule_details}    Split String    ${duplicated_schedule_details}    |
    FOR    ${key}    IN RANGE    0    ${duplicated_entities_count}
        ${updated_key}    Evaluate    ${key}+1
        ${splitted1}    Split String    ${duplicated_entity_task_type}[${key}]    &
        ${entity}    Set Variable    ${splitted1}[0]
        ${task_type}    Set Variable    ${splitted1}[1]
        FOR    ${key}    IN    ${splitted_schedule_details}[${key}]
            ${list}    Split String    ${key}    ,
            ${duration_days}    Set Variable    ${list}[0]
            ${predecessor}    Set Variable    ${list}[1]
            ${activity}    Set Variable    ${list}[2]
            ${document_no}    Set Variable    ${list}[3]
            Enter Duration In Days    ${entity}    ${task_type}    ${duration_days}    ${updated_key}
            Select Predecessor    ${entity}    ${task_type}    ${predecessor}    ${updated_key}
            Select Activity And Document No    ${entity}    ${task_type}    ${activity}    ${document_no}    ${updated_key}
        END
    END

Get Start Date And End Date In Schedule Project Screen
    [Documentation]    This keyword is used to get the start date from the schedule page and get end date by adding duration of days to start date
    Wait Until Time    2
    Click Button In VLMS    Apply
    Wait Until Time    2
    ${actual_start_date}    Get Element Attribute    ${label.project.create.schedule.calendar.date}    Value
    ${START_DATE}    Set Variable    ${actual_start_date}
    Set Suite Variable    ${START_DATE}
    ${splitted_start_date}    Split String    ${START_DATE}    /
    ${expected_start_date}    Set Variable    ${splitted_start_date}[2]/${splitted_start_date}[1]/${splitted_start_date}[0]
    ${expected_start_date}    Convert To String    ${expected_start_date}
    ${entities_count}    Get Element Count    ${label.project.create.deliverables.entity}
    ${expected_end_dates}    Create List
    FOR    ${count}    IN RANGE    1    ${entities_count}
        ${updated_count}    Evaluate    ${count}+1
        ${updated_count}    Convert To String    ${updated_count}
        ${label.project.create.schedule.newduration_days}    Update Dynamic Value    ${label.project.create.schedule.duration_days}    ${updated_count}
        ${duration_day}    Get Element Attribute    ${label.project.create.schedule.newduration_days}    Value
        ${expected_end_date}   Add Time To Date    ${expected_start_date}    ${duration_day}days    result_format=%d/%m/%Y
        ${expected_end_date}    Convert To String    ${expected_end_date}
        Append To List    ${expected_end_dates}    ${expected_end_date}
    END
    Set Test Variable    ${EXPECTED_END_DATES}

Verify Start Date And End Date In Schedule Project Screen
    [Documentation]    This keyword is used to Verify start date and end date based on given duration days
    Get Start Date And End Date In Schedule Project Screen
    ${entities_count}    Get Element Count    ${label.project.create.deliverables.entity}
    FOR    ${entity_count}    IN RANGE    0    ${entities_count}-1
        ${updated_count}    Evaluate    ${entity_count}+2
        ${updated_count}    Convert To String    ${updated_count}
        ${label.project.create.schedule.newstart_date}    Update Dynamic Value    ${label.project.create.schedule.start_date}    ${updated_count}
        Wait Until Time    2
        ${actual_start_date}    Get Element Attribute    ${label.project.create.schedule.newstart_date}    Value
        ${actual_start_date}    Convert To String    ${actual_start_date}
        Verify String Should Be Equal    ${START_DATE}    ${actual_start_date}
        ${label.project.create.schedule.newend_date}    Update Dynamic Value    ${label.project.create.schedule.end_date}    ${updated_count}
        ${actual_end_date}    Get Element Attribute    ${label.project.create.schedule.newend_date}    Value
        ${actual_end_date}    Convert To String    ${actual_end_date}
        Verify String Should Be Equal    ${expected_end_dates}[${entity_count}]    ${actual_end_date}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Enter Details And Submit Project Schedule
    [Arguments]    ${project_data}
    [Documentation]    This keyword is used to enter all details in Project Schedule
    Enter Schedule Details    ${project_data}
    Run Keyword And Continue On Failure    Verify Start Date And End Date In Schedule Project Screen
    IF    'ApprovalRequired' in ${project_data}    Select Value For Radio Button    radio    ${project_data}[ApprovalRequired]
    Wait Until Time    2
    IF    'WorkFlow' in ${project_data}    Select Value From Dropdown    drWorkflow    ${project_data}[WorkFlow]
    Wait Until Time    2
    IF    'RouteFor' in ${project_data}    Select Value From Dropdown    drworkflowoption    ${project_data}[RouteFor]
    Wait Until Time    2
    IF    'Comments' in ${project_data}    Enter Comments/Description    txtComments    ${project_data}[Comments]
    Select Submit/Reset Button    ${project_data}[Button]
    Wait Until Time    2
    IF    '${project_data}[ApprovalRequired]'=='rbtNwork'
        ${EXPECTED_SUCCESS_MSG}    Set Variable    ${PROJECT_NAME} project ${PROJECT_ID} has been created
        Set Test Variable    ${EXPECTED_SUCCESS_MSG}
    ELSE
        ${EXPECTED_SUCCESS_MSG}    Set Variable    ${PROJECT_NAME} project ${PROJECT_ID} has been routed for ${project_data}[RouteFor]
        Set Test Variable    ${EXPECTED_SUCCESS_MSG}
    END
