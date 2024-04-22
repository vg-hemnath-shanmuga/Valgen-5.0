*** Settings ***
Documentation     This prerequsite Resource file has all the prerequsite keywords
Resource          ../../Config/super.resource
#Resource    5.0_Keyword.resource

Library    XML
Library    ../../Library/prerequisite.py

*** Keywords ***
# Login To VLMS
#     [Arguments]    ${username}    ${password}
#     [Documentation]    Login To VLMS Application
#     Wait Until Element Is Visible    ${textbox.login.username}    ${LONG_WAIT}    Login page is not visible after waiting for ${LONG_WAIT} seconds
#     Input Text    ${textbox.login.username}    ${username}
#     Input Text    ${textbox.login.password}    ${password}
#     ${button.newsubmit/reset}    Update Dynamic Value    ${button.submit/reset}    Submit
#     Javascript Click    ${button.newsubmit/reset}
#     ${alert_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.home.expire_password_alert}    ${SHORT_WAIT}    Expire password alert is not visible after waiting for ${MEDIUM_WAIT} seconds
#     IF    '${alert_status}'=='True'    Click Button In VLMS    Ok
#     Wait Until Element Is Visible    ${icon.home}    ${LONG_WAIT}    Home page is not visible after waiting for ${LONG_WAIT} seconds

# Read Multiple TestData From Excel
#     [Arguments]           ${TESTDATA_FOLDER}    ${sheet_name}    
#     [Documentation]    Read Multiple TestData from excel file for required data.
#     ${expected_data}    Get Data Values     ${TESTDATA_FOLDER}    ${sheet_name}
#     RETURN    ${expected_data}

# Navigate To Create Entity Type_Prerequisite
#     [Documentation]    This keyword is used to navigate to the create entity type page
#     Navigate To Module Tab    System    Create    Entity Type    Select Entity Type
#     Click Button In VLMS    Create

# Create Role
#   [Documentation]     This keyword used to create role
#   [Arguments]    ${Role_Data}
#   Click Button in VLMS    Create
#   ${count}    Get Length    ${Role_Data}
#   FOR    ${key}    IN RANGE    0    ${count}
#         ${Role_data}    Set Variable    ${Role_Data}[${key}]
#         Wait Until Time    ${SHORT_WAIT}
#         IF    'Role Type' in ${Role_data}    Select Value From Dropdown    ddlRoleType_chosen    ${Role_data}[Role Type]
#         Wait Until Time    3
#         IF    'SiteName' in ${Role_data}    Select Value From Dropdown    ddlSite_chosen    ${Role_data}[SiteName]
#         Wait Until Time    3
#         Wait Until Element Is Visible    ${textbox.rolename.field}    ${MEDIUM_WAIT}    textbox is not visible after ${MEDIUM_WAIT} Seconds    
#         IF    'Role Name' in ${Role_data}    Input Text    ${textbox.rolename.field}    ${Role_data}[Role Name]
#         ${Role}    Set Variable    ${Role_data}[Role Name]
#         IF    'Description' in ${Role_data}    Input Text    ${textbox.Role.Description.field}    ${Role_data}[Description]
#         IF    'Button' in ${Role_data}    Select Submit/Reset Button    ${Role_data}[Button]
#         ${Expected_Result}    Set Variable    ${Role_data}[Role Name] Role has been created
#         ${Sts}    Get Value From Toast Message    ${Expected_Result}
#         Access control setting in VLMS    ${Role_data}    ${USER}    ${USER_PASSWORD}
#         Provide access to role profile    ${Role_data}
#     END

# Navigate To access RoleProfile
#     [Documentation]    This keyword will navigate to role profile page
#     [Arguments]    ${Role_data}
#     Unselect Frame
#     Mouse Over    ${icon.home}    
#     Menu Navigation_5.0   Administrator    Role    
#     select_task    ${Role_data}[Role Name]
#     Wait Until Element Is Enabled    ${button.edit.view.role}
#     Click Element    ${button.edit.view.role}

# select_task
#     [Arguments]    ${TaskID}
#     Unselect Frame
#     Wait Until Time    ${MEDIUM_WAIT}
#     #Mouse Over    ${textbox.search.task.common}
#     Wait Until Element Is Visible    ${textbox.search.task.common}    ${SHORT_WAIT}
#     Input Text    ${textbox.search.task.common}    ${TaskID}
#     Click Element    ${button.search.task.common}
#     Select Frame    ${iframe.framecontent}
#     ${select.task.common.new}    Update Dynamic Value    ${linktext.select.task.common}    ${TaskID}
#     Wait Until Element Is Visible    ${select.task.common.new}    ${SHORT_WAIT}
#     Click Element    ${select.task.common.new}
# Provide access to role profile
#     [Documentation]    This keyword will provide access to Role Profile
#     [Arguments]    ${Role_data}
#     Navigate To access RoleProfile    ${Role_data}
#     #${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Role Profile
#     #Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Role Profile access page is not visible after waiting for ${MEDIUM_WAIT} seconds
#     #IF     'SiteName' in ${Role_data}    Select Value From Dropdown    select2-ddlSite-container    ${Role_data}[SiteName]
#     #Wait Until Element Is Visible    //span[@id="select2-ddlRName-container"]    ${MEDIUM_WAIT}     Role Profile access page is not visible after waiting for ${MEDIUM_WAIT} seconds
#     #IF    'Role Name' in ${Role_data}    Select Value From Dropdown    select2-ddlRName-container    ${Role_data}[Role Name]
#     Wait Until Time    ${MEDIUM_WAIT}
#     IF    'No Access' in ${Role_data}    Check Checkboxes of No Access in role profile    ${Role_data}[No Access]
#     IF    'View Access' in ${Role_data}    Check Checkboxes of View Access in role profile    ${Role_data}[View Access]
#     IF    'Full Access' in ${Role_data}    Check Checkboxes of Full Access in role profile    ${Role_data}[Full Access]
#     IF    'Override User Profile?' in ${Role_data}    Select Value For Radio Button    Override    ${Role_data}[Override User Profile?]
#     Click Button in VLMS    Submit
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'Comments' in ${Role_data}    Input Text    ${textarea.comments.edit.roleprofile.access}    ${Role_data}[Comments]
#     Click Element    ${button.submit.edit.roleprofile.access}
#     ${Expected_Result}    Set Variable    ${Role_data}[Role Name] Role has been edited
#     IF    'Override User Profile?' in ${Role_data} == 'rbtnOverrideUserYes'
#         ${Expected_Result}    Set Variable    Are you sure want to override all User Profile    
#         Get Value From Toast Message    Are you sure want to override all User Profile
#     ELSE
#         Get Value From Toast Message    ${Expected_Result}
#     END

# Check Checkboxes of No Access in role profile
#     [Documentation]    This keyword will check checkboxes of no access in role profile
#     [Arguments]    ${groups_values}
#     ${groups_list_items}    Split String    ${groups_values}    ,
#     ${count}    Get Length    ${groups_list_items}
#     FOR    ${key}    IN RANGE   0    ${count}
#         ${updated.checkbox.roleprofile.noaccess}    Update Dynamic Value    ${checkbox.roleprofile.noaccess}    ${groups_list_items}[${key}]
#         ${source_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${updated.checkbox.roleprofile.noaccess}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible after waiting ${MEDIUM_WAIT} seconds
#         IF    '${source_status}'=='True'
#             Wait Until Time    3
#             Click Element    ${updated.checkbox.roleprofile.noaccess}
#             Wait Until Time    3
#         END
#     END

# Check Checkboxes of View Access in role profile
#     [Documentation]    This keyword will check checkboxes of no access in role profile
#     [Arguments]    ${groups_values}
#     ${groups_list_items}    Split String    ${groups_values}    ,
#     ${count}    Get Length    ${groups_list_items}
#     FOR    ${key}    IN RANGE   0    ${count}
#         ${updated.checkbox.roleprofile.viewaccess}    Update Dynamic Value    ${checkbox.roleprofile.viewaccess}    ${groups_list_items}[${key}]
#         ${source_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${updated.checkbox.roleprofile.viewaccess}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible after waiting ${MEDIUM_WAIT} seconds
#         IF    '${source_status}'=='True'
#             Click Element    ${updated.checkbox.roleprofile.viewaccess}
#             Wait Until Time    3
#         END
#     END

# Check Checkboxes of Full Access in role profile
#     [Documentation]    This keyword will check checkboxes of no access in role profile
#     [Arguments]    ${groups_values}
#     ${groups_list_items}    Split String    ${groups_values}    ,
#     ${count}    Get Length    ${groups_list_items}
#     FOR    ${key}    IN RANGE   0    ${count}
#         ${updated.checkbox.roleprofile.fullaccess}    Update Dynamic Value    ${checkbox.roleprofile.fullaccess}    ${groups_list_items}[${key}]
#         ${source_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${updated.checkbox.roleprofile.fullaccess}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible after waiting ${MEDIUM_WAIT} seconds
#         IF    '${source_status}'=='True'
#             Click Element    ${updated.checkbox.roleprofile.fullaccess}
#             Wait Until Time    3
#         END
#     END


# Create User or Provide Cross Site Access
#     [Arguments]    ${User_Data}
#     ${count_row}    Get Length    ${User_Data}
#     FOR    ${key}    IN RANGE    0    ${count_row}
#     ${dict_data}    Set Variable    ${User_Data}[${key}]
#         IF    '${dict_data}[NewUserCreationRequired?]' == 'Yes'
#             ##Menu    Administrator    Administrator    User
#             Creation_User    ${dict_data}
#             SignUp_User    ${dict_data}
#             ActivateUser    ${dict_data}    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}   
#             FirstLogin    ${dict_data}
#         ELSE
#             ${dict_data}    Set Variable    ${dict_data}
#             Access Cross-Site Profile    ${dict_data}
#             Logout From VLMS Application
#             Primary Site Setup    ${dict_data}
#         END
#     END

# Creation_User
#     [Arguments]    ${dict_data}
#     ##Click Button in VLMS    Create
    
#         ${FirstName}    Set Variable    ${dict_data}[FirstName]
#         ${LastName}    Set Variable    ${dict_data}[LastName]
#         ${UserID}    Set Variable    ${dict_data}[UserID]
#         ${EMailID}    Set Variable    ${dict_data}[EMailID]
#         ${TemporaryPassword}    Set Variable    ${dict_data}[TemporaryPassword]
#         ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create User
#         Click Button in VLMS    Create
#         Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create User is not visible ${MEDIUM_WAIT} seconds
#         Select Value From Dropdown    ddlSite_chosen    ${dict_data}[SiteName]
#         Wait Until Time    3
#         Select Value From Dropdown    ddlRole_chosen    ${dict_data}[Role Name]
#         Wait Until Time    3
#         Select Value From Dropdown    ddlDepartment_chosen    ${dict_data}[DepartmentName]
#         Wait Until Time    3
#         Select Value From Dropdown    drTitle_chosen    ${dict_data}[TitleName]
#         Wait Until Time    3
#         IF    'FirstName' in ${dict_data}    Enter Text In Mandatory Fields    FirstName    ${FirstName}
#         IF    'LastName' in ${dict_data}    Enter Text In Mandatory Fields    LastName    ${LastName}
#         IF    'UserID' in ${dict_data}    Enter Text In Mandatory Fields    UserName    ${UserID}
#         Set Suite Variable    ${UserID}
#         Wait Until Time    3
#         IF    'EMailID' in ${dict_data}    Enter Text In Mandatory Fields    Email    ${EMailID}
#                 Enter Text In Mandatory Fields    REEmail    ${EMailID}
#         IF    'TemporaryPassword' in ${dict_data}    Enter Text In Mandatory Fields    Pwd    ${TemporaryPassword}
#                 Enter Text In Mandatory Fields    RPwd    ${TemporaryPassword}
#         Select Submit/Reset Button    Submit
#         ${Expected_Result}    Set Variable    ${FirstName} ${LastName} User Account has been created
#         Get Value From Toast Message    ${Expected_Result}
#         Wait Until Time    ${SHORT_WAIT}
#         Logout From VLMS Application

# SignUp_User
#     [Arguments]    ${dict_data}
    
#         ${Password}    Set Variable    ${dict_data}[Password]
#         ${UserID}    Set Variable    ${dict_data}[UserID]
#         ${TemporaryPassword}    Set Variable    ${dict_data}[TemporaryPassword]
#         ${FirstName}    Set Variable    ${dict_data}[FirstName]
#         ${LastName}    Set Variable    ${dict_data}[LastName]
#         Wait Until Element Is Visible    ${textbox.login.username}    ${LONG_WAIT}    Login page is not visible after waiting for ${LONG_WAIT} seconds
#         Input Text    ${textbox.login.username}    ${UserID}
#         Input Text    ${textbox.login.password}    ${TemporaryPassword}
#         ${button.newsubmit/reset}    Update Dynamic Value    ${button.submit/reset}    Submit
#         Javascript Click    ${button.newsubmit/reset}
#         ##Wait Until Element Is Visible    ${label.admin.signup.user}
#         ##Click Element    ${label.admin.signup.user}
#         ##Wait Until Element Clickable    //input[@id="txtUserName"]
#         ##Input Text    //input[@id="txtUserName"]    ${UserID}
#         ##Wait Until Time    2
#         ##Input Text    //*[@id='txtPassword']    ${TemporaryPassword}
#         ##Wait Until Time    2
#         ##Press Keys    None    TAB
#         # Click Element    //input[@id="txtRole"]
#         #Wait Until Time    2
#         #Select Submit/Reset Button    Submit
#         Wait Until Time    ${SHORT_WAIT}
#         Enter Text In Mandatory Fields    Password    ${Password}
#         Enter Text In Mandatory Fields    REPassword    ${Password}
#         Enter Text In Mandatory Fields    Offlinepwd    ${Password}
#         Enter Text In Mandatory Fields    ROfflinepwd    ${Password}
#         Select Submit/Reset Button    Save
#         ${Expected_Result}    Set Variable    ${FirstName} ${LastName} User Account has been enrolled
#         Get Value From Toast Message    ${Expected_Result}
#         Wait Until Time    4
    

# ActivateUser
#     [Arguments]    ${dict_data}    ${AUTHOR}    ${AUTHOR_PASSWORD}
#     Login To VLMS Application    ${AUTHOR}    ${AUTHOR_PASSWORD}
#     Menu Navigation_5.0    Administrator    User    
#     ${UserID}    Set Variable    ${dict_data}[UserID]
#     Comment    Wait Until Element Is Visible    ${label.admin.activate.superadmin}
#     select_task    ${UserID}
#     Wait Until Time    ${SHORT_WAIT}
#     Wait Until Element Is Visible    ${button.edit.view.role}
#     Click Element    ${button.edit.view.role}
#     Wait Until Element Is Visible    ${button.action.common}    ${SHORT_WAIT}
#     Javascript Click    ${button.action.common}
#     Wait Until Time    ${SHORT_WAIT}
#     Click Element    ${dropdown.activate.user}
#         ##Click Element    ${label.admin.activateuser}
#     Wait Until Time    ${SHORT_WAIT}
#     Input Text    ${textarea.comments.edit.roleprofile.access}    User Activated
#     #Handle Electronic Sign    ${AUTHOR}    ${AUTHOR_PASSWORD}    Submit
#     Click Element    ${button.submit.esign.common}
#     ${Expected_Result}    Set Variable    ${UserID} User Account has been activated
#     Get Value From Toast Message    ${Expected_Result}
#     Logout From VLMS Application

# FirstLogin
#     [Arguments]    ${dict_data}
#     Wait Until Time    ${MEDIUM_WAIT}
    
#         ${Password}    Set Variable    ${dict_data}[Password]
#         Set Suite Variable    ${Password}
#         ${UserID}    Set Variable    ${dict_data}[UserID]
#         Set Suite Variable    ${UserID}
#         Enter Text In Mandatory Fields    UserName    ${UserID}
#         Enter Text In Mandatory Fields    Password    ${Password}
#         Comment    Select Value From Dropdown    ddlSetTimeZone    (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
#         Wait Until Time    ${SHORT_WAIT}
#         Select Value From Dropdown    ddlSetTimeZone_chosen    (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
#         ##Click Element    ${dropdown.timezone}
#         ##${dropdown.timezone.newvalue}    Update Dynamic Value    ${dropdown.timezone.value}    (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
#         ##Click Element    ${dropdown.timezone.newvalue}
#         Select Submit/Reset Button    Submit
#         ${alert}    Run Keyword And Return Status    Get Value From Toast Message    You have no access rights contact your administrator
#         IF    '${alert}'=='True'    
#             Login To VLMS Application    ${USER}    ${USER_PASSWORD}
#             Menu Navigation_5.0    Administrator    User
#             Login To VLMS Application    ${USER}    ${USER_PASSWORD}    
#             Menu    Administrator    Administrator    User
#             select_task    ${UserID}
#             Wait Until Element Is Enabled    ${button.edit.view.role}
#             Click Element    ${button.edit.view.role}
#             IF    'No Access' in ${dict_data}    Check Checkboxes of No Access in role profile    ${dict_data}[No Access]
#             IF    'View Access' in ${dict_data}    Check Checkboxes of View Access in role profile    ${dict_data}[View Access]
#             IF    'Full Access' in ${dict_data}    Check Checkboxes of Full Access in role profile    ${dict_data}[Full Access]
#             Select Submit/Reset Button    Submit
#             Input Text    ${textarea.comments.edit.roleprofile.access}    User Profile Updated
#             Select Submit/Reset Button    Submit
#             ${Expected_Result}    Set Variable    ${UserID} ${dict_data}[LastName] User Account has been edited
#             Get Value From Toast Message   ${Expected_Result}
#             Logout From VLMS Application
#             Enter Text In Mandatory Fields    UserName    ${UserID}
#             Enter Text In Mandatory Fields    Password    ${Password}
#             Select Value From Dropdown    ddlSetTimeZone_chosen    (UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi
#             Select Submit/Reset Button    Submit
#         END
#         ${alert_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.Reporting.manager.alert}    ${SHORT_WAIT}    Expire password alert is not visible after waiting for ${MEDIUM_WAIT} seconds
#         IF    '${alert_status}'=='True'    Click Element    ${button.ok.reporting.manager.popup}
#         Select Frame    ${iframe.framecontent}
#         Wait Until Time    3
#         Wait Until Element Clickable    ${checkbox.reporting.manager.click}
#         Wait Until Time    3
#         Javascript Click    ${checkbox.reporting.manager.click}
#         Wait Until Time    3
#         Scroll To Element    ${button.roleprofile.submit}
#         Click Element    ${button.roleprofile.submit}
#         Logout From VLMS Application
    

# Access Cross-Site Profile
#     [Arguments]    ${CrossSite_data}
#         Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}    
#         Menu Navigation_5.0    Administrator    User    Cross-Site Profile    
#         Select Value From Dropdown    ddlFromSite_chosen    ${CrossSite_data}[OldSite]
#         Wait Until Time    3
#         Select Value From Dropdown    ddlFromRole_chosen    ${CrossSite_data}[OldRole]
#         Wait Until Element Is Visible    //div[@id='lstSelActiveUsers_chosen']
#         ${splited_userID}    Split String    ${CrossSite_data}[User]    ,
#         ${userIDcount}    Get Length    ${splited_userID}
#         FOR    ${ID}    IN RANGE    0    ${userIDcount}
#             ${splited_userID}    Split String    ${CrossSite_data}[User]    ,
#             ${IDs}    Set Variable    ${splited_userID}[${ID}]
#             Wait Until Time    ${SHORT_WAIT}
#             Select Value From Dropdown    lstSelActiveUsers_chosen    ${IDs}
            
#         END
#         Wait Until Time    ${SHORT_WAIT}
#         FOR    ${ID}    IN RANGE    0    ${userIDcount}
#             ${checkbox.newselectallusers.crosssiteprofile}    Update Dynamic Value    ${checkbox.selectallusers.crosssiteprofile}    ${splited_userID}[${ID}]
#             Click Element    ${checkbox.newselectallusers.crosssiteprofile}
#         END
#         #Select Submit/Reset Button    Update
#         ##Wait Until Element Is Visible    ${table.crosssiteprofile.selectedusers}
#         Select Value From Dropdown    ddlToSite_chosen    ${CrossSite_data}[Site]
#         Wait Until Time    3
#         Select Value From Dropdown    ddlRoleG_chosen    ${CrossSite_data}[Role]
#         Wait Until Time    ${MEDIUM_WAIT}
#         Input Text    ${textbox.comments.cross.site.profile}    Cross site
#         Select Submit/Reset Button    Submit
#         ${Expected_Result}    Set Variable    Cross-Site Profile has been set
#         Get Value From Toast Message    ${Expected_Result}
    

# Primary Site Setup
#     [Arguments]    ${primarySite_data}
    
#         ${splited_userID}    Split String    ${primarySite_data}[User]    ,
#         ${splited_Password}    Split String    ${primarySite_data}[Pass]    ,
#         ${userIDcount}    Get Length    ${splited_userID}
#         FOR    ${ID}    IN RANGE    0    ${userIDcount}
#             Login To VLMS Application    ${splited_userID}[${ID}]    ${splited_Password}[${ID}]    
#             Javascript Click    ${dropdown.click}
#             Wait Until Element Is Visible    ${dropdown.profile.viewprofile}    ${SHORT_WAIT}
#             Click Element    ${dropdown.profile.viewprofile}
#             Select Frame    ${iframe.framecontent}
#             ${label.module.tab.content.newpage}    Update Dynamic Value    ${label.module.tab.content.page}    Change Profile
#             Wait Until Element Is Visible    ${label.module.tab.content.newpage}    ${MEDIUM_WAIT}
#             Select Value From Dropdown    ddlSite_chosen    ${primarySite_data}[SiteName]
#             Wait Until Time    3
#             Scroll Till Element Is Visible    ${button.roleprofile.submit}
#             Wait Until Element Is Clickable And Click    ${button.roleprofile.submit}    ${LONG_WAIT}
#             #${Expected_Result}    Set Variable    Profile has been Changed
#             #Get Value From Toast Message    ${Expected_Result}
#             Logout From VLMS Application
#         END
# Logout From VLMS Application
#     [Documentation]    This Keyword is used to Logout from VLMS application
#     Unselect Frame
#     Click Top Menu Icons    Logout
#     Wait Until Element Is Visible    ${textbox.login.username}    ${LONG_WAIT}    Login page is not visible after waiting for ${LONG_WAIT} seconds
#     Log Expected And Actual Results    Login page is displayed    Login page should be displayed
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

# Create Category
#     [Arguments]    ${Category_Data}
#     ${count_row}    Get Length    ${Category_Data}
#     FOR    ${key}    IN RANGE    0    ${count_row}
#         ${dict_data}    Set Variable    ${Category_Data}[${key}]
#         Click Button in VLMS    Create
#         Wait Until Time    ${SHORT_WAIT}
#         Enter Text In Mandatory Fields    CatName    ${dict_data}[CategoryName]
#         ${Category}    Set Variable    ${dict_data}[CategoryName]
#         Enter Text In Mandatory Fields    Prefix    ${dict_data}[CategoryPrefix]
#         Click Button in VLMS    Submit
#         Handle Electronic Sign    ${AUTHOR}    ${AUTHOR_PASSWORD}    Submit
#         ${ExpectedResult}    Set Variable     ${Category} category has been created
#         Get Value From Toast Message    ${ExpectedResult}
#         ${Object_Name}    Set Variable    ${Category}
#         Set Suite Variable    ${Category}    

#     END

# Create SubCategory
#     [Arguments]    ${SubCategory_Data}
#     ${count_row}    Get Length    ${SubCategory_Data}
#     FOR    ${key}    IN RANGE    0    ${count_row}
#         ${dict_data}    Set Variable    ${SubCategory_Data}[${key}]
#         ${Exisiting}    Set Variable    ${Existing_Data}[${key}]
#         Click Button in VLMS    Create
#         Wait Until Time    ${SHORT_WAIT}
#         Select Value From Dropdown    ddlCatName_chosen    ${dict_data}[CategoryName]
#         Wait Until Time    ${SHORT_WAIT}
#         Enter Text In Mandatory Fields    SubCatName    ${dict_data}[SubCategoryName]
#         ${SubCategory}    Set Variable    ${dict_data}[SubCategoryName]
#         Set Suite Variable    ${SubCategory}
#         Enter Text In Mandatory Fields    Prefix    ${dict_data}[SubCategoryPrefix]
#         Click Button in VLMS    Submit
#         Handle Electronic Sign    ${AUTHOR}    ${AUTHOR_PASSWORD}    Submit    created
#         ${ExpectedResult}    Set Variable     ${SubCategory} Sub Category has been created
#         Get Value From Toast Message    ${ExpectedResult} 
        
        
#     END

# Create Entity Status
#     [Arguments]    ${reason_data}    ${USER}    ${USER_PASSWORD}
#     ${count}    Get Length    ${reason_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${entitystatus_data}    Set Variable    ${reason_data}[${key}]
#         Wait Until Element Is Visible    ${dropdown.statustype.assessment.create.entitystatus}
#         Click Element    ${dropdown.statustype.assessment.create.entitystatus}
#         ${dropdown.selecttype.create.system.keywwordmapping.new}    Update Dynamic Value    ${dropdown.selecttype.create.system.keywwordmapping}    ${entitystatus_data}[EntityStatus]
#         Click Element    ${dropdown.selecttype.create.system.keywwordmapping.new}
#         Enter Text In Mandatory Fields    ValidationStatusName    ${entitystatus_data}[EntityStatusName]
#         Click Element    ${dropdown.Entitystatuscolor.assessment.create.entitystatus}
#         ${dropdown.selectcolor.assessment.create.entitystatus.new}    Update Dynamic Value    ${dropdown.selectcolor.assessment.create.entitystatus}    ${entitystatus_data}[EntityStatusColor]
#         Click Element    ${dropdown.selectcolor.assessment.create.entitystatus.new}
#         Select Submit/Reset Button    Submit
#         Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#         ${EXPECTED_SUCCESS_MSG}    Set Variable    ${entitystatus_data} entity status has been created
#         Verify Confirmation Popup    ${entitystatus_data}[EntityStatusName] entity status has been created    btnMessageOk
#     END

# Navigate To Create Validation Framework_Prerequisite
#     [Documentation]    This keyword will navigate to create validation framework page
#     Navigate To Module Tab    Assessment    Create    Framework    Select Validation Framework
#     Click Button In VLMS    Create

# Create Framework_Prerequisite
#     [Documentation]    This keyword will create the framework
#     [Arguments]    ${reason_data}    ${user_name}    ${password}
#     ${count}    Get Length    ${reason_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${create_data}    Set Variable    ${reason_data}[${key}]
#         ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create Validation Framework
#         Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create Validation Framework page is not visible after waiting for ${MEDIUM_WAIT} seconds
#         ${framework_doc_no}    Get Text    ${label.assessment.framework.document_no}
#         ${framework_doc_no}    Remove String    ${framework_doc_no}    <    >
#         IF    'FrameworkType' in ${create_data}    Select Value For Radio Button    rbtNew    ${create_data}[FrameworkType]
#         IF    'SelectFramework' in ${create_data}    Select Value From Dropdown    select2-ddlInheritVal-container    ${create_data}[SelectFramework]
#         Wait Until Time    2
#         IF    'FrameworkName' in ${create_data}    Enter Text In Mandatory Fields    VPtitle    ${create_data}[FrameworkName]
#         IF    'FrameworkForm' in ${create_data}    Select Value From Dropdown    select2-ddlPlanTemplate-container    ${create_data}[FrameworkForm]
#         Wait Until Time    3
#         IF    'Description' in ${create_data}    Enter Description For Framework_Prerequisite    ${create_data}
#         Wait Until Time    2
#         IF    'DeliverableName' in ${create_data}    Select Deliverable Name And Condition_Prerequisite    ${create_data}
#         IF    'Approval' in ${create_data}    Select Value For Radio Button    WFRequired    ${create_data}[Approval]
#         IF    'Workflow' in ${create_data}    Select Value From Dropdown    select2-ddWorkFlow-container    ${create_data}[Workflow]
#         IF    'Comments' in ${create_data}    Enter Comments/Description    txtComments    ${create_data}[Comments]
#         IF    'RouteFor' in ${create_data}    Select Value From Dropdown    select2-ddlWFStatus-container    ${create_data}[RouteFor]
#         Wait Until Time    2
#         IF    'Button' in ${create_data}    Select Submit/Reset Button    ${create_data}[Button]
#         Handle Electronic Sign    ${user_name}     ${password}   Submit
#         Verify Confirmation Popup    ${create_data}[FrameworkName] validation framework ${framework_doc_no} has been created    btnMessageOk
#         Click Button In VLMS    Create
#     END

# Select Deliverable Name And Condition_Prerequisite
#     [Arguments]    ${create_data}
#     [Documentation]    This keyword be used to select the Deliverable name and condition(ex:mandatory or optional)
#     @{deliverable_types}    Split String    ${create_data}[DeliverableName]    ,
#     @{deliverable_names}    Split String    ${create_data}[DeliverableCondition]    ,
#     ${count}    Get Length    ${deliverable_types}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${button.assessment.create.framework.newdelivrable_option}    Update Dynamic Values    ${button.assessment.create.framework.delivrable_option}    ${deliverable_types}[${key}]    ${deliverable_names}[${key}]
#         Wait Until Element Is Visible    ${button.assessment.create.framework.newdelivrable_option}
#         Click Element    ${button.assessment.create.framework.newdelivrable_option}
#     END

# Enter Description For Framework_Prerequisite
#     [Arguments]    ${create_data}
#     [Documentation]    This keyword will enter the description
#     Wait Until Element Is Visible    ${iframe.assessment.create.framework}    ${MEDIUM_WAIT}
#     Select Frame    ${iframe.assessment.create.framework}
#     Wait Until Element Is Visible    ${textbox.assessment.framework.description}    ${MEDIUM_WAIT}
#     Input Text    ${textbox.assessment.framework.description}    ${create_data}[Description]
#     Unselect Frame
#     Select Frame    ${iframe.framecontent}

