*** Settings ***
Documentation     This common Resource file has all the Common keywords
Resource          ../../Config/super.resource

Library    CustomLibrary
Library    CustomLibrary

*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Launch Web Application
    [Arguments]    ${browser_name}    ${url}
    [Documentation]    Launch the browser and application depending on the arguments we pass
    ${session}    Run Keyword And Return Status    Get Session Id
    IF    '${session}'=='True'
        Delete All Cookies
        Go To    ${url}
    ELSE
        Launch Browser    ${browser_name}    ${url}
    END
    Maximize Browser Window
    RETURN    ${session}

Launch Browser
    [Arguments]    ${browser_name}    ${url}
    [Documentation]    Launch the browser in Chrome or firefox.
    IF    '${browser_name}'=='Chrome' or '${browser_name}'=='chrome' or '${browser_name}'=='gc'
        Open Chrome Browser    ${url}
    ELSE IF    '${browser_name}'=='Firefox' or '${browser_name}'=='firefox' or '${browser_name}'=='ff'
        Open Browser    ${url}    Firefox
    ELSE IF    '${browser_name}'=='Headless' or '${browser_name}'=='hls'
        Open Headless Chrome    ${url}
    ELSE IF    '${browser_name}'=='Microsoft Edge' or '${browser_name}'=='Edge' or '${browser_name}'=='edge'
        Open Browser    ${url}    Edge
    ELSE IF    '${browser_name}'=='Safari' or '${browser_name}'=='safari' or '${browser_name}'=='sf'
        Open Browser    ${url}    safari
    ELSE
        Fail    ${browser_name} is not a valid browser
    END

Fail And Take Screenshot
    [Arguments]    ${message}
    [Documentation]    Take a Screenshot Fail the test case and displays message.
    Capture Allure Screenshot
    Fail    ${message}

Read TestData From Excel
    [Arguments]    ${tc_id}    ${sheet_name}
    [Documentation]    Read TestData from excel file for required data.
    ...    Example:
    ...    Read TestData From Excel TC_01 SheetName
    ${expected_data}    Get Ms Excel Row Values Into Dictionary Based On Key    ${TESTDATA_FOLDER}\\Testdata.xlsx    ${tc_id}    ${sheet_name}
    RETURN    ${expected_data}

Read TestData From Excel With File Location
    [Arguments]    ${FOLDER}    ${tc_id}    ${sheet_name}
    [Documentation]    Read TestData from excel file for required data.
    ...    Example:
    ...    Read TestData From Excel TC_01 SheetName
    ${expected_data}    Get Ms Excel Row Values Into Dictionary Based On Key    ${FOLDER}    ${tc_id}    ${sheet_name}
    RETURN    ${expected_data}

Update Dynamic Value
    [Arguments]    ${locator}    ${value}
    [Documentation]    It replace the string where ever you want.
    ...    Example:
    ...    web_common.Update Dynamic Value locator replace_string
    ${xpath}    Replace String    ${locator}    replaceText    ${value}
    RETURN    ${xpath}

Wait Until Element Is Clickable And Click
    # robocop: disable=unused-variable
    [Arguments]    ${locator}    ${time_out}
    [Documentation]    It will wait until element is clicable and click the element
    FOR    ${key}    IN RANGE    1    ${time_out}
        ${status}    Run Keyword And Return Status    Click Element    ${locator}
        IF    '${status}'=='True'    BREAK
        Wait Until Time    1
        CONTINUE
    END
    IF    '${status}'=='False'
        Fail And Take Screenshot    Element is not clickable even after waiting for ${time_out} seconds
    END

Scroll To Element
    [Arguments]    ${locator}
    [Documentation]    Scroll until element visible by using coordinates
    ${horizontal_position}    Get Horizontal Position    ${locator}
    ${vertical_position}    Get Vertical Position    ${locator}
    Execute Javascript    window.scrollTo(${horizontal_position},${vertical_position})

Verify String Should Be Equal
    [Arguments]    ${expected}    ${actual}
    [Documentation]    Verify strings should be equal
    ${status}    Run Keyword And Return Status    Should Be Equal    ${expected}    ${actual}    ignore_case=True
    Log Expected And Actual Results    ${actual}    ${expected}
    IF    '${status}'=='False'    Capture Allure Screenshot

Verify String Should Not Be Equal
    [Arguments]    ${expected}    ${actual}
    [Documentation]    Verify strings should not be equal
    ${status}    Run Keyword And Return Status    Should Not Be Equal    ${expected}    ${actual}
    IF    '${status}'=='False'
        Fail And Take Screenshot    ${expected} is equal to ${actual}
    END

Click And Wait For Element
    # robocop: disable=unused-variable
    [Arguments]    ${click_locator}    ${future_element}    ${message}=None
    [Documentation]    Click Until Next Element is Displayed
    Wait Until Element Is Visible    ${click_locator}    ${SHORT_WAIT}    ${message}
    FOR    ${key}    IN RANGE    1    4
        Click Element    ${click_locator}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${future_element}    ${SHORT_WAIT}
        IF    '${status}'=='True'    BREAK
        Wait Until Time    1
    END
    IF    '${status}'=='False'    Fail And Take Screenshot    ${message}

Click Until Element Is Invisible
    # robocop: disable=unused-variable
    [Arguments]    ${click_locator}
    [Documentation]    click until element is disappears
    Wait Until Element Is Visible    ${click_locator}    ${MEDIUM_WAIT}    ${click_locator} is not visible
    FOR    ${key}    IN RANGE    1    5
        ${wait_status}    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${click_locator}    ${SHORT_WAIT}
        IF    '${wait_status}'=='True'    BREAK
        Javascript Click    ${click_locator}
        Wait Until Time    2
    END
    IF    '${wait_status}'=='False'    Fail And Take Screenshot    ${click_locator} is still visible

Scroll Till Element Is Visible
    # robocop: disable=unused-variable
    [Arguments]    ${locator}
    [Documentation]    Scroll Till Element is Visible
    FOR    ${key}    IN RANGE    1    4
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    ${MEDIUM_WAIT}    locator is not visible
        IF    '${status}'=='True'    BREAK
        Scroll To Element    ${locator}
    END
    IF    '${status}'=='False'    Fail And Take Screenshot    ${locator} is not displayed

