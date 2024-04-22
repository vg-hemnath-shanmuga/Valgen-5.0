*** Settings ***
Documentation    This suite contains test cases of Prerequsites
Suite Teardown     Close All Browsers
Resource          ../Config/super.resource
Resource    ../Keywords/Web/prerequsiteKeywords.resource
Test Tags    test:retry(0)
Test Teardown    NONE

*** Test Cases ***
TC_Create Site
    [Documentation]    Creating Site
    ${site_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Site
    Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    Navigate To Module Tab    Config    Create    Site    Create Site
    Create Site    ${site_data}

TC_Create Role and Provide Access Control
    [Documentation]    Creating Role
    ${Role_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Role
    Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    Navigate To Module Tab    Administration    Create    Role    Create Role
    Create Role    ${Role_data}

TC_Create Department
    [Documentation]    Create A Department And Verify Success Message
    ${department_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Department
    Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    Navigate To Module Tab    Administration    Create    Department    Create Department
    Create Department    ${department_data}

TC_Create Job Title
    [Documentation]    Create A Job Title
    ${title_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Title
    Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    Navigate To Module Tab    Administration    Create    Job Title    Create Job Title
    Create Job Title    ${title_data}

TC_Create User in VLMS
    [Documentation]    Create User
    ${User_Data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    UserData
    ${CrossSiteProfile_Data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    CrossSiteProfile
    Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    Create User or Provide Cross Site Access    ${User_Data}    ${CrossSiteProfile_Data}

TC_Create Reason
    [Documentation]    create a reason
    ${reason_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Reason
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Reason    Create Reason
    Create Reason     ${reason_data}

TC_Create Category
    [Documentation]    Category Creation
    ${category_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    CatSub
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Category     Create Category
    Create Category    ${category_data}    ${USER}    ${USER_PASSWORD}

TC_Create SubCategory
    [Documentation]    Sub-Category  Creation
    ${Subcategory_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    CatSub
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System     Create     Sub Category     Create Sub Category   
    Create SubCategory    ${Subcategory_data}    ${USER}    ${USER_PASSWORD}

TC_Create Functional Role
    [Documentation]    TC to create a reason's for the input
    ${fnRole_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    FunctionalRole
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Functional Role    Create Functional Role
    Create the Functional roles    ${fnRole_data}    ${USER}    ${USER_PASSWORD}

TC_Create Groups
    [Documentation]    This keyword is used to Create a Group of available Users which can be applied for multiple objects
    ${Group_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Group
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Group    Create Group
    Create Group    ${Group_data}    ${USER}    ${USER_PASSWORD}

TC_Create WorkFlow
    [Documentation]    This keyword is used to Create WorkFlow
    ${workflow_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    WorkFlow
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Workflow    Create Workflow
    Create Workflow    ${workflow_data}    ${USER}    ${USER_PASSWORD}

TC_Create Form
    [Documentation]    TC_01,02,03,04 Create Form
    ${form_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Form
    Login To VLMS Application     ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Form    Select Form List
    Create Form prerequsite  ${form_data}   ${USER}    ${USER_PASSWORD}

TC_Create Content Type
    [Documentation]    TC_01 Create Content And Verify The Content Type
    ${content_type_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    ContentType
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Content Type    Create Content Type
    Enter The Details To Create A New Content_Prereuisite    ${content_type_data}    ${USER}    ${USER_PASSWORD}

TC_Create Validation Standard
    [Documentation]    TC_01 Create A Department And Verify Success Message
    ${validation_standard_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    ValidationStandard
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    Assessment    Create    Validation Standard    Create Validation Standard
    Create Validation Standard    ${validation_standard_data}    ${USER}    ${USER_PASSWORD} 

TC_Create Entitystatus
    [Documentation]    Create The EntityStatus
    ${entitystatus_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    EntityStatus
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    Assessment    Create    Entity Status    Create Entity Status
    Create Entity Status    ${entitystatus_data}    ${USER}    ${USER_PASSWORD}

TC_Create Framework
    [Documentation]    Create The Framework
    ${create_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Framework
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Create Validation Framework_Prerequisite
    Create Framework_Prerequisite    ${create_data}    ${USER}    ${USER_PASSWORD}

TC_Create Entity Type
    [Documentation]    Create Entity Type And Verify It.
    ${Group_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    EntityType
    Login To VLMS Application     ${USER}    ${USER_PASSWORD}
    Navigate To Create Entity Type_Prerequisite
    Create EntityType_Prerequisite    ${Group_data}    ${USER}    ${USER_PASSWORD}

TC_Create Entity
    [Documentation]    Create The Entity
    ${entity_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Entity
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Entity    Create Entity
    Create Entity prerequiste    ${entity_data}    ${USER}    ${USER_PASSWORD}

TC_Create Keyword Mapping
    [Documentation]    Create keyword mapping
    ${Keyword_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    KeywordMapping
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Mapping Keyword    Create Mapping Keyword
    Create Keyword Mapping    ${Keyword_data}    ${USER}    ${USER_PASSWORD}

TC_Create Table With Multiple Rows
    [Documentation]    TC_01 Create Content And Verify The Table
    ${table_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Table
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Table    Create Table
    Enter The Details To Create A New Table    ${table_data}    ${USER}    ${USER_PASSWORD}

TC_Author External Document
    [Documentation]    Author External Document 
    ${content_author_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    ExternalDocument
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Author Documnet Externally    ${content_author_data}    ${USER}    ${USER_PASSWORD}

TC_Create Content Library
    [Documentation]    TC_13,14,15 Create Content Library and Approve Content Library
    ${content_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    ContentLibrary
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Create Content Library_Prerequisite    ${content_data}    ${USER}    ${USER_PASSWORD}

TC_Create Trace Model
    [Documentation]    Create Trace Model
    ${trace_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    TraceModel
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Create Trace Model and Bind Task    ${trace_data}    ${USER}    ${USER_PASSWORD}

TC_Create Trace Matrix
    [Documentation]    Creating Trace Matrix
    ${record}    Set Variable    False
    ${tracematrix_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    TraceMatrix
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Create Trace Matrix_Prereuisite    ${tracematrix_data}    ${USER}    ${USER_PASSWORD}

TC_Create Template Group
    [Documentation]    TC to create Template Group
    ${tg_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Template Group
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    Content    Create    Template Group    Create Template Group
    Create Template Group    ${tg_data}

TC_Create Content Template
    [Documentation]    Create The Template
    ${create_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Template
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Create Template    ${create_data}    ${USER}    ${USER_PASSWORD}

TC_Create Risk Process
    [Documentation]    TC to create Risk Process
    ${riskprocess_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    RiskProcess
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    Risk    Create    Risk Process    Create Risk Process
    Create Risk Process_Prerequisite    ${riskprocess_data}    ${USER}    ${USER_PASSWORD}

TC_Create Risk Model
    [Documentation]    Create Risk Model
    ${riskmodel_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    RiskModel
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    Risk    Create    Risk Model    Create Risk Model Levels    True
    Create Custom Risk Model_Prerequisite    ${riskmodel_data}    ${USER}    ${USER_PASSWORD}

TC_Create Risk Framework
    [Documentation]    Create Risk Assessment
    ${risk_framework_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    RiskFramework
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    Risk    Create    Risk Framework    Risk Framework
    Create Risk Framework_Prerequisite    ${risk_framework_data}    ${USER}    ${USER_PASSWORD}

TC_Create Decision Tree
    [Documentation]    Create Decision Tree
    ${decision_tree_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    DecisionTree
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    System    Create    Decision Tree    Create Decision Tree
    Create Decision Tree_Prerequisite    ${decision_tree_data}    ${USER}    ${USER_PASSWORD}

TC_Bind Decision Tree
    [Documentation]    user able to bind decision tree
    ${Bind_decision}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    BindDecisionTree
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    Content    Bind    Bind Decision Tree    Bind Decision Tree
    Bind_Decision_Tree   ${Bind_decision}    ${USER}    ${USER_PASSWORD}

TC_Create Section
    [Documentation]    TC to create a reason's for the input
    ${section_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Section
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    Assessment    Create    Section    Create Section
    Create the Section_Prerequisite    ${section_data}    ${USER}    ${USER_PASSWORD}

# Validate User Is Able To Create Building
#     [Documentation]    TC to create a Building
#     ${record}    Set Variable    False
#     Start Recording    ${record}    Building
#     ${building_data}    Read TestData From Excel    TC_01    Building
#     Login To VLMS Application    ${BASE_URL}    ${USER}    ${USER_PASSWORD}
#     Navigate To Module Tab    System    Create    Building    Create Building
#     Enter details to create building   ${building_data}
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Verify Confirmation Popup    ${Building_data}[BuildingName] Building has been created    ${building_data}[ButtonOption]
#     Stop Recording    ${record}    Building

# Validate User Is Able To Create Room
#     [Documentation]    TC to create a Room inside a building
#     ${record}    Set Variable    False
#     Start Recording    ${record}    room
#     ${room_data}    Read TestData From Excel    TC_02    Room
#     Login To VLMS Application    ${BASE_URL}    ${USER}    ${USER_PASSWORD}
#     Navigate To Module Tab    System    Create    Room    Create Room
#     Enter details to create Room    ${room_data}  
#     Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
#     Verify Confirmation Popup    ${room_data}[RoomName] Building has been created    ${room_data}[ButtonOption]
#     Stop Recording    ${record}    room

# TC-1 Validation Plan
#     [Documentation]    Create Validation plan
#     ${validation_plan}    Read TestData From Excel    TC_01    Validation Plan
#     Login To VLMS Application    ${BASE_URL}    ${USER}    ${USER_PASSWORD}
#     Navigate To Module Tab    Assessment    Create    Validation Plan    Select Validation Plan
#     Enter the validation plan    ${validation_plan}    ${USER}    ${USER_PASSWORD}
#     Route for Review    ${validation_plan}    ${USER}    ${USER_PASSWORD}
#     Reviewed Validation Plan    ${validation_plan}    ${USER}    ${USER_PASSWORD}
#     Approve Validation plan    ${validation_plan}    ${USER}    ${USER_PASSWORD}

# TC-2 Validation Summary
#     [Documentation]    Create validation summary
#     ${validation_summary}    Read TestData From Excel    TC_01    Validationsummary
#     Login To VLMS Application    ${BASE_URL}    ${USER}    ${USER_PASSWORD}
#     Navigate To Module Tab    Assessment    Create    Validation Summary    Select Validation Summary
#     Enter Validation Summary    ${validation_summary}    ${USER}    ${USER_PASSWORD}
#     Route for Review for Validation summary    ${validation_summary}    ${USER}    ${USER_PASSWORD}
#     Reviewed for Validation summary    ${validation_summary}    ${USER}    ${USER_PASSWORD}
#     Approve Validation summary    ${validation_summary}    ${USER}    ${USER_PASSWORD}

# TC-4 Intiate and create Retirement
#     [Documentation]    This keyword is used to initiate and create Retirement
#     ${Retirement_data}    Read TestData From Excel    TC-01    Retirement
#     Login To VLMS Application    ${BASE_URL}    ${USER}    ${USER_PASSWORD}
#     Navigate To Module Tab    System    Create    Retire    Select Retirement
#     Intiate Retirement    ${Retirement_data}    ${USER}    ${USER_PASSWORD}