# Swipe Values Between Groups_Prerequisite
#     [Arguments]    ${groups_values}    ${source_group}    ${destination_group}
#     [Documentation]    This keyword is used to swipe values between source and destination groups
#     ${groups_list_items}    Split String    ${groups_values}    ,
#     ${count}    Get Length    ${groups_list_items}
#     FOR    ${key}    IN RANGE   0    ${count}
#         ${label.system.entity.newgroups_selection}    Update Dynamic Values    ${label.system.entity.groups_selection}    ${source_group}    ${groups_list_items}[${key}]
#         ${source_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.system.entity.newgroups_selection}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visible after waiting ${MEDIUM_WAIT} seconds
#         IF    '${source_status}'=='True'
#             Click Element    ${label.system.entity.newgroups_selection}
#             Click Element    ${label.system.entity.newgroups_selection}
#             Double Click Element    ${label.system.entity.newgroups_selection}
#             ${label.system.entity.newgroups_selection}    Update Dynamic Values    ${label.system.entity.groups_selection}    ${destination_group}    ${groups_list_items}[${key}]
#             Wait Until Element Is Visible    ${label.system.entity.newgroups_selection}    ${MEDIUM_WAIT}    ${groups_list_items}[${key}] is not visble.
#         END
#     END

# Enter Standard Form Details In Create Entity Type_Prerequisite
#     [Arguments]    ${system_entity_data}
#     [Documentation]    This keyword is used to enter standard form details(Getting Framework Name variable from Create Framework keyword)
#     IF    'AssessmentRequired' in ${system_entity_data}    Select Value For Radio Button    SystemAssessmentRequired    ${system_entity_data}[AssessmentRequired]
#     IF    'AssessmentTemplate' in ${system_entity_data}    Select Value From Dropdown    ddlPlanAssessmentSelect    ${system_entity_data}[AssessmentTemplate]
#     Wait Until Time    3
#     IF    'Framework' in ${system_entity_data}
#         Select Framework    ${system_entity_data}[Framework]
#         Set Validation Rule For Framework_Prerequisite    ${system_entity_data}
#         Validation Criteria_Prerequisite    ${system_entity_data}
#     END

# Set Validation Rule For Framework_Prerequisite
#     [Arguments]    ${system_entity_data}
#     [Documentation]    This Keyword is used to set validation rule for selected faramework
#     Click Element    ${link.system.create.entity.set_validation_rule}
#     Unselect Frame
#     Select Frame    ${iframe.library_frame.screen}
#     Wait Until Element Is Visible    ${label.system.create.entity_type.validation_criteria}    ${MEDIUM_WAIT}    Validation Criteria page is not visible after waiting ${MEDIUM_WAIT} seconds
#     IF    'CriteriaBasedOn' in ${system_entity_data}    Select Value For Radio Button    ValCrtBased    ${system_entity_data}[CriteriaBasedOn]
#     IF    'EntityStatusValidation' in ${system_entity_data}    Select Value From Dropdown    ${dropdown.system.create.entity.validation_criteria.status_validation}    ${system_entity_data}[EntityStatusValidation]

# Validation Criteria_Prerequisite
#     [Arguments]    ${system_entity_data}
#     [Documentation]    This keyword is used to validate criteria to set validation rule
#     Wait Until Time    3
#     Click Element    ${label.system.create.entity.set_validation_rule.deliverables_table}
#     IF    'EntityStatusValidation' in ${system_entity_data}
#         ${checkbox.system.create.entity.set_validation_rule.newdeliverables}    Update Dynamic Value    ${checkbox.system.create.entity.set_validation_rule.deliverables}    ${system_entity_data}[Deliverables]
#         Select Checkbox    ${checkbox.system.create.entity.set_validation_rule.newdeliverables}
#     END
#     Click Button    ${checkbox.system.create.entity.set_validation_rule.deliverables.save}
#     Wait Until Time    3
#     Validate Success Message    ${system_entity_data}[SuccessMessage]
#     Unselect Frame
#     Wait Until Element Is Visible    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}    ${MEDIUM_WAIT}    Close button is not visible after waiting ${MEDIUM_WAIT} seconds
#     Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}
#     Select Frame    ${iframe.framecontent}
#     Wait Until Element Is Visible    ${label.system.create.entity_type}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting ${MEDIUM_WAIT} seconds

# Validate Success Message
#     [Arguments]    ${alert_success_message}
#     [Documentation]    It is uesd to validate the success message
#     ${label.content.assign.authoring.new_success_message}    Update Dynamic Value    ${label.content.assign.authoring.success_message}    ${alert_success_message}
#     Wait Until Element Is Visible    ${label.content.assign.authoring.new_success_message}    ${MEDIUM_WAIT}    ${alert_success_message} message is not visible after waiting ${MEDIUM_WAIT} seconds
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
#     Click Element    ${button.success_alert.ok}

# Validate Entity Type
#     [Arguments]    ${username}    ${password}    ${system_entity_data}
#     [Documentation]    This keyword is used to validate entity type id
#     IF    '${system_entity_data}[ApprovalRequired]'=='rdoAppYes' or '${system_entity_data}[ApprovalRequired]'=='rdoYes'
#         Validate Document Is Routed For Peer Review/Review/Approval    ${username}    ${password}    ${system_entity_data}[EntityTypeName] entity type ${ENTITY_TYPE_ID} has been routed for ${system_entity_data}[RouteFor]
#     ELSE IF    '${system_entity_data}[ApprovalRequired]'=='rdoAppNo' or '${system_entity_data}[ApprovalRequired]'=='rdoNo'
#         Validate Document Is Routed For Peer Review/Review/Approval    ${username}    ${password}    ${system_entity_data}[EntityTypeName] entity type ${ENTITY_TYPE_ID} has been created
#     END

# Validate Document Is Routed For Peer Review/Review/Approval
#     [Arguments]    ${login_user}    ${login_password}    ${message}
#     [Documentation]    It is used to Validate Document is Routed for Peer Review or Review or Approval
#     ${status}    Run Keyword And Return Status    Wait Until Page Contains    Do you want to proceed?    ${SHORT_WAIT}
#     IF    '${status}'=='True'    Verify Notification Popup    Document mapping not verified. Do you want to proceed?    btnSubmitConfirm
#     Handle Electronic Sign    ${USER}    ${login_password}    Submit
#     Wait Until Element Is Visible    ${label.notification_popup.message}    ${MEDIUM_WAIT}    Message is not visible after waiting for ${MEDIUM_WAIT} seconds
#     ${actual_msg}    Get Text    ${label.notification_popup.message}
#     Verify String Should Be Equal   ${actual_msg}    ${message}
#     Log Expected And Actual Results    ${actual_msg}    ${message}
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
#     Wait Until Element Is Visible    ${button.success_alert.ok}    ${MEDIUM_WAIT}    Ok button is not visible after waiting for ${MEDIUM_WAIT} seconds
#     Javascript Click    ${button.success_alert.ok}

# Create Entity through Cat/Sub
#     [Arguments]    ${entity_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword will create entity
#     #robocop: disable=too-many-calls-in-keyword
#     ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create Entity
#     Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create Entity page is not visible after waiting for ${MEDIUM_WAIT} seconds
#     #IF    'Category' in ${entity_data}    Select Value From Dropdown    ddlCategory-container    ${entity_data}[Category]
#     Select Value From Dropdown    ddlCategory-container    ${Category_Name}
#     Wait Until Time    ${SHORT_WAIT}
#     Select Value From Dropdown    ddlSubCategory1-container    ${SubCategory_Name}
#     #IF    'SubCategory' in ${entity_data}    Select Value From Dropdown    ddlSubCategory1-container    ${entity_data}[SubCategory]
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'SystemAssessment' in ${entity_data}    Select Value For Radio Button     ValidationAssessmentReq    ${entity_data}[SystemAssessment]
#     IF    'AssignSystem' in ${entity_data}    Select Value For Radio Button    ValAssignYes    ${entity_data}[AssignSystem]
#     IF    'ScheduleAssessment' in ${entity_data}    Select Value For Radio Button     ScheduleAssessmentReq    ${entity_data}[ScheduleAssessment]
#     Wait Until Time    4
#     IF    'EntityName' in ${entity_data}    Enter Text In Mandatory Fields    EntityName    ${entity_data}[EntityName]
#     Select Value From Dropdown    select2-ddlEntityType-container    ${ENTITY_TYPE_NAME}
#     Wait Until Time    2
#     IF    'EntityNo' in ${entity_data}    Enter Text In Mandatory Fields    EntityNO    ${entity_data}[EntityNo]
#     IF    'AssessmentPlanTemplate' in ${entity_data}    Select Value From Dropdown    select2-ddlValidationTemplate-container    ${entity_data}[AssessmentPlanTemplate]
#     IF    'Description' in ${entity_data}    Enter Comments/Description    txtDescription    ${entity_data}[Description]
#     IF    'SystemOwner' in ${entity_data}    Select Dropdown Value With Partial Text    select2-ddlSysOwner-container    ${entity_data}[SystemOwner]
#     IF    'BusinessOwner' in ${entity_data}    Enter Comments/Description    txtBusinessOwner    ${entity_data}[BusinessOwner]
#     IF    'IntendedUse' in ${entity_data}    Select Value From Dropdown    ddlIntendedUse_I    ${entity_data}[IntendedUse]
#     IF    'AssessmentName' in ${entity_data}    Enter Comments/Description    txtValAssName    ${entity_data}[AssessmentName]
#     IF    'Assignment' in ${entity_data}    Choose Assignee Type    ${entity_data}[Assignment]    ${entity_data}[AssignTo]
#     IF    'Design' in ${entity_data}       Select Value For Radio Button     rbtDesignManagerNo    ${entity_data}[Design]
#     IF    'StatusAlertGroup' in ${entity_data}    Swipe Values Between Groups_Prerequisite    ${entity_data}[StatusAlertGroup]    lstAvailbleGroup    lstAssinGroup
#     Wait Until Time    4
#     IF    'SelectedGroup' in ${entity_data}    Swipe Values Between Groups_Prerequisite    ${entity_data}[SelectedGroup]    lstAssinGroup    lstAvailbleGroup
#     Wait Until Time    2
#     IF    'Button' in ${entity_data}    Select Submit/Reset Button    ${entity_data}[Button]
#     Handle Electronic Sign    ${userid}     ${password}    Submit
#     ${ENTITY_NAME}    Set Variable    ${entity_data}[EntityName]
#     Set Global Variable    ${ENTITY_NAME}
#     ${ENTITY_NUMBER}    Set Variable    ${entity_data}[EntityNo]
#     Set Global Variable    ${ENTITY_NUMBER} 

#Choose Assignee Type_Prerequisite
    # [Arguments]    ${assignee}    ${dropdown_value}
    # [Documentation]    It is used to choose the assignee from assign type radio button
    # Select Value For Radio Button    AssignType    rbtn${assignee}
    # IF    '${assignee}'!='assignMe'
    #     Select Value From Dropdown    AssignToGroup-container    ${dropdown_value}
    # END

# Access control setting in VLMS
#     [Documentation]    This keyword provide Access to the created Role
#     [Arguments]    ${Role_data}    ${userid}    ${USER_PASSWORD}
#     Unselect Frame
#     Mouse Over    ${icon.home}
#     Menu Navigation_5.0   Administrator    Access Control    
#     Select Value From Dropdown    ddlRoleSite_chosen    ${Role_data}[SiteName]
#     Wait Until Time    3
#     Select Value From Dropdown    ddlRoleName_chosen    ${Role_data}[Role Name]
#     Wait Until Time    3
#     click element    ${checkbox.site.selection.Access.control}
#     Wait Until Time    3
#     Wait Until Element Clickable    ${button.univeral.submit.button.VLMS}
#     Click Button    ${button.univeral.submit.button.VLMS}
#     Wait Until Element Is Visible    ${textbox.admin.access control.comments}    ${SHORT_WAIT}
#     Input Text   ${textbox.admin.access control.comments}     Access has been set
#     Click Element    ${button.submit.accessrole.settings}
#     ##Handle Electronic esign    ${userid}    ${USER_PASSWORD}
#     ${ExpectedResult}    Set Variable    Access Control for ${Role_data}[Role Name] Role has been set
#     Get Value From Toast Message   ${ExpectedResult}

# Handle Electronic Sign
#     [Arguments]    ${login_user}    ${login_password}    ${option}    ${reason}=None
#     [Documentation]    It is Used to handle electronic signature with Submit or Cancel button
#     ${status}    Run Keyword And Return Status    Wait Until Element Is Enabled    ${label.electronic_sign.popup.pre}    ${SHORT_WAIT}
#     IF    '${status}' == 'True'
#         Wait Until Element Is Visible    ${textbox.electronic_sign.user}    ${MEDIUM_WAIT}
#         ${loggedin_user}    Get Text    ${label.electronic_sign.popup.loggedin_user}
#         Set Test Variable    ${LOGGEDIN_USER}
#         IF    '${reason}'!='None'    Select Value From Dropdown    val1_ddlReason_chosen    ${reason}
#         ${status}    Run Keyword And Return Status    Wait Until Element Is Enabled    ${textbox.electronic_sign.user}    ${SHORT_WAIT}
#         IF    '${status}'=='True'    Input Text    ${textbox.electronic_sign.user}    ${login_user}
#         Input Text    ${textbox.electronic_sign.password}    ${login_password}
#         ${button.electronic_sign.newsubmit/cancel}    Update Dynamic Value    ${button.electronic_sign.submit/cancel}    ${option}
#         Click Element    ${button.electronic_sign.newsubmit/cancel}
#     END

# Create Keyword Mapping
#     [Arguments]    ${Keyword_Mapping_data}
#     ${Column_Header}    Split String    ${Keyword_Mapping_data}[Column Header]    ,
#     @{Headercount}    Create List    ${Column_Header}
#     ${Count}    Get Length    @{Headercount}
#     FOR    ${key}    IN RANGE    0    ${count}
#         Click Button in VLMS    Create
#         Wait Until Time    ${SHORT_WAIT}
#         Select Value From Dropdown    ddlMapType_chosen    ${Keyword_Mapping_data}[DocumentType]
#         ${ColumnHeader}    Split String    ${Keyword_Mapping_data}[Column Header]    ,
#         ${Header}    Set Variable    ${ColumnHeader}[${Key}]
#         ${ColumnType}    Split String    ${Keyword_Mapping_data}[Column Type]    ,
#         ${Type}    Set Variable    ${ColumnType}[${Key}]
#         ${SplitedheaderType}    Combine Lists    ${ColumnHeader}    ${ColumnType}
#         ##${ColumnHeader}    Set Variable    ${ColumnHeader}[${key}]    
#         Enter Text In Mandatory Fields    ColHeaderName    ${Header}
#         Wait Until Time    ${SHORT_WAIT}
#         Select Value From Dropdown    ddlColType_chosen    ${Type}
#         Select Submit/Reset Button    Submit
#         Handle Electronic Sign   ${AUTHOR}   ${AUTHOR_PASSWORD}    ${Keyword_Mapping_data}[Reason]
#         ${ExpectedResult}    Set Variable    Mapping Keyword has been created
#         Get Value From Toast Message    ${ExpectedResult}
#     END

# Navigate To External Document_Prerequisite
#     [Documentation]    This keyword is used to navigate to the external document
#     Navigate To Module Tab    Content    Author    External Document     Select Document to Author
#     Click Button In VLMS    Create

# Select Entity_Prerequisite
#     [Arguments]    ${entity}
#     [Documentation]    This keyword is used to search entity
#     Select Value From Table Dropdown    ${entity}
#     ${entity}    Get Text    ${label.content.author.external_document.entity}
#     ${splitted_entity}    Split String    ${entity}
#     ${ENTITY_NAME}    Set Variable    ${splitted_entity}[0]
#     Set Global Variable    ${ENTITY_NAME}
#     ${actual_entity_number}    Get Text    ${label.content.author.external_document.entity_number}
#     ${ENTITY_NUMBER}    Set Variable    ${actual_entity_number}
#     Set Global Variable    ${ENTITY_NUMBER}
#     ${EXPECTED_ENTITY_NAME}    Set Variable    ${ENTITY_NAME} - ${ENTITY_NUMBER}
#     Set Test Variable    ${EXPECTED_ENTITY_NAME}

# Get Entity ID_Prerequisite
#     [Arguments]    ${entity_name}
#     [Documentation]    This keyword is used to get the entity type id
#     Wait Until Time    3
#     Wait Until Element Is Visible    ${label.system.create.entity.pre}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting ${MEDIUM_WAIT} seconds
#     ${actual_entity_no}    Get Text    ${label.system.create.entity.pre}
#     ${updated_entity_id}    Remove String    ${actual_entity_no}    <    >
#     ${ENTITY_ID}    Set Variable    ${entity_name} - ${updated_entity_id}
#     Set Global Variable    ${ENTITY_ID}

# Get Document ID_Prerequisite
#     [Documentation]    This keyword is used to get the entity type id
#     Wait Until Time    3
#     Wait Until Element Is Visible    ${label.system.create.entity}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting ${MEDIUM_WAIT} seconds
#     ${actual_Doc_id}    Get Text    ${label.system.create.entity_code}
#     ${updated_entity_id}    Remove String    ${actual_Doc_id}    <    >
#     ${DOC_ID}    Set Variable    ${updated_entity_id}
#     Set Global Variable    ${DOC_ID}

# Upload External Document And Verify Success Message_Prerequisite
#     [Arguments]    ${file_name}
#     [Documentation]    This keyword is used to upload external document and Verify the success message
#     Wait Until Time    3
#     Choose File    ${textbox.attachments.browse.input}    ${EXECDIR}\\ImportFiles\\${file_name}
#     Wait Until Time    3
#     Wait Till Loading Icon Is Invisible    ${label.document.attachments.add.upload_attachment.status}
#     Verify Notification Popup    Uploaded Successfully    btnConfirmOk

# Select Original Author_Prerequisite
#     [Arguments]    ${content_author_data}
#     [Documentation]    This keyword is used to select original author
#     Wait Until Time    2
#     IF    'OriginalAuthor' in ${content_author_data}        Select Value For Radio Button    OAcheck    ${content_author_data}[OriginalAuthor]
#     IF    'AssignAuthorAs' in ${content_author_data}       Select Value From Dropdown    ddAssignInternalAuthor    ${content_author_data}[AssignAuthorAs]
#     IF    'FirstName' in ${content_author_data}        Enter Text In Mandatory Fields    OAExtFName    ${content_author_data}[FirstName]
#     IF    'LastName' in ${content_author_data}        Enter Text In Mandatory Fields    OAExtLName    ${content_author_data}[LastName]
#     IF    'Department' in ${content_author_data}        Enter Text In Mandatory Fields    OAExtDepartment    ${content_author_data}[Department]
#     IF    'Title' in ${content_author_data}        Enter Text In Mandatory Fields    OAExtTitle    ${content_author_data}[Title]

# Author Documnet Externally
#     [Arguments]    ${content_type_data}    ${USER}    ${USER_PASSWORD}
#     [Documentation]    This keyword is used to enter details in author external document and submit
#     ${count}    Get Length    ${content_type_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${content_author_data}    Set Variable    ${content_type_data}[${key}]
#         Navigate To External Document
#         IF    'AuthoringFor' in ${content_author_data}    Select Value For Radio Button    DevFor    ${content_author_data}[AuthoringFor]
#         IF    'TaskType' in ${content_author_data}    Select Value For Radio Button    DocType    ${content_author_data}[TaskType]
#         IF    'FolderName' in ${content_author_data}    Select Value From Dropdown    ddlListSiteFolder    ${content_author_data}[FolderName]
#         IF    'Entity' in ${content_author_data}    Select Entity    ${content_author_data}[Entity]
#         IF    'ContentType' in ${content_author_data}    Select Value From Dropdown    ddlValidationType    ${content_author_data}[ContentType]
#         Get Entity ID_Prerequisite    ${content_author_data}[Entity]
#         Get Document ID_Prerequisite
#         IF    'InitiateAs' in ${content_author_data}    Select Value For Radio Button    DeliverableType    ${content_author_data}[InitiateAs]
#         Wait Until Time    2
#         IF    'DocumentTitle' in ${content_author_data}    Enter Text In Mandatory Fields    DocumentTitle    ${content_author_data}[DocumentTitle]
#         IF    'Description' in ${content_author_data}    Enter Text In Mandatory Fields    Description    ${content_author_data}[Description]
#         IF    'TargetDateType' in ${content_author_data}
#             Click Calendar Icon In Vlms    ${icon.content.assign_doc.calendar}
#             Select Target Date    ${content_author_data}[TargetDateType]    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${content_author_data}[Year]    ${content_author_data}[Month]    ${content_author_data}[Date]
#         END
#         IF    'CCRNo.' in ${content_author_data}    Enter Text In Mandatory Fields    ChreqNo    ${content_author_data}[CCRNo]
#         IF    'DocumentMetadataForm' in ${content_author_data}    Select Value From Dropdown    ddlDocMeta    ${content_author_data}[DocumentMetadataForm]
#         IF    'FileName' in ${content_author_data}    Upload External Document And Verify Success Message    ${content_author_data}[FileName]
#         IF    'OriginalAuthor' in ${content_author_data}    Select Original Author    ${content_author_data}
#         IF    'ConfirmRoute' in ${content_author_data}    Select Checkbox    ${checkbox.content.author.doc.confirm_routing}
#         IF    'ApprovalRequired' in ${content_author_data}    Select Value For Radio Button    check    ${content_author_data}[ApprovalRequired]
#         IF    'WorkFlow' in ${content_author_data}    Select Value From Dropdown    select2-ddWorkFlow-container    ${content_author_data}[WorkFlow]
#         IF    'RouteFor' in ${content_author_data}    Select Value From Dropdown    ddlUserType    ${content_author_data}[RouteFor]
#         IF    'Comments' in ${content_author_data}    Enter Comments/Description    txtComments    ${content_author_data}[Comments]
#         IF    'Button' in ${content_author_data}    Select Submit/Reset Button    ${content_author_data}[Button]
#         ${status}    Run Keyword And Return Status    Wait Until Page Contains    Do you want to proceed?    ${SHORT_WAIT}
#         IF    '${status}'=='True'    Verify Notification Popup    Document mapping not verified. Do you want to proceed?    btnSubmitConfirm
#         Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#         Verify Confirmation Popup    ${content_author_data}[ContentType] document ${DOC_ID} for ${ENTITY_ID} has been approved    btnMessageOk
#     END

# Verify Entity
#     [Arguments]    ${username}    ${password}    ${content_author_data}
#     [Documentation]    This keyword is used Verify created entity
#     IF    '${content_author_data}[ApprovalRequired]'=='rdoAppYes' or '${content_author_data}[ApprovalRequired]'=='rdoYes'
#         Verify Document Is Routed For Peer Review/Review/Approval    ${username}    ${password}    ${content_author_data}[ContentType] document ${ENTITY_ID} for ${expected_entity_name} has been routed for ${content_author_data}[RouteFor]
#     ELSE IF    '${content_author_data}[ApprovalRequired]'=='rdoAppNo' or '${content_author_data}[ApprovalRequired]'=='rdoNo'
#         Verify Document Is Routed For Peer Review/Review/Approval    ${username}    ${password}    ${content_author_data}[ContentType] document ${ENTITY_ID} for ${expected_entity_name} has been approved
#     END

# Verify Document Is Routed For Peer Review/Review/Approval
#     [Arguments]    ${login_user}    ${login_password}    ${message}    ${reason}=None
#     [Documentation]    It is used to Verify Document is Routed for Peer Review or Review or Approval
#     ${status}    Run Keyword And Return Status    Wait Until Page Contains    Do you want to proceed?    ${SHORT_WAIT}
#     IF    '${status}'=='True'    Verify Notification Popup    Document mapping not verified. Do you want to proceed?    btnSubmitConfirm
#     Wait Until Time    4
#     Handle Electronic Sign    ${login_user}    ${login_password}    Submit    ${reason}
#     Wait Until Element Is Visible    ${label.notification_popup.message}    ${MEDIUM_WAIT}    Message is not visible after waiting for ${MEDIUM_WAIT} seconds
#     ${actual_msg}    Get Text    ${label.notification_popup.message}
#     Verify String Should Be Equal    ${message}    ${actual_msg}
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
#     Wait Until Element Is Visible    ${button.success_alert.ok}    ${MEDIUM_WAIT}    Ok button is not visible after waiting for ${MEDIUM_WAIT} seconds
#     Javascript Click    ${button.success_alert.ok}

# Enter details to create building    
#     [Arguments]    ${building_data}
#     [Documentation]    This keyword is to fill the building details
#     IF    'BuildingName' in ${building_data}    Enter Text In Mandatory Fields    BuildName    ${building_data}[BuildingName]
#     IF    'BuildingNo' in ${building_data}    Enter Text In Mandatory Fields    Prefix    ${building_data}[BuildingNo]
#     IF    'Description' in ${building_data}    Enter Text In Mandatory Fields    Description    ${building_data}[Description]
#     IF    'Button' in ${building_data}    Select Submit/Reset Button    ${building_data}[Button] 
#     # ${textbox.common.newcomments/desc}    Update Dynamic Value    ${textbox.common.comments/desc}    txtDescription
#     # Input Text    ${textbox.common.newcomments/desc}    Test Automation
#     # Wait Until Time    ${SHORT_WAIT}
#     # ${button.newsubmit/reset}    Update Dynamic Value    ${button.submit/reset}    Submit
#     # Click Element    ${button.newsubmit/reset}

# Enter details to create Room 
#     [Arguments]    ${room_data}
#     [Documentation]    This keyword is to fill the room details
#     IF    'BuildingNo' in ${room_data}    Select Value From Dropdown    select2-ddlBuilding-container    ${room_data}[BuildingNo]  
#     Wait Until Time    10
#     IF    'RoomName' in ${room_data}    Enter Text In Mandatory Fields    RoomName    ${room_data}[RoomName]
#     IF    'RoomNo' in ${room_data}    Enter Text In Mandatory Fields    Prefix    ${room_data}[RoomNo]
#     IF    'Description' in ${room_data}    Enter Text In Mandatory Fields    Description    ${room_data}[Description]
#     IF    'Button' in ${room_data}    Select Submit/Reset Button    ${room_data}[Button] 

# Create Reason
#     [Documentation]    This keyword is to anayze the excel data
#     [Arguments]    ${reason_data}
#     Wait Until Time    ${SHORT_WAIT}
#     Click Button in VLMS    Create
#     ${Reason}    Set Variable    ${reason_data}[ReasonValues]
#     Select Value From Dropdown    ddlReasonType_chosen    ${reason_data}[ReasonValues]
#     Wait Until Time    ${SHORT_WAIT}
#     ${Split_Object}    Split String    ${reason_data}[Object]    ;
#     ${count}    Get Length    ${Split_Object}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${Object}    Set Variable    ${Split_Object}[${key}]    
#         Select Value From Dropdown    lstObjectType_chosen    ${Object}
#         Wait Until Time    ${SHORT_WAIT}
#     END
#     IF    '${Reason}'=='Approval' or '${Reason}'=='Rejection' or '${Reason}'=='Review'
#         ${Split_Role}    Split String    ${reason_data}[Associate Functional Role]    ;
#         ${count2}    Get Length    ${Split_Role}
#         FOR    ${key}    IN RANGE    0    ${count2}
#             ${FunctionalRole}    Set Variable    ${Split_Role}[${key}]    
#             Select Value From Dropdown    lstFunctionalRole_chosen    ${FunctionalRole}
#         END    
#     END
#     Wait Until Time    ${SHORT_WAIT}
#     Enter Text In Mandatory Fields    StandardReason    ${reason_data}[ReasonForEsign]
#     Select Submit/Reset Button    Submit
#     Handle Electronic Sign   ${AUTHOR}    ${AUTHOR_PASSWORD}    Submit
#     ${ExpectedResult}    Set Variable    ${reason_data}[ReasonForEsign] reason has been saved    
#     Get Value From Toast Message  ${ExpectedResult}

# Enetr details for Reason
#     [Documentation]    This keyword is to fill the reason from based on the inputs given.
#     [Arguments]    ${reason_data}    ${reason_value}    ${list_of_reasonsforEsign}
#     IF    'ReasonValues' in ${reason_data}    Select Value From Dropdown    ddlReasonType_chosen    ${reason_value}
#     Select Value From Dropdown    lstObjectType_chosen    ${reason_data}[Object]
#     ${status}    Run Keyword And Return Status    Element Should Be Visible    //input[@id="CheckBox1"]
#     IF  '${status}'=='True'        Select Value From Dropdown    lstObjectType_chosen    ${reason_data}[Object]    
#     ##IF  '${status}'=='True'        Click Element    //input[@id="CheckBox1"]
#     IF    'ReasonForEsign' in ${reason_data}    Enter Text In Mandatory Fields    StandardReason    ${list_of_reasonsforEsign}
#     IF    'Button' in ${reason_data}    Select Submit/Reset Button    ${reason_data}[Button]
#     IF    'ReasonValues'!='Create'    Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     ${ExpectedResult}    Set Variable    ${reason_value} Reason has been created
#     Get Value From Toast Message    ${ExpectedResult}

# Create the Functional roles
#     [Documentation]    This keyword is for creating the functinal role.
#     [Arguments]    ${fnRole_data}    ${USER}    ${USER_PASSWORD}
#     ${count}    Get Length    ${fnRole_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${dict_data}    Set Variable    ${fnRole_data}[${key}]
#         Click Button in VLMS    Create
#         Fill the Functional role form    ${dict_data}    ${dict_data}[FRName]    ${dict_data}[FRPrefix]    ${USER}    ${USER_PASSWORD}
#     END