Verify String Should Contain
    [Arguments]    ${expected}    ${actual}
    [Documentation]    Verify strings should be equal
    ${status}    Run Keyword And Return Status    Should Contain    ${expected}    ${actual}    ignore_case=True
    Log Expected And Actual Results    ${actual}    ${expected}
    IF    '${status}'=='False'    Capture Allure Screenshot

Verify String Should Not Contain
    [Arguments]    ${expected}    ${actual}
    [Documentation]    Verify String Should not Contain
    ${status}    Run Keyword And Return Status    Should Not Contain    ${expected}    ${actual}
    IF    '${status}'=='False'
        Fail And Take Screenshot    ${expected} does contain ${actual}
    END

Wait Till Loading Icon Is Invisible
    [Arguments]    ${locator}    ${time_out}=60    ${loading_visibility_timeout}=10s
    [Documentation]    Wait Till Loading Icon Is Invisible
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${locator}    ${loading_visibility_timeout}
    IF    '${status}'=='True'
        FOR    ${key}    IN RANGE    1    ${time_out}
            ${status}    Run Keyword And Return Status    Element Should Be Visible    ${locator}
            IF    '${status}'=='False'    BREAK
            Wait Until Time    1
        END
        IF    '${status}'=='True'
            Fail And Take Screenshot    Loading Icon is Still Visible
        END
    END

Handle Electronic Sign
    [Arguments]    ${login_user}    ${login_password}    ${option}    ${reason}=None
    [Documentation]    It is Used to handle electronic signature with Submit or Cancel button
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.electronic_sign.popup}    ${SHORT_WAIT}
    IF    '${status}' == 'True'
        Wait Until Element Is Visible    ${textbox.electronic_sign.user}    ${MEDIUM_WAIT}
        ${loggedin_user}    Get Text    ${label.electronic_sign.popup.loggedin_user}
        Set Test Variable    ${LOGGEDIN_USER}
        IF    '${reason}'!='None'    Select Value From Dropdown    val1_ddlReason_chosen    ${reason}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Enabled    ${textbox.electronic_sign.user}    ${SHORT_WAIT}
        IF    '${status}'=='True'    Input Text    ${textbox.electronic_sign.user}    ${login_user}
        Input Text    ${textbox.electronic_sign.password}    ${login_password}
        ${button.electronic_sign.newsubmit/cancel}    Update Dynamic Value    ${button.electronic_sign.submit/cancel}    ${option}
        Click Element    ${button.electronic_sign.newsubmit/cancel}
    END

Handle Execution Electronic Sign
    [Arguments]    ${login_user}    ${login_password}
    [Documentation]    It is Used to handle electronic signature with Submit in electronic execution page in test url
    Wait Until Element Is Visible    ${label.test.electronic_sign.popup}    ${MEDIUM_WAIT}
    Wait Until Element Is Visible    ${textbox.test.electronic_sign.user}    ${MEDIUM_WAIT}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Enabled    ${textbox.test.electronic_sign.user}    ${SHORT_WAIT}
    IF    '${status}'=='True'    Input Text    ${textbox.test.electronic_sign.user}    ${login_user}
    Input Text    ${textbox.test.electronic_sign.password}    ${login_password}
    Click Element    ${button.test.electronic_sign.submit/cancel}

Verify Document Is Assigned
    [Arguments]    ${option}    ${msg}
    [Documentation]    This will Verify document is assigned, store document number & Handle Notification pop-up by clicking with Ok or Home button
    Wait Until Element Is Visible    ${label.notification_popup}
    Wait Until Element Is Visible    ${label.notification.doc_no}
    ${document_number}    Get Text    ${label.notification.doc_no}
    ${DOCUMENT_NO}    Set Variable    ${document_number}
    Set Suite Variable    ${DOCUMENT_NO}
    IF    '${option}'=='Ok'
        Click Element    ${button.notification_popup.ok}
        ${label.module.tab.content.newpage}    Update Dynamic Value    ${label.module.tab.content.page}    ${msg}
        Wait Until Element Is Visible    ${label.module.tab.content.newpage}    ${MEDIUM_WAIT}
    ELSE IF    '${option}'=='Home'
        Click Element    ${button.notification_popup.home}
        Unselect Frame
        Wait Until Element Is Visible    ${label.home.task_list}    ${MEDIUM_WAIT}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    RETURN    ${DOCUMENT_NO}

Select Submit/Reset Button
    [Arguments]    ${button_option}
    [Documentation]    It is used to select submit or reset button
    ${button.newsubmit/reset}    Update Dynamic Value    ${button.submit/reset}    ${button_option}
    Scroll Till Element Is Visible    ${button.newsubmit/reset}
    Wait Until Time    2
    Wait Until Element Is Clickable And Click    ${button.newsubmit/reset}    10
    ${status}    Run Keyword And Return Status    Element Should Be Disabled    ${button.newsubmit/reset}
    IF    '${status}'=='False'    Wait Until Time    5

Verify Success Message
    [Arguments]    ${alert_success_message}    ${button_option}
    [Documentation]    It is used to Verify the success message
    ${label.content.assign.authoring.new_success_message}    Update Dynamic Value    ${label.content.assign.authoring.success_message}    ${alert_success_message}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.content.assign.authoring.new_success_message}    ${MEDIUM_WAIT}    ${alert_success_message} message is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${status}'=='True'    Log Expected And Actual Results    ${alert_success_message} is Displayed    ${alert_success_message} should be Displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    ${button_option}
    Wait Until Element Is Visible    ${button.notification.newok/cancel}    ${MEDIUM_WAIT}    ${button_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.notification.newok/cancel}

