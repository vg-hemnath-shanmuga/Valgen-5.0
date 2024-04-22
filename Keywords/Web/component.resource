*** Settings ***
Documentation     This component Resource file has all the Common Component keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Select Value For Radio Button
    [Arguments]    ${group_name}    ${value}
    [Documentation]    This keyword is used to select radio button
    ${radiobutton.common.newvalue}    Update Dynamic Value    ${radiobutton.common.value}    ${value}
    Wait Until Element Is Visible    ${radiobutton.common.newvalue}    ${MEDIUM_WAIT}
    ${status}    Run Keyword And Return Status    Radio Button Should Be Set To    ${group_name}    ${value}
    Wait Until Time    3
    IF    '${status}' == 'False'    Javascript Click    ${radiobutton.common.newvalue}

Select Value From Dropdown
    [Arguments]    ${dropdown_ID}    ${dropdown_value}
    [Documentation]    This keyword is used to select value from a dropdown
    ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.reason.esign.common}    ${dropdown_ID}
    Wait Until Element Is Visible    ${dropdown.common.newselect}    ${LONG_WAIT}    ${dropdown_ID} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Calendar Icon In Vlms    ${dropdown.common.newselect}
    Wait Until Time    8
    ${dropdown.common.select.newvalue}    Update Dynamic Value    ${dropdown.select.reason.esign.common}    ${dropdown_value}
    Wait Until Element Is Visible    ${dropdown.common.select.newvalue}    ${LONG_WAIT}    ${dropdown_value} is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${dropdown.common.select.newvalue}
    Wait Until Element Is Visible    ${dropdown.common.newselect}

Select Dropdown Value With Partial Text
    [Arguments]    ${dropdown_name}    ${dropdown_value}
    [Documentation]    This keyword is used to select value dropdown with partial text using contains
    ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    ${dropdown_name}
    Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${dropdown.common.newselect}
    ${dropdown.route_for.select.newvalue}    Update Dynamic Value    ${dropdown.route_for.select.value}    ${dropdown_value}
    Wait Until Element Is Visible    ${dropdown.route_for.select.newvalue}    ${MEDIUM_WAIT}    ${dropdown_value} is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${dropdown.route_for.select.newvalue}

Click Button In VLMS
    [Arguments]    ${button_name}
    [Documentation]    This keyword is used to click button in VLMS
    ${button.common.newbtn_name}    Update Dynamic Value    ${button.common.btn_name}    ${button_name}
    Wait Until Element Is Visible    ${button.common.newbtn_name}    ${MEDIUM_WAIT}    ${button_name} button is not visible after waiting ${MEDIUM_WAIT} seconds
    #Scroll Till Element Is Visible    ${button.common.newbtn_name}
    Wait Until Time    2
    Scroll Till Element Is Visible    ${button.common.newbtn_name}
    Javascript Click    ${button.common.newbtn_name}

Select Value From Dropdown for Select
    [Arguments]    ${dropdown_name}    ${dropdown_value}
    [Documentation]    This keyword is used to select value from a dropdown
    Wait Until Element Is Visible    ${dropdown_name}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${dropdown_name}    2
    Wait Until Time    3
    ${dropdown.common.select.newvalue}    Update Dynamic Value    ${dropdown_name}//li[contains(text(),'replaceText')]    ${dropdown_value}
    Wait Until Element Is Visible    ${dropdown.common.select.newvalue}    ${MEDIUM_WAIT}    ${dropdown_value} is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${dropdown.common.select.newvalue}

Select Value For Radio Button by ID
    [Arguments]    ${group_name}    ${value}
    [Documentation]    This keyword is used to select radio button
    ${radiobutton.common.newvalue}    Update Dynamic Value    ${radiobutton.common.id}    ${value}
    Wait Until Element Is Visible    ${radiobutton.common.newvalue}    ${MEDIUM_WAIT}
    ${status}    Run Keyword And Return Status    Radio Button Should Be Set To    ${group_name}    ${value}
    Wait Until Time    3
    IF    '${status}' == 'False'    Javascript Click    ${radiobutton.common.newvalue}

Select Last Value From Dropdown
    [Arguments]    ${dropdown_name}
    [Documentation]    This keyword is used to select value from a dropdown
    ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    ${dropdown_name}
    Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    15
    Wait Until Element Is Visible    ${dropdown.common.select.newvalue}    ${MEDIUM_WAIT}
    Click Element    ${dropdown.common.select.newvalue}