# Fill the Functional role form
#     [Documentation]    This keyword is for filling the functional role.
#     [Arguments]    ${fnRole_data}    ${fnroles_name}    ${fnrole_prefix}    ${USER}    ${USER_PASSWORD}
#     IF    'FRName' in ${fnRole_data}    Enter Text In Mandatory Fields    FnRoleName    ${fnroles_name}
#     IF    'FRPrefix' in ${fnRole_data}    Enter Text In Mandatory Fields    FnRolePrefix    ${fnrole_prefix}
#     Input Text    ${textarea.description.system.create.functionalrole}    Functional Role Created
#     #IF    'Description' in ${fnRole_data}    Enter Text In Mandatory Fields    FnRoleDesc    ${fnRole_data}[Description]
#     IF    'Button' in ${fnRole_data}    Select Submit/Reset Button    ${fnRole_data}[Button]
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     ${Expected_Result}    Set Variable    Functional Role ${fnroles_name} has been created
#     Get Value From Toast Message    ${Expected_Result}

# Enter the validation plan
#     [Documentation]    This keyword used to create Validation plan
#     [Arguments]    ${validation_plan}    ${USER}    ${USER_PASSWORD}
#     Wait Until Time    ${SHORT_WAIT}
#     Click Element    ${button.create}
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'validationplan' in ${validation_plan}    Select Value For Radio Button    rdoValPlanNew    ${validation_plan}[validationplan]
#     IF    'validationName' in ${validation_plan}    Enter Text In Mandatory Fields    ValPlanName    ${validation_plan}[validationName]
#     ${valdation.plan.id}    Get Text    ${label.valdation.plan.id}
#     ${validation_plan_id}    Set Variable    ${valdation.plan.id}
#     # ${valdation.plan.id}    Remove String    <    >
#     IF    'Validation_Template' in ${validation_plan}    Select Value From Dropdown    select2-ddlValidationTemplate-container    ${validation_plan}[Validation_Template]
#     Wait Until Time    3
#     Click Element    ${button.tree.VP}
#     Wait Until Time    3
#     Click Element    ${button.subtree.VP}
#     Wait Until Time    3
#     Select Checkbox    ${checkbox.tree.vp}
#     Wait Until Time    3
#     Click Element    ${button_save}
#     Wait Until Time    3
#     Click Element    ${buttonsave1}
#     Wait Until Time    3
#     Verify Confirmation Popup    Validation Plan - ${validation_plan}[validationName] for ${valdation.plan.id} has been saved    btnMessageOk
#     Wait Until Time    5
#     Search And Select The Value From The Section    ${validation_plan}[validationName]
#     Wait Until Time    3
#     Select Checkbox    ${checkbox.routing.VP}
#     Wait Until Time    3
#     IF    'ApprovalRequired' in ${validation_plan}    Select Value For Radio Button    rdoApprovalYes    ${validation_plan}[ApprovalRequired]
#     Wait Until Time    3
#     IF    'Workflow' in ${validation_plan}    Select Value From Dropdown    select2-ddlWorkFlow-container    ${validation_plan}[Workflow]
#     Wait Until Time    3
#     IF    'RouteFor' in ${validation_plan}    Select Value From Dropdown    select2-ddlWorkflowTransfer-container    ${validation_plan}[RouteFor]
#     Select Submit/Reset Button    Submit
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Verify Confirmation Popup    ${validation_plan}[validationName] Validation Plan ${validation_plan_id} has been routed for Review    btnMessageOk
#     Set Suite Variable    ${validation_plan_id}

# Route for Review
#     [Documentation]    This keyword used to review and route to Approval.
#     [Arguments]    ${validation_plan}    ${USER}    ${USER_PASSWORD}
#     Wait Until Time    ${SHORT_WAIT}
#     Navigate To Module Tab    Assessment    Review    Validation Plan    Select Validation Summary to Review
#     Wait Until Time    ${SHORT_WAIT}
#     Search And Select The Value From The Section    ${validation_plan}[validationName]
#     Wait Until Time    ${SHORT_WAIT}
#     click Element    ${button.accept}
#     Wait Until Time    ${SHORT_WAIT}
#     Verify Confirmation Popup    Review Validation Plan has been accepted    btnMessageOk
#     Wait Until Time    300
#     # Click Element    ${button.Refresh}
#     Select Checkbox    ${checkbox.content.assign.authoring.peer_review_completed}
#     Wait Until Time    ${SHORT_WAIT}
#     Select Submit/Reset Button    Submit
#     Wait Until Time    ${SHORT_WAIT}
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Wait Until Time    ${MEDIUM_WAIT}
#     Verify Confirmation Popup    ${validation_plan}[validationName] Validation Plan ${validation_plan_id} has been reviewed    btnMessageOk

# Reviewed Validation Plan
#     [Documentation]    This keyword is used to route to approval after Reviewed.
#     [Arguments]    ${validation_plan}    ${USER}    ${USER_PASSWORD}
#     Wait Until Time    ${SHORT_WAIT}
#     Navigate To Module Tab    Assessment    Create    Validation Plan    Select Validation Plan
#     Wait Until Time    ${SHORT_WAIT}
#     Search And Select The Value From The Section    ${validation_plan}[validationName]
#     Wait Until Time    ${SHORT_WAIT}
#     Select Checkbox    ${checkbox.routing.VP}
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'RouteTask' in ${validation_plan}
#         Select Value From Dropdown    select2-ddlWorkflowTransfer-container    ${validation_plan}[RouteTask]
#     END
#     Select Submit/Reset Button    Submit
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Wait Until Time    ${SHORT_WAIT}
#     Verify Confirmation Popup    ${validation_plan}[validationName] Validation Plan ${validation_plan_id} has been routed for Approval    btnMessageOk

# Approve Validation plan
#     [Documentation]    This keyword is used Approve
#     [Arguments]    ${validation_plan}    ${USER}    ${USER_PASSWORD}
#     Wait Until Time    ${SHORT_WAIT}
#     Navigate To Module Tab    Assessment    Approve    Validation Plan    Select Validation Plan to Approve
#     Wait Until Time    ${SHORT_WAIT}
#     Search And Select The Value From The Section    ${validation_plan}[validationName]
#     Wait Until Time    ${SHORT_WAIT}
#     click Element    ${button.accept}
#     Wait Until Time    ${SHORT_WAIT}
#     Verify Confirmation Popup    Approve Validation Plan has been accepted    btnMessageOk
#     Wait Until Time    300
#     IF    'Approve' in ${validation_plan}
#         Select Value For Radio Button    rbtnApproveYes    ${validation_plan}[Approve]
#     END
#     Select Submit/Reset Button    Submit
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Verify Confirmation Popup    ${validation_plan}[validationName] Validation Plan ${validation_plan_id} has been approved    btnMessageOk

# Enter Validation Summary
#     [Documentation]    This keyword used to create Validation summary
#     [Arguments]    ${validation_summary}    ${USER}    ${USER_PASSWORD}
#     Wait Until Time    ${SHORT_WAIT}
#     Click Element    ${button.create}
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'validationplan' in ${validation_summary}
#         Select Value For Radio Button    rdoValPlanNew    ${validation_summary}[validationplan]
#     END
#     IF    'validationSummaryName' in ${validation_summary}
#         Enter Text In Mandatory Fields    ValPlanName    ${validation_summary}[validationSummaryName]
#     END
#     ${valdation.plan.id}    Get Text    ${label.valdation.plan.id}
#     Comment    ${valdation.plan.id}    Remove String    <    >
#     IF    'Validation_Template' in ${validation_summary}
#         Select Value From Dropdown    select2-ddlValidationTemplate-container    Validation Summary VG4.2 - [CND-VS VG4.2-0010.01]
#     END
#     Wait Until Time    3
#     Click Element    ${button.tree.VP}
#     Wait Until Time    3
#     Click Element    ${button.subtree.VP}
#     Wait Until Time    3
#     Select Checkbox    ${checkbox.tree.vp}
#     Wait Until Time    3
#     Click Element    ${button_save}
#     Wait Until Time    3
#     Click Element    ${buttonsave1}
#     Wait Until Time    3
#     Verify Confirmation Popup
#     ...    Validation Summary - ${validation_summary}[validationSummaryName] for ${valdation.plan.id} has been saved
#     ...    btnMessageOk
#     Wait Until Time    300
#     Search And Select The Value From The Section    ${validation_summary}[validationSummaryName]
#     Wait Until Time    ${SHORT_WAIT}
#     Select Checkbox    ${checkbox.routing.VP}
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'ApprovalRequired' in ${validation_summary}
#         Select Value For Radio Button    rdoApprovalYes    ${validation_summary}[ApprovalRequired]
#     END
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'Workflow' in ${validation_summary}
#         Select Value From Dropdown    select2-ddlWorkFlow-container    ${validation_summary}[Workflow]
#     END
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'RouteFor' in ${validation_summary}
#         Select Value From Dropdown    select2-ddlWorkflowTransfer-container    ${validation_summary}[RouteFor]
#     END
#     Select Submit/Reset Button    Submit
#     Wait Until Time    ${SHORT_WAIT}
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Verify Confirmation Popup
#     ...    ${validation_summary}[validationSummaryName] Validation Summary ${valdation.plan.id} has been routed for Review
#     ...    btnMessageOk
#     Set Suite Variable    ${valdation.plan.id}

# Route for Review for Validation summary
#     [Documentation]    This keyword used to review and route to Approval.
#     [Arguments]    ${validation_summary}    ${USER}    ${USER_PASSWORD}
#     Wait Until Time    ${SHORT_WAIT}
#     Navigate To Module Tab    Assessment    Review    Validation Summary    Select Validation Summary to Review
#     Wait Until Time    ${SHORT_WAIT}
#     Search And Select The Value From The Section    ${validation_summary}[validationSummaryName]
#     Wait Until Time    ${SHORT_WAIT}
#     click Element    ${button.accept}
#     Wait Until Time    ${SHORT_WAIT}
#     Verify Confirmation Popup    Review Validation Summary has been accepted    btnMessageOk
#     Wait Until Time    300
#     # Click Element    ${button.Refresh}
#     Select Checkbox    ${checkbox.content.assign.authoring.peer_review_completed}
#     Wait Until Time    ${SHORT_WAIT}
#     Select Submit/Reset Button    Submit
#     Wait Until Time    ${SHORT_WAIT}
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Wait Until Time    ${MEDIUM_WAIT}
#     Verify Confirmation Popup
#     ...    ${validation_summary}[validationSummaryName] Validation Summary ${valdation.plan.id} has been reviewed
#     ...    btnMessageOk

# Reviewed for Validation summary
#     [Documentation]    This keyword is used to route to approval after Reviewed.
#     [Arguments]    ${validation_summary}    ${USER}    ${USER_PASSWORD}
#     Wait Until Time    ${SHORT_WAIT}
#     Navigate To Module Tab    Assessment    Create    Validation Summary    Select Validation Summary
#     Wait Until Time    ${SHORT_WAIT}
#     Search And Select The Value From The Section    ${validation_summary}[validationSummaryName]
#     Wait Until Time    ${SHORT_WAIT}
#     Select Checkbox    ${checkbox.routing.VP}
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'RouteTask' in ${validation_summary}
#         Select Value From Dropdown    select2-ddlWorkflowTransfer-container    ${validation_Summary}[RouteTask]
#     END
#     Select Submit/Reset Button    Submit
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Wait Until Time    ${SHORT_WAIT}
#     Verify Confirmation Popup
#     ...    ${validation_summary}[validationSummaryName] Validation Summary ${valdation.plan.id} has been routed for Approval
#     ...    btnMessageOk

# Approve Validation summary
#     [Documentation]    This keyword is used Approve
#     [Arguments]    ${validation_summary}    ${USER}    ${USER_PASSWORD}
#     Wait Until Time    ${SHORT_WAIT}
#     Navigate To Module Tab    Assessment    Approve    Validation Summary    Select Validation Summary to Approve
#     Wait Until Time    ${SHORT_WAIT}
#     Search And Select The Value From The Section    ${validation_summary}[validationSummaryName]
#     Wait Until Time    ${SHORT_WAIT}
#     click Element    ${button.accept}
#     Wait Until Time    ${SHORT_WAIT}
#     Verify Confirmation Popup    Approve Validation Summary has been accepted    btnMessageOk
#     Wait Until Time    300
#     IF    'Approve' in ${validation_summary}
#         Select Value For Radio Button    rbtnApproveYes    ${validation_summary}[Approve]
#     END
#     Select Submit/Reset Button    Submit
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Verify Confirmation Popup
#     ...    ${validation_summary}[validationSummaryName] Validation Summary ${valdation.plan.id} has been approved
#     ...    btnMessageOk

# Create Group
#     [Documentation]    This keyword is used to Create a Group of available Users which can be applied for multiple objects
#     [Arguments]    ${Group_data}    ${USERID}    ${USER_PASSWORD}
            
#     Wait Until Time    2
#     ${count}    Get Length    ${Group_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${dict_data}    Set Variable    ${Group_data}[${key}]
#         Wait Until Time    ${SHORT_WAIT}
#         Click Button in VLMS    Create
#         IF    'GroupName' in ${dict_data}    Enter Text In Mandatory Fields    boxGroupName    ${dict_data}[GroupName]
#         Wait Until Time    2
#         IF    'GroupType' in ${dict_data}    Select Value From Dropdown    ddlGroupType_chosen    ${dict_data}[GroupType]
#         Wait Until Time    ${SHORT_WAIT}
#         ${split_data}    Split String    ${dict_data}[Users]    ,
#         ${user_count}    Get Length    ${split_data}
#         FOR    ${user}    IN RANGE    0    ${user_count}
#             Wait Until Time    ${SHORT_WAIT}
#             Select Value From Dropdown    lboxAssignedUser_chosen    ${split_data}[${user}]
#             Wait Until Time    ${SHORT_WAIT}
#             #IF    '${split_data}[${user}]' != 'All users'
#                 #Input Text    ${textbox.group}    ${split_data}[${user}]
#                 #Wait Until Time    ${SHORT_WAIT}
#                 #Click Element    ${checkbox.availableuser.groups}
#             #ELSE
#                 #Click Element    ${checkbox.selectalluser.groups}
#             #END
#         END
#         Select Submit/Reset Button    Submit
#         Handle Electronic Sign    ${USERID}    ${USER_PASSWORD}    Submit
#         ${Expected_Result}    Set Variable    ${dict_data}[GroupName] Group has been created.
#         Get Value From Toast Message    ${Expected_Result}
#     END

# Get Value From Toast Message
#     [Arguments]    ${ExpectedResult}
#     Wait Until Element Is Visible    ${toast.common.verify Message}
#     ${Actual_Result}    Get Text    ${toast.common.verify Message}
#     ${Color}    Get Element Attribute    ${toastmessage.popup.verify.common}    class
#     ${status}    Run Keyword And Return Status    Should Contain    ${Color}    alert-success
#     #Should Contain   ${Color}    alert-success show
#     Verify String Should Be Equal    ${ExpectedResult}    ${Actual_Result}
#     RETURN    ${status}

# Select Value From Dropdown for Select
#     [Arguments]    ${dropdown_name}    ${dropdown_value}
#     [Documentation]    This keyword is used to select value from a dropdown
#     Wait Until Element Is Visible    ${dropdown_name}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
#     Wait Until Element Is Clickable And Click    ${dropdown_name}    2
#     Wait Until Time    3
#     ${dropdown.common.select.newvalue}    Update Dynamic Value    ${dropdown_name}//li[contains(text(),'replaceText')]    ${dropdown_value}
#     Wait Until Element Is Visible    ${dropdown.common.select.newvalue}    ${MEDIUM_WAIT}    ${dropdown_value} is not visible after waiting ${MEDIUM_WAIT} seconds
#     Click Element    ${dropdown.common.select.newvalue}

# Create Form prerequsite
#     [Arguments]    ${dic_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword is used to Create Form
#     ${rows}   Get Length    ${dic_data}
#     FOR    ${key}    IN RANGE    0   ${rows}
#         ${dict_data}    Set Variable    ${dic_data}[${key}]
#         Click Element    //input[@id='btnCreate']
#         IF    '${dict_data}[FormType]'=='Standard Form'     Standard form creation prerequisite    ${dict_data}   ${user_name}    ${password}
#         IF   '${dict_data}[FormType]'=='Exception Form'     Exception form creation prerequiste    ${dict_data}   ${user_name}    ${password}
#         IF   '${dict_data}[FormType]'=='Discrepancy Form'     Exception form creation prerequiste    ${dict_data}   ${user_name}    ${password}
#         IF   '${dict_data}[FormType]'=='Deviation Form'     Exception form creation prerequiste    ${dict_data}   ${user_name}    ${password}        
#         IF    '${dict_data}[FormType]'=='Framework Form'    Framework and Project Form creation with Textbox Control     ${dict_data}   ${user_name}    ${password}
#         IF    '${dict_data}[FormType]'=='Project Form'    Framework and Project Form creation with Textbox Control     ${dict_data}   ${user_name}    ${password}
#         IF    '${dict_data}[FormType]'=='Internal Process Map'    IPM form cration for prerequiste    ${dict_data}   ${user_name}    ${password}
#         IF    'Button' in ${dict_data}    Select Submit/Reset Button    ${dict_data}[Button]
#         Handle Electronic Sign    ${user_name}    ${password}    Submit
#         Wait Until Element Clickable    //input[@id='btnCreate']
#         #Verify Confirmation Popup    ${dict_data}[FormName] Form has been created    btnMessageOk
#     END

# Drag And Drop Field Types To Form Field Details Grid_Prerequisite
#     [Arguments]    ${field_type}    ${cell_index}
#     [Documentation]    This Keyword is used to Verify Field Types in Control Creation in Create Form Screen.
#     ${label.system.create.form.add_controls.control_creation.newfield}    Update Dynamic Value    ${label.system.create.form.add_controls.control_creation.fields}    ${field_type}
#     Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation.newfield}    ${SHORT_WAIT}    ${field_type} is not visible after waiting ${SHORT_WAIT} seconds
#     ${textbox.system.create.form.add_controls.control_creation.form_field_details.newcell}    Update Dynamic Value    ${textbox.system.create.form.add_controls.control_creation.form_field_details.cell}    ${cell_index}
#     Drag And Drop    ${label.system.create.form.add_controls.control_creation.newfield}    ${textbox.system.create.form.add_controls.control_creation.form_field_details.newcell}

# Add Settings To Form Fields_Prerequisite
#     [Arguments]    ${form_data}    ${cell values}
#     [Documentation]    This Keyword is used to Add Settings To Form Fields
#     ${icon.system.create.form.add_controls.control_creation.field.newsettings}    Update Dynamic Value    ${icon.system.create.form.add_controls.control_creation.field.settings}    ${cell values}
#     Wait Until Element Is Visible    ${icon.system.create.form.add_controls.control_creation.field.newsettings}    ${MEDIUM_WAIT}    Settings Icon is not visible after waiting ${MEDIUM_WAIT} seconds
#     Click Element    ${icon.system.create.form.add_controls.control_creation.field.newsettings}
#     IF    'Label' in ${form_data}    Enter Text In Mandatory Fields    LabelValue    ${form_data}[Label]
#         Select Value For Radio Button    rdoRequiredNo    ${form_data}[Textbox Mandatory]
#         Select Value For Radio Button    tbTransNotRequired    ${form_data}[Textbox Translation]
#         Wait Until Time    3
#         Double Click Element       //*[@id="txtLength"]
#         Input Text    //*[@id="txtLength"]    ${form_data}[Textbox Length]
#     IF    'HelpText' in ${form_data}
#         Select Frame    ${iframe.system.create.form.control_creation.settings.helptext}
#         Input Text    ${textbox.system.create.form.control_creation.settings.helptext}    ${form_data}[HelpText]
#         Wait Until Time    3
#         Switch To Parent Frame
#     END
#       Scroll Element Into View    //input[@id="btnSaveSettings"]
#       Click Element  //input[@id="btnSaveSettings"]
#       Wait Until Time    2

# Add Settings To Form Fields for prerequiste
#     [Arguments]    ${form_data}    ${cell values}    
#     [Documentation]    This Keyword is used to Add Settings To Form Fields
#     ${icon.system.create.form.add_controls.control_creation.field.newsettings}    Update Dynamic Value    ${icon.system.create.form.add_controls.control_creation.field.settings}    ${cell values}
#     Wait Until Element Is Visible    ${icon.system.create.form.add_controls.control_creation.field.newsettings}    ${MEDIUM_WAIT}    Settings Icon is not visible after waiting ${MEDIUM_WAIT} seconds
#     Click Element    ${icon.system.create.form.add_controls.control_creation.field.newsettings}
#     IF    'Label' in ${form_data}    Enter Text In Mandatory Fields    LabelValue    ${form_data}[Label]
#       Select Value For Radio Button    rdoRequiredNo    ${form_data}[Textbox Mandatory]
#        Select Value For Radio Button    tbTransNotRequired    ${form_data}[Textbox Translation]
#       Wait Until Time    3
#       Double Click Element       //*[@id="txtLength"]
#        Input Text    //*[@id="txtLength"]    ${form_data}[Textbox Length]
#     IF    'HelpText' in ${form_data}
#         Select Frame    ${iframe.system.create.form.control_creation.settings.helptext}
#         Input Text    ${textbox.system.create.form.control_creation.settings.helptext}    ${form_data}[HelpText]
#         Switch To Parent Frame
#     END
#        Click Element   //input[@id="btnSaveSettings"]
#       Wait Until Time    2      

# Enter The Details To Create A New Content_Prereuisite
#     [Arguments]    ${content_type_data}    ${User}    ${USER_PASSWORD}
#     [Documentation]    This Is To Enter The Details To Create The Content
#     Click Button in VLMS    Create
#     Wait Until Time    ${SHORT_WAIT}
#     ${count}    Get Length    ${content_type_data}[ContentTypeName]
#     ##FOR    ${key}    IN RANGE    0    ${count}
#         ##${dict_data}    Set Variable    ${content_type_data}[${key}]
#         ${content_type_list}    Set Variable    ${content_type_data}[ContentTypeName]
#         ${content_type_prefix}    Set Variable    ${content_type_data}[PrefixName]
#         ${content_type_function}    Set Variable    ${content_type_data}[ContentFunction]
#         ${count}    Get Length    ${content_type_list}
#         Enter The Details Content_Prerequisite    ${content_type_list}    ${content_type_prefix}    ${content_type_function}    ${content_type_data}     ${User}    ${USER_PASSWORD}    
#     ##END

# Enter The Details Content_Prerequisite
#     [Arguments]    ${content_type_list}    ${content_type_prefix}    ${content_type_function}    ${content_type_data}    ${User}    ${USER_PASSWORD}
#     [Documentation]    This Is To Enter The Details To Create The Content
#     Wait Until Element Is Visible    txtTypeName    ${SHORT_WAIT}
#     Enter Text In Mandatory Fields    TypeName    ${content_type_list}      
#     Wait Until Element Is Visible    txtPrefix    ${SHORT_WAIT}
#     Enter Text In Mandatory Fields    Prefix    ${content_type_prefix} 
#     Wait Until Element Is Visible    ddlValType_chosen    ${SHORT_WAIT}
#     Select Value From Dropdown    ddlValType_chosen    ${content_type_function}
#     # Javascript Click   ${button.department.create.submit}
#     Select Submit/Reset Button    ${content_type_data}[Button]
#     Handle Electronic Sign   ${User}    ${User_password}       Submit    ${content_type_data}[Reason]
#     ${ExpectedResult}    Set Variable    ${content_type_list} content type has been created
#     Get Value From Toast Message    ${ExpectedResult}

# Create Department
#     [Arguments]    ${content_type_data}
#     [Documentation]    This is to enter the details to create the department
#     Click Button in VLMS    Create
#     ${count}    Get Length    ${content_type_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${department_data}    Set Variable    ${content_type_data}[${key}]
#         Wait Until Time    ${SHORT_WAIT}
#         Wait Until Element Is Visible    //span[@id="lblCreateDepartment"]    ${SHORT_WAIT}
#         Select Value From Dropdown   ddlSite_chosen    ${department_data}[SiteName]
#         Wait Until Time    3
#         Enter Text In Mandatory Fields    boxDepartmentName     ${department_data}[DepartmentName]
#         Javascript Click   ${button.department.create.submit}
#         IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
#         ${Expected_Result}    Set Variable    ${department_data}[DepartmentName] Department has been created
#         ${Sts}    Get Value From Toast Message    ${Expected_Result}
          
        
#     END

# Capture Allure Screenshot
#     [Documentation]    This Keyword will take screenshot for allure report
#     ${png_name}    Get Unique Test Data    Unique
#     Screenshot Page    Screenshot${png_name}

# Create Job Title
#     [Arguments]    ${content_type_data}
#     [Documentation]    This is to enter the details to create the Job Title
#     Click Button in VLMS    Create
#     ${count}    Get Length    ${content_type_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${title_data}    Set Variable    ${content_type_data}[${key}]
#         Wait Until Element Is Visible    //span[@id="lblCreateTitle"]    ${SHORT_WAIT}
#         Select Value From Dropdown    ddlSite_chosen    ${title_data}[SiteName]
#         Wait Until Time    3
#         Enter Text In Mandatory Fields    boxTitleName     ${title_data}[TitleName]
#         Javascript Click   ${button.department.create.submit}
#         IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
#         ${Expected_Result}    Set Variable    ${title_data}[TitleName] Job Title has been created
#         ${Sts}    Get Value From Toast Message    ${Expected_Result}
#     END
        

# Save Questions And Answers In Section_Prerequisite
#     [Arguments]    ${questions}    ${answers}
#     [Documentation]    Its is used to save the questions and answers in the define question section
#     ${splitted_questions}    Split String    ${questions}    ,
#     ${splitted_questions_count}    Get Length    ${splitted_questions}
#     FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
#         ${question_and_questionprefix}    Split String    ${splitted_questions}[${question_key}]    -
#         ${question}    Set Variable    ${question_and_questionprefix}[1]
#         ${questionprefix}    Set Variable    ${question_and_questionprefix}[0]
#         Wait Until Time    2
#         Input Text    ${textbox.system.create.decision_tree.section.question}    ${question}
#         Input Text    ${textbox.system.create.decision_tree.section.question_prefix}    ${questionprefix}
#         ${splitted_answers}    Split String    ${answers}    |
#         Enter Multiple Answers_Prerequisite    ${splitted_answers}[${question_key}]
#         Click Button In VLMS    Save
#         ${label.system.create.decision_tree.section.newquestion}    Update Dynamic Values    ${label.system.create.decision_tree.section.question}    ${questionprefix}    ${question}
#         Wait Until Element Is Visible    ${label.system.create.decision_tree.section.newquestion}
#         IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
#     END

# Enter Multiple Answers_Prerequisite
#     [Arguments]    ${answers}
#     [Documentation]    It is used to enter multiple answers to each question
#     ${splitted_answers}    Split String    ${answers}    ,
#     ${splitted_answers_count}    Get Length    ${splitted_answers}
#     FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
#         ${updated_answer_key}    Evaluate    ${answer_key}+2
#         ${updated_answer_key}    Convert To String    ${updated_answer_key}
#         ${textbox.system.create.decision_tree.newanswer}    Update Dynamic Value    ${textbox.system.create.decision_tree.answer}    ${updated_answer_key}
#         Wait Until Element Is Visible    ${textbox.system.create.decision_tree.newanswer}    ${MEDIUM_WAIT}    Answer input textbox is not visible after waiting ${MEDIUM_WAIT} seconds
#         Input Text    ${textbox.system.create.decision_tree.newanswer}    ${splitted_answers}[${answer_key}]
#         IF    ${answer_key}+1<${splitted_answers_count}
#             Click Element    ${link.system.create.decision_tree.section.answer.add}
#         END
#     END

# Add Manual Content Library_Prerequisite
#     [Arguments]    ${tab_name}    ${content_library}
#     [Documentation]    It is used to add content library in define action tab
#     Wait Until Time    3
#     Unselect Frame
#     Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}
#     Select Frame    ${iframe.library_frame.screen}
#     ${button.content_library.newtabs}    Update Dynamic Value    ${button.content_library.tabs}    ${tab_name}
#     Wait Until Element Is Visible    ${button.content_library.newtabs}    ${MEDIUM_WAIT}
#     Click Element    ${button.content_library.newtabs}
#     ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${dropdown.content_library.select_doc.select}
#     IF    '${status}'=='True'
#         Click Element    ${dropdown.content_library.select_doc.select}
#     ELSE
#         Click Element    ${dropdown.content_library.generic.select}
#     END
#     ${label.content_library.select_doc.newvalue}    Update Dynamic Value    ${label.content_library.select_doc.value.pre}    ${content_library}
#     Wait Until Element Is Visible    ${label.content_library.select_doc.newvalue}    ${MEDIUM_WAIT}
#     Click Element    ${label.content_library.select_doc.newvalue}
#     Wait Until Time    3
#     Click Element    ${checkbox.content_library.select}
#     Click Button In VLMS    Add
#     Wait Until Time    3
#     Click Button In VLMS    Save

# Create Site
#     [Arguments]    ${trace_data}
#     [Documentation]    This Keyword is used to creat Site on System Manager
#     Click Button In VLMS    Create
#     ${count}    Get Length    ${trace_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${site_data}    Set Variable    ${trace_data}[${key}]
#         Wait Until Element Is Visible    ${textbox.config.create.sitename}    ${MEDIUM_WAIT}
#         Input Text    ${textbox.config.create.sitename}    ${Site_Data}[SiteName]
#         ${Site}    Set Variable   ${Site_Data}[SiteName]
#         #${Site}    Set Variable    ${site_data}[SiteName]
#         Input Text    ${textbox.config.create.siteprefix}    ${Site_Data}[Prefix]
#         Click Button In VLMS    Submit
#         ${Expected_Result}    Set Variable    ${Site_Data}[SiteName] Site has been created
#         ${Sts}    Get Value From Toast Message    ${Expected_Result}
#     END