Verify Success Message And Click Submit
    [Arguments]    ${alert_success_message}    ${button_option}    ${index}
    [Documentation]    It is used to Verify the success message and click submit based on index
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.notification_popup.message}
    ${actual_msg}    Get Text    ${label.notification_popup.message}
    IF    '${status}'=='True'    Log Expected And Actual Results    ${actual_msg} is Displayed    ${alert_success_message} should be Displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    ${button_option}
    Wait Until Element Is Visible    (${button.notification.newok/cancel})[${index}]    ${MEDIUM_WAIT}    ${button_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    (${button.notification.newok/cancel})[${index}]

Verify Notification Popup
    [Arguments]    ${message}    ${button_option}
    [Documentation]    It is used to Verify notification popup and click ok/cancel button
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    ${message}    ${MEDIUM_WAIT}
    IF    '${status}'=='True'
        Log Expected And Actual Results    ${message}    ${message}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END
    ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    ${button_option}
    Wait Until Element Is Visible    ${button.notification.newok/cancel}    ${MEDIUM_WAIT}    ${button_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.notification.newok/cancel}

Verify Multiple Texts In A Page
    [Arguments]    ${text_list}
    [Documentation]    It is used to Verify Texts In A Page
    @{list}    Split String    ${text_list}    |
    FOR    ${key}    IN    @{list}
        ${status}    Run Keyword And Return Status    Wait Until Page Contains    ${key}    ${MEDIUM_WAIT}
        IF    '${status}'=='True'
            Log Expected And Actual Results    ${key} Message is Displayed    ${key} Message should be Displayed
            IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        END
    END

Enter Comments/Description
    [Arguments]    ${text_field}    ${text}
    [Documentation]    This keyword is used to enter comments/description in textbox
    ${textbox.common.newcomments/desc}    Update Dynamic Value    ${textbox.common.comments/desc}    ${text_field}
    Wait Until Element Is Visible    ${textbox.common.newcomments/desc}
    Wait Until Time    2
    Javascript Input Text    ${textbox.common.newcomments/desc}    ${text}

Select The Section
    [Arguments]    ${section_name}
    [Documentation]    Navigate to the section
    ${label.newsection}    Update Dynamic Value    ${label.section}    ${section_name}
    Wait Until Element Is Visible    ${label.newsection}    ${MEDIUM_WAIT}    ${section_name} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    ${SHORT_WAIT}
    Scroll Element Into View    ${label.newsection}
    #IF    '${section_name}' != 'Detectability'
        Click Element    ${label.newsection}  
    #END
    Mouse Up    ${label.newsection}
    ${section_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.section_view} ${MEDIUM_WAIT}    The ${section_name} section list is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    ${section_status}=='False'    Log    The ${section_name} section is no data available

Select Target Date
    # robocop: disable=too-many-arguments
    [Arguments]    ${option}    ${calendar_id}    ${year_id}=none    ${month_id}=none    ${year}=none    ${month}=none    ${target_date}=none
    [Documentation]    It is used to select the target date based on selected Option as 'Today' or 'Custom'
    IF    '${option}'=='Today'
        Select Today Date From Calendar    ${calendar_id}
    ELSE IF    '${option}'=='Custom'
        Select Custom Date From Calendar    ${calendar_id}    ${year_id}    ${month_id}    ${year}    ${month}    ${target_date}
    END

Select Today Date From Calendar
    [Arguments]    ${calendar_id}
    [Documentation]    Select Today Date From Calendar
    ${button.calendar.newtoday_date}    Update Dynamic Value    ${button.calendar.today_date}    ${calendar_id}
    Wait Until Element Is Visible    ${button.calendar.newtoday_date}    ${MEDIUM_WAIT}    Today date in Calendar is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.calendar.newtoday_date}

Select Custom Date From Calendar
    [Arguments]    ${calendar_id}    ${year_id}    ${month_id}    ${year}    ${month}    ${target_date}
    [Documentation]    It is used to select custom day, month and year from dropdowns
    ${dropdown.calendar.newyear}    Update Dynamic Value    ${dropdown.calendar.year/month}    ${year_id}
    Wait Until Element Is Visible    ${dropdown.calendar.newyear}    ${MEDIUM_WAIT}    Year dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select From List By Label    ${dropdown.calendar.newyear}    ${year}
    ${dropdown.calendar.newmonth}    Update Dynamic Value    ${dropdown.calendar.year/month}    ${month_id}
    Select From List By Label    ${dropdown.calendar.newmonth}    ${month}
    ${button.calendar.date.newoptions}    Update Dynamic Values    ${button.calendar.date.options}    ${target_date}    ${calendar_id}
    Click Element    ${button.calendar.date.newoptions}

Verify Data Is Cleared
    [Documentation]    It is used to Verify page is reset or not
    Wait Until Element Is Visible    ${dropdown.default.Entity.select}    ${MEDIUM_WAIT}    Default Content is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Visible    ${dropdown.default.Content_type.select}    ${MEDIUM_WAIT}    Default Content is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${comments}    Get Element Attribute    txtComments    value
    Verify String Should Be Equal    ${comments}    ${EMPTY}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Click View Icon
    [Documentation]    It is used to click view icon
    Wait Until Element Is Visible    ${icon.common.view}    ${MEDIUM_WAIT}    View Icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${icon.common.view}
    Unselect Frame
    ${icon.common.view.details.newnavigation}    Update Dynamic Value    ${icon.common.view.details.navigation}    Close
    Wait Until Element Is Visible    ${icon.common.view.details.newnavigation}    ${MEDIUM_WAIT}    Close icon is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.library_frame.screen}

Click Navigation Buttons In Screen
    [Arguments]    ${icon}
    [Documentation]    It is used to Click Close, Previous, Next buttons in screen
    Unselect Frame
    ${icon.common.view.details.newnavigation}    Update Dynamic Value    ${icon.common.view.details.navigation}    ${icon}
    Wait Until Element Is Visible    ${icon.common.view.details.newnavigation}    ${MEDIUM_WAIT}    ${icon} icon is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${icon.common.view.details.newnavigation}
    Select Frame    ${iframe.framecontent}

Enter Text In Mandatory Fields
    [Arguments]    ${text_field}    ${text}
    [Documentation]    This keyword is used to enter text in mandatory textbox field
    ${textbox.common.mandatory.newtext_field}    Update Dynamic Value    ${textbox.common.mandatory.text_field}    ${text_field}
    Wait Until Element Is Visible    ${textbox.common.mandatory.newtext_field}    ${LONG_WAIT}    ${text_field} is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${textbox.common.mandatory.newtext_field}
    Wait Until Time    2
    Javascript Input Text    ${textbox.common.mandatory.newtext_field}    ${text}

