*** Settings ***
Documentation     This admin resource file has all the admin keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Create Role
  [Documentation]     This keyword used to create role
  [Arguments]    ${Role_Data}
  Click Button in VLMS    Create
  ${count}    Get Length    ${Role_Data}
  FOR    ${key}    IN RANGE    0    ${count}
        ${Role_data}    Set Variable    ${Role_Data}[${key}]
        Wait Until Time    ${SHORT_WAIT}
        IF    'Role Type' in ${Role_data}    Select Value From Dropdown    ddlRoleType_chosen    ${Role_data}[Role Type]
        Wait Until Time    3
        IF    'SiteName' in ${Role_data}    Select Value From Dropdown    ddlSite_chosen    ${Role_data}[SiteName]
        Wait Until Time    3
        Wait Until Element Is Visible    ${textbox.rolename.field}    ${MEDIUM_WAIT}    textbox is not visible after ${MEDIUM_WAIT} Seconds    
        IF    'Role Name' in ${Role_data}    Input Text    ${textbox.rolename.field}    ${Role_data}[Role Name]
        ${Role}    Set Variable    ${Role_data}[Role Name]
        IF    'Description' in ${Role_data}    Input Text    ${textbox.Role.Description.field}    ${Role_data}[Description]
        IF    'Button' in ${Role_data}    Select Submit/Reset Button    ${Role_data}[Button]
        
        ${Expected_Result}    Set Variable    ${Role_data}[Role Name] Role has been created
        ${Sts}    Get Value From Toast Message    ${Expected_Result}
        Access control setting in VLMS    ${Role_data}    ${USER}    ${USER_PASSWORD}
        Provide access to role profile    ${Role_data}
    END

Navigate To access RoleProfile
    [Documentation]    This keyword will navigate to role profile page
    [Arguments]    ${Role_data}
    Unselect Frame
    Mouse Over    ${icon.home}    
    Menu Navigation_5.0   Administration    Role    
    select_task    ${Role_data}[Role Name]
    Wait Until Element Is Enabled    ${button.edit.view.role}
    Click Element    ${button.edit.view.role}

Provide access to role profile
    [Documentation]    This keyword will provide access to Role Profile
    [Arguments]    ${Role_data}
    Navigate To access RoleProfile    ${Role_data}
    #${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Role Profile
    #Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Role Profile access page is not visible after waiting for ${MEDIUM_WAIT} seconds
    #IF     'SiteName' in ${Role_data}    Select Value From Dropdown    select2-ddlSite-container    ${Role_data}[SiteName]
    #Wait Until Element Is Visible    //span[@id="select2-ddlRName-container"]    ${MEDIUM_WAIT}     Role Profile access page is not visible after waiting for ${MEDIUM_WAIT} seconds
    #IF    'Role Name' in ${Role_data}    Select Value From Dropdown    select2-ddlRName-container    ${Role_data}[Role Name]
    Wait Until Time    ${MEDIUM_WAIT}
    IF    'No Access' in ${Role_data}    Check Checkboxes of No Access in role profile    ${Role_data}[No Access]
    IF    'View Access' in ${Role_data}    Check Checkboxes of View Access in role profile    ${Role_data}[View Access]
    IF    'Full Access' in ${Role_data}    Check Checkboxes of Full Access in role profile    ${Role_data}[Full Access]
    IF    'Override User Profile?' in ${Role_data}    Select Value For Radio Button    Override    ${Role_data}[Override User Profile?]
    Click Button in VLMS    Submit
    Wait Until Time    ${SHORT_WAIT}
    IF    'Comments' in ${Role_data}    Input Text    ${textarea.comments.edit.roleprofile.access}    ${Role_data}[Comments]
    Click Element    ${button.submit.edit.roleprofile.access}
    ${Expected_Result}    Set Variable    ${Role_data}[Role Name] Role has been edited
    IF    'Override User Profile?' in ${Role_data} == 'rbtnOverrideUserYes'
        ${Expected_Result}    Set Variable    Are you sure want to override all User Profile    
        Get Value From Toast Message    Are you sure want to override all User Profile
    ELSE
        Get Value From Toast Message    ${Expected_Result}
    END