# Get Entity Type ID
#     [Documentation]    This keyword is used to get the entity type id
#     Wait Until Element Is Visible    ${label.system.create.entity_type}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting ${MEDIUM_WAIT} seconds
#     ${actual_entity_type_id}    Get Text    ${label.system.create.entity_type_code}
#     ${updated_entity_type_id}    Remove String    ${actual_entity_type_id}    <    >
#     ${ENTITY_TYPE_ID}    Set Variable    ${updated_entity_type_id}
#     Set Suite Variable    ${ENTITY_TYPE_ID}
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

# Enter Pre-requisite Details In Create Entity Type_Prerequisite
#     [Arguments]    ${system_entity_data}
#     [Documentation]    This keyword is used to enter pre-requisite details in create entity type
#     Log    ${system_entity_data}[TaskType]
#     IF    'TaskType' in ${system_entity_data}    Select Value For Radio Button    DocType    ${system_entity_data}[TaskType]
#     IF    'SelectEntityType' in ${system_entity_data}    Select Value From Dropdown    ddlRevisedEntType    ${system_entity_data}[SelectEntityType]
#     IF    'EntityTypeName' in ${system_entity_data}    Input Text    ${textbox.system.create.entity_type}    ${system_entity_data}[EntityTypeName]
#     IF    'Prefix' in ${system_entity_data}    Input Text    ${textbox.system.create.entity.prefix}    ${system_entity_data}[Prefix]
#     # Select Value For Radio Button    rbtEntConfigManual    rbtEntConfigManual
#     IF    'EntityNoType' in ${system_entity_data} or '${system_entity_data}[EntityNoType]'=='rbtEntConfigManual'
#         Select Value For Radio Button    rbtEntConfigManual    ${system_entity_data}[EntityNoType]
#     END
#     IF    'DepartmentRequired' in ${system_entity_data}    Select Value For Radio Button    DepartmentReq    ${system_entity_data}[DepartmentRequired]
#     Wait Until Time    3
#     IF    'VersioningRequired' in ${system_entity_data}    Select Value For Radio Button    VerReq    ${system_entity_data}[VersioningRequired]
#     Wait Until Time    2
#     IF    'VersionFormat' in ${system_entity_data}    Select Value From Dropdown    ddlVersionFormat    ${system_entity_data}[VersionFormat]
#     Wait Until Time    3
#     IF    'EntityFormType' in ${system_entity_data}    Select Value From Dropdown    EntTypeSelect-container    ${system_entity_data}[EntityFormType]

# Navigate To Create Trace Model Page_Prerequisite
#     [Documentation]    This Keyword is used to Navigate To Create Trace Model Page
#     Navigate To Module Tab    Content    Create    Trace Model    Select Trace Model to Develop
#     Click Button In VLMS    Create

# Enter Trace Model Title And Select Content Types_Prerequisite
#     [Arguments]    ${trace_data}
#     [Documentation]    This Keyword is used to Enter Trace Model Title And Select Content Types
#     IF    'TraceModelTitle' in ${trace_data}    Enter Text In Mandatory Fields    Title    ${trace_data}[TraceModelTitle]
#     Wait Until Element Is Visible    ${label.create.trace_model.header_id}    ${MEDIUM_WAIT}    Trace model header is not visible after waiting ${MEDIUM_WAIT} seconds
#     ${trace_model_id}    Get Text    ${label.create.trace_model.header_id}
#     ${TRACE_MODEL_NO}    Remove String    ${trace_model_id}    <    >
#     IF    'Description' in ${trace_data}    Enter Text In Mandatory Fields    Description   ${trace_data}[Description]
#     IF    'TargetDateType' in ${trace_data}
#         Click Calendar Icon In Vlms    ${icon.create_trace_model.calendar}
#         Select Target Date    ${trace_data}[TargetDateType]    txtTargetDt    txtTargetDt_DrpPnl_Calendar1_506    txtTargetDt_DrpPnl_Calendar1_504    ${trace_data}[Year]    ${trace_data}[Month]    ${trace_data}[Date]
#     END
#     IF    'SelectContentTypes' in ${trace_data}   Swipe Values Between Groups_Prerequisite    ${trace_data}[SelectContentTypes]    lstAvailbleValidationType    lstSelectedValidationType
#     IF    'DeselectContentTypes' in ${trace_data}   Swipe Values Between Groups_Prerequisite    ${trace_data}[DeselectContentTypes]    lstSelectedValidationType    lstAvailbleValidationType
#     IF    'ContentLibrary' in ${trace_data}    Select Value For Radio Button    TestFnReq    ${trace_data}[ContentLibrary]
#     IF    'OrderButton' in ${trace_data}    Click Button In VLMS    ${trace_data}[OrderButton]
#     @{SELECTED_LIST}    Get Selected List Labels    ${label.content.create.trace_model.selected_content_types}
#     Set Suite Variable    @{SELECTED_LIST}
#     ${SELECTED_CT_VALUES}    Create Dictionary
#     FOR    ${key}    IN   @{SELECTED_LIST}
#         ${label.content.create.trace_model.screen.newselected_content_types}    Update Dynamic Value    ${label.content.create.trace_model.screen.selected_content_types}    ${key}
#         ${value}    Get Value    ${label.content.create.trace_model.screen.newselected_content_types}
#         Set To Dictionary    ${SELECTED_CT_VALUES}    ${key}    ${value}
#     END
#     Set Suite Variable    ${SELECTED_CT_VALUES}
#     Set Test Variable    ${TRACE_MODEL_NO}
#     ${EXPECTED_MESSAGE}    Set Variable    ${trace_data}[TraceModelTitle] Trace Model ${TRACE_MODEL_NO} has been created
#     RETURN    ${EXPECTED_MESSAGE}

# Create Trace Model and Bind Task
#     [Arguments]    ${trace_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword is used to Create Trace Model
#     ${TRACE_MODEL_NO}    Set Variable    ACND-DDTM-0001.01
#     ${count}    Get Length    ${trace_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${dict_data}    Set Variable    ${trace_data}[${key}]
#         Navigate To Create Trace Model Page
#         ${EXPECTED_MESSAGE}    Enter Trace Model Title And Select Content Types    ${dict_data}
#         Wait Until Element Is Visible    ${img.content.create.trace_model}    ${LONG_WAIT}    Trace Model Image is not visible after waiting ${LONG_WAIT} seconds
#         Log Expected And Actual Results    "Trace Model" image with check boxes as matrix structure is Displayed    "Trace Model" image with check boxes as matrix structure should be populated
#         Verify Selected Content Types In Trace Model_Prerequisite
#         IF    'CheckboxList' in ${dict_data}    Select Checkboxes In Trace Model    ${dict_data}[CheckboxList]
#         IF    'Approval' in ${dict_data}    Select Value For Radio Button    ApprovReq    ${dict_data}[Approval]
#         IF    '${dict_data}[Approval]'=='rdoAppYes'
#             IF    'Workflow' in ${dict_data}    Select Value From Dropdown    ddlWorkflow    ${dict_data}[Workflow]
#         END
#         IF    'Comments' in ${dict_data}    Enter Text In Mandatory Fields    Comment    ${dict_data}[Comments]
#         Select Submit/Reset Button    Submit
#         Handle Electronic Sign    ${user_name}    ${password}    Submit
#         Verify Confirmation Popup    ${EXPECTED_MESSAGE}    btnMessageOk
#         Navigate To Create Bind Task Page_Prerequisite
#         ${EXPECTED_MESSAGE}    Create Bind Task_Prerequisite    ${dict_data}    ${TRACE_MODEL_NO}    ${USER}    ${USER_PASSWORD}
#         Verify Confirmation Popup    ${EXPECTED_MESSAGE}    btnMessageOk
#     END

# Navigate To Create Bind Task Page_Prerequisite
#     [Documentation]    This Keyword is used to Navigate To Create Bind Task Page
#     Navigate To Module Tab    System    Bind    Bind Task    Select Bind Task
#     Click Button In VLMS    Create

# Create Bind Task_Prerequisite
#     [Arguments]    ${trace_data}    ${trace_model_no}    ${user_name}    ${password}
#     [Documentation]    This Keyword is used to Create Bind Task
#     Select Trace Model And Select Entities_Prerequisite    ${trace_data}    ${trace_model_no}
#     Wait Until Element Is Visible    ${label.create.bind_task.header_id}    ${MEDIUM_WAIT}    Bind task header is not visible after waiting ${MEDIUM_WAIT} seconds
#     ${bind_task_id}    Get Text    ${label.create.bind_task.header_id}
#     ${BIND_TASK_NO}    Remove String    ${bind_task_id}    <    >
#     Set Test Variable    ${BIND_TASK_NO}
#     IF    'WorkFlow' in ${trace_data}    Select Value From Dropdown    WorkFlow    ${trace_data}[WorkFlow]
#     IF    'RouteTaskFor' in ${trace_data}    Select Value From Dropdown    WorkflowTransfer    ${trace_data}[RouteTaskFor]
#     IF    'Comments' in ${trace_data}    Enter Text In Mandatory Fields    Comment    ${trace_data}[Comments]
#     Select Submit/Reset Button    Submit
#     Handle Electronic Sign    ${user_name}    ${password}    Submit
#     ${EXPECTED_MESSAGE}    Set Variable    Bind Task - ${trace_data}[TraceModelTitle] for ${BIND_TASK_NO} has been created
#     RETURN    ${EXPECTED_MESSAGE}

# Select Trace Model And Select Entities_Prerequisite
#     [Arguments]    ${trace_data}    ${trace_model_no}
#     [Documentation]    This Keyword is used to Select Trace Model And Select Entities
#     IF    'TaskType' in ${trace_data}    Select Value For Radio Button    TaskType    ${trace_data}[TaskType]
#     IF    'Bind' in ${trace_data}    Select Value From Dropdown    AssociateType    ${trace_data}[Bind]
#     IF    'ActivityType' in ${trace_data}    Select Value For Radio Button    ValPlan    ${trace_data}[ActivityType]
#     IF    'BindTaskName' in ${trace_data}    Enter Text In Mandatory Fields    AssociateEntityName    ${trace_data}[BindTaskName]
#     Select Dropdown Value With Partial Text   DefaultTracebility    ${trace_model_no}
#     Wait Until Element Is Visible    ${img.content.create.trace_model}    ${LONG_WAIT}    Trace Model Image is not visible after waiting ${LONG_WAIT} seconds
#     IF    'AssociateWith' in ${trace_data}    Select Value For Radio Button    TraceFor    ${trace_data}[AssociateWith]
#     IF    'Entity/EntityType' in ${trace_data}    Select Entity/Entity Type Using Filter    ${trace_data}[Entity/EntityType]

# Verify Selected Content Types In Trace Model_Prerequisite
#     [Documentation]    This keyword is used to Verify Selected Content Types In Trace Model
#     FOR    ${key}    IN   @{SELECTED_LIST}
#         ${key}    Replace String    ${key}    ${SPACE}    ^
#         ${label.content.create.trace_model.image.newselected_doc_type}    Update Dynamic Value    ${label.content.create.trace_model.image.selected_doc_type}    ${key}
#         Wait Until Element Is Visible    ${label.content.create.trace_model.image.newselected_doc_type}    ${MEDIUM_WAIT}    ${key} is not visible after waiting ${MEDIUM_WAIT} seconds
#     END

# Select Checkboxes In Trace Model
#     [Arguments]    ${checkbox_list}
#     [Documentation]    This Keyword is used to Select Checkboxes In Trace Model and Store the selected checkboxes list
#     @{MAPPED_CONTENT_TYPES}    Create List
#     @{check_list}    Split String    ${checkbox_list}    |
#     FOR    ${key}    IN    @{check_list}
#         @{map_docs}    Split String    ${key}    &
#         ${x_axis_doc}    Set Variable    ${map_docs}[0]
#         ${y_axis_doc}    Set Variable    ${map_docs}[1]
#         ${x_axis_doc1}    Set Variable    ${x_axis_doc}-Content Library
#         IF  '${x_axis_doc1}'=='${y_axis_doc}'
#             ${x_axis_value1}    Get From Dictionary    ${SELECTED_CT_VALUES}    ${x_axis_doc}
#             ${id_value}    Set Variable    ${x_axis_value1}_${x_axis_value1}T
#             ${checkbox.create_tracemodel.image.newcontent_type_checkbox}    Update Dynamic Value    ${checkbox.create_tracemodel.map.content_library_type}    ${id_value}
#             Select Checkbox    ${checkbox.create_tracemodel.image.newcontent_type_checkbox}
#             ${value}    Get Element Attribute    ${checkbox.create_tracemodel.image.newcontent_type_checkbox}    id
#             Append To List    ${MAPPED_CONTENT_TYPES}    ${value}
#         ELSE
#             ${x_axis_value}    Get From Dictionary    ${SELECTED_CT_VALUES}    ${x_axis_doc}
#             ${y_axis_value}    Get From Dictionary    ${SELECTED_CT_VALUES}    ${y_axis_doc}
#             ${id_value1}    Set Variable    ${x_axis_value}_${y_axis_value}
#             ${id_value2}    Set Variable    ${y_axis_value}_${x_axis_value}
#             ${checkbox.create_tracemodel.image.newmapping_checkbox}    Update Dynamic Values    ${checkbox.create_tracemodel.map.content_types}    ${id_value1}    ${id_value2}
#             Select Checkbox    ${checkbox.create_tracemodel.image.newmapping_checkbox}
#             ${value}    Get Element Attribute    ${checkbox.create_tracemodel.image.newmapping_checkbox}    id
#             Append To List    ${MAPPED_CONTENT_TYPES}    ${value}
#         END
#     END
#     Set Suite Variable    @{MAPPED_CONTENT_TYPES}
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

# Navigate To Create Trace Matrix Page_Prerequisite
#     [Documentation]    This Keyword is used to Navigate To Create Trace Matrix Page
#     Navigate To Module Tab    Content    Create    Trace Matrix    Select Trace Matrix to Develop
#     Click Button In VLMS    Create

# Create Trace Matrix_Prereuisite
#     [Arguments]    ${tracematrix_data}    ${USER}    ${USER_PASSWORD}
#     [Documentation]    This keyword is used to enter data to create Trace Matrix
#     ${count}    Get Length    ${tracematrix_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${dict_data}    Set Variable    ${tracematrix_data}[${key}]
#         Navigate To Create Trace Matrix Page
#         ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Trace Matrix
#         Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Trace Matrix page is not visible after waiting for ${MEDIUM_WAIT} seconds
#         IF    'TraceAs' in ${dict_data}    Select Value For Radio Button    TraceAs    ${dict_data}[TraceAs]
#         Wait Until Time    3
#         IF    'SelectEntity' in ${dict_data}    Select Value From Table Dropdown    ${dict_data}[SelectEntity]
#         Wait Until Time    2
#         ${trace_matrix_id}    Get Text    ${label.create.trace_model.header_id}
#         ${TRACEMATRIX_NO}    Remove String    ${trace_matrix_id}    <    >
#         Set Test Variable    ${TRACEMATRIX_NO}
#         IF    'TraceModel' in ${dict_data}
#             Select Dropdown Value With Partial Text    select2-ddlTraceDesignList-container    ${dict_data}[TraceModel]
#         END
#         IF    'TraceMatrixTitle' in ${dict_data}    Enter Text In Mandatory Fields    Title    ${dict_data}[TraceMatrixTitle]
#         IF    'Description' in ${dict_data}    Enter Comments/Description    txtDescription    ${dict_data}[Description]
#         IF    'TargetDate' in ${dict_data}
#             Click Calendar Icon In Vlms    ${button.content.create.tracematrix.calendar}
#             Select Target Date    ${dict_data}[TargetDate]    txtTargetDt    txtTargetDt_DrpPnl_Calendar1_506    txtTargetDt_DrpPnl_Calendar1_504    ${dict_data}[Year]    ${dict_data}[Month]    ${dict_data}[Date]
#         END
#         IF   'SelectAllCheckbox' in ${dict_data}    Select Checkbox    ${checkbox.content.create.tracematrix.documentmapping}
#         IF    'SelectDocuments' in ${dict_data}    Select Documents Under Document Mapping Grid_Prerequisite    ${dict_data}[SelectDocuments]
#         IF    'SaveButton' in ${dict_data}    Click Button In VLMS    ${dict_data}[SaveButton]
#         ${label.content.create.newtracematrix}    Update Dynamic Value    ${label.content.create.tracematrix}    ${dict_data}[AlertMSgOption]
#         ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.content.create.newtracematrix}    ${MEDIUM_WAIT}
#         IF    '${status}'=='True'    Unselect Unmapped Documents_Prerequisite    ${dict_data}
#         ${expected_msg}    Set Variable    Document Positioning for ${TRACEMATRIX_NO} trace matrix has been saved
#         ${EXPECTED_MESSAGE}    Set Variable    ${expected_msg}
#         Set Test Variable    ${EXPECTED_MESSAGE}
#         Verify Confirmation Popup    ${EXPECTED_MESSAGE}    ${dict_data}[SucessMessageOption]
#         Wait Until Element Is Visible    ${button.content.create.trace_matrix.save_docs.trace_matrix}    ${MEDIUM_WAIT}    Trace Matrix button is not visible after waiting ${MEDIUM_WAIT} seconds
#         ${selected_docs_list}    Get List Of Selected Documents Under Requirements And Executable Tabs_Prerequisite
#         Click Element    ${button.content.create.trace_matrix.save_docs.trace_matrix}
#         Click Navigation Buttons In Screen    Close
#         Verify Trace Matrix Screen Is Displayed_Prerequisite
#         ${EXPECTED_SUCCESSMESSAGE}    Submit Trace Matrix_Prerequisite    ${dict_data}    ${USER}    ${USER_PASSWORD}
#         Verify Confirmation Popup    ${EXPECTED_SUCCESSMESSAGE}    ${dict_data}[SucessMessageOption]
#     END

# Verify Trace Matrix Screen Is Displayed_Prerequisite
#     [Documentation]    This keyword is used to Verify Trace Matrix screen is displayed.
#     ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Trace Matrix
#     Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Trace Matrix page is not visible after waiting for ${MEDIUM_WAIT} seconds
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

# Get List Of Selected Documents Under Requirements And Executable Tabs_Prerequisite
#     [Documentation]    This keyword is used to Get List Of Selected Documents Under Requirements And Executable Tabs in Trace Matrix Screen
#     ${count}    Get Element Count    ${checkbox.content.create.trace_matrix.selected_documents}
#     @{selected_docs_list}    Create List
#     FOR    ${index}    IN RANGE    1    ${count}+1
#         ${value}    Get Text    (${checkbox.content.create.trace_matrix.selected_documents})[${index}]
#         Append To List    ${selected_docs_list}    ${value}
#     END
#     RETURN    ${selected_docs_list}

# Submit Trace Matrix_Prerequisite
#     [Arguments]    ${tracematrix_data}    ${user_name}    ${password}
#     [Documentation]    It is used to Submit the Trace Matrix
#     IF    'Approval' in ${tracematrix_data}    Select Value For Radio Button    ApprovReq    ${tracematrix_data}[Approval]
#     IF    '${tracematrix_data}[Approval]'=='rdoAppYes'
#         IF    'Workflow' in ${tracematrix_data}    Select Value From Dropdown    ddlWorkflow    ${tracematrix_data}[Workflow]
#     END
#     IF    'Comments' in ${tracematrix_data}    Enter Comments/Description    txtComments    ${tracematrix_data}[Comments]
#     IF    'Button' in ${tracematrix_data}    Select Submit/Reset Button    ${tracematrix_data}[Button]
#     IF    'eSign' in ${tracematrix_data}    Handle Electronic Sign    ${user_name}    ${password}    Submit
#     ${EXPECTED_SUCCESSMESSAGE}    Set Variable    ${tracematrix_data}[TraceMatrixTitle] Trace Matrix ${TRACEMATRIX_NO} has been created
#     RETURN    ${EXPECTED_SUCCESSMESSAGE}

# Select Documents Under Document Mapping Grid_Prerequisite
#     [Arguments]    ${documents_list}
#     [Documentation]    This key word is used to Select Documents Under Document Mapping Grid to create trace matrix
#     Wait Until Element Is Visible    ${button.content.save}    ${MEDIUM_WAIT}    Save Draft button is not visible after waiting ${MEDIUM_WAIT} seconds
#     Scroll Element Into View    ${button.content.save}
#     @{doc_list_to_map}    Split String    ${documents_list}    ,
#     FOR    ${key}    IN    @{doc_list_to_map}
#         ${checkbox.content.create.tracematrix.new.document_mapping}    Update Dynamic Value    ${checkbox.content.create.tracematrix.document_unmapping}    ${key}
#         Scroll Till Element Is Visible    ${checkbox.content.create.tracematrix.new.document_mapping}
#         Select Checkbox    ${checkbox.content.create.tracematrix.new.document_mapping}
#     END

# Unselect Unmapped Documents_Prerequisite
#     [Arguments]    ${tracematrix_data}
#     [Documentation]    This key word is used to unselect the unmapped documents.
#     ${label.content.create.newtracematrix}    Update Dynamic Value    ${label.content.create.tracematrix}    val1_lblErrorAlert
#     ${popup_msg}    Get Text    ${label.content.create.newtracematrix}
#     ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    val1_btnerrorok
#     Click Element    ${button.notification.newok/cancel}
#     @{msg}    Split String    ${popup_msg}    ${SPACE}
#     Remove Values From List    ${msg}    Selected    documents    is    not    yet    Mapped
#     FOR    ${key}    IN    @{msg}
#         ${doc}    Remove String    ${key}    ,
#         ${checkbox.content.create.tracematrix.new.document_unmapping}    Update Dynamic Value    ${checkbox.content.create.tracematrix.document_unmapping}    ${doc}
#         Scroll Element Into View    ${button.content.save}
#         Scroll Till Element Is Visible    ${checkbox.content.create.tracematrix.new.document_unmapping}
#         Unselect Checkbox    ${checkbox.content.create.tracematrix.new.document_unmapping}
#     END
#     Click Button In VLMS    ${tracematrix_data}[SaveButton]

# Create the Section_Prerequisite
#     [Documentation]    This keyword is to create different types of section.
#     [Arguments]    ${section_data}    ${USER}    ${USER_PASSWORD}
#     ${count}    Get Length    ${section_data}
#     FOR    ${key}    IN RANGE    1    ${count}
#         ${dict_data}    Set Variable    ${section_data}[${key}]
#         IF    'Action' in ${dict_data}    Select Value For Radio Button    rbtNew    ${dict_data}[Action]
#         IF    'SectionName' in ${dict_data}    Enter Text In Mandatory Fields    SectionName    ${dict_data}[SectionName]
#         IF    'SectionType' in ${dict_data}    Select Value From Dropdown    select2-ddlSectionTypes-container    ${dict_data}[SectionType]
#         Wait Until Time    3
#         IF    'DecisionTreeReq' in ${dict_data}    Select Value For Radio Button    rbtnIsDeciTreeReqYes    ${dict_data}[DecisionTreeReq]
#         Wait Until Time    3
#         IF    'DecisionTreefor' in ${dict_data}    Select Dropdown Value With Partial Text    select2-ddlDecisionTree-container    ${dict_data}[DecisionTreefor]
#         Wait Until Time    3
#         @{list_of_SelectAssessors}    Split String    ${dict_data}[SelectAssessors]    ,
#         ${count}    Get Length    ${list_of_SelectAssessors}
#         FOR    ${key}    IN RANGE    0    ${count}
#             Swipe Values Between Groups_Prerequisite    ${list_of_SelectAssessors}[${key}]    lstAvailbleGroup    lstAssinGroup
#         END
#         Select Submit/Reset Button    Submit
#         Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#         Verify Confirmation Popup    ${dict_data}[SectionName] section has been created    btnMessageOk
#     END

# Create Template Group
#     [Documentation]    Fill the template group
#     [arguments]    ${tg_data}
#     ${count}    Get Length    ${tg_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${dict_data}    Set Variable    ${tg_data}[${key}]
#         IF    'GroupName' in ${dict_data}    Enter Text In Mandatory Fields    boxTitle    ${dict_data}[GroupName]
#         IF    'Description' in ${dict_data}    Enter Text In Mandatory Fields    boxDescription    ${dict_data}[Description]
#         IF    'Button' in ${dict_data}    Select Submit/Reset Button    ${dict_data}[Button]
#         Verify Confirmation Popup    ${dict_data}[GroupName] Template Group has been created.    ${dict_data}[ButtonOption]
#     END

# Create Template
#     [Documentation]    Create Template
#     [arguments]    ${tg_data}    ${USER}    ${USER_PASSWORD}
#     ${count}    Get Length    ${tg_data}
#     FOR    ${key}    IN RANGE    1    ${count}
#         ${create_data}    Set Variable    ${tg_data}[${key}]
#         Navigate To Create Template
#         IF    'TaskType' in ${create_data}    Select Value For Radio Button    rbtNew    ${create_data}[TaskType]
#         IF    'Template For' in ${create_data}    Select Value From Dropdown    ddlTempType    ${create_data}[Template For]
#         Wait Until Time    2
#         ${tempfor}    Set Variable    ${create_data}[Template For]
#         IF    '${tempfor}'=='Document'    Select Value From Dropdown    ddlTemplateType    ${create_data}[Template Type]
#         Wait Until Time    2
#         IF    'Template Group' in ${create_data}    Select Value From Dropdown    ddlTemplateGroup    ${create_data}[Template Group]
#         Wait Until Time    2
#         IF    'TemplateName' in ${create_data}    Enter Text In Mandatory Fields    BoxName    ${create_data}[TemplateName]
#         ${TEMPLATE_NAME}    Set Variable    ${create_data}[TemplateName]
#         Set Suite Variable    ${TEMPLATE_NAME}
#         Wait Until Time    2
#         IF    'TemplatePrefix' in ${create_data}    Enter Text In Mandatory Fields    Prefix    ${create_data}[TemplatePrefix]
#         ${TEMPLATE_PREFIX}    Set Variable    ${create_data}[TemplatePrefix]
#         Set Suite Variable    ${TEMPLATE_PREFIX}
#         Wait Until Time    2
#         IF    'TemplateDescription' in ${create_data}
#             Select Frame    ${iframe.content.template.description}
#             Javascript Click    ${body.template.description}
#             Press Keys    ${body.template.description}    ${create_data}[TemplateDescription]
#             Switch To Parent Frame
#         END    
#         Wait Until Time    2
#         Upload External Document And Verify Success Message    ${create_data}[File]
#         Select Checkbox    ${checkbox.content.author.doc.confirm_routing}
#         IF    'ApprovalRequired' in ${create_data}    Select Value For Radio Button    check    ${create_data}[ApprovalRequired]
#         IF    'TargetDateType' in ${create_data}
#             Click Calendar Icon In Vlms    ${icon.content.assign_doc.calendar}
#             Select Target Date    ${create_data}[TargetDateType]    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${create_data}[Year]    ${create_data}[Month]    ${create_data}[Date]
#         END
#         IF    'WorkFlow' in ${create_data}    Select Value From Dropdown    select2-ddWorkFlow-container    ${create_data}[WorkFlow]
#         IF    'RouteFor' in ${create_data}    Select Value From Dropdown    ddlUserType    ${create_data}[RouteFor]
#         IF    'Comments' in ${create_data}    Enter Comments/Description    txtComments    ${create_data}[Comments]
#         ${template_id}    Get Text    ${tab.template.id}
#         Set Suite Variable    ${template_id}
#         IF    'Button' in ${create_data}    Select Submit/Reset Button    ${create_data}[Button]
#         Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#         Verify Confirmation Popup    ${create_data}[TemplateName]-${template_id} Template has been created    ${create_data}[ButtonOption]
#         Navigate To Module Tab    Content    Bind    Template    Bind Template
#         Enter Details In Bind Template Page    ${create_data}    ${template_id}
#         Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#         Verify Confirmation Popup    Template has been Bound    ${create_data}[ButtonOption]
#     END

# Navigate To Create Template
#     [Documentation]    This keyword will navigate to create template page
#     Navigate To Module Tab    Content    Create    Template    Select Templates to Author
#     Click Button In VLMS    Create
#     Wait Until Time    5
#     Wait Until Element Is Visible    ${tab.template.create}

# Enter Details In Bind Template Page
#     [Arguments]    ${bind_data}    ${templateid}
#     [Documentation]    This will bind the created template as specified by user
#     ${button.boundTo.new}    Update Dynamic Value    ${button.boundTo}    ${bind_data}[BoundTo]
#     Wait Until Element Is Visible    ${button.boundTo.new}    ${MEDIUM_WAIT}    ${bind_data}[BoundTo] button is not visible after waiting ${MEDIUM_WAIT} seconds
#     Click Element    ${button.boundTo.new}
#     Wait Until Time    3
#     Select Content To Bind Template    ${bind_data}
#     Select Value From Dropdown    ddlTemplateType    ${bind_data}[Template Type]
#     Wait Until Time    3
#     Click Element    ${dropdown.template.tobind}
#     Wait Until Time    2
#     Wait Until Element Is Visible    ${textbox.template.tobind.search}    ${MEDIUM_WAIT}    Search box is not visible after waiting ${MEDIUM_WAIT} seconds
#     Input Text    ${textbox.template.tobind.search}    ${templateid}
#     ${checkbox.system.create.bind_task.newentity}    Update Dynamic Value    ${checkbox.system.create.bind_task.entity}   ${templateid}
#     Wait Until Element Is Visible    ${checkbox.system.create.bind_task.newentity}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting ${MEDIUM_WAIT} seconds
#     Click Element    ${checkbox.system.create.bind_task.newentity}
#     Wait Until Time    2
#     Click Element    ${dropdown.template.tobind}
#     Click Button In VLMS    Save
#     Wait Until Time    2
#     Click Element    ${checkbox.bind.template.contenttype}
#     Wait Until Time    2
#     Click Element    ${checkbox.bind.template.workflow.applicableto}
#     IF    'Comments' in ${bind_data}    Enter Comments/Description    txtComments    ${bind_data}[Comments]
#     IF    'Button' in ${bind_data}    Select Submit/Reset Button    ${bind_data}[Button]