Verify Length Of Text Field
    # robocop: disable=unused-variable
    [Arguments]    ${text_field}    ${invalid_text}
    [Documentation]    It is used to Verify Length Of Mandatory Text Field
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${input_text_length}    Get Length    ${invalid_text}
    ${textbox.common.mandatory.newtext_field}    Update Dynamic Value    ${textbox.common.mandatory.text_field}    ${text_field}
    ${actual_text}    Get Element Attribute    ${textbox.common.mandatory.newtext_field}    value
    ${actual_text_length}    Get Length    ${actual_text}
    Should Be Equal As Integers    ${actual_text_length}    50
    Clear Text Field    ${textbox.common.mandatory.newtext_field}

Navigate To Page Title Tab
    [Arguments]    ${tab}
    [Documentation]    It is used to navigate to page title tab
    ${label.content.document.newtab}    Update Dynamic Value    ${label.content.document.tab}    ${tab}
    Wait Until Element Is Visible    ${label.content.document.newtab}    ${MEDIUM_WAIT}    ${tab} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Keyword Succeeds    10s    2s    Javascript Click    ${label.content.document.newtab}
    #Scroll Till Element Is Visible    ${label.content.document.newtab}
    #Wait Until Keyword Succeeds    10s    2s    Click Element    ${label.content.document.newtab}

Filter Data
    [Arguments]    ${input_text}    ${column}==None
    [Documentation]    Click view icon and filter data
    Click View Icon
    ${textbox.view_icon.view_details.newfilter_box}    Update Dynamic Value    ${textbox.lbframe_screen.filter_box}    ${column}
    Wait Until Element Is Visible    ${textbox.view_icon.view_details.newfilter_box}    ${MEDIUM_WAIT}
    Input Text    ${textbox.view_icon.view_details.newfilter_box}    ${input_text}

Verify Filter Option In View Details Screen
    [Arguments]    ${input_text}
    [Documentation]    Verify Filtered Data In View Details Is Visible
    ${label.view_icon.view_details.newcontent}    Update Dynamic Value    ${label.view_icon.view_details.content}    ${input_text}
    Wait Until Element Is Visible    ${label.view_icon.view_details.newcontent}    ${MEDIUM_WAIT}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Reset Clears Filter Data
    [Arguments]    ${value}
    [Documentation]    This Keyword Will Click View Icon and Resets values in View Details Screen
    Wait Until Time    3
    ${textbox.view_icon.view_details.filter_box.newvalue}    Update Dynamic Value    ${textbox.view_icon.view_details.filter_box.value}    ${value}
    Wait Until Element Is Not Visible    ${textbox.view_icon.view_details.filter_box.newvalue}    ${MEDIUM_WAIT}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Sort Column In View Details Page
    [Arguments]    ${col_name}
    [Documentation]    This Keyword will Sort Column In View Details Page
    ${label.view_icon.view_details.newcontent}    Update Dynamic Value    ${label.view_icon.view_details.content}    ${col_name}
    Wait Until Time    1
    Click Element    ${label.view_icon.view_details.newcontent}

Select Page Number
    [Arguments]    ${page_no}
    [Documentation]    This Keyword will select particular page number
    ${button.newpage_no}    Update Dynamic Value    ${button.page_no}    ${page_no}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.newpage_no}
    IF    '${status}'=='True'
        Scroll Till Element Is Visible    ${button.newpage_no}
        Wait Until Element Is Clickable And Click    ${button.newpage_no}    5
    END

Verify Page Capacity In View Details Screen
    [Arguments]    ${page_capacity}
    [Documentation]    This Keyword will Verify Page Capacity in View Details Screen i.e no of rows in the page
    Wait Until Element Is Visible    ${label.view_icon.view_details.table_rows}    ${MEDIUM_WAIT}
    ${actual_rows}    Get Element Count    ${label.view_icon.view_details.table_rows}
    Should Be True    ${actual_rows} <= ${page_capacity}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Capture Allure Screenshot
    [Documentation]    This Keyword will take screenshot for allure report
    ${png_name}    Get Unique Test Data    Unique
    Screenshot Page    Screenshot${png_name}

Update Dynamic Values
    [Arguments]    ${locator}    ${value1}    ${value2}
    [Documentation]    It replace two strings where ever you want.
    ${locator_new}    Replace String    ${locator}    replaceText1    ${value1}
    ${xpath}    Replace String    ${locator_new}    replaceText2    ${value2}
    RETURN    ${xpath}

Verify Confirmation Popup
    [Arguments]    ${message}    ${button_option}
    [Documentation]    It is used to Verify Confirmation popup and click ok/cancel button
    Wait Until Element Is Visible    ${label.notification_popup.message}    ${MEDIUM_WAIT}    Message is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_msg}    Get Text    ${label.notification_popup.message}
    Verify String Should Contain    ${message}    ${actual_msg}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    ${button_option}
    Wait Until Element Is Visible    ${button.notification.newok/cancel}    ${MEDIUM_WAIT}    ${button_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.notification.newok/cancel}

Search And Select The Value From The Section
    [Arguments]    ${value}
    [Documentation]    It is used to Search for given Value and select it from the section
    Enter Text In Mandatory Fields    Search    ${value}
    Click Element    ${icon.content.section.search_icon}
    Wait Until Time    3
    ${label.content.section.search.value}    Update Dynamic Value    ${label.content.section.search.doc_no}    ${value}
    Wait Until Element Is Visible    ${label.content.section.search.value}    ${MEDIUM_WAIT}    ${value} is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${label.content.section.search.value}

Click Accept Button And Accept The Popup
    [Arguments]    ${message}
    [Documentation]    This keyword will click Accept Button And Accept The Popup
    ${button.common.newbtn_name}    Update Dynamic Value    ${button.common.btn_name}    Accept
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.common.newbtn_name}    ${MEDIUM_WAIT}
    IF    '${status}'=='True'
        Click Button In VLMS    Accept
        Wait Until Time    2
        Verify Document Notification Popup_Prerequisite    ${message}    btnMessageOk
    END
    RETURN    ${status}