Check Checkboxes of No Access in role profile
    [Documentation]    This keyword will check checkboxes of no access in role profile
    [Arguments]    ${groups_values}
    ${groups_list_items}    Split String    ${groups_values}    ,
    ${count}    Get Length    ${groups_list_items}
    FOR    ${key}    IN RANGE   0    ${count}
        ${updated.checkbox.roleprofile.noaccess}    Update Dynamic Value    ${checkbox.roleprofile.noaccess}    ${groups_list_items}[${key}]
        ${source_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${updated.checkbox.roleprofile.noaccess}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible after waiting ${MEDIUM_WAIT} seconds
        IF    '${source_status}'=='True'
            Wait Until Time    3
            Click Element    ${updated.checkbox.roleprofile.noaccess}
            Wait Until Time    3
        END
    END

Check Checkboxes of View Access in role profile
    [Documentation]    This keyword will check checkboxes of no access in role profile
    [Arguments]    ${groups_values}
    ${groups_list_items}    Split String    ${groups_values}    ,
    ${count}    Get Length    ${groups_list_items}
    FOR    ${key}    IN RANGE   0    ${count}
        ${updated.checkbox.roleprofile.viewaccess}    Update Dynamic Value    ${checkbox.roleprofile.viewaccess}    ${groups_list_items}[${key}]
        ${source_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${updated.checkbox.roleprofile.viewaccess}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible after waiting ${MEDIUM_WAIT} seconds
        IF    '${source_status}'=='True'
            Click Element    ${updated.checkbox.roleprofile.viewaccess}
            Wait Until Time    3
        END
    END

Check Checkboxes of Full Access in role profile
    [Documentation]    This keyword will check checkboxes of no access in role profile
    [Arguments]    ${groups_values}
    ${groups_list_items}    Split String    ${groups_values}    ,
    ${count}    Get Length    ${groups_list_items}
    FOR    ${key}    IN RANGE   0    ${count}
        ${updated.checkbox.roleprofile.fullaccess}    Update Dynamic Value    ${checkbox.roleprofile.fullaccess}    ${groups_list_items}[${key}]
        ${source_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${updated.checkbox.roleprofile.fullaccess}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible after waiting ${MEDIUM_WAIT} seconds
        IF    '${source_status}'=='True'
            Click Element    ${updated.checkbox.roleprofile.fullaccess}
            Wait Until Time    3
        END
    END


Create User or Provide Cross Site Access
    [Arguments]    ${User_Data}
    ${count_row}    Get Length    ${User_Data}
    FOR    ${key}    IN RANGE    0    ${count_row}
    ${dict_data}    Set Variable    ${User_Data}[${key}]
        IF    '${dict_data}[NewUserCreationRequired?]' == 'Yes'
            ##Menu    Administrator    Administrator    User
            Creation_User    ${dict_data}
            SignUp_User    ${dict_data}
            ActivateUser    ${dict_data}    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}   
            FirstLogin    ${dict_data}
        ELSE
            ${dict_data}    Set Variable    ${dict_data}
            Access Cross-Site Profile    ${dict_data}
            Logout From VLMS Application
            Primary Site Setup    ${dict_data}
        END
    END

Creation_User
    [Arguments]    ${dict_data}
    ##Click Button in VLMS    Create
        Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
        Menu Navigation_5.0    Administration    User
        ${FirstName}    Set Variable    ${dict_data}[FirstName]
        ${LastName}    Set Variable    ${dict_data}[LastName]
        ${UserID}    Set Variable    ${dict_data}[UserID]
        ${EMailID}    Set Variable    ${dict_data}[EMailID]
        ${TemporaryPassword}    Set Variable    ${dict_data}[TemporaryPassword]
        ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create User
        Click Button in VLMS    Create
        Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create User is not visible ${MEDIUM_WAIT} seconds
        Select Value From Dropdown    ddlSite_chosen    ${dict_data}[SiteName]
        Wait Until Time    3
        Select Value From Dropdown    ddlRole_chosen    ${dict_data}[Role Name]
        Wait Until Time    3
        Select Value From Dropdown    ddlDepartment_chosen    ${dict_data}[DepartmentName]
        Wait Until Time    3
        Select Value From Dropdown    drTitle_chosen    ${dict_data}[TitleName]
        Wait Until Time    3
        IF    'FirstName' in ${dict_data}    Enter Text In Mandatory Fields    FirstName    ${FirstName}
        IF    'LastName' in ${dict_data}    Enter Text In Mandatory Fields    LastName    ${LastName}
        IF    'UserID' in ${dict_data}    Enter Text In Mandatory Fields    UserName    ${UserID}
        Set Suite Variable    ${User}
        Set Global Variable    ${User}
        Wait Until Time    3
        IF    'EMailID' in ${dict_data}    Enter Text In Mandatory Fields    Email    ${EMailID}
                Enter Text In Mandatory Fields    REEmail    ${EMailID}
        IF    'TemporaryPassword' in ${dict_data}    Enter Text In Mandatory Fields    Pwd    ${TemporaryPassword}
                Enter Text In Mandatory Fields    RPwd    ${TemporaryPassword}
        Select Submit/Reset Button    Submit
        ${Expected_Result}    Set Variable    ${FirstName} ${LastName} User Account has been created
        Get Value From Toast Message    ${Expected_Result}
        Wait Until Time    ${SHORT_WAIT}
        Logout From VLMS Application

SignUp_User
    [Arguments]    ${dict_data}
    
        ${Password}    Set Variable    ${dict_data}[Password]
        ${UserID}    Set Variable    ${dict_data}[UserID]
        ${TemporaryPassword}    Set Variable    ${dict_data}[TemporaryPassword]
        ${FirstName}    Set Variable    ${dict_data}[FirstName]
        ${LastName}    Set Variable    ${dict_data}[LastName]
        Wait Until Element Is Visible    ${textbox.login.username}    ${LONG_WAIT}    Login page is not visible after waiting for ${LONG_WAIT} seconds
        Input Text    ${textbox.login.username}    ${UserID}
        Input Text    ${textbox.login.password}    ${TemporaryPassword}
        ${button.newsubmit/reset}    Update Dynamic Value    ${button.submit/reset}    Submit
        Javascript Click    ${button.newsubmit/reset}
        ##Wait Until Element Is Visible    ${label.admin.signup.user}
        ##Click Element    ${label.admin.signup.user}
        ##Wait Until Element Clickable    //input[@id="txtUserName"]
        ##Input Text    //input[@id="txtUserName"]    ${UserID}
        ##Wait Until Time    2
        ##Input Text    //*[@id='txtPassword']    ${TemporaryPassword}
        ##Wait Until Time    2
        ##Press Keys    None    TAB
        # Click Element    //input[@id="txtRole"]
        #Wait Until Time    2
        #Select Submit/Reset Button    Submit
        Wait Until Time    ${SHORT_WAIT}
        Enter Text In Mandatory Fields    Password    ${Password}
        Enter Text In Mandatory Fields    REPassword    ${Password}
        Enter Text In Mandatory Fields    Offlinepwd    ${Password}
        Enter Text In Mandatory Fields    ROfflinepwd    ${Password}
        Select Submit/Reset Button    Save
        ${Expected_Result}    Set Variable    ${FirstName} ${LastName} User Account has been enrolled
        Get Value From Toast Message    ${Expected_Result}
        Wait Until Time    4
    

ActivateUser
    [Arguments]    ${dict_data}    ${AUTHOR}    ${AUTHOR_PASSWORD}
    Login To VLMS Application    ${AUTHOR}    ${AUTHOR_PASSWORD}
    Menu Navigation_5.0    Administration    User    
    ${UserID}    Set Variable    ${dict_data}[UserID]
    Wait Until Element Is Visible    ${tab.Activateuser.Administartion.User}
    Click Element    ${tab.Activateuser.Administartion.User}
    Unselect Frame
    Wait Until Element Is Visible    ${textbox.search.task.common}    ${SHORT_WAIT}
    Input Text    ${textbox.search.task.common}    ${UserID}
    Click Element    ${button.search.task.common}
    Select Frame    ${iframe.framecontent}
    Wait Until Time    ${SHORT_WAIT}
    # Wait Until Element Is Visible    ${button.edit.view.role}
    # Click Element    ${button.edit.view.role}
    # Wait Until Element Is Visible    ${button.action.common}    ${SHORT_WAIT}
    # Javascript Click    ${button.action.common}
    # Wait Until Time    ${SHORT_WAIT}
    ${checkbox.Activateuser.Administartion.User.new}    Update Dynamic Value    ${checkbox.Activateuser.Administartion.User}    ${UserID}
    Wait Until Element Is Visible    ${checkbox.Activateuser.Administartion.User.new}    ${SHORT_WAIT}
    Click Element    ${checkbox.Activateuser.Administartion.User.new}
    ##Click Element    ${label.admin.activateuser}
    # Wait Until Time    ${SHORT_WAIT}
    # Input Text    ${textarea.comments.edit.roleprofile.access}    User Activated
    #Handle Electronic Sign_Prerequisite    ${AUTHOR}    ${AUTHOR_PASSWORD}    Submit
    Wait Until Element Is Enabled    ${button.submit.esign.common}
    Click Element    ${button.submit.esign.common}
    ${Expected_Result}    Set Variable    ${UserID} User Account has been activated
    Get Value From Toast Message    ${Expected_Result}
    Logout From VLMS Application

FirstLogin
    [Arguments]    ${dict_data}
    Wait Until Time    ${MEDIUM_WAIT}
    
        ${Password}    Set Variable    ${dict_data}[Password]
        Set Suite Variable    ${Password}
        ${UserID}    Set Variable    ${dict_data}[UserID]
        Set Suite Variable    ${UserID}
        Enter Text In Mandatory Fields    UserName    ${UserID}
        Enter Text In Mandatory Fields    Password    ${Password}
        Comment    Select Value From Dropdown    ddlSetTimeZone    (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
        Wait Until Time    ${SHORT_WAIT}
        Select Value From Dropdown    ddlSetTimeZone_chosen    (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
        ##Click Element    ${dropdown.timezone}
        ##${dropdown.timezone.newvalue}    Update Dynamic Value    ${dropdown.timezone.value}    (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
        ##Click Element    ${dropdown.timezone.newvalue}
        Select Submit/Reset Button    Submit
        ${alert}    Run Keyword And Return Status    Get Value From Toast Message    You have no access rights contact your administrator
        IF    '${alert}'=='True'    
            Login To VLMS Application    ${USER}    ${USER_PASSWORD}
            Menu Navigation_5.0    Administrator    User
            Login To VLMS Application    ${USER}    ${USER_PASSWORD}    
            Menu Navigation_5.0    Administrator    User
            select_task    ${UserID}
            Wait Until Element Is Enabled    ${button.edit.view.role}
            Click Element    ${button.edit.view.role}
            IF    'No Access' in ${dict_data}    Check Checkboxes of No Access in role profile    ${dict_data}[No Access]
            IF    'View Access' in ${dict_data}    Check Checkboxes of View Access in role profile    ${dict_data}[View Access]
            IF    'Full Access' in ${dict_data}    Check Checkboxes of Full Access in role profile    ${dict_data}[Full Access]
            Select Submit/Reset Button    Submit
            Input Text    ${textarea.comments.edit.roleprofile.access}    User Profile Updated
            Select Submit/Reset Button    Submit
            ${Expected_Result}    Set Variable    ${UserID} ${dict_data}[LastName] User Account has been edited
            Get Value From Toast Message   ${Expected_Result}
            Logout From VLMS Application
            Enter Text In Mandatory Fields    UserName    ${UserID}
            Enter Text In Mandatory Fields    Password    ${Password}
            Select Value From Dropdown    ddlSetTimeZone_chosen    (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
            Select Submit/Reset Button    Submit
        END
        ${alert_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.Reporting.manager.alert}    ${SHORT_WAIT}    Expire password alert is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    '${alert_status}'=='True'    Click Element    ${button.ok.reporting.manager.popup}
        Select Frame    ${iframe.framecontent}
        Wait Until Time    3
        Wait Until Element Clickable    ${checkbox.reporting.manager.click}
        Wait Until Time    3
        Javascript Click    ${checkbox.reporting.manager.click}
        Wait Until Time    3
        Scroll To Element    ${button.roleprofile.submit}
        Click Element    ${button.roleprofile.submit}
        Wait Until Time    ${SHORT_WAIT}
        Logout From VLMS Application
    

Access Cross-Site Profile
    [Arguments]    ${CrossSite_data}
        Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}    
        Menu Navigation_5.0    Administration    User    Cross-Site Profile    
        Select Value From Dropdown    ddlFromSite_chosen    ${CrossSite_data}[OldSite]
        Wait Until Time    3
        Select Value From Dropdown    ddlFromRole_chosen    ${CrossSite_data}[OldRole]
        Wait Until Element Is Visible    //div[@id='lstSelActiveUsers_chosen']
        ${splited_userID}    Split String    ${CrossSite_data}[User]    ,
        ${userIDcount}    Get Length    ${splited_userID}
        FOR    ${ID}    IN RANGE    0    ${userIDcount}
            ${splited_userID}    Split String    ${CrossSite_data}[User]    ,
            ${IDs}    Set Variable    ${splited_userID}[${ID}]
            Wait Until Time    ${SHORT_WAIT}
            Select Value From Dropdown    lstSelActiveUsers_chosen    ${IDs}
            
        END
        Wait Until Time    ${SHORT_WAIT}
        FOR    ${ID}    IN RANGE    0    ${userIDcount}
            ${checkbox.newselectallusers.crosssiteprofile}    Update Dynamic Value    ${checkbox.selectallusers.crosssiteprofile}    ${splited_userID}[${ID}]
            Click Element    ${checkbox.newselectallusers.crosssiteprofile}
        END
        #Select Submit/Reset Button    Update
        ##Wait Until Element Is Visible    ${table.crosssiteprofile.selectedusers}
        Select Value From Dropdown    ddlToSite_chosen    ${CrossSite_data}[Site]
        Wait Until Time    3
        Select Value From Dropdown    ddlRoleG_chosen    ${CrossSite_data}[Role]
        Wait Until Time    ${MEDIUM_WAIT}
        Input Text    ${textbox.comments.cross.site.profile}    Cross site
        Select Submit/Reset Button    Submit
        ${Expected_Result}    Set Variable    Cross-Site Profile has been set
        Get Value From Toast Message    ${Expected_Result}
    

Primary Site Setup
    [Arguments]    ${primarySite_data}
    
        ${splited_userID}    Split String    ${primarySite_data}[User]    ,
        ${splited_Password}    Split String    ${primarySite_data}[Pass]    ,
        ${userIDcount}    Get Length    ${splited_userID}
        FOR    ${ID}    IN RANGE    0    ${userIDcount}
            Login To VLMS Application    ${splited_userID}[${ID}]    ${splited_Password}[${ID}]    
            Javascript Click    ${dropdown.click}
            Wait Until Element Is Visible    ${dropdown.profile.viewprofile}    ${SHORT_WAIT}
            Click Element    ${dropdown.profile.viewprofile}
            Select Frame    ${iframe.framecontent}
            ${label.module.tab.content.newpage}    Update Dynamic Value    ${label.module.tab.content.page}    Change Profile
            Wait Until Element Is Visible    ${label.module.tab.content.newpage}    ${MEDIUM_WAIT}
            Select Value From Dropdown    ddlSite_chosen    ${primarySite_data}[SiteName]
            Wait Until Time    3
            Scroll Till Element Is Visible    ${button.roleprofile.submit}
            Wait Until Element Is Clickable And Click    ${button.roleprofile.submit}    ${LONG_WAIT}
            #${Expected_Result}    Set Variable    Profile has been Changed
            #Verify Toast Message    ${Expected_Result}
            Logout From VLMS Application
        END

Access control setting in VLMS
    [Documentation]    This keyword provide Access to the created Role
    [Arguments]    ${Role_data}    ${userid}    ${USER_PASSWORD}
    Unselect Frame
    Mouse Over    ${icon.home}
    Menu Navigation_5.0   Administration    Access Control    
    Select Value From Dropdown    ddlRoleSite_chosen    ${Role_data}[SiteName]
    Wait Until Time    3
    Select Value From Dropdown    ddlRoleName_chosen    ${Role_data}[Role Name]
    Wait Until Time    3
    click element    ${checkbox.site.selection.Access.control}
    Wait Until Time    3
    Wait Until Element Clickable    ${button.univeral.submit.button.VLMS}
    Click Button    ${button.univeral.submit.button.VLMS}
    Wait Until Element Is Visible    ${textbox.admin.access control.comments}    ${SHORT_WAIT}
    Input Text   ${textbox.admin.access control.comments}     Access has been set
    Click Element    ${button.submit.accessrole.settings}
    ##Handle Electronic esign    ${userid}    ${USER_PASSWORD}
    ${ExpectedResult}    Set Variable    Access Control for ${Role_data}[Role Name] Role has been set
    Get Value From Toast Message   ${ExpectedResult}

Create Job Title
    [Arguments]    ${content_type_data}
    [Documentation]    This is to enter the details to create the Job Title
    Click Button in VLMS    Create
    ${count}    Get Length    ${content_type_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${title_data}    Set Variable    ${content_type_data}[${key}]
        Wait Until Element Is Visible    //span[@id="lblCreateTitle"]    ${SHORT_WAIT}
        Select Value From Dropdown    ddlSite_chosen    ${title_data}[SiteName]
        Wait Until Time    3
        Enter Text In Mandatory Fields    boxTitleName     ${title_data}[TitleName]
        Javascript Click   ${button.department.create.submit}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        ${Expected_Result}    Set Variable    ${title_data}[TitleName] Job Title has been created
        ${Sts}    Get Value From Toast Message    ${Expected_Result}
    END

Create Site
    [Arguments]    ${trace_data}
    [Documentation]    This Keyword is used to creat Site on System Manager
    Click Button In VLMS    Create
    ${count}    Get Length    ${trace_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${site_data}    Set Variable    ${trace_data}[${key}]
        Wait Until Element Is Visible    ${textbox.config.create.sitename}    ${MEDIUM_WAIT}
        Input Text    ${textbox.config.create.sitename}    ${Site_Data}[SiteName]
        ${Site}    Set Variable   ${Site_Data}[SiteName]
        Set Global Variable    ${Site}
        Input Text    ${textbox.config.create.siteprefix}    ${Site_Data}[Prefix]
        Click Button In VLMS    Submit
        ${Expected_Result}    Set Variable    ${Site_Data}[SiteName] Site has been created
        ${Sts}    Get Value From Toast Message    ${Expected_Result}
    END