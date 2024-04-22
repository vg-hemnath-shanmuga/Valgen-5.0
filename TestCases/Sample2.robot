*** Settings ***
Resource    ../Config/super.resource



*** Test Cases ***
Validate User able to create site
    [Tags]    Demo1
    Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    ${Site_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Site
    ${Existing_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    ExistingData
    Menu Navigation_5.0    Configuration    Site
    Create Site    ${Site_Data}


TC_Create Role and Provide Access Control
    [Tags]    Demo1
    Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    ${Role_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Role
    Menu Navigation_5.0    Administration    Role
    Create Role    ${Role_Data}

TC_Create Department
    [Tags]    Demo
    Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    ${Department_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Department
    Menu Navigation_5.0    Administration    Department    
    Create Department    ${Department_Data}     

TC_Create Job Title
    [Tags]    Demo
    Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    ${JobTitle_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Title
    Menu Navigation_5.0    Administration    User    Job Title
    Create Job Title    ${JobTitle_Data}    
    
TC_Create User
    #Login To VLMS Application    ${SYSTEMUSER}    ${SYSTEM_PASSWORD}
    ${User_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    UserData
    Create User or Provide Cross Site Access    ${User_Data}
       


Validate User able to Category creation
    [Tags]    v4
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    ${Category_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Category
    Menu Navigation_5.0    System    Taxonomy    Category    
    Create Category    ${Category_Data}

Validate User able to SubCategory Creation
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    [Tags]    v4
    ${SubCategory_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    SubCategory
    Menu Navigation_5.0    System    Taxonomy    Sub Category    
    Create SubCategory    ${SubCategory_Data}


TC_Create Functional Role
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    ${FunctionalRole_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    FunctionalRole
    Menu Navigation_5.0    System    Workflow    Functional Role    
    Create the Functional roles    ${FunctionalRole_Data}    ${USER}    ${USER_PASSWORD}

Validate User able to Create Reason
    [Documentation]    create a reason
    ${reason_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Reason
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Reason   
    Create Reason     ${reason_data}




TC_Create Groups
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    ${Group_Data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Group
    Menu Navigation_5.0    System    Group    
    Create Group    ${Group_Data}    ${USER}    ${USER_PASSWORD}

TC_Create WorkFlow
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    ${Workflow_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Workflow
    Menu Navigation_5.0    System    Workflow
    Create Workflow    ${Workflow_data}    ${USER}    ${USER_PASSWORD}

Validate User able to create ContentType
    [Documentation]    create a ContentType
    ${content_type_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    ContentType
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Content Type    
    Enter The Details To Create A New Content_Prereuisite    ${content_type_data}    ${USER}    ${USER_PASSWORD}
    

TC_Create Validation Standard
    [Documentation]    create a ContentType
    ${VS_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Validation Standard
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    Assessment    Assessment Setup    Validation Standard
    Create Validation Standard    ${VS_data}    ${USER}    ${USER_PASSWORD}

TC_Create Entitystatus
    [Documentation]    create a ContentType
    ${EntityStatus_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    EntityStatus
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Entity    Entity Status
    Create Entity Status    ${EntityStatus_data}    ${USER}    ${USER_PASSWORD}

TC_Create Form
    [Documentation]    Create Form
    ${form_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Form
    Login To VLMS Application   ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Form    
    Wait Until Time    ${SHORT_WAIT}
    Create Form prerequsite  ${form_data}   ${USER}    ${USER_PASSWORD}

TC_Create Framework
    [Documentation]    Create The Framework
    ${create_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Framework
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Create Validation Framework
    Create Framework_Prerequisite    ${create_data}    ${USER}    ${USER_PASSWORD}

TC_Create Entity Type
    [Documentation]    Create Entity Type And Verify It.
    ${Group_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    EntityType
    Login To VLMS Application     ${USER}    ${USER_PASSWORD}
    Navigate To Create Entity Type
    Create EntityType_Prerequisite    ${Group_data}    ${USER}    ${USER_PASSWORD}

TC_Create Entity
    [Documentation]    Create The Entity
    ${entity_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Entity
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Entity
    Create Entity prerequiste    ${entity_data}    ${USER}    ${USER_PASSWORD}


TC_Create Table With Multiple Rows
    [Documentation]    TC_01 Create Content And Verify The Table
    ${table_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Table
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Mapping    Table
    Enter The Details To Create A New Table    ${table_data}    ${USER}    ${USER_PASSWORD}


Validate User able to create Keyword Mapping
    [Documentation]    create a keyword Mapping
    ${Keyword_Mapping_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    KeywordMapping
    Login To VLMS Application    ${AUTHOR}    ${AUTHOR_PASSWORD}
    Menu Navigation_5.0    System    Mapping    Mapping Keyword    
    Create Keyword Mapping    ${Keyword_Mapping_data}


TC_Author External Document
    [Documentation]    Author External Document 
    ${content_author_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    ExternalDocument
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Author Documnet Externally    ${content_author_data}    ${USER}    ${USER_PASSWORD}

TC_Create Content Library
    [Documentation]    TC_13,14,15 Create Content Library and Approve Content Library
    ${content_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Content Library
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Create Content Library_Prerequisite    ${content_data}    ${USER}    ${USER_PASSWORD}

TC_Create Trace Model
    [Documentation]    Create Trace Model
    ${trace_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    TraceModel
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Create Trace Model and Bind Task    ${trace_data}    ${USER}    ${USER_PASSWORD}

TC_Create Trace Matrix
    [Documentation]    Creating Trace Matrix
    ${record}    Set Variable    False
    ${tracematrix_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    TraceMatrix
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Create Trace Matrix_Prereuisite    ${tracematrix_data}    ${USER}    ${USER_PASSWORD}

TC_Create Template Group
    [Documentation]    TC to create Template Group
    ${tg_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Template Group
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    Content    Template    Template Group
    Create Template Group    ${tg_data}

TC_Create Content Template
    [Documentation]    Create The Template
    ${create_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Template
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Create Template    ${create_data}    ${USER}    ${USER_PASSWORD}

TC_Create Risk Process
    [Documentation]    TC to create Risk Process
    ${riskprocess_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    RiskProcess
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab    Risk    Create    Risk Process    Create Risk Process
    Create Risk Process    ${riskprocess_data}    ${USER}    ${USER_PASSWORD}

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
    ${decision_tree_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    DecisionTree
    Login To VLMS Application   ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Decision Tree
    Wait Until Time    ${SHORT_WAIT}
    Create Decision Tree_Prerequisite    ${decision_tree_data}    ${USER}    ${USER_PASSWORD}

TC_Bind Decision Tree
    [Documentation]    user able to bind decision tree
    ${Bind_decision}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    BindDecisionTree
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Bind    Decision Tree
    Bind_Decision_Tree   ${Bind_decision}    ${USER}    ${USER_PASSWORD}

TC_Create Section
    [Documentation]    TC to create a reason's for the input
    ${section_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Section
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    Assessment    Assessment Setup
    Create the Section    ${section_data}    ${USER}    ${USER_PASSWORD}

TC_Create DM Content ID Configuration
    [Tags]    Prerequisites
    [Documentation]    This keyword is used to create DM Content ID Configuration
    ${DMIDConfig_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    DMIDConfig
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Unique IDs    DM Content ID Configuration
    Create DM ID Configuration    ${DMIDConfig_data}    ${USER}    ${USER_PASSWORD}



TC_Create Spread Template
    [Documentation]    Create Spread Template
    ${SpreadTemplate_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    SpreadTemplate
    Login To VLMS Application   ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Spread Template
    Wait Until Time    ${SHORT_WAIT}
    Create Spread Template    ${SpreadTemplate_data}    ${USER}    ${USER_PASSWORD}


TC_Create Calendar
    [Tags]    Prerequisites
    [Documentation]    Create calender.
    ${calender_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    Calendar
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0    System    Calendar
    Create Calender    ${calender_data}    ${USER}    ${USER_PASSWORD}
 
TC_Create User Point Estimation
    [Tags]    Prerequisites
    [Documentation]    TC_01 Create A User Point Estimation And Verify Success Message
    ${userstoryestimation_data}    Read Multiple TestData From Excel    ${TESTDATA_FOLDER}    UserStoryEstimation
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Menu Navigation_5.0   System    User Story Point Estimation
    Create User Story Estimation    ${userstoryestimation_data}    ${USER}    ${USER_PASSWORD}
 
TC_Create Epic
    [Documentation]    TC_01 Create Content And Verify The Content Type
    ${epic_data}    Read Multiple TestData From Excel    ${PREREQUISITESDATA_FOLDER}    Epic
    Login To VLMS Application    ${USER}    ${USER_PASSWORD}
    Navigate To Module Tab   System    Create    User Story Point Estimation    User Story Point Estimation    True
    Enter The Details To Create And Submit A New Epic   ${epic_data}    ${USER}    ${USER_PASSWORD}

    