Verify Document Notification Popup_Prerequisite
    [Arguments]    ${message}    ${button_option}
    [Documentation]    It is used to Verify notification popup and click ok/cancel button
    ${label.notification.newmessage}    Update Dynamic Value    ${label.notification.message}    ${message}
    Wait Until Element Is Visible    ${label.notification.newmessage}    ${MEDIUM_WAIT}
    Log Expected And Actual Results    ${message}    ${message}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    ${button_option}
    Wait Until Element Is Visible    ${button.notification.newok/cancel}    ${MEDIUM_WAIT}    ${button_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.notification.newok/cancel}

Get Downloads Folder Path
    [Documentation]    This keyword is used to get downloads path
    ${user_home}    Get Environment Variable    UserProfile
    ${DOWNLOADS_FOLDER}    Set Variable    ${user_home}\\Downloads
    Set Global Variable    ${DOWNLOADS_FOLDER}

Log Expected And Actual Results
    [Documentation]    This Keyword is Used to get Expected and Actual Results in Log file
    [Arguments]    ${actual_result}    ${expected_result}
    Log    Actual Result: ${actual_result}
    Log    Expected Result: ${expected_result}

Start Recording
    [Documentation]    This Keyword Is Used to Start Video Recording
    [Arguments]    ${record}    ${alias}=None
    ${name}    Get Unique Test Data    Unique
    IF    '${VIDEO}'=='True' or '${record}'=='True'    ScreenCapLibrary.Start Video Recording    alias=${alias}    name=Video${name}    fps=20    size_percentage=0.7

Stop Recording
    [Documentation]    This Keyword Is Used to Stop Video Recording
    [Arguments]    ${record}    ${alias}=None
    IF    '${VIDEO}'=='True' or '${record}'=='True'    ScreenCapLibrary.Stop Video Recording    alias=${alias}

Select Framework
    [Arguments]    ${frameworks}
    [Documentation]    This keyword is used to select framework
    #Wait Until Element Is Visible    ${textbox.system.create.entity.search}    ${MEDIUM_WAIT}    Search is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    @{select_frameworks}    Split String    ${frameworks}    ,
    FOR    ${key}    IN    @{select_frameworks}
        Select Value From Dropdown    ddlDefaultFrameworks_chosen    ${key}
        # Input Text    ${textbox.system.create.entity.search}    ${key}
        # ${label.system.create.entity.newframework}    Update Dynamic Value    ${label.system.create.entity.framework}    ${key}
        # Wait Until Element Is Visible    ${label.system.create.entity.newframework}    ${SHORT_WAIT}    ${key} is not visible after waiting ${SHORT_WAIT} seconds
        # Click Element    ${label.system.create.entity.newframework}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Set Validation Rule For Framework
    [Arguments]    ${criteria_basedon}    ${entity_status_validation}=None    ${task_dependency}=None    ${predecessor_list}=None
    [Documentation]    This Keyword is used to set validation rule for selected framework
    Wait Until Element Is Visible    ${link.system.create.entity.set_validation_rule}    ${MEDIUM_WAIT}    Validation Rule icon is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Time    3
    Click Element    ${link.system.create.entity.set_validation_rule}
    Unselect Frame
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Element Is Visible    ${label.system.create.entity_type.validation_criteria}    ${MEDIUM_WAIT}     Validation Criteria page is not visible after waiting ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    IF    "${criteria_basedon}"!="None"    Select Value For Radio Button    ValCrtBased    ${criteria_basedon}
    IF    "${entity_status_validation}"!="None"     Select Value From Dropdown    ${dropdown.system.create.entity.validation_criteria.status_validation}    ${entity_status_validation}
    IF    "${task_dependency}"!="None"
        Select Value For Radio Button    Dependency    ${task_dependency}
        IF    '${task_dependency}'=='rbtDependencyYes'
            ${index}    Set Variable    1
            @{predecessors}    Split String    ${predecessor_list}    ,
            FOR    ${key}    IN    @{predecessors}
                Wait Until Element Is Visible    (${dropdown.assessment.create.template.validation_criteria.predecessor})[${index}]    ${MEDIUM_WAIT}    Predecessor dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
                Select From List By Label    (${dropdown.assessment.create.template.validation_criteria.predecessor})[${index}]    ${key}
                ${index}    Evaluate    ${index}+1
            END
        END
    END

Set Validation Rule For Framework_Prerequisite
    [Arguments]    ${system_entity_data}
    [Documentation]    This Keyword is used to set validation rule for selected faramework
    Click Element    ${link.system.create.entity.set_validation_rule}
    Wait Until Time    ${SHORT_WAIT}
    #Unselect Frame
    Select Frame    ${iframe.library_frame.screen}
    #Wait Until Element Is Visible    ${label.system.create.entity_type.validation_criteria}    ${MEDIUM_WAIT}    Validation Criteria page is not visible after waiting ${MEDIUM_WAIT} seconds
    IF    'CriteriaBasedOn' in ${system_entity_data}    Select Value For Radio Button    rbtValDeliverables    ${system_entity_data}[CriteriaBasedOn]
    Wait Until Time    ${SHORT_WAIT}
    IF    'EntityStatusValidation' in ${system_entity_data}    Select Value From Dropdown    ddlEntStatusSelect_chosen    ${system_entity_data}[EntityStatusValidation]