# Select Content To Bind Template
#      [Arguments]    ${bind_data}
#     [Documentation]    This will select Caterory or SubCategory or Entity as mentioned in user input
#     Click Element    ${dropdown.content.bind.template}
#     Wait Until Time    3
#     @{list}    Split String    ${bind_data}[BindTemplateWith]    ,
#     FOR    ${key}    IN    @{list}
#         IF    '${bind_data}[BoundTo]' == 'Category'
#             Wait Until Element Is Visible    (${textbox.bindto.search})[1]    ${MEDIUM_WAIT}    Search box is not visible after waiting ${MEDIUM_WAIT} seconds
#             Wait Until Time    2
#             Input Text    (${textbox.bindto.search})[1]    ${key}
#             ${checkbox.system.create.bind_task.newentity}    Update Dynamic Value    ${checkbox.system.create.bind_task.entity}   ${key}
#             Wait Until Element Is Visible    ${checkbox.system.create.bind_task.newentity}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting ${MEDIUM_WAIT} seconds
#             Click Element    ${checkbox.system.create.bind_task.newentity}
#             Clear Element Text    (${textbox.bindto.search})[1]
#         ELSE IF    '${bind_data}[BoundTo]' == 'Entity'
#             Wait Until Element Is Visible    (${textbox.bindto.search})[3]    ${MEDIUM_WAIT}    Search box is not visible after waiting ${MEDIUM_WAIT} seconds
#             Wait Until Time    2
#             Input Text    (${textbox.bindto.search})[3]    ${key}
#             ${checkbox.system.create.bind_task.newentity}    Update Dynamic Value    ${checkbox.system.create.bind_task.entity}   ${key}
#             Wait Until Element Is Visible    ${checkbox.system.create.bind_task.newentity}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting ${MEDIUM_WAIT} seconds
#             Click Element    ${checkbox.system.create.bind_task.newentity}
#             Clear Element Text    (${textbox.bindto.search})[3]
#         ELSE
#             Wait Until Element Is Visible    (${textbox.bindto.search})[2]    ${MEDIUM_WAIT}    Search box is not visible after waiting ${MEDIUM_WAIT} seconds
#             Wait Until Time    2
#             Input Text    (${textbox.bindto.search})[2]    ${key}
#             ${checkbox.system.create.bind_task.newentity}    Update Dynamic Value    ${checkbox.system.create.bind_task.entity}   ${key}
#             Wait Until Element Is Visible    ${checkbox.system.create.bind_task.newentity}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting ${MEDIUM_WAIT} seconds
#             Click Element    ${checkbox.system.create.bind_task.newentity}
#             Clear Element Text    (${textbox.bindto.search})[2]    
#         END
#     END
#     Wait Until Time    2
#     Click Element    ${dropdown.content.bind.template}
#     Wait Until Time    2

# Create Risk Process_Prerequisite
#     [Documentation]    Fill the risk Process
#     [arguments]    ${tg_data}    ${USER}    ${USER_PASSWORD}
#     ${count}    Get Length    ${tg_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${create_data}    Set Variable    ${tg_data}[${key}]
#         IF    'ProcessName' in ${create_data}    Enter Text In Mandatory Fields    ProcessName    ${create_data}[ProcessName]
#         ${riskprocess.processlevel}    Update Dynamic Value    ${riskprocess.common}    Requirement/Functional Level
#         Click Element    ${riskprocess.processlevel}
#         Wait Until Time    3
#         ${list_of_processconditions}    Split String    ${create_data}[ProcessConditions]    ,
#         ${count}    Get Length    ${list_of_processconditions}
#         FOR    ${key}    IN RANGE    0    ${count}
#             ${riskprocess.processcondition}    Update Dynamic Value    ${riskprocess.common}    ${list_of_processconditions}[${key}]
#             Click Element    ${riskprocess.processcondition}
#         END
#         ${list_of_contenttype}    Split String    ${create_data}[ContentType]    ,
#         ${count}    Get Length    ${list_of_contenttype}
#         FOR    ${key}    IN RANGE    0    ${count}
#             ${riskprocess.contenttype}    Update Dynamic Value    ${riskprocess.common}    ${list_of_contenttype}[${key}]
#             Click Element    ${riskprocess.contenttype}
#         END
#         Wait Until Time   1
#         Select Submit/Reset Button    Submit
#         Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#         Verify Confirmation Popup    Risk Process has been created    btnMessageOk
#     END

# Create EntityType_Prerequisite
#     [Arguments]    ${entitytype_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword will create entity type
#     ${count}    Get Length    ${entitytype_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${system_entity_data}    Set Variable     ${entitytype_data}[${key}]
#         Get Entity Type ID
#         Enter Pre-requisite Details In Create Entity Type_Prerequisite    ${system_entity_data}
#         Enter Standard Form Details In Create Entity Type_Prerequisite    ${system_entity_data}
#         IF    'ApprovalRequired' in ${system_entity_data}    Select Value For Radio Button    check    ${system_entity_data}[ApprovalRequired]
#         IF    'WorkFlow' in ${system_entity_data}    Select Value From Dropdown    ddlWorkFlow    ${system_entity_data}[WorkFlow]
#         IF    'RouteFor' in ${system_entity_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${system_entity_data}[RouteFor]
#         IF    'Comments' in ${system_entity_data}    Enter Comments/Description    txtComments    ${system_entity_data}[Comments]
#         IF    'Button' in ${system_entity_data}    Select Submit/Reset Button    ${system_entity_data}[Button]
#         Handle Electronic Sign  ${USER}    ${USER_PASSWORD}    Submit
#         Verify Notification Popup_Prerequisite    Are you sure want to submit without framework    btnSubmitEntitytype
#         Verify Confirmation Popup    ${system_entity_data}[EntityTypeName] entity type ${ENTITY_TYPE_ID} has been created    btnMessageOk
#         Click Button In VLMS    Create
#     END 

# Verify Notification Popup_Prerequisite
#     [Arguments]    ${message}    ${button_option}
#     [Documentation]    It is used to Verify notification popup and click ok/cancel button
#     ${status}    Run Keyword And Return Status    Wait Until Page Contains    ${message}    ${MEDIUM_WAIT}
#     IF    '${status}'=='True'
#         Log Expected And Actual Results    ${message}    ${message}
#         ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    ${button_option}
#         Wait Until Element Is Visible    ${button.notification.newok/cancel}    ${MEDIUM_WAIT}    ${button_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
#         Javascript Click    ${button.notification.newok/cancel}
#     END

# Create Entity prerequiste
#     # robocop: disable=too-many-calls-in-keyword
#     [Arguments]    ${entitytype_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword will create entity
#     ${count}    Get Length    ${entitytype_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${entity_data}    Set Variable     ${entitytype_data}[${key}]
#         ${label.module.tab.content.page.new}    Update Dynamic Value    ${label.module.tab.content.page}    Create Entity
#         Wait Until Element Is Visible    ${label.module.tab.content.page.new}    ${MEDIUM_WAIT}    Create Entity page is not visible after waiting for ${MEDIUM_WAIT} seconds
#         IF    'Category' in ${entity_data}    Select Value From Dropdown    ddlCategory-container    ${entity_data}[Category]
#         Wait Until Time    3
#         IF    'SubCategory' in ${entity_data}    Select Value From Dropdown    ddlSubCategory1-container    ${entity_data}[SubCategory]
#         Wait Until Time    3
#         IF    'SystemAssessment' in ${entity_data}    Select Value For Radio Button   ValidationAssessmentReq    ${entity_data}[SystemAssessment]
#         IF    'AssignSystem' in ${entity_data}    Select Value For Radio Button    ValAssignYes    ${entity_data}[AssignSystem]
#         IF    'ScheduleAssessment' in ${entity_data}    Select Value For Radio Button   ScheduleAssessmentReq    ${entity_data}[ScheduleAssessment]
#         Wait Until Time    2
#         IF    'EntityName' in ${entity_data}    Enter Text In Mandatory Fields    EntityName    ${entity_data}[EntityName]
#         Select Value From Dropdown    select2-ddlEntityType-container    ${entity_data}[EntityType]
#         Wait Until Time    2
#         IF    'EntityNo' in ${entity_data}    Enter Text In Mandatory Fields    EntityNO    ${entity_data}[EntityNo]
#         IF    'AssessmentPlanTemplate' in ${entity_data}    Select Value From Dropdown    select2-ddlValidationTemplate-container    ${entity_data}[AssessmentPlanTemplate]
#         IF    'Description' in ${entity_data}    Enter Comments/Description    txtDescription    ${entity_data}[Description]
#         IF    'SystemOwner' in ${entity_data}    Select Dropdown Value With Partial Text    select2-ddlSysOwner-container    [${user_name}]
#         IF    'BusinessOwner' in ${entity_data}    Enter Comments/Description    txtBusinessOwner    ${user_name}
#         IF    'IntendedUse' in ${entity_data}    Select Value From Dropdown    ddlIntendedUse_I    ${entity_data}[IntendedUse]
#         IF    'AssessmentName' in ${entity_data}    Enter Comments/Description    txtValAssName    ${entity_data}[AssessmentName]
#         IF    'Assignment' in ${entity_data}    Choose Assignee Type    ${entity_data}[Assignment]    ${entity_data}[AssignTo]
#         IF    'Design' in ${entity_data}    Select Value For Radio Button   DesignManager    ${entity_data}[Design]
#         IF    'StatusAlertGroup' in ${entity_data}    Swipe Values Between Groups_Prerequisite    ${entity_data}[StatusAlertGroup]    lstAvailbleGroup    lstAssinGroup
#         Wait Until Time    4
#         IF    'SelectedGroup' in ${entity_data}    Swipe Values Between Groups_Prerequisite    ${entity_data}[SelectedGroup]    lstAssinGroup    lstAvailbleGroup
#         Wait Until Time    2
#         IF    'Button' in ${entity_data}    Select Submit/Reset Button    ${entity_data}[Button]
#         Handle Electronic Sign    ${user_name}    ${password}    Submit
#         Verify Confirmation Popup    ${entity_data}[EntityName] entity ${entity_data}[EntityNo] has been created    btnMessageOk
#     END

# Enter The Details To Create A New Table 
#     [Arguments]    ${table_name_list}    ${User}    ${USER_PASSWORD}
#     [Documentation]    This Is To Enter The Details To Create The Table
#     ${count}    Get Length    ${table_name_list}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${table_data}    Set Variable     ${table_name_list}[${key}]
#         Enter The Details To The Table        ${table_data}     ${User}    ${USER_PASSWORD}    
#     END

# Enter Text In Mandatory Header Fields
#     [Arguments]    ${text_field}    ${text}
#     [Documentation]    This keyword is used to enter text in mandatory textbox field
#     ${textbox.header.mandatory.newtext_field}    Update Dynamic Value    ${textbox.header.mandatory.text_field}    ${text_field}
#     Wait Until Element Is Visible    ${textbox.header.mandatory.newtext_field}    ${MEDIUM_WAIT}    ${text_field} is not visible after waiting ${MEDIUM_WAIT} seconds
#     Javascript Click    ${textbox.header.mandatory.newtext_field}
#     Wait Until Time    2
#     Javascript Input Text    ${textbox.header.mandatory.newtext_field}    ${text} 

# Enter The Details To The Table
#     [Arguments]    ${table_data}    ${User}    ${USER_PASSWORD}
#     [Documentation]    This Is To Enter The Details To Create The Content
#     ${column_header}    Split String    ${table_data}[ColumnHeader]   ,
#     ${column_type}    Split String    ${table_data}[ColumnType]   ,
#     Wait Until Element Is Visible    txtTableName    ${SHORT_WAIT}
#     Enter Text In Mandatory Fields    TableName    ${table_data}[TableName]
#     Wait Until Element Is Visible    select2-ddlTblType-container    ${SHORT_WAIT}
#     Select Value From Dropdown    select2-ddlTblType-container    ${table_data}[TableType]
#     Wait Until Element Is Visible    select2-ddlNoOfColumns-container    ${SHORT_WAIT}
#     Select Value From Dropdown    select2-ddlNoOfColumns-container    ${table_data}[NumberColumns]
#     ${num_columns}    Get Length    ${column_header}
#     FOR    ${index}    IN RANGE    0    ${num_columns}
#         ${selector_index}    Set Variable    ${index+2}
#         ${selector_index_str}    Convert To String    ${selector_index}
#         ${selector_prefix}    Set Variable If    ${selector_index} < 10    l0    l
#         ${element_selector}    Set Variable        grdTableTypes1$ct${selector_prefix}${selector_index_str}$txtColHeader
#         Wait Until Element Is Visible    ${element_selector}    ${SHORT_WAIT}
#         Enter Text In Mandatory Header Fields    ${element_selector}    ${column_header}[${index}]
#         ${dropdown_selector}    Set Variable   select2-grdTableTypes1_ct${selector_prefix}${selector_index_str}_ddlColType-container
#         Wait Until Element Is Visible    ${dropdown_selector}    ${SHORT_WAIT}
#         ${current_column_type}    Set Variable    ${column_type[${index}]}
#         Select Value From Dropdown    ${dropdown_selector}    ${current_column_type}
#     END
#     Select Submit/Reset Button    Submit
#     Handle Electronic Sign    ${User}    ${User_password}    Submit
#     Verify Confirmation Popup    ${table_data}[TableName] content type has been created    btnMessageOk

# Standard form creation prerequisite
#     [Arguments]    ${dict_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword is used to Create Form
#         IF    '${dict_data}[FormType]'=='Standard Form'
#             Wait Until Element Is Visible    ${textbox.system.create.form.form_type}    ${MEDIUM_WAIT}    Form type is not visible after waiting ${MEDIUM_WAIT} seconds
#             Click Element    ${textbox.system.create.form.form_type}
#             Input Text    ${textbox.system.create.form.form_type}    ${dict_data}[FormName]
#             ${label.system.create.form.newform_type}    Update Dynamic Value    ${label.system.create.form.form_type}    ${dict_data}[FormType]
#             Wait Until Element Is Visible    ${label.system.create.form.newform_type}    ${MEDIUM_WAIT}    ${dict_data}[FormType] is not visible after waiting ${MEDIUM_WAIT} seconds
#             Click Element    ${label.system.create.form.newform_type}
#             Wait Until Time    4
#             IF    'FormName' in ${dict_data}    Enter Text In Mandatory Fields    FormName    ${dict_data}[FormName]
#             IF    '${dict_data}[FormApplicableTo]'== 'SelectAll'
#                 Wait Until Element Is Visible    ${dropdown.div.system.create.form.applicableTo.parentdiv}    ${MEDIUM_WAIT}    applicableTo is not visible after waiting ${MEDIUM_WAIT} seconds
#                 Click Element    ${dropdown.div.system.create.form.applicableTo}
#                 Wait Until Element Is Visible    ${list.system.create.form.form_applicable.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting ${MEDIUM_WAIT} seconds
#                 Click Element    ${list.system.create.form.form_applicable.select_all}
#             ELSE
#                 @{select_list}    Split String    ${dict_data}[FormApplicableTo]    ,
#                 FOR    ${key}    IN    @{select_list}
#                     Wait Until Element Is Visible    ${dropdown.div.system.create.form.applicableTo.parentdiv}    ${MEDIUM_WAIT}    applicableTo is not visible after waiting ${MEDIUM_WAIT} seconds
#                     Click Element    ${dropdown.div.system.create.form.applicableTo}
#                     Wait Until Time    2
#                     Enter Text In Mandatory Fields    ${textbox.search.system.create.form.applicableTo}    ${key}
#                     ${list.system.create.form.form_applicable_to.newtype}    Update Dynamic Value    ${list.system.create.form.form_applicable_to.type}    ${key}
#                     Wait Until Element Is Visible    ${list.system.create.form.form_applicable_to.newtype}    ${SHORT_WAIT}    Option is not visible after waiting for ${SHORT_WAIT} seconds
#                     Click Element    ${list.system.create.form.form_applicable_to.newtype}
#                 END
#             END
#             IF    'Description' in ${dict_data}    Enter Comments/Description    txtDescription    ${dict_data}[Description]
#             IF    'InheritFields' in ${dict_data}    Select Value From Dropdown    ddlInherit    ${dict_data}[InheritFields]
#             IF    'AddControls' in ${dict_data}    Click Button In VLMS    Add Controls
#             IF    'CreateControls' in ${dict_data}    Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation}    ${MEDIUM_WAIT}    Control Creation is not visible after waiting ${MEDIUM_WAIT} seconds
#             IF    'Row' in ${dict_data}    Select Value From Dropdown    ddlRows    ${dict_data}[Row]
#             #IF    'Column' in ${dict_data}    Select Value From Dropdown    ddlColumns    ${dict_data}[Column]
#             IF    'CreateControls' in ${dict_data}    Click Button In VLMS    Create Controls
#             Wait Until Time    3
#             IF    'FieldType' in ${dict_data}
#                 Drag And Drop Field Types To Form Field Details Grid    ${dict_data}[FieldType]    ${dict_data}[CellIndex]
#                 Wait Until Time    3
#                 Add Settings To Form Fields for prerequiste    ${dict_data}
#                 Wait Until Time    7
#                 Wait Until Element Is Visible    ${button.system.create.form.control_creation.save}    ${MEDIUM_WAIT}    Save button is not visible after waiting ${MEDIUM_WAIT} seconds
#                 Click Element    ${button.system.create.form.control_creation.save}
#             END
#         END

# Exception form creation prerequiste
#     [Arguments]    ${dict_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword is used to Create Form
#     ${Cell multiple index values}    Split String    ${dict_data}[Cell multiple index]    ,
#         ${multiple DD}    Get Length    ${Cell multiple index values}
#         ${cell value key}    Set Variable    0
#         Wait Until Element Is Visible    ${textbox.system.create.form.form_type}    ${MEDIUM_WAIT}    Form type is not visible after waiting ${MEDIUM_WAIT} seconds
#         Click Element    ${textbox.system.create.form.form_type}
#         Input Text    ${textbox.system.create.form.form_type}    ${dict_data}[FormType]
#         Wait Until Time    2
#         ${label.system.create.form.newform_type}    Update Dynamic Value    ${label.system.create.form.form_type}    ${dict_data}[FormType]
#         Wait Until Element Is Visible    ${label.system.create.form.newform_type}    ${MEDIUM_WAIT}    ${dict_data}[FormType] is not visible after waiting ${MEDIUM_WAIT} seconds
#         Click Element    ${label.system.create.form.newform_type}
#         Wait Until Time    4
#         IF    'FormName' in ${dict_data}    Enter Text In Mandatory Fields    FormName   ${dict_data}[FormName]
#         IF    '${dict_data}[FormApplicableTo]'== 'SelectAll'
#                 Wait Until Element Is Visible    ${dropdown.div.system.create.form.applicableTo.parentdiv}    ${MEDIUM_WAIT}    applicableTo is not visible after waiting ${MEDIUM_WAIT} seconds
#                 Click Element    ${dropdown.div.system.create.form.applicableTo}
#                 Wait Until Element Is Visible    ${list.system.create.form.form_applicable.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting ${MEDIUM_WAIT} seconds
#                 Click Element    ${list.system.create.form.form_applicable.select_all}
#         END
#         IF    'Description' in ${dict_data}    Enter Comments/Description    txtDescription    ${dict_data}[Description]
#         IF    'InheritFields' in ${dict_data}    Select Value From Dropdown    ddlInherit    ${dict_data}[InheritFields]
#         ${exception count}    Set Variable     2
#         ${index}    Set Variable    1
#         FOR    ${key1}    IN RANGE    0    ${exception count}
#             ${cell values}    Set Variable    ${Cell multiple index values}[${key1}] 
#            Wait Until Element Is Visible    (//input[@value="Add Controls"])[${index}]    ${MEDIUM_WAIT}    Add Controls is not visible after waiting ${MEDIUM_WAIT} seconds
#            Click Element    (//input[@value="Add Controls"])[${index}]
#            Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation}    ${MEDIUM_WAIT}    Control Creation is not visible after waiting ${MEDIUM_WAIT} seconds
#            IF    'Row' in ${dict_data}    Select Value From Dropdown    ddlRows    ${dict_data}[Row]    
#            #IF    'Column' in ${dict_data}    Select Value From Dropdown    ddlColumns    ${dict_data}[Column]
#            IF    'CreateControls' in ${dict_data}    Click Button In VLMS    Create Controls
#            Wait Until Time    3
#            Drag And Drop Field Types To Form Field Details Grid    ${dict_data}[FieldType]    ${cell values}
#            Wait Until Time    3
#            Add Settings To Form Fields for prerequiste    ${dict_data}    ${cell values}
#            Wait Until Element Is Visible    ${button.system.create.form.control_creation.save}    ${MEDIUM_WAIT}    save button is not visible after waiting ${MEDIUM_WAIT} seconds 
#            Click Element    ${button.system.create.form.control_creation.save}
#            Wait Until Time    4
#            Evaluate    ${index}+1
#         END 

# Framework and Project Form creation with Textbox Control
#      [Arguments]    ${dict_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword is used to Create Form
#         Wait Until Element Is Visible    ${textbox.system.create.form.form_type}    ${MEDIUM_WAIT}    Form type is not visible after waiting ${MEDIUM_WAIT} seconds
#         Click Element    ${textbox.system.create.form.form_type}
#         Input Text    ${textbox.system.create.form.form_type}    ${dict_data}[FormType]
#         ${label.system.create.form.newform_type}    Update Dynamic Value    ${label.system.create.form.form_type}    ${dict_data}[FormType]
#         Wait Until Element Is Visible    ${label.system.create.form.newform_type}    ${MEDIUM_WAIT}    form type is not visible after waiting ${MEDIUM_WAIT} seconds
#         Click Element    ${label.system.create.form.newform_type}
#         Wait Until Time    4
#        IF    'FormName' in ${dict_data}    Enter Text In Mandatory Fields    FormName     ${dict_data}[FormName]
#        IF    '${dict_data}[FormApplicableTo]'== 'SelectAll'
#                 Wait Until Element Is Visible    ${dropdown.div.system.create.form.applicableTo.parentdiv}    ${MEDIUM_WAIT}    applicableTo is not visible after waiting ${MEDIUM_WAIT} seconds
#                 Click Element    ${dropdown.div.system.create.form.applicableTo}
#                 Wait Until Element Is Visible    ${list.system.create.form.form_applicable.select_all}    ${MEDIUM_WAIT}    Select All is not visible after waiting ${MEDIUM_WAIT} seconds
#                 Click Element    ${list.system.create.form.form_applicable.select_all}
#         END
#        IF    'Description' in ${dict_data}    Enter Comments/Description    txtDescription    ${dict_data}[Description]
#        IF    'InheritFields' in ${dict_data}    Select Value From Dropdown    ddlInherit    ${dict_data}[InheritFields]
#        IF    'AddControls' in ${dict_data}    Click Button In VLMS    Add Controls
#        IF    'CreateControls' in ${dict_data}
#             Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation}    ${MEDIUM_WAIT}    Control Creation is not visible after waiting ${MEDIUM_WAIT} seconds
#             IF    'Row' in ${dict_data}    Select Value From Dropdown    ddlRows        ${dict_data}[Row]
#             #IF    'Column' in ${dict_data}    Select Value From Dropdown    ddlColumns        ${dict_data}[Column]
#             IF    'CreateControls' in ${dict_data}    Click Button In VLMS    Create Controls
#        END 
#         Wait Until Time    3
#         IF    'FieldType' in ${dict_data}
#         Drag And Drop Field Types To Form Field Details Grid    ${dict_data}[FieldType]    ${dict_data}[CellIndex]
#         Wait Until Time    3
#         Add Settings To Form Fields for prerequiste    ${dict_data}
#         Wait Until Time    3
#         Wait Until Element Is Visible    ${button.system.create.form.control_creation.save}    ${MEDIUM_WAIT}    Save button is not visible after waiting ${MEDIUM_WAIT} seconds
#         Click Element    ${button.system.create.form.control_creation.save}
#         Wait Until Time    3
#     END

# IPM form cration for prerequiste
#     [Arguments]    ${dict_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword is used to Create Form
#     Framework and Project Form creation with Textbox Control   ${dict_data}   ${USER}    ${USER_PASSWORD}
#     Enter Text In Mandatory Fields    Section    ${dict_data}[Section Name]
#     Click Button In VLMS    Add
#     Select Value For Radio Button    rbtnPre_ImpYes    ${dict_data}[Implementation Deliverables Required]
#     Select Value For Radio Button    User or Group Assignment    ${dict_data}[User or Group Assignment]
#     Select Value From Dropdown    select2-GridView1_ctl03_ddlSectionGroup-container   ${dict_data}[Select Group]
#     Input Text    GridView1_ctl03_txtTenure    ${dict_data}[Assessment Period]
#     Input Text    GridView1_ctl03_txtAlertFrequency   ${dict_data}[Notification Alert]
#     Select Value From Dropdown    select2-GridView1_ctl03_ddlProcFlowtype-container   ${dict_data}[Serial / Parallel]
#     #IF    'Is GXP Assessment Required' in ${dict_data}    Select Value For Radio Button    rbtnPre_ImpvalNo    ${dict_data}[Is GXP Assessment Required]
#     Wait Until Element Is Visible    //input[@value="Add Controls"]  ${MEDIUM_WAIT}    Add Controls is not visible after waiting ${MEDIUM_WAIT} seconds
#     Click Element    //input[@value="Add Controls"]
#     ${Cell index ipm}    Set Variable    ${dict_data}[Cell index ipm]    
#     Wait Until Element Is Visible    ${label.system.create.form.add_controls.control_creation}    ${MEDIUM_WAIT}    Control Creation is not visible after waiting ${MEDIUM_WAIT} seconds
#     IF    'Row' in ${dict_data}    Select Value From Dropdown    ddlRows    ${dict_data}[Row]    
#     #IF    'Column' in ${dict_data}    Select Value From Dropdown    ddlColumns    ${dict_data}[Column]
#     IF    'CreateControls' in ${dict_data}    Click Button In VLMS    Create Controls
#     Wait Until Time    3
#     Drag And Drop Field Types To Form Field Details Grid   ${dict_data}[FieldType]    ${Cell index ipm}
#     Wait Until Time    3
#     Add Settings To Form Fields for prerequiste    ${dict_data}    ${Cell index ipm}
#     Wait Until Time    3
#     Wait Until Element Is Visible    ${button.system.create.form.control_creation.save}    ${MEDIUM_WAIT}    save button is not visible after waiting ${MEDIUM_WAIT} seconds 
#     Click Element    ${button.system.create.form.control_creation.save} 

# Navigate To Initiate Content Library Page_Prerequisite
#     [Documentation]    This Keyword is used to navigate to Initiate Content Library Page
#     Navigate To Module Tab    Content    Create    Content Library    Create Content Library
#     Click Button In VLMS    Create

# Create Content Library_Prerequisite
#     [Arguments]    ${table_name_list}    ${user_name}    ${password}
#     [Documentation]    This Keyword is used to Create Content Library
#     ${count}    Get Length    ${table_name_list}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${content_data}    Set Variable     ${table_name_list}[${key}]
#         Initiate Content Library_Prerequisite    ${content_data}    ${user_name}    ${password}
#         Navigate To Author Content Library Page_Prerequisite    ${content_data}[SelectEntity]
#         Author Content Library_Prerequisite    ${content_data}
#         Approve Content Library_Prerequisite    ${content_data}
#     END

# Select Value For Radio Button by ID
#     [Arguments]    ${group_name}    ${value}
#     [Documentation]    This keyword is used to select radio button
#     ${radiobutton.common.newvalue}    Update Dynamic Value    ${radiobutton.common.id}    ${value}
#     Wait Until Element Is Visible    ${radiobutton.common.newvalue}    ${MEDIUM_WAIT}
#     ${status}    Run Keyword And Return Status    Radio Button Should Be Set To    ${group_name}    ${value}
#     Wait Until Time    3
#     IF    '${status}' == 'False'    Javascript Click    ${radiobutton.common.newvalue}

# Initiate Content Library_Prerequisite
#     [Arguments]    ${content_data}    ${user_name}    ${password}
#     [Documentation]    This Keyword is used to Initiate Content Library
#     Navigate To Initiate Content Library Page
#     Wait Until Element Is Visible    ${label.content.create.content_library.create.initiate_content_library}    ${MEDIUM_WAIT}    Initiate Content Library screen is not visible after waiting ${MEDIUM_WAIT} seconds
#     IF    'ContentLibraryType' in ${content_data}    Select Value For Radio Button    TestType    ${content_data}[ContentLibraryType]
#     Wait Until Time    2
#     IF    '${content_data}[ContentLibraryType]'=='rbtEntity'
#         IF    'TaskType' in ${content_data}    Select Value For Radio Button by ID    rbtnlstTFnDocType    ${content_data}[TaskType]
#         IF    'SelectEntity' in ${content_data}    Select Value From Table Dropdown    ${content_data}[SelectEntity]
#         IF    'ReferenceContentType' in ${content_data}    Select Value From Dropdown    ddlValidationType    ${content_data}[ReferenceContentType]
#         Wait Until Time    2
#         Select Last Value From Dropdown    ddlRequirement
#     END
#     IF    '${content_data}[ContentLibraryType]'=='rbtGeneric'
#          IF    'TaskType' in ${content_data}    Select Value For Radio Button by ID    rbtnlstTFnDocType    ${content_data}[TaskType]
#          IF    'ContentLibraryGroup' in ${content_data}    Select Value From Dropdown    ddlTemplateGroup    ${content_data}[ContentLibraryGroup]
#     END
#     IF    'Assignment' in ${content_data}    Choose Assignee Type    ${content_data}[Assignment]    ${content_data}[AssignTo]
#     IF    'TargetDateType' in ${content_data}
#         Click Calendar Icon In Vlms    ${icon.content.assign_doc.calendar}
#         Select Target Date    ${content_data}[TargetDateType]    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${content_data}[Year]    ${content_data}[Month]    ${content_data}[Date]
#     END
#     IF    'Comments' in ${content_data}    Enter Text In Mandatory Fields    Comments    ${content_data}[Comments]
#     IF    'Button' in ${content_data}    Select Submit/Reset Button    ${content_data}[Button]
#     Verify Confirmation Popup    Content Library has been initiated    btnMessageOk

