*** Settings ***
Documentation     This home Resource file has all the home page keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Click Top Menu Icons
    [Arguments]    ${Menu}
    [Documentation]    It is used to Click top menu icons
    #Wait Until Element Is Visible    ${dropdown.icon.topmenu}    ${MEDIUM_WAIT}
    Wait Until Element Is Enabled    ${dropdown.click}
    Javascript Click    ${dropdown.click}
    ${dropdown.select.view. Profile.new}    Update Dynamic Value    ${dropdown.select.view. Profile}    ${Menu}
    Click Element    ${dropdown.select.view. Profile.new}
    Wait Until Time    4

Navigate To Module Tab
    [Arguments]    ${module}    ${tab_option}    ${sub_menu_option}    ${page_title}    ${js_click}=False
    [Documentation]    Navigate to Module Tab
    Unselect Frame
    Navigate To Main Menu    ${module}    ${js_click}
    Navigate To Menu Tab    ${tab_option}
    Navigate To Tab Content    ${sub_menu_option}    ${page_title}

Navigate To Main Menu
    [Arguments]    ${module}    ${js_click}
    [Documentation]    It is used to select left menu option on home page
    ${button.newmodule}    Update Dynamic Value    ${button.module}    ${module}
    Wait Until Element Is Visible    ${button.newmodule}    ${MEDIUM_WAIT}    ${module} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    IF    '${js_click}'=='False'    Click Element    ${button.newmodule}    ELSE   Javascript Click    ${button.newmodule}

Navigate To Menu Tab
    [Arguments]    ${tab_option}
    [Documentation]    It is used to select menu tab option
    ${button.module.newtab}    Update Dynamic Value    ${button.module.tab}    ${tab_option}
    Wait Until Element Is Visible    ${button.module.newtab}    ${MEDIUM_WAIT}    ${tab_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.module.newtab}

Navigate To Tab Content
    [Arguments]    ${sub_menu_option}    ${page_title}
    [Documentation]    It is used to select contents in that tab
    ${button.module.tab.newcontent}    Update Dynamic Value    ${button.module.tab.content}    ${sub_menu_option}
    Wait Until Element Is Visible    ${button.module.tab.newcontent}    ${MEDIUM_WAIT}    ${sub_menu_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.module.tab.newcontent}
    Select Frame    ${iframe.framecontent}
    ${label.module.tab.content.newpage}    Update Dynamic Value    ${label.module.tab.content.page}    ${page_title}
    Wait Until Element Is Visible    ${label.module.tab.content.newpage}    ${MEDIUM_WAIT}    ${page_title} is not visible after waiting for ${MEDIUM_WAIT} seconds

Navigate To Dashboard Title Tabs
    [Arguments]    ${tab_name}    ${subtab_name}=none
    [Documentation]    It is used to navigate to Dashboard tabs in home page ex: My Task
    ${button.home_page.title.newtabs}    Update Dynamic Value    ${button.home_page.title.tabs}    ${tab_name}
    Wait Until Element Is Visible    ${button.home_page.title.newtabs}    ${MEDIUM_WAIT}
    Javascript Click    ${button.home_page.title.newtabs}
    Wait Until Time    4
    IF    '${tab_name}'=='Task List'
        Select Frame    ${iframe.framecontent}
        ${button.home_page.title.newsubtabs}    Update Dynamic Value    ${button.home_page.title.subtabs}    ${subtab_name}
        Wait Until Element Is Visible    ${button.home_page.title.newsubtabs}    ${MEDIUM_WAIT}
        Javascript Click    ${button.home_page.title.newsubtabs}
        Wait Until Time    4
    END

Click Document Id From My Task
    [Arguments]    ${document_id}
    [Documentation]    It is used to select document with id from my task
    Wait Until Element Is Visible    ${textbox.home.search}    ${MEDIUM_WAIT}    Search textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    4
    Javascript Click    ${textbox.home.search}
    Javascript Input Text    ${textbox.home.search}    ${document_id}
    ${label.home.newdocument}    Update Dynamic Value    ${label.home.document}    ${document_id}
    Wait Until Time    2
    Javascript Click    ${label.home.newdocument}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}

Logout From VLMS Application
    [Documentation]    This Keyword is used to Logout from VLMS application
    Unselect Frame
    Click Top Menu Icons    Logout
    Wait Until Element Is Visible    ${textbox.login.username}    ${LONG_WAIT}    Login page is not visible after waiting for ${LONG_WAIT} seconds
    Log Expected And Actual Results    Login page is displayed    Login page should be displayed
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Search Task Under My Task List
    [Arguments]    ${task_id}
    [Documentation]    It is used to search for the task with id under My task list
    Click Top Menu Icons    Home
    Navigate To Dashboard Title Tabs    Task List    My Task
    Wait Until Element Is Visible    ${textbox.home.search}    ${LONG_WAIT}    Search textbox is not visible after waiting for ${LONG_WAIT} seconds
    Wait Until Time    4
    Javascript Click    ${textbox.home.search}
    Input Text    ${textbox.home.search}    ${task_id}

Verify Task Is Displayed Under My Task List
    [Arguments]    ${task_id}
    [Documentation]    It is used to Verify the task with id under My task list
    ${label.home.newtask}    Update Dynamic Value    ${label.home.document}    ${task_id}
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.home.newtask}    ${MEDIUM_WAIT}    ${task_id} is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Unselect Frame