Validation Criteria
    [Arguments]    ${system_entity_data}    ${val_framework_list}=None
    [Documentation]    This keyword is used to Verify criteria to set validation rule
    IF    'Deliverables' in ${system_entity_data}
        Wait Until Element Is Visible    ${label.System.create.entity.set_validation_rule.deliverables}    ${MEDIUM_WAIT}    Deliverables table is not visible after waiting ${MEDIUM_WAIT} seconds
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        Click Element    ${label.system.create.entity.set_validation_rule.deliverables_table}
        ${checkbox.system.create.entity.set_validation_rule.newdeliverables}    Update Dynamic Value    ${checkbox.system.create.entity.set_validation_rule.deliverables}    ${system_entity_data}[Deliverables]
        Select Checkbox    ${checkbox.system.create.entity.set_validation_rule.newdeliverables}
    END
    IF    'ValidationFrameworks' in ${system_entity_data}
        Wait Until Element Is Visible    ${textbox.assessment.create.template.validation_icon.popup.select_frameworks}    ${MEDIUM_WAIT}    FrameWork table is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${textbox.assessment.create.template.validation_icon.popup.select_frameworks}
        Wait Until Time    1
        @{val_frameworks}    Split String    ${val_framework_list}    ,
        FOR    ${value}    IN    @{val_frameworks}
            ${checkbox.assessment.create.template.validation_icon.popup.newselect_framework}    Update Dynamic Value    ${checkbox.assessment.create.template.validation_icon.popup.select_framework}    ${value}
            Wait Until Element Is Visible    ${checkbox.assessment.create.template.validation_icon.popup.newselect_framework}   ${SHORT_WAIT}    checkbox is not visible after waiting ${SHORT_WAIT} seconds
            Wait Until Time    1
            Select Checkbox    ${checkbox.assessment.create.template.validation_icon.popup.newselect_framework}
        END
    END
    Click Button    ${checkbox.system.create.entity.set_validation_rule.deliverables.save}
    Wait Until Time    3
    Verify Success Message    ${system_entity_data}[SuccessMessage]    btnMessageOk
    Unselect Frame
    Wait Until Element Is Visible    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}    ${MEDIUM_WAIT}    Close button is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}
    Select Frame    ${iframe.framecontent}
    IF    'Deliverables' in ${system_entity_data}
        Wait Until Element Is Visible    ${label.system.create.entity_type}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting ${MEDIUM_WAIT} seconds
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Delete A Row From The Table
    [Arguments]    ${select_row_to_delete}
    [Documentation]    This keyword is used to Delete a Row From The Table
    ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${select_row_to_delete}
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${MEDIUM_WAIT}    ${select_row_to_delete} row is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    ${row_count_before_delete}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    Click Element    ${label.content.author.content_library.create.add_row.newrow_no}
    ${label.content.author.content_library.create.add_row.newselected_row_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.selected_row_no}    ${select_row_to_delete}
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newselected_row_no}    ${MEDIUM_WAIT}    selected row is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${icon.content.author.content_library.create.table.delete_row}
    Wait Until Time    4
    ${row_count_after_delete}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    ${exp_count}    Evaluate    ${row_count_before_delete}-1
    Should Be Equal    ${row_count_after_delete}    ${exp_count}
    Log Expected And Actual Results    Selected row is deleted from the content table    Selected row should be deleted from the content table
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Add/Insert A Row In The Table
    [Arguments]    ${select_row_to_insert}    ${function}=Insert
    [Documentation]    This keyword is used to Insert/Add a Row In The Table
    Wait Until Element Is Visible    ${icon.content.author.content_library.create.table.add_row}    ${MEDIUM_WAIT}    Add Icon is not displaying after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    ${row_count_before_insert}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    IF    '${function}'=='Insert'
        ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${select_row_to_insert}
        Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${LONG_WAIT}    ${select_row_to_insert} row is not visible after waiting for ${LONG_WAIT} seconds
        Click Element    ${label.content.author.content_library.create.add_row.newrow_no}
        ${label.content.author.content_library.create.add_row.newselected_row_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.selected_row_no}    ${select_row_to_insert}
        Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newselected_row_no}    ${MEDIUM_WAIT}    selected row is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${icon.content.author.content_library.create.table.insert_row}
    ELSE IF    '${function}'=='Add'
        Click Element    ${icon.content.author.content_library.create.table.add_row}
    END
    Wait Until Time    4
    ${row_count_after_insert}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    ${exp_count}    Evaluate    ${row_count_before_insert}+1
    Should Be Equal    ${row_count_after_insert}    ${exp_count}
    RETURN    ${row_count_after_insert}

Expand Tree View_Prerequisite
    [Arguments]    ${locator}    ${tree_view}    ${entity_name}
    [Documentation]    Is is used to expand the tree view
    @{splitted_tree_view}    Split String    ${tree_view}    ,
    ${tree_view_count}    Get Length    ${splitted_tree_view}
    FOR    ${key}    IN RANGE    0    ${tree_view_count}
        IF    '${splitted_tree_view}[${key}]'=='$'
            ${icon.inventory.tree_view.newplus}    Update Dynamic Values    ${icon.inventory.tree_view.plus}    ${locator}    ${entity_name}
            Scroll Till Element Is Visible    ${icon.inventory.tree_view.newplus}
            Wait Until Element Is Visible    ${icon.inventory.tree_view.newplus}    ${MEDIUM_WAIT}    ${tree_view} plus is not visible after waiting ${MEDIUM_WAIT} seconds
            Click Element    ${icon.inventory.tree_view.newplus}
            Wait Until Time    1
        ELSE
            ${icon.inventory.tree_view.newplus}    Update Dynamic Values    ${icon.inventory.tree_view.plus}    ${locator}    ${splitted_tree_view}[${key}]
            Scroll Till Element Is Visible    ${icon.inventory.tree_view.newplus}
            Wait Until Element Is Visible    ${icon.inventory.tree_view.newplus}    ${MEDIUM_WAIT}    ${tree_view} plus is not visible after waiting ${MEDIUM_WAIT} seconds
            Click Element    ${icon.inventory.tree_view.newplus}
            Wait Until Time    1
        END
    END

Navigate To Entity And Expand Tree View
    [Arguments]    ${tree_view}    ${entity_name}
    [Documentation]    It is used to expand tree view to operational qualification
    Wait Until Time    3
    #Click Top Menu Icons  Inventory
    Select Frame    ${iframe.framecontent}
    Wait Until Element Is Visible    ${label.home.inventory}    ${MEDIUM_WAIT}    Inventory is not visible after waiting ${MEDIUM_WAIT} seconds
    Wait Until Time    ${SHORT_WAIT}
    Navigate To Page Title Tab   Default
    Navigate To Page Title Tab    Entity
    Expand Tree View_Prerequisite    Treeview    ${tree_view}    ${entity_name}