# Select Last Value From Dropdown
#     [Arguments]    ${dropdown_name}
#     [Documentation]    This keyword is used to select value from a dropdown
#     ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    ${dropdown_name}
#     Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
#     Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    15
#     Wait Until Element Is Visible    ${dropdown.common.select.newvalue}    ${MEDIUM_WAIT}
#     Click Element    ${dropdown.common.select.newvalue}

# Select First Value From Dropdown
#     [Arguments]    ${dropdown_name}
#     [Documentation]    This keyword is used to select value from a dropdown
#     ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    ${dropdown_name}
#     Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
#     Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    15
#     Wait Until Element Is Visible    ${dropdown.common.select.firstvalue}    ${MEDIUM_WAIT}
#     Click Element    ${dropdown.common.select.firstvalue}
# Select Specific Index Value From Dropdown
#     [Arguments]    ${dropdown_name}    ${index}
#     [Documentation]    This keyword is used to select value from a dropdown
#     ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    ${dropdown_name}
#     Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
#     Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    15
#     Wait Until Element Is Visible    (${dropdown.common.select.indexvalue})[${index}]    ${MEDIUM_WAIT}
#     Wait Until Time    4
#     Click Element    (${dropdown.common.select.indexvalue})[${index}]
# Navigate To Author Content Library Page_Prerequisite
#     [Arguments]    ${value}
#     [Documentation]    This keyword will Navigate To Author Content Library Page
#     Unselect Frame
#     Navigate To Module Tab    Content    Author    Content Library    Select Content Library
#     Select Content Library Task To Author_Prerequisite    ${value}

# Select Content Library Task To Author_Prerequisite
#     [Arguments]    ${value}
#     [Documentation]    It is used to select Content Library Task To Author
#     Select The Section    Select Content Library to Author
#     ${label.content.author.content_library.select.newcontent_lib_task}    Update Dynamic Value    ${label.content.author.content_library.select.content_lib_task}    ${value}
#     Wait Until Element Is Visible    ${label.content.author.content_library.select.newcontent_lib_task}    ${MEDIUM_WAIT}    Content Library Task is not visible after waiting for ${MEDIUM_WAIT} seconds
#     Wait Until Time    2
#     Click Element    ${label.content.author.content_library.select.newcontent_lib_task}

# Author Content Library_Prerequisite
#     [Arguments]    ${content_data}
#     [Documentation]    This keyword is used to Author Content Library
#     Wait Until Element Is Visible    ${label.content.author.content_library.select.content_lib_task.author}    ${LONG_WAIT}    Author Content Library screen is not visible after waiting ${LONG_WAIT} seconds
#     Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create}    ${MEDIUM_WAIT}    Create Link is not visible after waiting ${MEDIUM_WAIT} seconds
#     Click Element    ${link.content.author.content_library.select_task.create}
#     Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create.select_req}    ${MEDIUM_WAIT}    Select Link is not visible after waiting ${MEDIUM_WAIT} seconds
#     IF    'SelectRequirements' in ${content_data}
#         Click Element    ${link.content.author.content_library.select_task.create.select_req}
#         Select Requirements_Prerequisite    ${content_data}[SelectRequirements]
#     END
#     ${CONTENT_LIBRARY_NO}    Get Text    ${label.content.author.content_library.author_content_lib.content_lib_no}
#     Set Test Variable    ${CONTENT_LIBRARY_NO}
#     IF    'ContentLibraryName' in ${content_data}    Enter Text In Mandatory Fields    TestFnTitle    ${content_data}[ContentLibraryName]
#     IF    'Prefix' in ${content_data}    Enter Text In Mandatory Fields    TestFnPrefix    ${content_data}[Prefix]
#     IF    'Description' in ${content_data}    Enter Comments/Description    txtBoxDesc   ${content_data}[Description]
#     IF    'ContentLibraryStructure' in ${content_data}    Select Value From Dropdown    ddlTable    ${content_data}[ContentLibraryStructure]
#     IF    'RowDetails1' in ${content_data}
#         Wait Until Element Is Visible    ${icon.content.author.content_library.create.table.add_row}    ${MEDIUM_WAIT}    Add a row icon is not visible after waiting for ${MEDIUM_WAIT} seconds
#         Click Element    ${icon.content.author.content_library.create.table.add_row}
#         Select Requirements From Content Table And Verify Displayed Details_Prerequisite    ${content_data}[RowNo1]    ${content_data}[ContentTableRequirements]
#         Enter Details In Content Library Table_Prerequisite    ${content_data}[RowNo1]    ${content_data}[RowDetails1]
#     END

# Select Requirements From Content Table And Verify Displayed Details_Prerequisite
#     [Arguments]    ${row_no}    ${table_with_list}
#     [Documentation]    This keyword is used to Select Requirements From Content Table Reference Column and Verify displayed details in Reference cell
#     Wait Until Element Is Visible    (${icon.content.author.content_library.table.reference.search_icon})[${row_no}]    ${MEDIUM_WAIT}    Search icon is not visible after waiting for ${MEDIUM_WAIT} seconds
#     @{selected_requirements}    Create List
#     @{table_list}    Split String    ${table_with_list}    |
#     FOR    ${key}    IN    @{table_list}
#         Click Element   (${icon.content.author.content_library.table.reference.search_icon})[${row_no}]
#         Wait Until Element Is Visible    ${dropdown.content.author.content_library.table.reference.select_requirements}    ${MEDIUM_WAIT}    Select table dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
#         @{list}    Split String    ${key}    -
#         ${table}    Set Variable    ${list}[0]
#         ${select_req_list}    Set Variable    ${list}[1]
#         @{req_list}    Split String    ${select_req_list}    ,
#         Select From List By Label    ${dropdown.content.author.content_library.table.reference.select_requirements}    ${table}
#         Wait Until Time    2
#         FOR    ${value}    IN    @{req_list}
#             ${checkbox.content.author.content_library.table.reference.newselect_requirements}    Update Dynamic Value    ${checkbox.content.author.content_library.table.reference.select_requirements}    ${value}
#             Wait Until Element Is Visible    ${checkbox.content.author.content_library.table.reference.newselect_requirements}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
#             Select Checkbox    ${checkbox.content.author.content_library.table.reference.newselect_requirements}
#         END
#         Click Element    ${button.content.author.content_library.table.search.save}
#         Verify Notification Popup    Reference saved successfully    btnConfirmOk
#         Click Button In VLMS    Close
#         Append To List    ${selected_requirements}    @{req_list}
#     END
#     Log    ${selected_requirements}
#     Wait Until Element Is Visible    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[4]    ${MEDIUM_WAIT}    Reference cell is not visible after waiting for ${MEDIUM_WAIT} seconds

# Enter Details In Content Library Table_Prerequisite
#     [Arguments]    ${row_no}    ${details}
#     [Documentation]    This keyword is used to Enter Details in Content Library Table
#     ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${row_no}
#     Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${MEDIUM_WAIT}    ${row_no} row is not visible after waiting for ${MEDIUM_WAIT} seconds
#     @{details_list}    Split String    ${details}    |
#     ${col_no}    Set Variable    1
#     FOR    ${key}    IN    @{details_list}
#         IF    "${key}"!="None"
#             Wait Until Element Is Visible    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]    ${MEDIUM_WAIT}    cell is not visible after waiting for ${MEDIUM_WAIT} seconds
#             Click Element    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]
#             Wait Until Time    1
#             Press Keys    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]    ${key}
#         END
#         ${col_no}    Evaluate    ${col_no}+1
#     END

# Approve Content Library_Prerequisite
#     [Arguments]    ${content_data}
#     [Documentation]    This keyword is used to Approve Content Library
#     Click Button In VLMS    Save and Complete
#     Verify Confirmation Popup    Content Library Task has been completed    btnMessageOk
#     ${checkbox.content.author.content_library.select_content_libno.newcheckbox}    Update Dynamic Value    ${checkbox.content.author.content_library.select_content_libno.checkbox}    ${CONTENT_LIBRARY_NO}
#     Wait Until Element Is Visible    ${checkbox.content.author.content_library.select_content_libno.newcheckbox}    ${MEDIUM_WAIT}    ${CONTENT_LIBRARY_NO} is not visible after waiting for ${MEDIUM_WAIT} seconds
#     Select Checkbox    ${checkbox.content.author.content_library.select_content_libno.newcheckbox}
#     ${CONTENT_LIBRARY_TASKNO}    Get Text    ${label.content.author.content_library.author_content_lib.content_lib_task_no}
#     Set Test Variable    ${CONTENT_LIBRARY_TASKNO}
#     IF    'Approval' in ${content_data}
#         Select Value For Radio Button    WorkflowReq    ${content_data}[Approval]
#         IF    '${content_data}[Approval]'=='rbtnWorkflowYes'
#             Wait Until Time    2
#             IF    'Workflow' in ${content_data}    Select Value From Dropdown    ddlWorkflow    ${content_data}[Workflow]
#             IF    'RouteTaskFor' in ${content_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${content_data}[RouteTaskFor]
#         END
#     END
#     IF    'ApproveComments' in ${content_data}    Enter Comments/Description    txtComments    ${content_data}[ApproveComments]
#     Select Submit/Reset Button    Submit
#     Verify Confirmation Popup    Content Library Task ${CONTENT_LIBRARY_TASKNO}-Set-01 has been Approved    btnMessageOk

# Select Requirements_Prerequisite
#     [Arguments]    ${table_req_list}
#     [Documentation]    This keyword is used to Select Requirements in Author Content Library
#     Unselect Frame
#     Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
#     Select Frame    ${iframe.library_frame.screen}
#     Wait Until Element Is Visible    ${label.content.author.content_library.select_task.create.select_req_screen}    ${MEDIUM_WAIT}    Select Requirement screen is not visible after waiting for ${MEDIUM_WAIT} seconds
#     Wait Until Element Is Visible    ${dropdown.content.author.content_library.select_req.select_table}    ${MEDIUM_WAIT}    Select table dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
#     @{table_list}    Split String    ${table_req_list}    |
#     FOR    ${key}    IN    @{table_list}
#         @{list}    Split String    ${key}    -
#         ${tableno}    Set Variable    ${list}[0]
#         ${select_list}    Set Variable    ${list}[1]
#         @{select_reqlist}    Split String    ${select_list}    ,
#         Select From List By Label    ${dropdown.content.author.content_library.select_req.select_table}    ${tableno}
#         Wait Until Time    2
#         FOR    ${key}    IN    @{select_reqlist}
#             ${checkbox.content.author.content_library.select_req.newselect_req_no}    Update Dynamic Value    ${checkbox.content.author.content_library.select_req.select_req_no}    ${key}
#             Wait Until Element Is Visible    ${checkbox.content.author.content_library.select_req.newselect_req_no}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
#             Select Checkbox    ${checkbox.content.author.content_library.select_req.newselect_req_no}
#         END
#     END
#     Click Button In VLMS    Save
#     Verify Confirmation Popup    Requirements have been saved    btnMessageOk
#     Click Navigation Buttons In Screen    Close

# Create Custom Risk Model_Prerequisite
#     # robocop: disable=too-long-keyword
#     [Arguments]    ${table_name_list}    ${username}    ${password}
#     [Documentation]    This keyword is used to create custom risk model
#     ${count}    Get Length    ${table_name_list}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${riskmodel_data}    Set Variable     ${table_name_list}[${key}]
#         IF    'RiskModelName' in ${riskmodel_data}    Enter Text In Mandatory Fields    RiskType    ${riskmodel_data}[RiskModelName]
#         IF    'Justification' in ${riskmodel_data}    Enter Comments/Description    txtJustify    ${riskmodel_data}[Justification]
#         IF    'Description' in ${riskmodel_data}    Enter Comments/Description    txtDescription    ${riskmodel_data}[Description]
#         IF    'RiskModel' in ${riskmodel_data}    Select Value From Dropdown    ddlRiskModel    ${riskmodel_data}[RiskModel]
#         IF    '${riskmodel_data}[RiskModel]'=='Custom'    Enter Custom Risk Model Details_Prerequisite    ${riskmodel_data}
#         IF    '${riskmodel_data}[RiskModel]'=='FMEA'    Enter FMEA Risk Model Details_Prerequisite    ${riskmodel_data}
#         ${button.common.newname}    Update Dynamic Value    ${button.common.name}    btnSubmit
#         Wait Until Element Is Visible    ${button.common.newname}    ${MEDIUM_WAIT}
#         Click Element    ${button.common.newname}
#         Handle Electronic Sign    ${username}    ${password}    Submit    Create
#         Verify Confirmation Popup    ${riskmodel_data}[RiskModelName] Risk Model has been created    btnMessageOk
#     END

# Enter FMEA Risk Model Details_Prerequisite
#     # robocop: disable=too-long-keyword
#     [Arguments]    ${riskmodel_data}
#     [Documentation]    This keyword is used to create custom risk model
#     Wait Until Time    3
#     ${factorlevel_names}    Split String    ${riskmodel_data}[FactorLevelNames]    ,
#     ${factor_count}    Get Length    ${factorlevel_names}
#     ${row_no}    Set Variable    2
#     FOR    ${counter}    IN RANGE    0    ${factor_count}
#         Select The FMEA Section    ${factorlevel_names}[${counter}]
#         Wait Until Time    3
#         Select Value From Dropdown    select2-gvMain_ctl0${row_no}_ddlRows-container    ${riskmodel_data}[No.ofRows]
#         IF    '${factorlevel_names}[${counter}]'=='Severity'    Enter Values in Section For FMEA_Prerequisite    ${riskmodel_data}[SeverityValues]    ${row_no}
#         IF    '${factorlevel_names}[${counter}]'=='Probability'    Enter Values in Section For FMEA_Prerequisite    ${riskmodel_data}[ProbabilityValues]    ${row_no}
#         IF    '${factorlevel_names}[${counter}]'=='Detectability'    Enter Values in Section For FMEA_Prerequisite    ${riskmodel_data}[DetectabilityValues]    ${row_no}
#         ${row_no}    Evaluate    ${row_no}+1
#     END
#     Select The FMEA Section    Risk Class
#     Wait Until Time    3
#     Select Value From Dropdown    select2-gvMain_ctl05_ddlRows-container    ${riskmodel_data}[No.ofRows]
#     Wait Until Time    3
#     Enter Values in Risk Class Section For FMEA_Prerequisite    ${riskmodel_data}[RiskClassValues]
#     Select The FMEA Section    Risk Priority Number
#     Wait Until Time    3
#     Select Value From Dropdown    select2-gvMain_ctl06_ddlRows-container    ${riskmodel_data}[No.ofRows]
#     Wait Until Time    3
#     Enter Values in Risk Priority Number Section For FMEA_Prerequisite    ${riskmodel_data}[RiskPriorityNumberValues]
#     IF    'ProcessModel' in ${riskmodel_data}    Select Value From Dropdown    select2-ddlProcessbased-container    ${riskmodel_data}[ProcessModel]

# Select The FMEA Section
#     [Arguments]    ${section_name}
#     [Documentation]    Navigate to the section
#     ${label.newsection}    Update Dynamic Value    ${label.section.FMEA}    ${section_name}
#     Wait Until Element Is Visible    ${label.newsection}    ${MEDIUM_WAIT}    ${section_name} is not visible after waiting for ${MEDIUM_WAIT} seconds
#     Click Element    ${label.newsection}

# Enter Custom Risk Model Details_Prerequisite
#     # robocop: disable=too-long-keyword
#     [Arguments]    ${riskmodel_data}
#     [Documentation]    This keyword is used to create custom risk model
#     Select Value From Dropdown    ddlNoofRiskType    ${riskmodel_data}[RiskFactorLevel]
#     IF    'FactorLevelName' in ${riskmodel_data}    Enter Comments/Description    gvFactorLevel_ctl02_txtName    ${riskmodel_data}[FactorLevelName]
#     IF    'FactorLevelDescription' in ${riskmodel_data}    Enter Comments/Description     gvFactorLevel_ctl02_txtDescription    ${riskmodel_data}[FactorLevelDescription]
#     Click Button In VLMS    Save Risk Factor
#     Select The Section    ${riskmodel_data}[FactorLevelName]
#     IF    'Rows' in ${riskmodel_data}    Select Value From Dropdown    select2-gvMain_ctl02_ddlRows-container    ${riskmodel_data}[Rows]
#     Enter Values For Severity Section_Prerequisite    ${riskmodel_data}
#     Wait Until Time    3
#     Enter Details In Business Rule For Requirement Level Section_Prerequisite    ${riskmodel_data}
#     IF    'AdditionalFactorLevel' in ${riskmodel_data}    Select Value From Dropdown    select2-ddlNoofCustomfactor-container    ${riskmodel_data}[AdditionalFactorLevel]
#     Enter Details In Select Additional Factor Section_Prerequisite    ${riskmodel_data}
#     Click Button In VLMS    Save Additional Factor
#     Wait Until Time    2
#     @{factorlevel_names}    Split String    ${riskmodel_data}[FactorLevelNames]    ,
#     Select The Section    ${factorlevel_names}[0]
#     Verify Number Of Rows Dropdown Field Is Displayed_Prerequisite    ${factorlevel_names}[0]
#     Select The Section    ${factorlevel_names}[1]
#     Verify Number Of Rows Dropdown Field Is Displayed_Prerequisite    ${factorlevel_names}[1]
#     Wait Until Time    3
#     Select Rows And Enter Level Name_Prerequisite   ${riskmodel_data}[DetectabilityValues]    select2-gvMainCustom_ctl02_ddlRowsCustom-container    gvMainCustom_ctl02_gvFieldSaveCustom_ctl02_txtFieldTitle    gvCustomFactorLevel_ctl02_txtDescription
#     Wait Until Time    2
#     Select Rows And Enter Level Name_Prerequisite    ${riskmodel_data}[ProbabilityValues]    select2-gvMainCustom_ctl03_ddlRowsCustom-container    gvMainCustom_ctl03_gvFieldSaveCustom_ctl02_txtFieldTitle    gvCustomFactorLevel_ctl03_txtDescription

# Enter Values For Severity Section_Prerequisite
#     [Arguments]    ${risk_data}
#     [Documentation]    This keyword is used to enter values for fields under severity section
#     @{severity_values}    Split String    ${risk_data}[SeverityValues]    |
#     ${rows}    Get Length    ${severity_values}
#     FOR    ${row}    IN RANGE    0    ${rows}
#         ${row_values}    Split String    ${severity_values}[${row}]    ,
#         ${line}    Set Variable    ${row}+1
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain    txtFieldTitle    ${line}    ${row_values}[0]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain    txtFrom    ${line}    ${row_values}[1]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain    txtTo    ${line}    ${row_values}[2]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain    txtFieldDesc    ${line}    ${row_values}[3]
#     END
#     IF    'ProcessModel' in ${risk_data}    Select Value From Dropdown    select2-ddlProcessbased-container    ${risk_data}[ProcessModel]

# Enter Values in Section For FMEA_Prerequisite
#     [Arguments]    ${risk_data}    ${field_No}
#     [Documentation]    This keyword is used to enter values for fields under severity section
#     ${severity_values}    Split String    ${risk_data}    |
#     ${rows}    Get Length    ${severity_values}
#     FOR    ${row}    IN RANGE    0    ${rows}
#         ${row_values}    Split String    ${severity_values}[${row}]    ,
#         ${line}    Set Variable    ${row}+1
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl0${field_No}    txtFieldTitle    ${line}    ${row_values}[0]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl0${field_No}    txtFrom    ${line}    ${row_values}[1]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl0${field_No}    txtTo    ${line}    ${row_values}[2]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl0${field_No}    txtFieldDesc    ${line}    ${row_values}[3]
#         Wait Until Time    3
#     END

# Enter Values in Risk Class Section For FMEA_Prerequisite
#     [Arguments]    ${risk_data}
#     [Documentation]    This keyword is used to enter values for fields under severity section
#     ${risk_class}    Split String    ${risk_data}    |
#     ${rows}    Get Length    ${risk_class}
#     ${field}    Set Variable    2
#     FOR    ${row}    IN RANGE    0    ${rows}
#         ${row_values}    Split String    ${risk_class}[${row}]    ,
#         ${line}    evaluate    ${row}+1
#         ${line_no}    Set Variable    ${line}
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl05    txtFieldTitle    ${line_no}    ${row_values}[0]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl05    txtFrom    ${line_no}    ${row_values}[1]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl05    txtTo    ${line_no}    ${row_values}[2]
#         Select From List By Value    gvMain_ctl05_gvFieldSave_ctl0${field}_ddlcolor    ${row_values}[3]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl05    txtFieldDesc    ${line_no}    ${row_values}[4]
#         ${field}    evaluate    ${field}+1
#         Wait Until Time    3
#     END

# Enter Values in Risk Priority Number Section For FMEA_Prerequisite
#     [Arguments]    ${risk_data}
#     [Documentation]    This keyword is used to enter values for fields under severity section
#     ${risk_class}    Split String    ${risk_data}    |
#     ${rows}    Get Length    ${risk_class}
#     ${field}    Set Variable    2
#     FOR    ${row}    IN RANGE    0    ${rows}
#         ${row_values}    Split String    ${risk_class}[${row}]    ,
#         ${line}    evaluate    ${row}+1
#         ${line_no}    Set Variable    ${line}
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl06    txtFieldTitle    ${line_no}    ${row_values}[0]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl06    txtFrom    ${line_no}    ${row_values}[1]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl06    txtTo    ${line_no}    ${row_values}[2]
#         Select From List By Value    gvMain_ctl06_gvFieldSave_ctl0${field}_ddlcolor    ${row_values}[3]
#         Enter Value For The Selected Section TextField_Prerequisite    gvMain_ctl06    txtFieldDesc    ${line_no}    ${row_values}[4]
#         ${field}    evaluate    ${field}+1
#         Wait Until Time    3
#     END

# Enter Value For The Selected Section TextField_Prerequisite
#     [Arguments]    ${section_name}    ${field_name}    ${row}    ${value}
#     [Documentation]    This Keyword is used to enter data into the text field
#     ${textbox.risk.create.riskmodel.severity.newlevel}    Update Dynamic Values     ${textbox.risk.create.riskmodel.severity.levelname}    ${section_name}    ${field_name}
#     Wait Until Element Is Visible    (${textbox.risk.create.riskmodel.severity.newlevel})[${row}]    ${MEDIUM_WAIT}    ${field_name} is not visible after waiting for ${MEDIUM_WAIT} seconds
#     IF    '${value}'!='None'    Input Text    (${textbox.risk.create.riskmodel.severity.newlevel})[${row}]    ${value}

# Enter Details In Business Rule For Requirement Level Section_Prerequisite
#     [Arguments]    ${risk_data}
#     [Documentation]    This keyword is used to enter the values for the fields under business rule for requirement level section
#     IF    'RiskFactor' in ${risk_data}    Select Value From Dropdown    select2-gvBusinessruleReq_ctl02_grvAddReq_ctl02_ddlRiskFactor-container    ${risk_data}[RiskFactor]
#     IF    'ValidationScoreFrom' in ${risk_data}    Enter Comments/Description    gvBusinessruleReq_ctl02_grvAddReq_ctl02_txtFrom    ${risk_data}[ValidationScoreFrom]
#     IF    'ValidationScoreTo' in ${risk_data}    Enter Comments/Description    gvBusinessruleReq_ctl02_grvAddReq_ctl02_txtTo   ${risk_data}[ValidationScoreTo]
#     IF    'ProcessCondition' in ${risk_data}    Select Dropdown Value With Partial Text    select2-gvBusinessruleReq_ctl02_ddlProcessRequirement-container    ${risk_data}[ProcessCondition]

# Enter Details In Select Additional Factor Section_Prerequisite
#     [Arguments]    ${risk_data}
#     [Documentation]    This keyword is used to enter data for fields under select additional factor section
#     @{factorlevel_names}    Split String    ${risk_data}[FactorLevelNames]    ,
#     @{factorlevel_descriptions}    Split String    ${risk_data}[FactorLevelDescriptions]    ,
#     ${count}    Get Length    ${factorlevel_names}
#     FOR    ${row}    IN RANGE    1    ${count}+1
#         ${index}    Evaluate    ${row}-1
#         Enter Value For The Selected Section TextField    gvCustomFactor    txtName    ${row}    ${factorlevel_names}[${index}]
#         Enter Value For The Selected Section TextField    gvCustomFactor    txtDescription    ${row}    ${factorlevel_descriptions}[${index}]
#     END

# Verify Number Of Rows Dropdown Field Is Displayed_Prerequisite
#     [Arguments]    ${sectionname}
#     [Documentation]    This keyword is used to Verify the No. of rows dropdown field under severity section
#     ${dropdown.risk.create.riskmodel.newnoof_rows}    Update Dynamic Value    ${dropdown.risk.create.riskmodel.noof_rows}    ${sectionname}
#     Wait Until Element Is Visible   ${dropdown.risk.create.riskmodel.newnoof_rows}    ${MEDIUM_WAIT}    No. of rows dropdown field is not visible after waiting for ${MEDIUM_WAIT} seconds
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

# Select Rows And Enter Level Name_Prerequisite
#     [Arguments]    ${sectionvalues}    ${dropdownid}    ${levelanameid}    ${descriptionid}
#     [Documentation]    This keyword is used to enter number of rows and level name for the selected section
#     ${sectionvalues}    Split String    ${sectionvalues}    ,
#     Select Value From Dropdown    ${dropdownid}    ${sectionvalues}[0]
#     Enter Comments/Description    ${levelanameid}    ${sectionvalues}[1]
#     Enter Comments/Description    ${descriptionid}    ${sectionvalues}[2]

# Create Risk Framework_Prerequisite
#     [Arguments]    ${riskmodel_data}    ${username}    ${password}
#     ${count}    Get Length    ${riskmodel_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${risk_framework_data}    Set Variable     ${riskmodel_data}[${key}]
#         Click Button In VLMS    Create
#         Wait Until Time    ${MEDIUM_WAIT}
#         IF    'RiskFrameworkName' in ${risk_framework_data}    Enter Text In Mandatory Fields    RiskFrameWorkName    ${risk_framework_data}[RiskFrameworkName]
#         IF    'TemplateType' in ${risk_framework_data}
#         ${checkbox.templatetype.risk.create.riskframework.new}    Update Dynamic Value    ${checkbox.templatetype.risk.create.riskframework}    ${risk_framework_data}[TemplateType]
#         Select Checkbox    ${checkbox.templatetype.risk.create.riskframework.new}
#         END
#         ${Risk_framework_ID}    Get Text    ${label.riskframeworkid.create.risk.framework}
#         ${Risk_ID}   Remove String    ${Risk_framework_ID}    <
#         ${Risk_ID1}   Remove String    ${Risk_ID}    >
#         ${RiskID2}    Remove String    ${Risk_ID1}    [ ]
#         Set Suite Variable    ${RiskID2}
#         Click Element    ${button.nextdefine.risk.create.risk framework}
#         Wait Until Element Is Visible    ${textbox.columnheader.create.risk.framework}    ${MEDIUM_WAIT}
#         Input Text    ${textbox.columnheader.create.risk.framework}    ${risk_framework_data}[ColumnTitle]
#         Wait Until Time    3
#         Select Dropdown Value With Partial Text    select2-gvSelectedColumn_ctl05_ddlRiskModel-container    ${risk_framework_data}[RiskModel]
#         Click Button In VLMS    Generate
#         Select Value For Radio Button    Approval    rbtnApprovalNo
#         Select Submit/Reset Button    FWsubmit
#         Handle Electronic Sign    ${username}    ${password}    Submit
#         Verify Confirmation Popup    RiskFrameWork - ${risk_framework_data}[RiskFrameworkName] for ${RiskID2} has been created    btnMessageOk
#     END

# Create Decision Tree_Prerequisite
#     [Arguments]    ${Tree_Prerequisite_data}    ${username}    ${password}
#     ${count}    Get Length    ${Tree_Prerequisite_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${decision_tree_data}    Set Variable     ${Tree_Prerequisite_data}[${key}]
#         Click Button In VLMS    Create
#         Enter Name And Prefix Decision Tree Page    ${decision_tree_data}
#         Select Decision Tree For Details    ${decision_tree_data}
#         Enter Section Details Of Decision Tree    ${decision_tree_data}
#         Navigate To Page Title Tab    Define Action
#         Enter Details In Define Action Tab For Decision Tree    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]    ${decision_tree_data}[DecisionRequired]    ${decision_tree_data}
#         Click Button In VLMS    Submit
#         Handle Electronic Sign    ${username}    ${password}    Submit
#         #Verify Confirmation Popup    ${decision_tree_data}[DecisionTreeName] decision tree has been created    btnMessageOk
#     END

# Enter Name And Prefix Decision Tree Page
#     [Arguments]    ${decision_tree_data}
#     [Documentation]    It is used to enter aname and prefix details in decision tree page
#     Wait Until Time    2
#     IF    'DecisionTreeName' in ${decision_tree_data}    Input Text    ${textbox.system.create.decision_tree}    ${decision_tree_data}[DecisionTreeName]
#     IF    'Prefix' in ${decision_tree_data}    Input Text    ${textbox.system.create.entity.prefix}    ${decision_tree_data}[Prefix]
#     IF    'DecisionTreeFor' in ${decision_tree_data}    Select Value From Dropdown    divDecisionTreeFor    ${decision_tree_data}[DecisionTreeFor]