Select First Value From Dropdown
    [Arguments]    ${dropdown_name}
    [Documentation]    This keyword is used to select value from a dropdown
    ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    ${dropdown_name}
    Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    15
    Wait Until Element Is Visible    ${dropdown.common.select.firstvalue}    ${MEDIUM_WAIT}
    Click Element    ${dropdown.common.select.firstvalue}

Select Specific Index Value From Dropdown
    [Arguments]    ${dropdown_name}    ${index}
    [Documentation]    This keyword is used to select value from a dropdown
    ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    ${dropdown_name}
    Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    15
    Wait Until Element Is Visible    (${dropdown.common.select.indexvalue})[${index}]    ${MEDIUM_WAIT}
    Wait Until Time    4
    Click Element    (${dropdown.common.select.indexvalue})[${index}]

Validate highlighted field
    [Arguments]    ${message}
    [Documentation]    Validate highlighted field
    ${common.missing.new_text}    Update Dynamic Value    ${common.missing.text}    ${message}
    Wait Until Element Is Visible    ${common.missing.new_text}    ${MEDIUM_WAIT}    Warning text is not visible after waiting for ${MEDIUM_WAIT}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Search The Value From The Section
    [Arguments]    ${value}
    [Documentation]    It is used to Search for given Value in the section
    Enter Text In Mandatory Fields    Search    ${value}
    Click Element    ${icon.content.section.search_icon}
    Wait Until Time    ${SHORT_WAIT}

Expand Search Filter
    [Documentation]    It is used for expanding the search filter
    Wait Until Element Is Clickable And Click    ${common.expand.status.button}    ${MEDIUM_WAIT}

Select Option To Filter
    [Arguments]    ${option}    ${filter}=None
    [Documentation]    It is used for selecting option for filter
    IF    "${filter}"!="None"
        ${common.dropdown.filter.new_selection}    Update Dynamic Value    ${common.dropdown.filter.selection}    ${filter}
        Wait Until Element Is Visible    ${common.dropdown.filter.new_selection}    ${MEDIUM_WAIT}    Warning text is not visible after waiting for ${MEDIUM_WAIT}
        Javascript Click    ${common.dropdown.filter.new_selection}
    END
    ${common.dropdown.filter.selection.new_option}    Update Dynamic Value    ${common.dropdown.filter.selection.option}    ${option}
    Wait Until Element Is Visible    ${common.dropdown.filter.selection.new_option}    ${MEDIUM_WAIT}    Warning text is not visible after waiting for ${MEDIUM_WAIT}
    Javascript Click    ${common.dropdown.filter.selection.new_option}

Filter The Option And Search The Text
    [Arguments]        ${option}    ${filter}==None    ${value}==None
    [Documentation]    It is used for search and selecting the option by filtering
    Expand Search Filter
    Select Option To Filter    ${option}
    Wait Until Time    ${SHORT_WAIT}
    #Search The Value From The Section    ${value}

Click And Delete The Task
   [Documentation]    It is used for deleting the task
    Click Element    ${icon.initiated.tasks.del}
    Enter Comments/Description    txtActionComments    Remove
    Select Submit/Reset Button    ActionSubmit

Click The Link In Table By Filter
    [Arguments]    ${status}    ${text}    
    [Documentation]    It is used for clicking the link in the table based on filter
    ${common.link.table.new_search}    Update Dynamic Values    ${common.link.table.search}    ${status}    ${text}
    Click Element    ${common.link.table.new_search}

Select The Task Filtered By Status
    [Arguments]    ${filter}    ${status}    ${text}
    [Documentation]    It is used for selecting the task from the table which is filtered by status filter
    Filter The Option And Search The Text    ${filter}    ${status}    ${text}
    Wait Until Time    ${SHORT_WAIT}
    Click The Link In Table By Filter    ${status}    ${text}

Select Value From Dropdown In Verify Mapping
    [Arguments]    ${dropdown_name}    ${dropdown_value}    ${key}
    [Documentation]    This keyword is used to select value from a dropdown
    ${dropdown.common.newselect}    Update Dynamic Value    (${label.auto_mapping.fix.column_type.select.value_5.0})[${key}]    ${dropdown_name}
    Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Time    ${SHORT_WAIT}
    Input Text    (${dropdown.auto_mapping.common.select.value.input})[${key}]    ${dropdown_value}
    Press Keys    (${dropdown.auto_mapping.common.select.value.input})[${key}]    ENTER