Select Value From Table Dropdown
    [Arguments]    ${value}
    [Documentation]    This keyword is used to select entity from list of entities.
    Click Element    ${label.content.assign.document.initiate.entity_search}
    Input Text    ${label.content.assign.document.initiate.entity_search}    ${value}
    Wait Until Time    4
    ${label.content.assign.document.initiate.newentity}    Update Dynamic Value    ${label.content.assign.document.initiate.entity}    ${value}
    #Wait for
    Wait Until Element Is Visible    ${label.content.assign.document.initiate.newentity}    ${LONG_WAIT}    ${value} message is not visible after waiting ${MEDIUM_WAIT} seconds
    ${Status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.content.assign.document.initiate.newentity}
    IF    '${Status}'=='True'    
        Click Element   ${label.content.assign.document.initiate.newentity}
    ELSE
        Click Element    ${label.select.entity.content.upload.document}
    Wait Until Time    3
    END
Get Login Username
    [Documentation]    This keyword is used to get login username
    Unselect Frame
    Wait Until Time    3
    Javascript Click    ${label.home.login_name}
    Wait Until Time    3
    ${LOGIN_NAME}    Get Text    ${label.home.profile_name}
    Set Suite Variable    ${LOGIN_NAME}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Get Timezone
    [Documentation]    This keyword is used to get timezone
    Unselect Frame
    Wait Until Element Is Visible    ${label.home.time_zone}
    ${TIME_ZONE}    Get Text    ${label.home.time_zone}
    Set Suite Variable    ${TIME_ZONE}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify And Submit Electronic Signature
    [Arguments]    ${login_user}    ${login_password}    ${exception_data}    ${activity}
    [Documentation]    This keyword is used to Verify electronic signature popup and submit it
    ${expected_date_and_time}    Get Current Date    result_format=%d/%m/%Y %I:%M
    Verify Electronic Signature    ${activity}    ${expected_date_and_time}    ${login_user}
    Handle Electronic Sign    ${login_user}    ${login_password}    Submit    ${exception_data}[ReasonForEsign]

Verify Electronic Signature
    [Arguments]    ${expected_activity}    ${expected_date_and_time}    ${logged_in_user}
    [Documentation]    This keyword is used to Verify activity, date and time and logged_in from electronic sign
    Wait Until Time    2
    ${actual_activity}    Get Text    ${label.execution.execute.returned_deviation.esign.activity}
    Verify String Should Be Equal    ${expected_activity}    ${actual_activity}
    ${actual_date_and_time}    Get Text    ${label.execution.execute.returned_deviation.esign.date_and_time}
    Verify String Should Contain    ${actual_date_and_time}    ${expected_date_and_time}
    ${actual_username}    Get Text    ${label.electronic_sign.popup.loggedin_user}
    ${USER}    Set Variable    [${logged_in_user}] - Title
    Set Suite Variable    ${USER}
    Verify String Should Be Equal    ${LOGIN_NAME} ${USER}    ${actual_username}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Select Answers For Questions In Decision Tree
    [Arguments]    ${grid_list}    ${button_name}
    [Documentation]    It is used to select answers for questions in decision tree
    @{list}    Split String    ${grid_list}    |
    ${index}    Set Variable    1
    FOR    ${key}    IN    @{list}
        ${index}    Convert To String    ${index}
        ${label.decision_tree.question.newoption}    Update Dynamic Values    ${label.decision_tree.question.option}    ${index}    ${key}
        Wait Until Element Is Visible    ${label.decision_tree.question.newoption}    ${SHORT_WAIT}
        Wait Until Keyword Succeeds    10s    2s    Click Element    ${label.decision_tree.question.newoption}
        ${index}    Evaluate    ${index}+1
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${textbox.content.author.doc.decision_tree.justification}    2s
        IF    '${status}'=='True'    Input Text    ${textbox.content.author.doc.decision_tree.justification}    Test
        Select Previous/Next Button In Decision Tree_Prerequisite    Next
        ${status1}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.content.author.doc.decision_tree.complete}    2s
        IF    '${status1}'=='True'    BREAK
    END
    Click Button In VLMS    ${button_name}

Select Previous/Next Button In Decision Tree_Prerequisite
    [Arguments]    ${button_option}
    [Documentation]    It is used to select previuos or next button
    ${button.content.author.doc.decision_tree.newprevious/next}    Update Dynamic Value    ${button.content.author.doc.decision_tree.previous/next}    ${button_option}
    Click Element    ${button.content.author.doc.decision_tree.newprevious/next}

Select Entity/Entity Type Using Filter
    [Arguments]    ${entity_list}    ${id}=GridLookup_B-1    ${fields_id}=GridLookup
    [Documentation]    This keyword is used to select entities or entity types
    Wait Until Time    2
    ${dropdown.project.create.project.newentity}    Update Dynamic Value     ${dropdown.project.create.project.entity}   ${id}
    Click Element   ${dropdown.project.create.project.newentity}
    @{list}    Split String    ${entity_list}    ,
    FOR    ${key}    IN    @{list}
        ${textbox.system.create.bind_task.entity.newsearch}    Update Dynamic Value    ${textbox.system.create.bind_task.entity.search}    ${fields_id}
        Wait Until Element Is Visible    ${textbox.system.create.bind_task.entity.newsearch}    ${MEDIUM_WAIT}    Entity search box is not visible after waiting ${MEDIUM_WAIT} seconds
        Wait Until Time    3
        Input Text    ${textbox.system.create.bind_task.entity.newsearch}    ${key}
        ${checkbox.system.create.bind_task.newentity}    Update Dynamic Value    ${checkbox.system.create.bind_task.entity}   ${key}
        Wait Until Element Is Visible    ${checkbox.system.create.bind_task.newentity}    ${MEDIUM_WAIT}    Entity checkbox is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${checkbox.system.create.bind_task.newentity}
        Clear Element Text    ${textbox.system.create.bind_task.entity.newsearch}
    END
    Wait Until Time    2
    ${button.system.create.bind_task.entity.newsave}    Update Dynamic Value    ${button.system.create.bind_task.entity.save}    ${fields_id}
    Javascript Click    ${button.system.create.bind_task.entity.newsave}