# Select Decision Tree For Details
#     [Arguments]    ${decision_tree_data}
#     [Documentation]    It is used to select the decision for details in decision tree page
#     Wait Until Time    2
#     IF    '${decision_tree_data}[DecisionTreeFor]' == 'Content Generation'
#         Select Value From Dropdown    divContentGenerationType    ${decision_tree_data}[DuplicatesOfContent]
#     ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'GxP Assessment'
#         ${button.decisiontree.newassessmentbasedon}    Update Dynamic Value    ${button.decisiontree.assessmentbasedon}    ${decision_tree_data}[AssessmentBasedOn]
#         Wait Until Element Is Visible    ${button.decisiontree.newassessmentbasedon}    ${MEDIUM_WAIT}    Button is not visible after waiting for ${MEDIUM_WAIT} seconds
#         Click Element    ${button.decisiontree.newassessmentbasedon}
#     ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Risk Assessment'
#         Select Dropdown Value With Partial Text    divRiskModel    ${decision_tree_data}[RiskModel]
#     END

# Enter Section Details Of Decision Tree
#     [Arguments]    ${decision_tree_data}
#     [Documentation]    It is used to enter section details in decision tree page
#     Wait Until Time    2
#     IF    '${decision_tree_data}[DecisionTreeFor]' != 'Risk Assessment'
#         Wait Until Time    2
#         Input Text    ${textbox.system.create.decision_tree.section}    ${decision_tree_data}[SectionName]
#         Click Element    ${link.system.create.decision_tree.section.add}
#         Select The Section    ${decision_tree_data}[SectionName]
#         Save Questions And Answers In Section    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]
#         Wait Until Time    3
#     ELSE
#         Wait Until Time    2
#         ${itr}    Get Element Count    ${label.section.count}
#         Set Global Variable    ${itr}
#         @{section_list}=    Create List
#         @{texttoappend.question}=    Create List
#         FOR    ${section_key}    IN RANGE    0    ${itr}
#             ${sectioname_toclick}    Get Text    (${sectiontext})[${section_key}+1]
#             Wait Until Time    3
#             Select The Section    ${sectioname_toclick}
#             ${answer_toclick}    Evaluate    ${section_key}+1
#             #${answer_toclick}    Convert To String    ${answer_toclick}
#             ${section_no}    Evaluate    ${section_key}+2
#             ${section_no}    Convert To String    ${section_no}
#             Save Questions And Answers In Section For Risk Assessment Decision Tree    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]    ${section_no}    ${answer_toclick}
#             Select The Section    ${sectioname_toclick}
#             Append To List    ${section_list}    ${sectioname_toclick}
#             Append To List    ${texttoappend.question}    ${answer_toclick}
#         END
#         Set Global Variable    ${section_list}
#         Set Global Variable    ${texttoappend.question}
#         Wait Until Time    3
#     END

# Save Questions And Answers In Section For Risk Assessment Decision Tree
#     [Arguments]    ${questions}    ${answers}    ${section}    ${answer_toclick}
#     [Documentation]    Its is used to save the questions and answers in the define question section
#     ${splitted_questions}    Split String    ${questions}    ,
#     ${splitted_questions_count}    Get Length    ${splitted_questions}
#     FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
#         ${question_and_questionprefix}    Split String    ${splitted_questions}[${question_key}]    -
#         ${question}    Catenate    ${question_and_questionprefix}[1]    ${answer_toclick}
#         ${questionprefix}    Catenate    ${question_and_questionprefix}[0]    ${answer_toclick}
#         Wait Until Time    3
#         ${textbox.system.create.decision_tree.riskassess.section.newquestion}    Update Dynamic Value    ${textbox.system.create.decision_tree.riskassess.section.question}    ${section}
#         ${textbox.system.create.decision_tree.riskassess.section.newquestion_prefix}    Update Dynamic Value   ${textbox.system.create.decision_tree.riskassess.section.question_prefix}    ${section}
#         Input Text    ${textbox.system.create.decision_tree.riskassess.section.newquestion}    ${question}
#         Input Text    ${textbox.system.create.decision_tree.riskassess.section.newquestion_prefix}    ${questionprefix}
#         ${splitted_answers}    Split String    ${answers}    |
#         Enter Multiple Answers For Risk Assessment Decision Tree    ${splitted_answers}[${question_key}]    ${section}    ${answer_toclick}
#         Click Element    (${button.system.create.decision_tree.riskassess.section.save})[${answer_toclick}]
#         ${label.system.create.decision_tree.section.newquestion}    Update Dynamic Values    ${label.system.create.decision_tree.section.question}    ${questionprefix}    ${question}
#         Wait Until Element Is Visible    ${label.system.create.decision_tree.section.newquestion}    ${MEDIUM_WAIT}
#         IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
#     END

# Enter Multiple Answers For Risk Assessment Decision Tree
#     [Arguments]    ${answers}    ${section}    ${answer_toclick}
#     [Documentation]    It is used to enter multiple answers to each question
#     ${splitted_answers}    Split String    ${answers}    ,
#     ${splitted_answers_count}    Get Length    ${splitted_answers}
#     FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
#         ${updated_answer_key}    Evaluate    ${answer_key}+2
#         ${updated_answer_key}    Convert To String    ${updated_answer_key}
#         ${textbox.system.create.decision_tree.riskassess.newanswer}    Update Dynamic Values    ${textbox.system.create.decision_tree.riskassess.answer}    ${updated_answer_key}    ${section}
#         Wait Until Time    1
#         Wait Until Element Is Visible    ${textbox.system.create.decision_tree.riskassess.newanswer}    ${MEDIUM_WAIT}    Answer input textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
#         Input Text   ${textbox.system.create.decision_tree.riskassess.newanswer}    ${splitted_answers}[${answer_key}]
#         IF    ${answer_key}+1<${splitted_answers_count}
#             Click Element    (${link.system.create.decision_tree.riskassess.section.answer.add})[${answer_toclick}]
#         END
#     END

# Add Validation Standard
#     [Arguments]    ${validation_standard}
#     [Documentation]    It is used to validation standard in define action tab
#     Unselect Frame
#     Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}
#     Select Frame    ${iframe.library_frame.screen}
#     Click Element    ${dropdown.system.create.decision_tree.section.answer.decision_required.validation_standard}
#     ${checkbox.validation_standard.newdecision_tree}    Update Dynamic Value    ${list.validation_standard.decision_tree}    ${validation_standard}
#     Wait Until Time    3
#     Wait Until Element Is Visible    ${checkbox.validation_standard.newdecision_tree}    ${MEDIUM_WAIT}
#     ${status}    Run Keyword And Return Status    Element Attribute Value Should Be    ${checkbox.validation_standard.newdecision_tree}    class    active-result
#     IF    '${status}' == 'True'
#         Click Element    ${checkbox.validation_standard.newdecision_tree}
#     ELSE
#         ${status1}    Run Keyword And Return Status    Element Attribute Value Should Be    ${checkbox.validation_standard.newdecision_tree}    class    active-result highlighted
#         IF    '${status1}' == 'True'    Click Element    ${checkbox.validation_standard.newdecision_tree}
#     END
#     Wait Until Time    3
#     Click Button In VLMS    Save
#     Wait Until Time    3

# Define Question Actions For Decision Tree
#     [Arguments]    ${decision_required}    ${key}    ${question}    ${decision_tree_data}
#     [Documentation]    It is used to define the different actions for questions
#     Wait Until Time    5
#     IF    '${decision_tree_data}[DecisionTreeFor]' == 'Content Generation'
#         ${radiobutton.system.create.decision_tree.section.action.newdecision_required}    Update Dynamic Value    ${radiobutton.system.create.decision_tree.section.action.decision_required.pre}    ${decision_required}
#         Click Element    (${radiobutton.system.create.decision_tree.section.action.newdecision_required})[${key}]
#         Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
#         Wait Until Time    3
#         ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action}    ${question}
#         Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
#     ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'GxP Assessment'
#         IF    '${decision_tree_data}[AssessmentBasedOn]' != 'Calculated values'
#             Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
#             ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action}    ${question}
#             Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
#         ELSE
#             Select From List By Value    (${dropdown.system.creacte.decision_tree.validation_score})[${key}]    ${decision_required}    
#             Wait Until Time    2
#             Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
#             ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action}    ${question}
#             Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
#         END
#     ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Validation Standard Assessment'
#         ${radiobutton.system.create.decision_tree.section.action.newdecision_required}    Update Dynamic Value    ${radiobutton.system.create.decision_tree.section.action.decision_required.pre}    ${decision_required}
#         Click Element    (${radiobutton.system.create.decision_tree.section.action.newdecision_required})[${key}]
#         Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
#         ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action}    ${question}
#         Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
#     ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Risk Assessment'
#         Click Element    (${dropdown.system.create.decision_tree.section.action})[${key}]
#         ${label.system.create.decision_tree.section.newaction}    Update Dynamic Value    ${label.system.create.decision_tree.section.action.riskassess}    ${question}
#         Click Element    (${label.system.create.decision_tree.section.newaction})[${key}]
#     END

# Enter Details In Define Action Tab For Decision Tree
#     [Arguments]    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
#     [Documentation]    It is used to enter all details in define action tab
#     IF    '${decision_tree_data}[DecisionTreeFor]' == 'Content Generation'
#         Define Action For Content Generator Decision Tree    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
#     ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'GxP Assessment'
#         Define Action For GxP Decision Tree    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
#     ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Validation Standard Assessment'
#         Define Action For Validation Standard Decision Tree    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
#     ELSE IF    '${decision_tree_data}[DecisionTreeFor]' == 'Risk Assessment'
#         Define Action For Risk Assessment Decision Tree    ${questions}    ${answers}    ${decision_tree_data}
#     END

# Define Action For Content Generator Decision Tree
#     [Arguments]    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
#     [Documentation]    It is used for content generator decision 
#     ${splitted_questions}    Split String    ${questions}    ,
#     ${splitted_questions_count}    Get Length    ${splitted_questions}
#     ${splitted_decision_required}    Split String    ${decision_required}    |
#     FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
#         ${updated_decision_required}    Split String    ${splitted_decision_required}[${question_key}]    ,
#         Wait Until Time    2
#         Select Value From Dropdown    divQuestion    ${splitted_questions}[${question_key}]
#         ${splitted_answers}    Split String    ${answers}    |
#         ${updated_splitted_answers}    Split String    ${splitted_answers}[${question_key}]    ,
#         ${splitted_answers_count}    Get Length    ${updated_splitted_answers}
#         FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
#             ${updated_answer_key}    Evaluate    ${answer_key}+1
#             ${updated_question_key}    Evaluate    ${question_key}+1
#             IF    ${answer_key}==1 or ${updated_question_key}==${splitted_questions_count}
#                 Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    End Action    ${decision_tree_data}
#                 IF    '${updated_decision_required}[${answer_key}]'=='rbtnYes'
#                     Click Element    ${button.system.create.decision_tree.section.answer.decision_required.pre}
#                     Add Manual Content Library_Prerequisite    Generic Based    ${decision_tree_data}[ContentLibrary]
#                     #Verify Success Message And Click Submit    Deliverables saved    btnMessageOk    2
#                     Wait Until Time    4
#                     Click Element    ${button.document.sliderclose}
#                     Unselect Frame
#                     Select Frame    ${iframe.framecontent}
#                 END
#             ELSE
#                 Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    ${splitted_questions}[${updated_question_key}]    ${decision_tree_data}
#             END
#         END
#         Wait Until Time    4
#         Click Button In VLMS    Complete
#         #Verify Confirmation Popup    Decision Action has been Completed    btnMessageOk
#     END

# Define Action For GxP Decision Tree
#     [Arguments]    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
#     [Documentation]    It is used for content generator decision 
#     ${splitted_questions}    Split String    ${questions}    ,
#     ${splitted_questions_count}    Get Length    ${splitted_questions}
#     ${splitted_decision_required}    Split String    ${decision_required}    |
#     FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
#         ${updated_decision_required}    Split String    ${splitted_decision_required}[${question_key}]    ,
#         Wait Until Time    2
#         Select Value From Dropdown    divQuestion    ${splitted_questions}[${question_key}]
#         ${splitted_answers}    Split String    ${answers}    |
#         ${updated_splitted_answers}    Split String    ${splitted_answers}[${question_key}]    ,
#         ${splitted_answers_count}    Get Length    ${updated_splitted_answers}
#         FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
#             ${updated_answer_key}    Evaluate    ${answer_key}+1
#             ${updated_question_key}    Evaluate    ${question_key}+1
#             IF    ${answer_key}==1 or ${updated_question_key}==${splitted_questions_count}
#                 Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    End Action    ${decision_tree_data}
#             ELSE
#                 Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    ${splitted_questions}[${updated_question_key}]    ${decision_tree_data}
#             END
#         END
#         Wait Until Time    4
#         Click Button In VLMS    Complete
#         #Verify Confirmation Popup    Decision Action has been Completed    btnMessageOk
#     END
#     Wait Until Time    ${MEDIUM_WAIT}
#     IF    '${decision_tree_data}[AssessmentBasedOn]' != 'Calculated values'
#         ${question_GxP1}    Split String    ${splitted_questions}[0]    -
#         ${question_GxP2}    Split String    ${splitted_questions}[1]    -
#         ${result_GxP}    Split String    ${answers}    |
#         ${updated_result_GxP}    Split String    ${result_GxP}[0]    ,
#         Scroll To Element    //div[contains(@id,'ddlDefaultRule_')]
#         Select Dropdown Value With Partial Text    RuleDetail_ctl02_ddlQuestionCombination_    ${question_GxP1}[1]
#         Wait Until Time    2
#         Select Dropdown Value With Partial Text    RuleDetail_ctl02_ddlResult_    ${updated_result_GxP}[0]
#         Wait Until Time    2
#         Select Dropdown Value With Partial Text    ReqDetail_ctl02_ddlQuestionCombination_    ${question_GxP2}[1]
#         Wait Until Time    2
#         Select Dropdown Value With Partial Text    ReqDetail_ctl02_ddlResult_    ${updated_result_GxP}[1]
#     ELSE
#         ${splitted_score}    Split String    ${decision_tree_data}[ValidationScore-Score]    |
#         ${splitted_requirement}    Split String    ${decision_tree_data}[ValidationScore-Requirement]    |
#         ${splitted_score_count}    Get Length    ${splitted_score}
#         IF    '${decision_tree_data}[ValidationScore-Condition]' == 'Between'
#             FOR    ${score_key}    IN RANGE    0    ${splitted_score_count}
#                 ${splitted_key}    Split String    ${splitted_score}[${score_key}]    ,
#                 ${updated_score_key}    Evaluate    ${score_key}+1
#                 Select From List By Label    (${dropdown.system.create.decision_tree.gxp_impact.condition})[${updated_score_key}]    Between
#                 Wait Until Time    2
#                 Input Text    (${dropdown.system.create.decision_tree.gxp_impact.validationscore.from})[${updated_score_key}]    ${splitted_key}[0]
#                 Input Text    (${dropdown.system.create.decision_tree.gxp_impact.validationscore.to})[${updated_score_key}]    ${splitted_key}[1]
#                 Wait Until Time    2
#                 Select From List By Label    (${dropdown.system.create.decision_tree.gxp_impact.requirement})[${updated_score_key}]    ${splitted_requirement}[${score_key}]
#             END
#         ELSE
#             FOR    ${score_key}    IN RANGE    0    ${splitted_score_count}
#                 ${updated_score_key}    Evaluate    ${score_key}+1
#                 Select From List By Label    (${dropdown.system.create.decision_tree.gxp_impact.condition})[${updated_score_key}]    =
#                 Wait Until Time    2
#                 Input Text    (${dropdown.system.create.decision_tree.gxp_impact.validationscore.equalto})[${updated_score_key}]    ${splitted_score}[${score_key}]
#                 Wait Until Time    2
#                 Select From List By Label    (${dropdown.system.create.decision_tree.gxp_impact.requirement})[${updated_score_key}]    ${splitted_requirement}[${score_key}]
#             END
#         END
#     END
#     Wait Until Time    2
#     Select Dropdown Value With Partial Text    ddlDefaultRule_    GxP Impact

# Define Action For Validation Standard Decision Tree
#     [Arguments]    ${questions}    ${answers}    ${decision_required}    ${decision_tree_data}
#     [Documentation]    It is used for content generator decision 
#     ${splitted_questions}    Split String    ${questions}    ,
#     ${splitted_questions_count}    Get Length    ${splitted_questions}
#     ${splitted_decision_required}    Split String    ${decision_required}    |
#     FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
#         ${updated_decision_required}    Split String    ${splitted_decision_required}[${question_key}]    ,
#         Wait Until Time    2
#         Select Value From Dropdown    divQuestion    ${splitted_questions}[${question_key}]
#         ${splitted_answers}    Split String    ${answers}    |
#         ${updated_splitted_answers}    Split String    ${splitted_answers}[${question_key}]    ,
#         ${splitted_answers_count}    Get Length    ${updated_splitted_answers}
#         FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
#             ${updated_answer_key}    Evaluate    ${answer_key}+1
#             ${updated_question_key}    Evaluate    ${question_key}+1
#             IF    ${answer_key}==1 or ${updated_question_key}==${splitted_questions_count}
#                 Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    End Action    ${decision_tree_data}
#                 IF    '${updated_decision_required}[${answer_key}]'=='rbtnYes'
#                     Click Element    ${button.system.create.decision_tree.section.answer.decision_required.pre}
#                     Add Validation Standard    ${decision_tree_data}[Validation Standard]
#                     #Click Element    //div[@id="val1_pnlConfirmationMessage" and not(contains(@style,"display: none;"))]//following::input[@id="btnMessageOk"]
#                     # Verify Confirmation Popup    Deliverables saved    btnMessageOk
#                     Wait Until Time    2
#                     Click Element    ${button.document.sliderclose.ValidationStandard}
#                     Unselect Frame
#                     Select Frame    ${iframe.framecontent}
#                 END
#             ELSE
#                 Define Question Actions For Decision Tree    ${updated_decision_required}[${answer_key}]    ${updated_answer_key}    ${splitted_questions}[${updated_question_key}]    ${decision_tree_data}
#                 IF    '${updated_decision_required}[${answer_key}]'=='rbtnYes'
#                     Click Element    ${button.system.create.decision_tree.section.answer.decision_required.pre}
#                     Add Validation Standard    ${decision_tree_data}[Validation Standard]
#                     #Click Element    //div[@id="val1_pnlConfirmationMessage" and not(contains(@style,"display: none;"))]//following::input[@id="btnMessageOk"]
#                     # Verify Confirmation Popup    Deliverables saved    btnMessageOk
#                     Wait Until Time    2
#                     Click Element    ${button.document.sliderclose.ValidationStandard}
#                     Wait Until Time    2
#                     Unselect Frame
#                     Select Frame    ${iframe.framecontent}
#                 END
#             END
#         END
#         Wait Until Time    4
#         Click Button In VLMS    Complete
#         #Verify Confirmation Popup    Decision Action has been Completed    btnMessageOk
#     END

# Define Action For Risk Assessment Decision Tree
#     [Arguments]    ${questions}    ${answers}    ${decision_tree_data}
#     [Documentation]    It is used for risk assessment decision
#     ${splitted_questions}    Split String    ${questions}    ,
#     ${splitted_questions_count}    Get Length    ${splitted_questions}
#     ${index_itr}    Set Variable    0
#     Wait Until Time    3
#     FOR    ${section_key}    IN RANGE    0    ${itr}
#         Scroll To Element    //input[@id='btnSubmit']
#         Select Dropdown Value With Partial Text    _ddlRiskModelSectionAction_    ${section_list}[${section_key}]
#         Scroll To Element    //input[@id='btnSubmit']
#         FOR    ${question_key}    IN RANGE    0    ${splitted_questions_count}
#             Wait Until Time    2
#             ${question_and_questionprefix}    Split String    ${splitted_questions}[${question_key}]    -
#             ${question}    Catenate    ${question_and_questionprefix}[1]    ${texttoappend.question}[${index_itr}]
#             #${questionprefix}    Catenate    ${question_and_questionprefix}[0]    ${texttoappend.question}[${question_key}]
#             Select Dropdown Value With Partial Text    divQuestion    ${question}
#             ${splitted_answers}    Split String    ${answers}    |
#             ${updated_splitted_answers}    Split String    ${splitted_answers}[${question_key}]    ,
#             ${splitted_answers_count}    Get Length    ${updated_splitted_answers}
#             FOR    ${answer_key}    IN RANGE    0    ${splitted_answers_count}
#                 ${updated_answer_key}    Evaluate    ${answer_key}+1
#                 ${updated_question_key}    Evaluate    ${question_key}+1
#                 IF    ${answer_key}==1 or ${updated_question_key}==${splitted_questions_count}
#                     Define Question Actions For Decision Tree    None    ${updated_answer_key}    End Action    ${decision_tree_data}
#                 ELSE
#                     ${question_and_questionprefix}    Split String    ${splitted_questions}[${updated_question_key}]    -
#                     ${question}    Catenate    ${question_and_questionprefix}[1]    ${texttoappend.question}[${index_itr}]
#                     Define Question Actions For Decision Tree    None    ${updated_answer_key}    ${question}    ${decision_tree_data}
#                 END
#             END
#             Wait Until Time    2
#             Click Button In VLMS    Complete
#             #Verify Confirmation Popup    Decision Action has been Completed    btnMessageOk
#         END
#     ${index_itr}    Evaluate    ${index_itr}+1    
#     Wait Until Time    3
#     END
#     Scroll To Element    //input[@id='btnSubmit']
#     FOR    ${section_key}    IN RANGE    0    ${itr}
#         ${updated_section_key}    Evaluate    ${section_key}+1
#         Click Element    (${tab.system.create.decision_tree.business_rule_riskassess})[${updated_section_key}]
#         Wait Until Time    3
#         Select First Value From Dropdown    _ddlQuestionCombination
#         Wait Until Time    2
#         Select First Value From Dropdown    _ddlResult
#         Wait Until Time    2
#         Select Specific Index Value From Dropdown    _ddlRiskFactors    3
#         Wait Until Time    2
#         ${dropdown.common.newselect}    Update Dynamic Value    ${dropdown.common.select}    ddlDefaultRule
#         Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
#         Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    15
#         #Javascript Input Text    ${textbox.common.select.value}    5
#         Wait Until Time    2
#         Click element    //div[@id='dvDefaultRule']/div//li[3]
#         #Select Specific Index Value From Dropdown    ddlDefaultRule    3
#     END

# Create Validation Standard
#     [Arguments]    ${validation_standard}    ${User}    ${User_password}
#     ${count}    Get Length    ${validation_standard}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${validation_standard_data}    Set Variable    ${validation_standard}[${key}]
#         Click Button In VLMS    Create
#         Wait Until Element Is Visible    txtRegulationName    3
#         Enter Text In Mandatory Fields    RegulationName     ${validation_standard_data}[ValidationStandardName]
#         Wait Until Element Is Visible    txtPrefix    2
#         Enter Text In Mandatory Fields    Prefix     ${validation_standard_data}[Prefix] 
#         Select Submit/Reset Button    Submit
#         Handle Electronic Sign    ${User}    ${User_password}    Submit
#         ${Expected_Result}    Set Variable    ${validation_standard_data}[ValidationStandardName] Validation Standard
#         Get Value From Toast Message    ${Expected_Result}
#     END

# Bind_Decision_Tree
#     [Arguments]    ${validation_standard}    ${User}    ${User_password}
#     ${count}    Get Length    ${validation_standard}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${Bind_decision}    Set Variable    ${validation_standard}[${key}]
#         IF    'BoundType' in ${Bind_decision}    Select Value For Radio Button    BindDecisionTree    ${Bind_decision}[BoundType]
#         Wait Until Time    ${SHORT_WAIT}
#         ${checkbox.category.content.bind.decisiontree.new}    Update Dynamic Value    ${checkbox.category.content.bind.decisiontree}    ${Bind_decision}[Category]
#         Scroll Element Into View    ${checkbox.category.content.bind.decisiontree.new}
#         Wait Until Time    ${SHORT_WAIT}
#         Click Element    ${checkbox.category.content.bind.decisiontree.new}
#         IF    'DecisionTreeType' in ${Bind_decision}    Select Value From Dropdown    ddlDecisionTreeType    ${Bind_decision}[DecisionTreeType]
#         Wait Until Time    ${SHORT_WAIT}
#         ${checkbox.decisiontree.content.bind.decisiontree.new}    Update Dynamic Value    ${checkbox.decisiontree.content.bind.decisiontree}    ${Bind_decision}[DecisionTreeName]
#         Click Element    ${checkbox.decisiontree.content.bind.decisiontree.new}
#         Select Submit/Reset Button    Submit
#         Handle Electronic Sign    ${User}    ${User_password}    Submit
#         Verify Confirmation Popup    Decision Tree has been bound    btnMessageOk
#     END

# Create Spread Template
#     [Documentation]    This keyword is sused to create Retirement
#     [Arguments]    ${SpreadTemplate_data}    ${USER}    ${USER_PASSWORD}
#     Click Button In VLMS    Create
#     Wait Until Element Is Visible    ${spreadtemplate.Text}
#     IF    'Select Content Function' in ${SpreadTemplate_data}    Select Value From Dropdown    select2-ddlTemplateType-container    Requirement
#     Wait Until Element Is Visible    ${spreadtemplate.Text}
#     IF    'Template Name' in ${SpreadTemplate_data}    Enter Text In Mandatory Fields    BoxName    ${SpreadTemplate_data}[Template Name]
#     Wait Until Time    5
#     ${spreadtemplate.id}    Get Text    ${label.spreadtemplate.id}
#     Wait Until Element Is Visible    ${label.spreadtemplate.id}    ${SHORT_WAIT}    ${label.spreadtemplate.id} is not visible after waiting for ${SHORT_WAIT} sec
#     IF    'ID Format' in ${SpreadTemplate_data}    Select Value From Dropdown    select2-ddlSelReqIDFormat-container    ${SpreadTemplate_data}[ID Format]
#     Wait Until Element Is Visible    ${icon.add}    ${SHORT_WAIT}    ${icon.add}
#     Click Element    ${icon.add}
#     Wait Until Element Is Visible    ${icon.add}    ${SHORT_WAIT}    ${icon.add} is not visible for ${SHORT_WAIT} seconds
#     IF    'Column Label' in ${SpreadTemplate_data}        Input Text    grdTemplateFieldDetails_ctl04_txtFieldLabel    ${SpreadTemplate_data}[Column Label]
#     IF    'Column Type' in ${SpreadTemplate_data}    Select Value From Dropdown    select2-grdTemplateFieldDetails_ctl04_ddlColType-container    ${SpreadTemplate_data}[Column Type]
#     Wait Until Element Is Visible    ${icon.add.sheet}    ${SHORT_WAIT}    ${icon.add.sheet} is not visible for ${SHORT_WAIT} seconds
#     Click Element    ${icon.add.sheet}
#     Wait Until Element Clickable    ${icon.add.sheet}
#     IF    'Type' in ${SpreadTemplate_data}    Select Value From Dropdown    select2-ddlHierarchy-container    ${SpreadTemplate_data}[Type]
#     Wait Until Time    ${SHORT_WAIT}
#     IF    'Inheritance Level' in ${SpreadTemplate_data}    Select Value From Dropdown    ddlHierarchyData    ${SpreadTemplate_data}[Inheritance Level]
#     Wait Until Time    ${SHORT_WAIT}
#     Click Element     //*[@id='Label2']
#     Wait Until Time    ${SHORT_WAIT}
#     Click Element     //*[@id='btnSaveAddAssociateGroup']
#     Wait Until Time    ${SHORT_WAIT}
#     Select Value For Radio Button    rbtnApprovalYes    ${SpreadTemplate_data}[Approve]
#     Select Submit/Reset Button    Submit
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Wait Until Element Is Visible    ${label.id}    ${MEDIUM_WAIT}    ${label.id} is not visible after ${MEDIUM_WAIT}
#     ${Retirement.id}    Get Text    ${label.id}
#     Verify Confirmation Popup    ${SpreadTemplate_data}[Template Name] Spread Template ${spreadtemplate.id} has been created    btnMessageOk
#     Set Suite Variable    ${spreadtemplate.id}

# Create Workflow
#     [Documentation]    This keyword is used to create Workflow
#     [Arguments]    ${workflow_data}    ${USER}    ${USER_PASSWORD}
#     Wait Until Time    ${SHORT_WAIT}
#     ${count}    Get Length    ${workflow_data}
#     FOR    ${key}    IN RANGE    0    ${count}
#         ${dict_data}    Set Variable    ${workflow_data}[${key}]
#         Click Button in VLMS    Create
#         IF    'WorkflowName' in ${dict_data}    Enter Text In Mandatory Fields    WName    ${dict_data}[WorkflowName]
#         ${Assigncount}    Split String    ${dict_data}[ApplicableTo]    ,
#         ${Assign}    Get Length    ${Assigncount}
#         FOR    ${key}    IN RANGE    0    ${Assign}
#             ${Value}    Set Variable    ${Assigncount}[${key}]
#             Select Value From Dropdown    chkApplicableTo_chosen    ${Value}
#         END    
#         #Click Element    ${checkbox.selectall.WF}
#         Wait Until Time    2
#         IF    'ReviewerGroup' in ${dict_data}   
#             ${Groupcount}    Split String    ${dict_data}[ReviewerGroup]    ,
#             ${Group}    Get Length    ${Groupcount}
#             FOR    ${key}    IN RANGE    0   ${Group}
#                 ${Value}    Set Variable    ${Groupcount}[${key}]
#                 Wait Until Time    ${SHORT_WAIT}
#                 Select Value From Dropdown    lstReviewer_chosen    ${Value}
#             END
#             #Swipe Values Between Groups_Prerequisite    ${dict_data}[ReviewerGroup]    lstReviewer    lstAssreviewer
#             ${rowNo}    Set Variable    2
#             ${groups}    Split String    ${dict_data}[ReviewerGroup]    ,
#             ${GroupUsers}    Split String    ${dict_data}[ReviewGroup]    |
#             ${splitorder}    Split String    ${dict_data}[Rorder]    ,
#             ${splitFRole}    Split String    ${dict_data}[ReviewerFunctionalRole]    ,
#             ${splitPeriod}    Split String    ${dict_data}[RWPeriodinDay]    ,
#             ${splitFrequency}    Split String    ${dict_data}[RWFrequencyinDay]    ,
#             ${splitSerial}    Split String    ${dict_data}[RWSerial/Parallel]    ,
#             ${order_count}    Get Length    ${splitorder}
#             FOR    ${counter}    IN RANGE    0    ${order_count}
#                 Wait Until Time    ${SHORT_WAIT}
#                 Wait Until Element Is Visible    //input[@id="grvReview_ctl0${rowNo}_txtGroupUser"]
#                 Click Element    //input[@id="grvReview_ctl0${rowNo}_txtGroupUser"]
#                 Wait Until Time    2
#                 ${splitgroup}    Split String    ${GroupUsers}[${counter}]    -
#                 IF    'Group' == '${splitorder}[${counter}]'
#                     Input Text    //input[@id="txtSearchGroup"]    ${groups}[${counter}]
#                     Click Element    //span[text()="${splitgroup}[0]"]/preceding-sibling::input[contains(@id,"chkGroupSel")]
#                     Click Element    //input[@id="btnESave"]
#                 ELSE
#                     Click Element    //span[text()="${splitgroup}[0]"]/preceding-sibling::a[contains(@id,"btnExpand")]
#                     Wait Until Time    2
#                     ${splitusers}    Split String    ${splitgroup}[1]    ,
#                     ${user_count}    Get Length    ${splitusers}
#                     FOR    ${rusers}    IN RANGE    0    ${user_count}
#                         #Wait Until Element Is Visible    //span[text()="${splitgroup}[0]"]//following::a[contains(@id,"btnSearch")]
#                         #Click Element    //span[text()="${splitgroup}[0]"]//following::a[contains(@id,"btnSearch")]
#                         #Click Element    //span[text()="${splitgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]
#                         #Clear Element Text    //span[text()="${splitgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]
#                         #Input Text    //span[text()="${splitgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]    ${splitusers}[${rusers}]
#                         Wait Until Time    2
#                         Click Element    //table[contains(@id,"ddlUser")]//span[contains(text(),"${splitusers}[${rusers}]")]/preceding-sibling::div/input[contains(@id,"ddlUser")]
#                     END
#                     Click Element    //input[@id="btnESave"]
#                 END
#                 Wait Until Time    2
#                 Select Value From Dropdown for Select    //div[@id="grvReview_ctl0${rowNo}_ddlFunctionalRole_chosen"]    ${splitFRole}[${counter}]
#                 Wait Until Time    3
#                 Input Text    //input[@id='grvReview_ctl0${rowNo}_txtTenure']    ${splitPeriod}[${counter}]
#                 Input Text    //input[@id='grvReview_ctl0${rowNo}_txtAlert']    ${splitFrequency}[${counter}]
#                 Select Value From Dropdown    grvReview_ctl0${rowNo}_ddlSerial_chosen    ${splitSerial}[${counter}]
#                 ${status}    Evaluate    ${order_count} >= ${rowNo}
#                 IF    '${status}' == 'True'
#                     Javascript Click   //a[@id='btnAddRview']
#                     ${rowNo}    Evaluate    ${rowNo}+1
#                 END
#             END
#         END
#         IF    'ApproverGroup' in ${dict_data}   
#             #Swipe Values Between Groups_Prerequisite    ${dict_data}[ApproverGroup]    lstApAvailbleUser    lstApAssignUser
#             ${rowNo}    Set Variable    2
#             ${Agroups}    Split String    ${dict_data}[ApproverGroup]    ,
#             ${AGroupUsers}    Split String    ${dict_data}[ApproveGroup]    |
#             ${splitAorder}    Split String    ${dict_data}[Aorder]    ,
#             ${splitAFRole}    Split String    ${dict_data}[ApproverFunctionalRole]    ,
#             ${splitAPeriod}    Split String    ${dict_data}[APRPeriodinDay]    ,
#             ${splitAFrequency}    Split String    ${dict_data}[APRFrequencyinDay]    ,
#             ${splitASerial}    Split String    ${dict_data}[APSerial/Parallel]    ,
#             ${order_Acount}    Get Length    ${splitAorder}
#             FOR    ${Acounter}    IN RANGE    0    ${order_Acount}
#                 Wait Until Element Is Visible    //input[@id="grvApprove_ctl0${rowNo}_txtGroupUser"]
#                 Click Element    //input[@id="grvApprove_ctl0${rowNo}_txtGroupUser"]
#                 Input Text    //input[@id="txtSearchGroup"]    ${Agroups}[${Acounter}]
#                 ${splitAgroup}    Split String    ${AGroupUsers}[${Acounter}]    -
#                 IF    'Group' == '${splitAorder}[${Acounter}]'
#                     Click Element    //span[text()="${splitAgroup}[0]"]/preceding-sibling::input[contains(@id,"chkGroupSel")]
#                     Click Element    //input[@id="btnESave"]
#                 ELSE
#                     Click Element    //span[text()="${splitAgroup}[0]"]/preceding-sibling::input[contains(@id,"btnExpand")]
#                     Wait Until Time    2
#                     ${splitAusers}    Split String    ${splitAgroup}[1]    ,
#                     ${user_count}    Get Length    ${splitAusers}
#                     FOR    ${ausers}    IN RANGE    0    ${user_count}
#                         Wait Until Element Is Visible    //span[text()="${splitAgroup}[0]"]//following::a[contains(@id,"btnSearch")]
#                         Click Element    //span[text()="${splitAgroup}[0]"]//following::a[contains(@id,"btnSearch")]
#                         Click Element    //span[text()="${splitAgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]
#                         Clear Element Text    //span[text()="${splitAgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]
#                         Input Text    //span[text()="${splitAgroup}[0]"]//following::input[contains(@id,"txtUserSearch")]    ${splitAusers}[${ausers}]
#                         Wait Until Time    2
#                         Click Element    //table[contains(@id,"ddlUser")]//span[contains(text(),"${splitusers}[${ausers}]")]/preceding-sibling::input[contains(@id,"ddlUser")]
#                     END
#                     Click Element    //input[@id="btnESave"]
#                 END
#                 Wait Until Time    3
#                 Select Value From Dropdown for Select    //div[@id="grvApprove_ctl0${rowNo}_ddlFunctionalRole_chosen"]    ${splitAFRole}[${Acounter}]
#                 Wait Until Time    3
#                 Input Text    //input[@id='grvApprove_ctl0${rowNo}_txtTenure']    ${splitAPeriod}[${Acounter}]
#                 Input Text    //input[@id='grvApprove_ctl0${rowNo}_txtAlert']    ${splitAFrequency}[${Acounter}]
#                 Wait Until Time    ${SHORT_WAIT}
#                 Scroll To Element    grvApprove_ctl0${rowNo}_ddlSerial_chosen
#                 Select Value From Dropdown    grvApprove_ctl0${rowNo}_ddlSerial_chosen    ${splitASerial}[${Acounter}]
#                 ${status}    Evaluate    ${order_Acount} >= ${rowNo}
#                 IF    '${status}' == 'True'
#                     Click Element    //input[@id="btnAddApprove"]
#                     ${rowNo}    Evaluate    ${rowNo}+1
#                 END
#             END
#         END
#         Select Submit/Reset Button    Submit
#         Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit    created
#         ${Expected_Result}    Set Variable    ${dict_data}[WorkflowName] Workflow has been created
#         Get Value From Toast Message    ${Expected_Result}
#     END

# Validate highlighted field
#     [Arguments]    ${message}
#     [Documentation]    Validate highlighted field
#     ${common.missing.new_text}    Update Dynamic Value    ${common.missing.text}    ${message}
#     Wait Until Element Is Visible    ${common.missing.new_text}    ${MEDIUM_WAIT}    Warning text is not visible after waiting for ${MEDIUM_WAIT}
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
# Search The Value From The Section
#     [Arguments]    ${value}
#     [Documentation]    It is used to Search for given Value in the section
#     Enter Text In Mandatory Fields    Search    ${value}
#     Click Element    ${icon.content.section.search_icon}
#     Wait Until Time    ${SHORT_WAIT}
# Expand Search Filter
#     [Documentation]    It is used for expanding the search filter
#     Wait Until Element Is Clickable And Click    ${common.expand.status.button}    ${MEDIUM_WAIT}
# Select Option To Filter
#     [Arguments]    ${filter}    ${option}
#     [Documentation]    It is used for selecting option for filter
#     ${common.dropdown.filter.new_selection}    Update Dynamic Value    ${common.dropdown.filter.selection}    ${filter}
#     Wait Until Element Is Visible    ${common.dropdown.filter.new_selection}    ${MEDIUM_WAIT}    Warning text is not visible after waiting for ${MEDIUM_WAIT}
#     Javascript Click    ${common.dropdown.filter.new_selection}
#     ${common.dropdown.filter.selection.new_option}    Update Dynamic Value    ${common.dropdown.filter.selection.option}    ${option}
#     Wait Until Element Is Visible    ${common.dropdown.filter.selection.new_option}    ${MEDIUM_WAIT}    Warning text is not visible after waiting for ${MEDIUM_WAIT}
#     Javascript Click    ${common.dropdown.filter.selection.new_option}
# Filter The Option And Search The Text
#     [Arguments]    ${filter}    ${option}    ${value}
#     [Documentation]    It is used for search and selecting the option by filtering
#     Expand Search Filter
#     Select Option To Filter    ${filter}    ${option}
#     Wait Until Time    ${SHORT_WAIT}
#     Search The Value From The Section    ${value}
# Click And Delete The Task
#    [Documentation]    It is used for deleting the task
#     Click Element    ${icon.initiated.tasks.del}
#     Enter Comments/Description    txtActionComments    Remove
#     Select Submit/Reset Button    ActionSubmit
# Click The Link In Table By Filter
#     [Arguments]    ${status}    ${text}    
#     [Documentation]    It is used for clicking the link in the table based on filter
#     ${common.link.table.new_search}    Update Dynamic Values    ${common.link.table.search}    ${status}    ${text}
#     Click Element    ${common.link.table.new_search}
# Select The Task Filtered By Status
#     [Arguments]    ${filter}    ${status}    ${text}
#     [Documentation]    It is used for selecting the task from the table which is filtered by status filter
#     Filter The Option And Search The Text    ${filter}    ${status}    ${text}
#     Wait Until Time    ${SHORT_WAIT}
#     Click The Link In Table By Filter    ${status}    ${text}

# Select Value From Dropdown In Verify Mapping
#     [Arguments]    ${dropdown_name}    ${dropdown_value}    ${key}
#     [Documentation]    This keyword is used to select value from a dropdown
#     ${dropdown.common.newselect}    Update Dynamic Value    (${label.auto_mapping.fix.column_type.select.value_5.0})[${key}]    ${dropdown_name}
#     Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
#     Wait Until Time    ${SHORT_WAIT}
#     Input Text    (${dropdown.auto_mapping.common.select.value.input})[${key}]    ${dropdown_value}
#     Press Keys    (${dropdown.auto_mapping.common.select.value.input})[${key}]    ENTER



# Navigate.To.Create Entity Type
#     [Documentation]    This keyword is used to navigate to the create entity type page
#     Navigate To Module Tab    System    Create    Entity Type    Select Entity Type
#     Click Button In VLMS    Create

# Create.Entity.Type
#     [Arguments]    ${system_entity_data}
#     [Documentation]    This keyword is used to create new entity type
#     Get Entity Type ID
#     Enter Pre-requisite Details In Create Entity Type    ${system_entity_data}
#     Enter Standard Form Details In Create Entity Type    ${system_entity_data}
#     IF    'ApprovalRequired' in ${system_entity_data}    Select Value For Radio Button    check    ${system_entity_data}[ApprovalRequired]
#     IF    'WorkFlow' in ${system_entity_data}    Select Value From Dropdown    ddlWorkFlow    ${system_entity_data}[WorkFlow]
#     IF    'RouteFor' in ${system_entity_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${system_entity_data}[RouteFor]
#     IF    'Comments' in ${system_entity_data}    Enter Comments/Description    txtComments    ${system_entity_data}[Comments]
#     IF    'Button' in ${system_entity_data}    Select Submit/Reset Button    ${system_entity_data}[Button]
#     Wait Until Time    2

# Enter.Pre-requisite Details In Create Entity Type
#     [Arguments]    ${system_entity_data}
#     [Documentation]    This keyword is used to enter pre-requisite details in create entity type
#     IF    'TaskType' in ${system_entity_data}    Select Value For Radio Button    DocType    ${system_entity_data}[TaskType]
#     IF    'SelectEntityType' in ${system_entity_data}    Select Value From Dropdown    ddlRevisedEntType    ${system_entity_data}[SelectEntityType]
#     IF    'EntityTypeName' in ${system_entity_data}    Input Text    ${textbox.system.create.entity_type}    ${system_entity_data}[EntityTypeName]
#     IF    'Prefix' in ${system_entity_data}    Input Text    ${textbox.system.create.entity.prefix}    ${system_entity_data}[Prefix]
#     IF    '${system_entity_data}[EntityNoType]'=='ConfigAutomated' or '${system_entity_data}[EntityNoType]'=='ConfigHybrid'
#         Select Value For Radio Button    EntConfig    ${system_entity_data}[EntityNoType]
#         Enter Unique ID Configuration Details    ${system_entity_data}
#     END
#     IF    'EntityNoType' in ${system_entity_data} or '${system_entity_data}[EntityNoType]'=='ConfigManual'
#         Select Value For Radio Button    EntConfig    ${system_entity_data}[EntityNoType]
#     END
#     IF    'DepartmentRequired' in ${system_entity_data}    Select Value For Radio Button    DepartmentReq    ${system_entity_data}[DepartmentRequired]
#     Wait Until Time    3
#     IF    'VersioningRequired' in ${system_entity_data}    Select Value For Radio Button    VerReq    ${system_entity_data}[VersioningRequired]
#     Wait Until Time    2
#     IF    'VersionFormat' in ${system_entity_data}    Select Value From Dropdown    ddlVersionFormat    ${system_entity_data}[VersionFormat]
#     Wait Until Time    3
#     IF    'EntityFormType' in ${system_entity_data}    Select Value From Dropdown    EntTypeSelect-container    ${system_entity_data}[EntityFormType]
#     ${ENTITY_TYPE_NAME}    Set Variable    ${system_entity_data}[EntityTypeName]
#     Set Global Variable    ${ENTITY_TYPE_NAME}

# Enter.Unique ID Configuration Details
#     [Arguments]    ${configuration_details}
#     [Documentation]    This keyword is used to enter details in Unique Id Configuration
#     Wait Until Time    3
#     IF    'StartingNo' in ${configuration_details}    Enter Text In Mandatory Fields    EntityStartingNo    ${configuration_details}[StartingNo]
#     IF    'SelectedTags' in ${configuration_details}    Swipe Values Between Groups    ${configuration_details}[SelectedTags]    lstEntAvailTag    lstEntSelectTag
#     IF    'DeselectTags' in ${configuration_details}    Swipe Values Between Groups    ${configuration_details}[DeselectTags]    lstEntSelectTag    lstEntAvailTag
#     IF    'Separator' in ${configuration_details}    Select Value From Dropdown    ddlEntSepartor    ${configuration_details}[Separator]
#     IF    'SerialNolength' in ${configuration_details}    Select Value From Dropdown    ddlEntSNoLength    ${configuration_details}[SerialNolength]

# Intiate Retirement
#     [Documentation]    This keyword i sused to create Retirement
#     [Arguments]    ${Retirement_data}    ${USER}    ${USER_PASSWORD}
#     Wait Until Element Is Visible
#     ...    ${button_create}
#     ...    ${SHORT_WAIT}
#     ...    Select Retirement is not visible after waiting ${SHORT_WAIT} Seconds
#     Click Button In VLMS    Create
#     Wait Until Element Is Visible
#     ...    ${label.header}
#     ...    ${SHORT_WAIT}
#     ...    Select Retirement is not visible after waiting ${SHORT_WAIT} Seconds
#     IF    'Retirement Name' in ${Retirement_data}
#         Enter Text In Mandatory Fields    RetireName    ${Retirement_data}[Retirement Name]
#     END
#     ${Retirement.id}    Get Text    ${label.id}
#     Wait Until Time    ${MEDIUM_WAIT}
#     Enter Description in Retirement    Description
#     Wait Until Time    ${MEDIUM_WAIT}
#     IF    'Retire' in ${Retirement_data}
#         Select Value From Dropdown    select2-ddlRetireType-container    ${Retirement_data}[Retire]
#     END
#     Wait Until Time    ${MEDIUM_WAIT}
#     click Tree Details    Category_155534    SubCategory_155602    Entity_155912**155912
#     Wait Until Time    ${MEDIUM_WAIT}
#     Click Element    ${button.saveretire}
#     Wait Until Time    ${MEDIUM_WAIT}
#     Enter Text In Mandatory Fields    Alert    1
#     Wait Until Time    ${SHORT_WAIT}
#     Enter Text In Mandatory Fields    Frequency    1
#     Wait Until Time    ${SHORT_WAIT}
#     Swipe Values Between Groups_Prerequisite    Group1    lstAvailableGroups    lstSelGroups
#     Wait Until Time    ${SHORT_WAIT}

# Decision Tree Of Type Content Generation
#     [Arguments]    ${decision_tree_data}
#     Enter Name And Prefix Decision Tree Page    ${decision_tree_data}
#     Select Decision Tree For Details    ${decision_tree_data}
#     Enter Section Details Of Decision Tree    ${decision_tree_data}
#     Navigate To Page Title Tab    Define Action
#     Enter Details In Define Action Tab For Decision Tree    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]    ${decision_tree_data}[DecisionRequired]    ${decision_tree_data}

# Decision Tree Of Type GxP
#     [Documentation]    TC_01 Create Decision Tree of type GxP
#     [Arguments]    ${decision_tree_data}
#     Enter Name And Prefix Decision Tree Page    ${decision_tree_data}
#     Select Decision Tree For Details    ${decision_tree_data}
#     Enter Section Details Of Decision Tree    ${decision_tree_data}
#     Navigate To Page Title Tab    Define Action
#     Enter Details In Define Action Tab For Decision Tree    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]    ${decision_tree_data}[ValidationScore-GxP]    ${decision_tree_data}

# Decision Tree Of Type Validation Standard
#     [Documentation]    TC_01 Create Decision Tree of type validation standard
#     [Arguments]    ${decision_tree_data}
#     Enter Name And Prefix Decision Tree Page    ${decision_tree_data}
#     Select Decision Tree For Details    ${decision_tree_data}
#     Enter Section Details Of Decision Tree    ${decision_tree_data}
#     Navigate To Page Title Tab    Define Action
#     Enter Details In Define Action Tab For Decision Tree    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]    ${decision_tree_data}[DecisionRequired]    ${decision_tree_data}

# Decision Tree Of Type Risk Assessment
#     [Documentation]    TC_01 Create Decision Tree of type risk assessment
#     [Arguments]    ${decision_tree_data}
#     Enter Name And Prefix Decision Tree Page    ${decision_tree_data}
#     Select Decision Tree For Details    ${decision_tree_data}
#     Enter Section Details Of Decision Tree    ${decision_tree_data}
#     Navigate To Page Title Tab    Define Action
#     Enter Details In Define Action Tab For Decision Tree    ${decision_tree_data}[Questions]    ${decision_tree_data}[Answers]    None    ${decision_tree_data}

# Login To VLMS 5.0 Application
#     [Arguments]    ${username}    ${password}
#     [Documentation]    Login To VLMS Application
#     Launch Web Application    ${BROWSER_NAME}    ${BASE_URL}
#      Wait Until Element Is Visible    ${textbox.login.username}    ${LONG_WAIT}    Login page is not visible after waiting for ${LONG_WAIT} seconds
#     Input Text    ${textbox.login.username}    ${username}
#     Input Text    ${textbox.login.password}    ${password}
#     ${button.newsubmit/reset}    Update Dynamic Value    ${button.submit/reset}    Submit
#     Javascript Click    ${button.newsubmit/reset}
#     ${alert_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.home.expire_password_alert}    ${SHORT_WAIT}    Expire password alert is not visible after waiting for ${MEDIUM_WAIT} seconds
#     IF    '${alert_status}'=='True'    Click Button In VLMS    Ok
#     Wait Until Element Is Visible    ${icon.home_5.0}    ${LONG_WAIT}    Home page is not visible after waiting for ${LONG_WAIT} seconds
# # Menu Navigation_5.0
# #     [Arguments]    ${MainMenu}    ${Section}    ${tab}=None
# #     ${button.newmodule}    Update Dynamic Value    ${button.module_5.0}    ${MainMenu}
# #     Wait Until Element Is Visible    ${button.newmodule}
# #     Click Element    ${button.newmodule}
# #     ${button.newmodule.tab.content_5.0}    Update Dynamic Value    ${button.module.tab.content_5.0}    ${Section}
# #     Wait Until Element Is Visible    ${button.newmodule.tab.content_5.0}
# #     Click Element    ${button.newmodule.tab.content_5.0}
# #     Select Frame    ${iframe.framecontent}
# #     IF    "${tab}"!="None"
# #         ${LinkText.system.System.Taxonomy.new}    Update Dynamic Value    ${LinkText.system.System.Taxonomy}    ${tab}
# #         Wait Until Element Is Visible    ${LinkText.system.System.Taxonomy.new}
# #         Click Element    ${LinkText.system.System.Taxonomy.new}
# #     END
# Navigate to Assign Document Screen
#     [Arguments]    ${MainMenu}    ${Section}    ${Button}
#     [Documentation]    It is uesd to navigate to assign document screen
#     Menu Navigation_5.0    ${MainMenu}    ${Section}
#     Wait Until Time    ${SHORT_WAIT}
#     Select Frame    ${iframe.framecontent}
#     Click Button In VLMS    ${Button}
# Validate Toast Message
#     [Arguments]    ${alert_success_message}
#     [Documentation]    It is uesd to validate the toast message
#     ${label.content.assign.authoring.new_success_message}    Update Dynamic Value    ${label.content.assign.authoring.success_message}    ${alert_success_message}
#     Wait Until Element Is Visible    ${label.content.assign.authoring.new_success_message}    ${SHORT_WAIT}    ${alert_success_message} is not visible after waiting ${MEDIUM_WAIT} seconds
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
# Validate highlighted field
#     [Arguments]    ${message}
#     [Documentation]    Validate highlighted field
#     ${common.missing.new_text}    Update Dynamic Value    ${common.missing.text}    ${message}
#     Wait Until Element Is Visible    ${common.missing.new_text}    ${MEDIUM_WAIT}    Warning text is not visible after waiting for ${MEDIUM_WAIT}
#     IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
# Search The Value From The Section
#     [Arguments]    ${value}
#     [Documentation]    It is used to Search for given Value in the section
#     Enter Text In Mandatory Fields    Search    ${value}
#     Click Element    ${icon.content.section.search_icon}
#     Wait Until Time    ${SHORT_WAIT}
# Expand Search Filter
#     [Documentation]    It is used for expanding the search filter
#     Wait Until Element Is Clickable And Click    ${common.expand.status.button}    ${MEDIUM_WAIT}
# Select Option To Filter
#     [Arguments]    ${filter}    ${option}
#     [Documentation]    It is used for selecting option for filter
#     ${common.dropdown.filter.new_selection}    Update Dynamic Value    ${common.dropdown.filter.selection}    ${filter}
#     Wait Until Element Is Visible    ${common.dropdown.filter.new_selection}    ${MEDIUM_WAIT}    Warning text is not visible after waiting for ${MEDIUM_WAIT}
#     Javascript Click    ${common.dropdown.filter.new_selection}
#     ${common.dropdown.filter.selection.new_option}    Update Dynamic Value    ${common.dropdown.filter.selection.option}    ${option}
#     Wait Until Element Is Visible    ${common.dropdown.filter.selection.new_option}    ${MEDIUM_WAIT}    Warning text is not visible after waiting for ${MEDIUM_WAIT}
#     Javascript Click    ${common.dropdown.filter.selection.new_option}
# Filter The Option And Search The Text
#     [Arguments]    ${filter}    ${option}    ${value}
#     [Documentation]    It is used for search and selecting the option by filtering
#     Expand Search Filter
#     Select Option To Filter    ${filter}    ${option}
#     Wait Until Time    ${SHORT_WAIT}
#     Search The Value From The Section    ${value}
# Click And Delete The Task
#    [Documentation]    It is used for deleting the task
#     Click Element    ${icon.initiated.tasks.del}
#     Enter Comments/Description    txtActionComments    Remove
#     Select Submit/Reset Button    ActionSubmit
# Click The Link In Table By Filter
#     [Arguments]    ${status}    ${text}    
#     [Documentation]    It is used for clicking the link in the table based on filter
#     ${common.link.table.new_search}    Update Dynamic Values    ${common.link.table.search}    ${status}    ${text}
#     Click Element    ${common.link.table.new_search}
# Select The Task Filtered By Status
#     [Arguments]    ${filter}    ${status}    ${text}
#     [Documentation]    It is used for selecting the task from the table which is filtered by status filter
#     Filter The Option And Search The Text    ${filter}    ${status}    ${text}
#     Wait Until Time    ${SHORT_WAIT}
#     Click The Link In Table By Filter    ${status}    ${text}
# Select Review Flow In Workflow
#     [Arguments]    ${flow}    ${row_no}
#     [Documentation]    It is used for selecting the flow of review in workflow
#     ${common.label.review.new_flow}    Update Dynamic Values    ${common.label.review.flow}    ${row_no}    ${flow}
#     Click Element    ${common.label.review.new_flow}
# Select Approve Flow In Workflow
#     [Arguments]    ${flow}    ${row_no}
#     [Documentation]    It is used for selecting the flow of approve in workflow
#     ${common.label.approve.new_flow}    Update Dynamic Values    ${common.label.approve.flow}    ${row_no}    ${flow}
#     Click Element    ${common.label.approve.new_flow}
# # Validate Radio Button Is Selected
# #     [Arguments]    ${radiobutton}
# #     [Documentation]    Validate radio button is selected
# #     ${status}    Run Keyword And Return Status    Validate Radio Button Selected Using Javascript    ${radiobutton}
# #     IF    '${status}'=='False'
# #         Fail And Take Screenshot    Radio button is not selected
# #    END
# Select Value From Dropdown In Verify Mapping
#     [Arguments]    ${dropdown_name}    ${dropdown_value}    ${key}
#     [Documentation]    This keyword is used to select value from a dropdown
#     ${dropdown.common.newselect}    Update Dynamic Value    (${label.auto_mapping.fix.column_type.select.value_5.0})[${key}]    ${dropdown_name}
#     Wait Until Element Is Visible    ${dropdown.common.newselect}    ${MEDIUM_WAIT}    ${dropdown_name} dropdown is not visible after waiting ${MEDIUM_WAIT} seconds
#     Wait Until Time    ${SHORT_WAIT}
#     Input Text    (${dropdown.auto_mapping.common.select.value.input})[${key}]    ${dropdown_value}
#     Press Keys    (${dropdown.auto_mapping.common.select.value.input})[${key}]    ENTER
#     #Wait Until Element Is Clickable And Click    ${dropdown.common.newselect}    15
#     #Wait Until Time    ${SHORT_WAIT}
#     #Wait Until Element Is Clickable And Click    ${search.highlight.li}    15
#     #Scroll Element Into View    ${dropdown.common.newselect}
#     #Click Element    ${dropdown.common.newselect}
#     #${dropdown.common.select.newvalue}    Update Dynamic Value    (${dropdown.auto_mapping.common.select.value})[${key}]    ${dropdown_value}
#     #Wait Until Element Is Visible    ${dropdown.common.select.newvalue}    ${MEDIUM_WAIT}    ${dropdown_value} is not visible after waiting ${MEDIUM_WAIT} secondswait untikk
#     #Javascript Click    ${dropdown.common.select.newvalue}
#     #Scroll Element Into View    ${dropdown.common.select.newvalue}
#     #Click Element    ${dropdown.common.select.newvalue}
#     #Click Element At Coordinates    ${dropdown.common.select.newvalue}    xoffset    yoffset
# Select Answers For Questions In Decision Tree In 5.0
#     [Arguments]    ${message}    ${grid_list}
#     [Documentation]    It is used to select answers for questions in decision tree
#     #Accept Document And Accept The Popup    ${message}
#     Navigate To Page Title Tab    Content Generation
#     Click Button In VLMS    Decision Tree
#     @{list}    Split String    ${grid_list}    |
#     ${index}    Set Variable    0
#     ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.content.author.doc.decision_tree.complete}    5s
#     WHILE    '${status}'!='True'
#         ${button.decisiontree.option.newselection}    Update Dynamic Value    ${button.decisiontree.option.selection}    ${list}[${index}]
#         Wait Until Keyword Succeeds    10s    2s    Click Element    ${button.decisiontree.option.newselection}
#         ${index}    Evaluate    ${index}+1
#         ${status1}    Run Keyword And Return Status    Wait Until Element Is Visible    ${textbox.content.author.doc.decision_tree.justification}    2s
#         IF    '${status1}'=='True'    Input Text    ${textbox.content.author.doc.decision_tree.justification}    Test
#         #Select Previous/Next Button In Decision Tree    Next
#         Wait Until Time    ${SHORT_WAIT}
#         ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.content.author.doc.decision_tree.complete}    5s
#     END
#     Click Element    ${button.content.author.doc.decision_tree.complete}