Select Multiple Checkboxes In A Screen
    [Arguments]    ${locator}    ${select_count}
    [Documentation]    This keyword is used to Select Multiple Checkboxes In A Screen
    ${count}    Get Element Count    ${locator}
    ${status}    Run Keyword And Return Status    Should Be True    ${select_count}<${count}
    IF    '${status}'=='True'
        FOR    ${index}    IN RANGE    1    ${select_count}+1
            Wait Until Element Is Visible    (${locator})[${index}]    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
            Select Checkbox    (${locator})[${index}]
        END
    ELSE
        FOR    ${index}    IN RANGE    1    ${count}+1
            Wait Until Element Is Visible    (${locator})[${index}]    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
            Select Checkbox    (${locator})[${index}]
        END
    END

Menu Navigation_5.0
    [Arguments]    ${MainMenu}    ${Section}=None    ${tab}=None
    ${button.newmodule}    Update Dynamic Value    ${button.module_5.0}    ${MainMenu}
    Wait Until Element Is Visible    ${button.newmodule}    ${LONG_WAIT}
    Click Element    ${button.newmodule}
    ${button.newmodule.tab.content_5.0}    Update Dynamic Value    ${button.module.tab.content_5.0}    ${Section}
    Wait Until Element Is Visible    ${button.newmodule.tab.content_5.0}    ${LONG_WAIT}
    Click Element    ${button.newmodule.tab.content_5.0}
    Select Frame    ${iframe.framecontent}
    IF    "${tab}"!="None"
        ${LinkText.system.System.Taxonomy.new}    Update Dynamic Value    ${LinkText.system.System.Taxonomy}    ${tab}
        Wait Until Element Is Visible    ${LinkText.system.System.Taxonomy.new}
        Click Element    ${LinkText.system.System.Taxonomy.new}
    END

Read Multiple TestData From Excel
    [Arguments]           ${TESTDATA_FOLDER}    ${sheet_name}    
    [Documentation]    Read Multiple TestData from excel file for required data.
    ${expected_data}    Get Data Values     ${TESTDATA_FOLDER}    ${sheet_name}
    RETURN    ${expected_data}

select_task
    [Arguments]    ${TaskID}
    Unselect Frame
    Wait Until Time    ${MEDIUM_WAIT}
    #Mouse Over    ${textbox.search.task.common}
    Wait Until Element Is Visible    ${textbox.search.task.common}    ${SHORT_WAIT}
    Input Text    ${textbox.search.task.common}    ${TaskID}
    Click Element    ${button.search.task.common}
    Select Frame    ${iframe.framecontent}
    ${select.task.common.new}    Update Dynamic Value    ${linktext.select.task.common}    ${TaskID}
    Wait Until Element Is Visible    ${select.task.common.new}    ${SHORT_WAIT}
    Click Element    ${select.task.common.new}

Validation Criteria_Prerequisite
    [Arguments]    ${system_entity_data}
    [Documentation]    This keyword is used to validate criteria to set validation rule
    Wait Until Time    3
    #Click Element    ${label.system.create.entity.set_validation_rule.deliverables_table}
    IF    'EntityStatusValidation' in ${system_entity_data}
        #${checkbox.system.create.entity.set_validation_rule.newdeliverables}    Update Dynamic Value    ${checkbox.system.create.entity.set_validation_rule.deliverables}    ${system_entity_data}[Deliverables]
        #Select Checkbox    ${checkbox.system.create.entity.set_validation_rule.newdeliverables}
        Select Value From Dropdown    chkBoxDeliverables_chosen    ${system_entity_data}[Deliverables]
    END
    Click Button    ${checkbox.system.create.entity.set_validation_rule.deliverables.save}
    Wait Until Time    5
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    Javascript Click    //input[@id='btnSliderClose']
    #Validate Success Message    ${system_entity_data}[SuccessMessage]
    
    #Wait Until Element Is Visible    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}    ${MEDIUM_WAIT}    Close button is not visible after waiting ${MEDIUM_WAIT} seconds
    #Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}
    
    Wait Until Element Is Visible    ${label.system.create.entity_type}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting ${MEDIUM_WAIT} seconds

Get Value From Toast Message
    [Arguments]    ${ExpectedResult}
    Wait Until Element Is Visible    ${toast.common.verify Message}    20
    ${Actual_Result}    Get Text    ${toast.common.verify Message}
    ${Color}    Get Element Attribute    ${toastmessage.popup.verify.common}    class
    ${status}    Run Keyword And Return Status    Should Contain    ${Color}    alert-success
    #Should Contain   ${Color}    alert-success show
    Verify String Should Be Equal    ${ExpectedResult}    ${Actual_Result}
        
        
    
    
        
    
    
Select DropDown value from Table
    [Arguments]    ${Dropdownid}    ${Dropdownvalue}
    ${table.dropdown.select.common.new}    Update Dynamic Value    ${table.dropdown.select.common}    ${Dropdownid}
    Click Element    ${table.dropdown.select.common.new}
    ${dropdown.table.common.select.value.new}    Update Dynamic Value    ${dropdown.table.common.select.value}    ${Dropdownvalue}
    Scroll Element Into View    ${dropdown.table.common.select.value.new}
    Click Element    ${dropdown.table.common.select.value.new}


Enter Text In Mandatoy Field with TextField
    [Documentation]    This keyword is used to enter text in mandatory textbox field
    [Arguments]    ${text_field}    ${text}
    ${textbox.common.mandatory.newtext_field}    Update Dynamic Value    ${textbox.common.mandatory.textfieldsarea}    ${text_field}
    Wait Until Element Is Visible    ${textbox.common.mandatory.newtext_field}    ${MEDIUM_WAIT}    ${text_field} is not visible after waiting ${MEDIUM_WAIT} seconds
    Javascript Click    ${textbox.common.mandatory.newtext_field}
    Wait Until Time    2
    Javascript Input Text    ${textbox.common.mandatory.newtext_field}    ${text}

