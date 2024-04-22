*** Settings ***
Documentation     This content menu resource file has all the content menu keywords
Resource          ../../Config/super.resource

Library    CustomLibrary

*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Include Additional Entities
    [Arguments]    ${entity_name}    ${bind_as}
    [Documentation]    It is used to include the additional entities in assign document authoring
    Click Element    ${button.content.assign.authoring.additional_entity}
    Wait Until Time    2
    Wait Until Element Is Visible    ${dropdown.content.assign.authoring.additional_entity}    ${MEDIUM_WAIT}    Entity dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${dropdown.content.assign.authoring.additional_entity}    5
    Javascript Input Text    ${textbox.content.assign.authoring.additional_entity}    ${entity_name}
    Wait Until Time    4
    ${dropdown.content.additional_entity.newvalue}    Update Dynamic Value    ${dropdown.content.additional_entity.value}    ${entity_name}
    Javascript Click    ${dropdown.content.additional_entity.newvalue}
    Javascript Click    ${button.save}
    ${updated_entity_name1}    Replace String    ${entity_name}    ${SPACE}\[    **
    ${updated_entity_name2}    Replace String    ${updated_entity_name1}    ]    **
    ${web.label.vlms.content.assign.authoring.new.additional_entity}    Update Dynamic Value    ${label.content.assign.authoring.additional_entity}    ${updated_entity_name2}
    Wait Until Time    1
    Wait Until Element Is Visible    ${web.label.vlms.content.assign.authoring.new.additional_entity}    ${MEDIUM_WAIT}    Added entity is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Value For Radio Button    BindCopy    ${bind_as}

Enable/Disable Decision Tree Action
    [Arguments]    ${option}    ${decision_tree}
    [Documentation]    It is used to enable the decision tree in assign document authoring
    ${button.content.assign.authoring.newdecision_tree}    Update Dynamic Value    ${button.content.assign.authoring.decision_tree}    ${option}
    Scroll Element Into View    ${button.content.assign.authoring.newdecision_tree}
    Click Element    ${button.content.assign.authoring.newdecision_tree}
    IF    '${option}'=='Yes'
        Wait Until Time    1
        Wait Until Element Is Visible    ${dropdown.content.assign.authoring.decision_tree}    ${MEDIUM_WAIT}    Decision tree dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        Select From List By Label    ${dropdown.content.assign.authoring.decision_tree}    ${decision_tree}
    END

Choose Assignee Type
    [Arguments]    ${assignee}    ${dropdown_value}
    [Documentation]    It is used to choose the assignee from assign type radio button
    Select Value For Radio Button    AssignType    rbtn${assignee}
    IF    '${assignee}'!='assignMe'
        Select Value From Dropdown    AssignToGroup-container    ${dropdown_value}
    END

Select Work Flow
    [Arguments]    ${workflow}
    [Documentation]    It is used to select the Work flow from dropdown
    Select Value From Dropdown    WorkFlow    ${workflow}
    Wait Until Element Is Visible    ${label.content.assign.authoring.review_workflow}    ${MEDIUM_WAIT}    Review workflow is not visible after waiting for ${MEDIUM_WAIT} seconds

Add Content Library Using Decision Tree
    [Arguments]    ${message}    ${grid_list}    ${button_name}
    [Documentation]    It is used to Add Content Library Using Decision Tree
    Accept Document And Accept The Popup    ${message}
    Navigate To Page Title Tab    Content Generation
    Click Button In VLMS    Decision Tree
    Select Answers For Questions In Decision Tree    ${grid_list}    ${button_name}

Select Previous/Next Button In Decision Tree
    [Arguments]    ${button_option}
    [Documentation]    It is used to select previuos or next button
    ${button.content.author.doc.decision_tree.newprevious/next}    Update Dynamic Value    ${button.content.author.doc.decision_tree.previous/next}    ${button_option}
    Click Element    ${button.content.author.doc.decision_tree.newprevious/next}

Select Icon From Plugins Tab
    [Arguments]    ${tab}    ${icon}
    [Documentation]    It is used to select option from plugins tab in a document
    Navigate To Page Title Tab    ${tab}
    Navigate To Ribbon Tabs In Document    Plugins
    Select Frame    ${iframe.content.document_frame}
    Select Frame    ${iframe.content.document.frame_editor}
    ${web.img.vlms.content.author.doc.plugins.newoption}    Update Dynamic Value    ${web.img.vlms.content.author.doc.plugins.option}    ${icon}
    Wait Until Time    3
    Wait Until Element Is Visible    ${web.img.vlms.content.author.doc.plugins.newoption}    ${MEDIUM_WAIT}    ${icon} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${web.img.vlms.content.author.doc.plugins.newoption}
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Route Document For Peer Review/Approval
    [Arguments]    ${message}    ${page_title}    ${author_data}
    [Documentation]    It is used to route document for peer review/approval
    Accept Document And Accept The Popup    ${message}
    Navigate To Page Title Tab    ${page_title}
    IF    'DocumentTitle' in ${author_data}    Enter Text In Mandatory Fields    DocumentTitle    ${author_data}[DocumentTitle]
    IF    'Description' in ${author_data}    Enter Text In Mandatory Fields    Description    ${author_data}[Description]
    ${content_type}    Get Text    ${label.assign_doc.default_content_type}
    ${doc_no}    Get Text    ${label.assign_doc.default_doc_no}
    ${entity_name}    Get Text    ${label.assign_doc.default_entity_name}
    ${entity_no}    Get Text    ${label.assign_doc.default_entity_no}
    IF    'CheckIn' in ${author_data}    Select Value For Radio Button    ConfirmReview    ${author_data}[CheckIn]
    IF    'ConfirmRoute' in ${author_data}    Select Checkbox    ${checkbox.content.author.doc.confirm_routing}
    IF    'RouteFor' in ${author_data}    Select Value From Dropdown    Route    ${author_data}[RouteFor]
    IF    '${author_data}[RouteFor]' == 'Peer Review/Collaborative Authoring'
        Select Users For Peer Review    ${author_data}[Users]    ${author_data}[Tenure]
    END
    IF    'TransferTask' in ${author_data}    Select Value For Radio Button    Review    ${author_data}[TransferTask]
    IF    'TransferTo' in ${author_data}    Select Value From Dropdown    Transferto    ${author_data}[TransferTo]
    IF    'TransferTenure' in ${author_data}    Enter Text In Mandatory Fields    TranferTenure    ${author_data}[TransferTenure]
    IF    'Comments' in ${author_data}    Enter Text In Mandatory Fields    Comments    ${author_data}[Comments]
    IF    'Button' in ${author_data}    Select Submit/Reset Button    ${author_data}[Button]
    IF    'RouteFor' in ${author_data}
        ${EXPECTED_SUCCESS_MSG}    Set Variable    ${content_type} document ${doc_no} for ${entity_name} - ${entity_no} has been routed for ${author_data}[RouteFor]
        Set Test Variable    ${EXPECTED_SUCCESS_MSG}
    END

Select Users For Peer Review
    [Arguments]    ${grid_list}    ${tenure_days}
    [Documentation]    It is used to select users for Peer review
    @{list}    Split String    ${grid_list}    |
    FOR    ${key}    IN    @{list}
        Wait Until Element Is Visible    ${textbox.content.author.doc.route.search_user}    ${MEDIUM_WAIT}    Search box is not visible after waiting for ${MEDIUM_WAIT} seconds
        Input Text    ${textbox.content.author.doc.route.search_user}    ${key}
        Wait Until Time    1
        Wait Until Element Is Visible    //td[@dxtext="${key}"]/preceding-sibling::td//span[contains(@id,"lboxRouteTo")]    ${MEDIUM_WAIT}    ${key} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    //td[@dxtext="${key}"]/preceding-sibling::td//span[contains(@id,"lboxRouteTo")]
    END
    Input Text    ${textbox.content.author.doc.route.peer_tenure}    ${tenure_days}

Navigate To Ribbon Tabs In Document
    [Arguments]    ${rib_tab}
    [Documentation]    It is used to navigate to ribbon tab in document
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}
    Wait Until Time    3
    Scroll Down In Document    15
    ${label.content.document.new_rib_tab}    Update Dynamic Value    ${label.content.document.rib_tab}    ${rib_tab}
    Select Frame    ${iframe.content.document_frame}
    Select Frame    ${iframe.content.document.frame_editor}
    Wait Until Element Is Visible    ${label.content.document.new_rib_tab}    ${LONG_WAIT}    ${rib_tab} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.content.document.new_rib_tab}
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Navigate To Left Menu In Document
    [Arguments]    ${left_menu}
    [Documentation]    It is used to navigate to ribbon tab in document
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Wait Until Element Is Visible    ${iframe.content.document_frame}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.content.document_frame}
    Select Frame    ${iframe.content.document.frame_editor}
    ${button.content.document.newleft_menu}    Update Dynamic Value    ${button.content.document.left_menu}    ${left_menu}
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.content.document.newleft_menu}    ${MEDIUM_WAIT}    ${left_menu} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.content.document.newleft_menu}

Select Edit/SaveDraft Button
    [Arguments]    ${button_option}
    [Documentation]    It is used to select submit or reset button
    Wait Until Time    5
    ${button.newedit/save_draft}    Update Dynamic Value    ${button.edit/save_draft}    ${button_option}
    Scroll Element Into View    ${button.newedit/save_draft}
    Click Element    ${button.newedit/save_draft}
    ${status}    Run Keyword And Return Status    Element Should Be Disabled    ${button.newedit/save_draft}
    IF    '${status}'=='False'    Wait Until Time    4

Initiate Authoring Task
    [Arguments]    ${initiate_data}
    [Documentation]    It is used to enter details in Initiate Authoring Task Page
    # robocop: disable=bad-indent
    Wait Until Element Is Visible    ${label.content.assign.document.initiate.authoring_task}    ${MEDIUM_WAIT}    Initiate Authoring Task page is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'AuthoringFor' in ${initiate_data}    Select Value For Radio Button    ExistEnt    ${initiate_data}[AuthoringFor]
    IF    'EntityName' in ${initiate_data}
        Wait Until Time    3
        Input Text    id=txtEntitySystemName    ${initiate_data}[EntityName]
    END
    IF    'TaskType' in ${initiate_data}    Select Value For Radio Button    DocType    ${initiate_data}[TaskType]
    IF    'Entity' in ${initiate_data}
        Click Element    ${label.content.assign.document.initiate.entity_search}
        Input Text    ${label.content.assign.document.initiate.entity_search}    ${initiate_data}[Entity]
        ${label.content.assign.document.initiate.newentity}    Update Dynamic Value    ${label.content.assign.document.initiate.entity}    ${initiate_data}[Entity]
        Wait Until Element Is Visible    ${label.content.assign.document.initiate.newentity}    ${MEDIUM_WAIT}    ${initiate_data}[Entity] message is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${label.content.assign.document.initiate.newentity}
        Wait Until Time    4
    END
    IF    'ContentType' in ${initiate_data}    Select Value From Dropdown    ValidationType    ${initiate_data}[ContentType]
    IF    'IncludeCCR' in ${initiate_data}    Select Value For Radio Button    CCRRequired    ${initiate_data}[IncludeCCR]
    IF    'Assign' in ${initiate_data}    Select Value For Radio Button    AssignDocument    ${initiate_data}[Assign]
    IF    'Comments' in ${initiate_data}    Enter Comments/Description    txtComments    ${initiate_data}[Comments]
    Wait Until Time    3
    IF    'Button' in ${initiate_data}    Select Submit/Reset Button    ${initiate_data}[Button]

Verify Document Is Routed For Peer Review/Review/Approval
    [Arguments]    ${login_user}    ${login_password}    ${message}    ${reason}=None    ${route_for}=None
    [Documentation]    It is used to Verify Document is Routed for Peer Review or Review or Approval
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    Do you want to proceed?    ${SHORT_WAIT}
    IF    '${status}'=='True'    Verify Notification Popup    Document mapping not verified. Do you want to proceed?    btnSubmitConfirm
    Wait Until Time    4
    ${logged_user}    ${date_time}    Handle Electronic Sign    ${login_user}    ${login_password}    Submit    ${reason}
    IF    '${route_for}'=='Approval'
        ${time_zone}    Get Timezone
        Select Frame    ${iframe.framecontent}
        ${APPROVED_DOC_DETAILS}    Create Dictionary
        Set To Dictionary    ${APPROVED_DOC_DETAILS}    Authoring Completed By    ${logged_user}
        ${date_time_zone}    Set Variable    ${date_time} (${time_zone})
        Set To Dictionary    ${APPROVED_DOC_DETAILS}    Authoring Completed On    ${date_time_zone}
        Set Suite Variable    ${APPROVED_DOC_DETAILS}
    END
    Wait Until Element Is Visible    ${label.notification_popup.message}    ${MEDIUM_WAIT}    Message is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_msg}    Get Text    ${label.notification_popup.message}
    Verify String Should Be Equal    ${message}    ${actual_msg}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Wait Until Element Is Visible    ${button.success_alert.ok}    ${MEDIUM_WAIT}    Ok button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.success_alert.ok}

Append Content Library To The Document
    [Arguments]    ${tab}    ${icon}
    [Documentation]    It is used to Append Content Library To The Document
    Select Icon From Plugins Tab    ${tab}    ${icon}

Navigate To Author Document
    [Arguments]    ${document_number}
    [Documentation]    It is used to Navigate To Document
    Navigate To Module Tab    Content    Author    Document    Select Document to Author
    Search And Select The Value From The Section    ${document_number}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}

Navigate To Initiate Authoring Task
    [Documentation]    This keyword will navigate to initiate authoring task page
    Navigate To Module Tab    Content    Assign    Document    Select Authoring Task
    Click Button In VLMS    Initiate

Add Comments In Document
    [Arguments]    ${comment}
    [Documentation]    It is used to Add Comments For Peer Review Document
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.content.assign.authoring.peer_review.add_comment}    ${MEDIUM_WAIT}    Add comments label is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.content.assign.authoring.peer_review.add_comment}
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.content.assign.authoring.peer_review.comment}    ${MEDIUM_WAIT}    Comment textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    Input Text    ${textbox.content.assign.authoring.peer_review.comment}    ${comment}
    Click Element    ${button.content.assign.authoring.peer_review.addcomment}
    Wait Until Element Is Visible    ${label.content.assign.authoring.peer_review.add_comment.add_reply}    ${MEDIUM_WAIT}    Add Reply label is not visible after waiting for ${MEDIUM_WAIT} seconds
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Add Texts In Chatbox
    [Arguments]    ${text_message}
    [Documentation]    Send text in chat while reviewing document
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.content.assign.authoring.peer_review.chat}    ${MEDIUM_WAIT}    Chat textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Input Text    ${textbox.content.assign.authoring.peer_review.chat}    ${text_message}
    Click Element    ${button.content.assign.authoring.peer_review.add_chat}
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.content.assign.authoring.peer_review.add_chat}    ${MEDIUM_WAIT}    Chat is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${expected_message}    Get Text    ${label.content.assign.authoring.peer_review.add_chat}
    Verify String Should Be Equal    ${expected_message}    ${text_message}
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Navigate To Comments And Comment In Document
    [Arguments]    ${comment}
    [Documentation]    Navigate To Comments and Comment In Document
    Navigate To Left Menu In Document    comments
    Add Comments In Document    ${comment}

Navigate To Chat Box And Enter Text
    [Arguments]    ${text_message}
    [Documentation]    Navigate To Chat Box and Enter Text
    Navigate To Left Menu In Document    chat
    Add Texts In Chatbox    ${text_message}

Navigate To Assign Document Authoring
    [Arguments]    ${content_type}=Operational Qualification
    [Documentation]    This keyword will navigate to initiate Assign Document Authoring page
    Navigate To Module Tab    Content    Assign    Document    Select Authoring Task
    Select Task From The Section    Initiated    Task ID    ${content_type}    Initiated

Assign Document Author
    [Arguments]    ${assign_document_data}    ${username}    ${password}
    [Documentation]    This Keyword Will Assign document to author
    ${DOC_NO}    Enter Details In Assign Document Authoring    ${assign_document_data}
    Enter Details In Reviewer WorkFlow    ${assign_document_data}
    Enter Details In Approval WorkFlow    ${assign_document_data}
    Verify Added Approval Details    ${assign_document_data}
    IF    'Approvers' in ${assign_document_data}    Verify Deleted Approver    ${assign_document_data}[Approvers]
    ${AUTHOR_DOC_APPROVER}    Get Element Attribute    ${dropdown.content.assign.document.approver_wf.selected_approver}    Value
    Set Suite Variable    ${AUTHOR_DOC_APPROVER}
    Select Submit/Reset Button    Submit
    Handle Electronic Sign    ${username}    ${password}    Submit
    Set Suite Variable    ${DOC_NO}

Verify Entity Is Selected
    [Arguments]    ${entity}
    [Documentation]    Verify Entity is selected in initiate task page
    ${label.content.assign.document.initiate.newselected_entity}    Update Dynamic Value    ${label.content.assign.document.initiate.selected_entity}    ${entity}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.assign.document.initiate.newselected_entity}    ${MEDIUM_WAIT}    Selected Entity is not visible after waiting for ${MEDIUM_WAIT}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Content Function Is Pre-populated
    [Documentation]    Verify Content Function Is Pre-populated
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.assign.document.initiate.content_function}    ${MEDIUM_WAIT}    Content Function is not visible after waiting for ${MEDIUM_WAIT}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Success Message In Document Tab
    [Arguments]    ${message}    ${button_option}
    [Documentation]    Verify Success Message Message In Document Tab
    Select Frame    ${iframe.content.document_frame}
    Verify Notification Popup    ${message}    ${button_option}
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Verify Delivery Type In Content Library Tab
    [Arguments]    ${row}    ${delivery_type}
    [Documentation]    Verify Delivery Type In Content Library Tab
    Run Keyword And Continue On Failure    Scroll Till Element Is Visible    ${label.content_library.table.delivery_type_header}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content_library.table.delivery_type_header}    ${MEDIUM_WAIT}    Deliverable Type is not visible after waiting for ${MEDIUM_WAIT}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Table Cell Should Contain    ${label.content_library.table}    ${row}    8    ${delivery_type}

Verify Filter Option In Content Library Frame Screen
    [Arguments]    ${column}    ${index}    ${input_text}
    [Documentation]    This Keyword Will Click View Icon and Verify Filtered Data In View Details Is Visible
    ${textbox.lbframe_screen.newfilter_box}    Update Dynamic Values    ${textbox.lbframe_screen.filter_box}    ${column}    ${index}
    Wait Until Time    1
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${textbox.lbframe_screen.newfilter_box}    ${MEDIUM_WAIT}
    Input Text    ${textbox.lbframe_screen.newfilter_box}    ${input_text}
    ${label.lbframe_screen.filter.newcontent}    Update Dynamic Value    ${label.lbframe_screen.filter.content}    ${input_text}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.lbframe_screen.filter.newcontent}    ${MEDIUM_WAIT}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Content Library Has Been Saved
    [Arguments]    ${message}    ${button_option}
    [Documentation]    It is used to Verify Content Library Has Been Saved by notification
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    ${message}    ${MEDIUM_WAIT}
    IF    '${status}'=='True'
        Log    ${message} Message is Displayed
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END
    ${button.content_library.saved.notification.newok}    Update Dynamic Value    ${button.content_library.saved.notification.ok}    ${button_option}
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.content_library.saved.notification.newok}    ${MEDIUM_WAIT}    ${button_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.content_library.saved.notification.newok}
    Click Navigation Buttons In Screen    Close

Generate Content Library
    [Documentation]    This keyword will generate content library
    Wait Until Time    4
    Click Button In VLMS    Generate
    Wait Till Loading Icon Is Invisible    ${label.status_popup}

Navigate To Page Tab And Click Additional Information
    [Arguments]    ${message}    ${page_tab}    ${tab_name}
    [Documentation]    Navigate To Author Document And Click Tab In Additional Information
    Accept Document And Accept The Popup    ${message}
    Navigate To Page Title Tab    ${page_tab}
    Wait Until Time    5
    Select The Section    Additional Information
    Wait Until Time    3
    Navigate To Page Title Tab    ${tab_name}

Verify Content Library Is Highlighted In Green Colour
    [Arguments]    ${row}
    [Documentation]    This keyword is used to Verify Content Library Is Highlighted In Green Colour
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content_library.table.delivery_type_header}    ${MEDIUM_WAIT}    Deliverable Type is not visible after waiting for ${MEDIUM_WAIT}
    FOR    ${index}    IN    1    8
        Run Keyword And Continue On Failure    Element Should Be Visible    //table//tr[${row}]//td[${index}]//span[contains(@style,"Green")]
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Get Decision Tree Content Deliverables
    [Documentation]    This keyword is used to Get Decision Tree Content Deliverables
    Navigate To Page Title Tab    Content Generation
    @{DELIVERABLES_LIST}    Create List
    Wait Until Element Is Visible    ${label.content.author.document.content_generation.deliver_type.decision_tree}    ${MEDIUM_WAIT}    Decision Tree deliverable type is not visible after waiting for ${MEDIUM_WAIT}
    ${count}    Get Element Count    ${label.content.author.document.content_generation.deliver_type.decision_tree}
    FOR    ${index}    IN RANGE    1    ${count}+1
        ${content_type}    Get Text    (${label.content.author.document.content_generation.content_lib_type})[${index}]
        ${content_lib}    Get Text    (${label.content.author.document.content_generation.content_library})[${index}]
        ${deliverable}    Set Variable    ${content_type} Content Library : ${SPACE}${SPACE}1. ${content_lib}
        Append To List    ${DELIVERABLES_LIST}    ${deliverable}
    END
    Set Test Variable    @{DELIVERABLES_LIST}

Verify View Decision Tree Screen
    [Arguments]    ${author_data}
    [Documentation]    This keyword is used to Verify View Decision Tree Screen with content library for each answer and Deliverables
    Wait Until Element Is Visible    ${button.content_generation.process_flow_diagram}    ${MEDIUM_WAIT}    Process Flow Diagram button is not visible after waiting for ${MEDIUM_WAIT}
    Javascript Click    ${button.content_generation.process_flow_diagram}
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT}
    Select Frame    ${iframe.library_frame.screen}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content_generation.process_flow_diagram.view_decision_tree}    ${MEDIUM_WAIT}    View Decision Tree screen is not visible after waiting for ${MEDIUM_WAIT}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${img.content_generation.process_flow.decision_tree_diagram}    ${MEDIUM_WAIT}    Decision Tree diagram is not visible after waiting for ${MEDIUM_WAIT}
    IF    'DiagramView' in ${author_data}    Select Value From Dropdown    DecistionTree_ddlDiagramView    ${author_data}[DiagramView]
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.author.document.process_flow_diagram.decision_tree.deliverables}    ${SHORT_WAIT}    Deliverables is not visible after waiting for ${MEDIUM_WAIT}
    Run Keyword And Continue On Failure    Scroll To Element    ${label.content.author.document.process_flow_diagram.decision_tree.deliverables}
    ${decision_deliverables}    Get Element Attribute    ${label.content.author.document.process_flow_diagram.decision_tree.deliverables}    title
    FOR    ${key}    IN    @{DELIVERABLES_LIST}
        IF   '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        Run Keyword And Continue On Failure    Should Contain    ${decision_deliverables}    ${key}    None    True    ignore_case=True    strip_spaces=False    collapse_spaces=True
    END
    @{list}    Split String    ${author_data}[Answers]    |
    Wait Until Time    3
    ${q1_ans}    Get Element Attribute    ${label.content.author.document.process_flow_diagram.decision_tree.q1_answer}    title
    IF   '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Contain    ${q1_ans}    ${list}[0]
    ${q2_ans}    Get Element Attribute    ${label.content.author.document.process_flow_diagram.decision_tree.q2_answer}    title
    Run Keyword And Continue On Failure    Should Contain    ${q2_ans}    ${list}[1]
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.author.document.process_flow_diagram.decision_tree_details_table}    ${MEDIUM_WAIT}    Decision Tree Details table is not visible after waiting for ${MEDIUM_WAIT} Seconds
    Run Keyword And Continue On Failure    Scroll Till Element Is Visible    ${label.content.author.document.process_flow_diagram.decision_tree_details_table}
    Run Keyword And Continue On Failure    Click Element    ${label.content.author.document.process_flow_diagram.decision_tree_details_table}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Unselect Frame
    Click Navigation Buttons In Screen    Close

Navigate To Review Document And Edit The Document
    [Arguments]    ${document_number}
    [Documentation]    It is used to Navigate To Review Document and Edit the document
    Navigate To Module Tab    Content    Review    Document    Review Document
    Search And Select The Value From The Section    ${document_number}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.document.edit}
    IF    '${status}'=='True'
        Click Button In VLMS    Edit
        Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
        Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}
    END
    Wait Until Time    3
    Scroll Down In Document    30
    Edit Document In Vlms    Review It
    Click Button In VLMS    Save Draft
    Verify Notification Popup    Document Saved    btnMessageOk

Peer Review/Review The Document
    [Arguments]    ${tab}    ${peer_review_data}    ${document}=Label
    [Documentation]    It is used to Peer Review/Review The Document
    Navigate To Page Title Tab    ${tab}
    IF    'CheckIn' in ${peer_review_data}    Select Value For Radio Button    ConfirmReview    ${peer_review_data}[CheckIn]
    IF    'Transfer' in ${peer_review_data}    Select Value For Radio Button    rbtntransfer    ${peer_review_data}[Transfer]
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.assign_doc.default_content_type}
    ${content_type}    Get Text    ${label.assign_doc.default_content_type}
    IF    '${document}'=='Label'
        Wait Until Element Is Visible    ${label.assign_doc.default_doc_no}
        ${doc_no}    Get Text    ${label.assign_doc.default_doc_no}
    END
    IF    '${document}'=='Link'
        Wait Until Element Is Visible    ${label.assign_doc.test.default_doc_no}
        ${doc_no}    Get Text    ${label.assign_doc.test.default_doc_no}
    END
    Wait Until Element Is Visible    ${label.assign_doc.default_entity_name}
    ${entity_name}    Get Text    ${label.assign_doc.default_entity_name}
    Wait Until Element Is Visible    ${label.assign_doc.default_entity_no}    ${MEDIUM_WAIT}    Entity no is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${entity_no}    Get Text    ${label.assign_doc.default_entity_no}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.assign_doc.default_exe_no}
    IF    'Reviewed' in ${peer_review_data} and '${status}'=='True'
        ${exe_no}    Get Text    ${label.assign_doc.default_exe_no}
        ${EXP_SUCCESS_MSG}    Set Variable    ${content_type} Execution ${exe_no} for ${entity_name} - ${entity_no} has been Reviewed
        Set Test Variable    ${EXP_SUCCESS_MSG}
    END
    IF    'TransferTo' in ${peer_review_data}    Select Value From Dropdown    Transferto    ${peer_review_data}[TransferTo]
    IF    'Reviewed' in ${peer_review_data}    Select Checkbox    ${checkbox.content.assign.authoring.peer_review_completed}
    IF    'Comments' in ${peer_review_data}    Enter Text In Mandatory Fields    Comments    ${peer_review_data}[Comments]
    IF    'Button' in ${peer_review_data}    Select Submit/Reset Button    ${peer_review_data}[Button]
    IF    'Reviewed' in ${peer_review_data} and '${status}'=='False'
        ${EXP_SUCCESS_MSG}    Set Variable    ${content_type} document ${doc_no} for ${entity_name} - ${entity_no} has been Reviewed
        Set Test Variable    ${EXP_SUCCESS_MSG}
    END

Verify Document Is Reviewed
    [Arguments]    ${login_user}    ${login_password}    ${message}
    [Documentation]    It is used to Verify Document is Reviewed
    Handle Electronic Sign    ${login_user}    ${login_password}    Submit
    Wait Until Element Is Visible    ${label.notification_popup.message}    ${MEDIUM_WAIT}    Message is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_msg}    Get Text    ${label.notification_popup.message}
    Verify String Should Contain    ${actual_msg}    ${message}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Wait Until Element Is Visible    ${button.success_alert.ok}    ${MEDIUM_WAIT}    Ok button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.success_alert.ok}

Click Add Approval Button
    [Documentation]    It is uaed to click on add approval button in assign document authoring page
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.content.assign.document.add_approver}    ${MEDIUM_WAIT}    Add button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Button    ${button.content.assign.document.add_approver}

Select Approver/Reviewer
    [Arguments]    ${group_name}    ${approver}
    [Documentation]    It is used to select Approver in Approver WorkFlow and Reviewer in Reviewer Workflow
    Wait Until Time    ${SHORT_WAIT}
    Javascript Click    ${dropdown.content.assign.document.approver}
    ${label.content.assign.document.approver.newgroup_plus}    Update Dynamic Value    ${label.content.assign.document.approver.group_plus}    ${group_name}
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.content.assign.document.approver.newgroup_plus}    ${MEDIUM_WAIT}    Group plus label is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.content.assign.document.approver.newgroup_plus}
    ${checkbox.content.assign.document.newapprover}    Update Dynamic Value    ${checkbox.content.assign.document.approver}    ${approver}
    Wait Until Time    2
    Wait Until Element Is Visible    ${checkbox.content.assign.document.newapprover}    ${MEDIUM_WAIT}    ${approver} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Checkbox    ${checkbox.content.assign.document.newapprover}
    Click Element    ${button.content.assign.document.approver.save}

Enter Details In Approval WorkFlow
    [Arguments]    ${assign_document_data}
    [Documentation]    It is used to enter approval details in Approval workFlow
    IF    'Approvers' in ${assign_document_data}
        Click Add Approval Button
        Select Approver/Reviewer    ${assign_document_data}[ApproverGroupName]    ${assign_document_data}[Approvers]
    END
    IF    'FunctionalRole' in ${assign_document_data}    Select Value From Dropdown    select2-vgw_grvApprove_ctl03_ddlF    ${assign_document_data}[FunctionalRole]
    IF    'ApprovalPeriod' in ${assign_document_data}    Input Text    ${textbox.content.assign.document.approver.approval_period}    ${assign_document_data}[ApprovalPeriod]
    IF    'AlertFrequency' in ${assign_document_data}    Input Text    ${textbox.content.assign.document.approver.alert_frequency}    ${assign_document_data}[AlertFrequency]
    IF    'ApproverSerialorParallel1' in ${assign_document_data}    Select Value From Dropdown    select2-vgw_grvApprove_ctl03_ddlS    ${assign_document_data}[ApproverSerialorParallel1]
    IF    'Approvers' in ${assign_document_data}    Click Add Approval Button

Enter Details In Reviewer WorkFlow
    [Arguments]    ${assign_document_data}
    [Documentation]    It is used to enter reviewer details in Reviewer WorkFlow
    IF    'AddReviewers' in ${assign_document_data}
        Wait Until Time    3
        Wait Until Element Is Visible    ${button.content.assign.document.add_reviewer}    ${MEDIUM_WAIT}    Add Reviewer button is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${button.content.assign.document.add_reviewer}
        Select Approver/Reviewer    ${assign_document_data}[ReviewerGroupName]    ${assign_document_data}[AddReviewers]
    END
    IF    'ReviewerFunctionalRole' in ${assign_document_data}    Select Value From Dropdown    select2-vgw_grvReview_ctl04_ddlFunctionalRole    ${assign_document_data}[ReviewerFunctionalRole]
    IF    'ReviewPeriod' in ${assign_document_data}    Input Text    ${textbox.content.assign.document.reviewer.review_period}    ${assign_document_data}[ReviewPeriod]
    IF    'ReviewerAlertFrequency' in ${assign_document_data}    Input Text    ${textbox.content.assign.document.reviewer.alert_frequency}    ${assign_document_data}[ReviewerAlertFrequency]
    IF    'ReviewerSerialorParallel1' in ${assign_document_data}    Select Value From Dropdown    select2-vgw_grvReview_ctl04_ddlSerial    ${assign_document_data}[ReviewerSerialorParallel1]

Verify Added Approval Details
    [Arguments]    ${assign_document_data}
    [Documentation]    It is used to Verify added approver details in approval work flow for assign document authoring
    IF    'Approvers' in ${assign_document_data}
        Wait Until Time    ${SHORT_WAIT}
        Wait Until Element Is Visible    ${label.content.assign.document.approver.add.approver}    ${MEDIUM_WAIT}    Approver is not visible after waiting for ${MEDIUM_WAIT} seconds
        ${actual_approver}    Get Text    ${label.content.assign.document.approver.add.approver}
        Verify String Should Contain    ${actual_approver}    ${assign_document_data}[Approvers]
    END
    IF    'FunctionalRole' in ${assign_document_data}
        Wait Until Element Is Visible    ${label.content.assign.document.approver.add.alert_frequency}    ${MEDIUM_WAIT}    Functional functional_role label is not visible after waiting for ${MEDIUM_WAIT} seconds
        ${actual_functional_role}    Get Text    ${label.content.assign.document.approver.add.functional_role}
        Verify String Should Contain    ${actual_functional_role}    ${assign_document_data}[FunctionalRole]
    END
    IF    'ApprovalPeriod' in ${assign_document_data}
        ${actual_approval_period}    Get Text    ${label.content.assign.document.approver.add.alert_frequency}
        Verify String Should Contain    ${actual_approval_period}    ${assign_document_data}[ApprovalPeriod]
    END
    IF    'AlertFrequency' in ${assign_document_data}
        Wait Until Element Is Visible    ${label.content.assign.document.approver.add.alert_frequency}    ${MEDIUM_WAIT}    Alert frequency label is not visible after waiting for ${MEDIUM_WAIT} seconds
        ${actual_alert_frequency}    Get Text    ${label.content.assign.document.approver.add.alert_frequency}
        Verify String Should Contain    ${actual_alert_frequency}    ${assign_document_data}[AlertFrequency]
    END
    IF    'ApproverSerialorParallel1' in ${assign_document_data}
        ${actual_review}    Get Text    ${label.content.assign.document.approver.add.serial/parallel}
        Verify String Should Contain    ${actual_review}    ${assign_document_data}[ApproverSerialorParallel1]
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Deleted Approver
    [Arguments]    ${approver}
    [Documentation]    It is used to Verify deleted approval under Approval WorkFlow in assign document authoring page
    Wait Until Time    2
    Delete Approver    2
    Wait Until Time    4
    Delete Approver    2
    ${label.content.assign.document.approver.delete.newapprover}    Update Dynamic Value    ${label.content.assign.document.approver.delete.approver}    ${approver}
    ${approver_status}    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${label.content.assign.document.approver.delete.newapprover}    ${SHORT_WAIT}    ${approver} is visble after waiting for ${SHORT_WAIT} seconds
    IF    '${approver_status}'=='True'
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Delete Approver
    [Arguments]    ${index}
    [Documentation]    It is used to delete Approver under Aprroval workflow in assign document authoirng page
    Wait Until Element Is Clickable And Click    (${button.content.assign.document.delete})[${index}]    14

Navigate To Document From My Task List
    [Arguments]    ${doc_id}
    [Documentation]    Is is used to navigate to the document from My Task list
    Click Top Menu Icons    Home
    Navigate To Dashboard Title Tabs    Task List    My Task
    Click Document Id From My Task    ${doc_id}

Navigate To Document Page Title
    [Arguments]    ${doc_id}    ${message}    ${page_title}
    [Documentation]    Is it used to navigate to the Author Document page
    Navigate To Document From My Task List    ${doc_id}
    Accept Document And Accept The Popup    ${message}
    Navigate To Page Title Tab    ${page_title}

Navigate To Approve Document
    [Arguments]    ${doc_id}    ${message}    ${page_tab}
    [Documentation]    It is used to navigate to Approve Document page
    Navigate To Document From My Task List    ${doc_id}
    Accept Document And Accept The Popup    ${message}
    Navigate To Page Title Tab    ${page_tab}

Navigate To Trace Matrix In Document
    [Arguments]    ${page_title}
    [Documentation]    It is used to Navigate To Trace Matrix In Document Window
    Navigate To Page Title Tab    ${page_title}
    Wait Until Time    ${SHORT_WAIT}
    Click Button In VLMS    Trace Matrix
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    Do you want to Continue?    ${SHORT_WAIT}
    IF    '${status}'=='True'    Verify Notification Popup    Do you want to Continue?    btncnfrmOk
    Wait Until Time    3
    Wait Till Loading Icon Is Invisible    ${label.content.author.document.trace_matrix}    ${MEDIUM_WAIT}
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.view_icon.view_details.frame}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.view_icon.view_details.frame}

Verify Spread View Tab Is Displayed In Trace Matrix
    [Documentation]    It is used to Verify Spread View Tab Is Displayed In Trace Matrix
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.author.document.trace_matrix.spread_view}    ${LONG_WAIT}    Spread view label is not visible after waiting for ${LONG_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Trace Between Authoring Document And Selected Document
    [Arguments]    ${frs_doc}    ${current_doc}    ${author_data}
    [Documentation]    It is used to Verify Trace Between Authoring Document And Selected Document
    Wait Until Element Is Not Visible    ${label.content.author.document.trace_matrix}    ${MEDIUM_WAIT}    Trace Matrix is visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    2
    Expand Document Under Spread View Tab    grvYDocument    ${frs_doc}
    Expand Document Under Spread View Tab    grvXDocument    ${current_doc}
    @{ref_list}    Split String    ${author_data}[TraceReferences]    |
    FOR    ${key}    IN    @{ref_list}
        @{list}    Split String    ${key}    =
        ${row_no}    Set Variable    ${list}[0]
        ${ref_no}    Set Variable    ${list}[1]
        ${label.content.author.document.trace_matrix.spread_view.newref_no}    Update Dynamic Values    ${label.content.author.document.trace_matrix.spread_view.ref_no}    ${row_no}    ${ref_no}
        Wait Until Time    1
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.author.document.trace_matrix.spread_view.newref_no}    ${MEDIUM_WAIT}    ${ref_no} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Run Keyword And Continue On Failure    Scroll Element Into View    ${label.content.author.document.trace_matrix.spread_view.newref_no}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Expand Document Under Spread View Tab
    [Arguments]    ${table_id}    ${doc_id}
    [Documentation]    It is used to Expand Document Under Spread View Tab
    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}    Update Dynamic Value    ${icon.create_tracematrix.traceview.spreadview_tab.doc.expand}    ${doc_id}
    ${label.content.author.document.trace_matrix.spread_view.newpage_count}    Update Dynamic Value    ${label.content.author.document.trace_matrix.spread_view.page_count}    ${table_id}
    ${table_page_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.content.author.document.trace_matrix.spread_view.newpage_count}    ${SHORT_WAIT}
    IF    '${table_page_status}'=='True'
        ${table_page_count}    Get Element Count    ${label.content.author.document.trace_matrix.spread_view.newpage_count}
        FOR    ${key}    IN RANGE    1    ${table_page_count}
            ${index}    Evaluate    ${key}+1
            ${index}    Convert To String    ${index}
            ${doc_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}    ${SHORT_WAIT}
            IF    '${doc_status}'=='True'
                Scroll Till Element Is Visible    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}
                Click Element    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}
                Wait Till Loading Icon Is Invisible    ${label.content.author.document.trace_matrix}
                BREAK
            ELSE
                ${label.content.author.document.trace_matrix.spread_view.table.newpage_no}    Update Dynamic Values    ${label.content.author.document.trace_matrix.spread_view.table.page_no}    ${table_id}    ${index}
                Click Element    ${label.content.author.document.trace_matrix.spread_view.table.newpage_no}
                Wait Till Loading Icon Is Invisible    ${label.content.author.document.trace_matrix}
            END
        END
        Wait Until Element Is Visible    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}    ${SHORT_WAIT}    ${doc_id} is not visible after waiting for ${MEDIUM_WAIT} seconds
    ELSE IF    '${table_page_status}'=='False'
        Wait Until Time    3
        Wait Until Element Is Visible    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}    ${SHORT_WAIT}    ${doc_id} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Scroll Till Element Is Visible    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}
        Click Element    ${icon.create_tracematrix.traceview.spreadview_tab.doc.newexpand}
        Wait Till Loading Icon Is Invisible    ${label.content.author.document.trace_matrix}
    END

Navigate To Testing Coverage
    [Documentation]    It is used to navigate to "View of Testing Coverage" in trace matrix
    Scroll Till Element Is Visible    ${button.content.author.document.trace_matrix.uncovered_test_cases}
    Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases}

Enter Details In Uncovered Test Cases
    [Arguments]    ${author_document_details}
    [Documentation]    It is used to enter details in uncovered test cases in trace matrix
    Wait Until Time    2
    Wait Until Element Is Visible    ${dropdown.content.aythor.document.trace_matrix.test_cases.document_status}    ${MEDIUM_WAIT}
    Select From List By Label    ${dropdown.content.aythor.document.trace_matrix.test_cases.document_status}    ${author_document_details}[DocumentStatus]
    Select Value From Dropdown    TypeOfCoverage    ${author_document_details}[TypeOfCoverage]
    Select Value From Dropdown    YDocument    ${author_document_details}[Y-AxisDocument]

Verify Uncovered Test Cases From Trace Matrix
    [Arguments]    ${document_id}    ${uncovered_tc_list}
    [Documentation]    It is used to Verify uncovered test cases in trace matrix
    ${label.content.author.document.trace_matrix.test_cases.newexcel_part}    Update Dynamic Value    ${label.content.author.document.trace_matrix.test_cases.excel_part}    ${document_id}
    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.author.document.trace_matrix.test_cases.newexcel_part}    ${MEDIUM_WAIT}    ${document_id} is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{table_list}    Split String    ${uncovered_tc_list}    |
    FOR    ${key}    IN    @{table_list}
        @{list}    Split String    ${key}    =
        ${table_no}    Set Variable    ${list}[0]
        ${require_list}    Set Variable    ${list}[1]
        @{uncovered_req_list}    Split String    ${require_list}    ,
        ${label.content.author.document.uncovered_tcs.newtable_no}    Update Dynamic Value    ${label.content.author.document.uncovered_tcs.table_no}    ${table_no}
        Wait Until Element Is Visible    ${label.content.author.document.uncovered_tcs.newtable_no}    ${MEDIUM_WAIT}    ${table_no} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Time    2
        Scroll Element Into View    ${label.content.author.document.uncovered_tcs.newtable_no}
        Click Element    ${label.content.author.document.uncovered_tcs.newtable_no}
        Wait Until Time    2
        FOR    ${key}    IN    @{uncovered_req_list}
            ${label.content.author.document.uncovered_tcs.newtable.req}    Update Dynamic Value    ${label.content.author.document.uncovered_tcs.table.req}    ${key}
            Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.author.document.uncovered_tcs.newtable.req}    ${SHORT_WAIT}    ${key} is not visible after waiting for ${SHORT_WAIT} seconds
            Run Keyword And Continue On Failure    Scroll Element Into View    ${label.content.author.document.uncovered_tcs.newtable.req}
        END
    END
    Unselect Frame
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}
    Select Frame    ${iframe.framecontent}

Accept Document And Accept The Popup
    [Arguments]    ${message}
    [Documentation]    This keyword will accept the document and handle success popup
    ${status}    Click Accept Button And Accept The Popup    ${message}
    IF    '${status}'=='True'
        Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
        Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}
    END

Approve Document
    [Arguments]    ${author_document_data}    ${username}    ${password}    ${approved_data}=None
    [Documentation]    Approve the document
    IF    'ConfirmRoute' in ${author_document_data}    Select Value For Radio Button    Approves?    ${author_document_data}[ConfirmRoute]
    IF    'Comments' in ${author_document_data}    Enter Comments/Description    txtComments    ${author_document_data}[Comments]
    ${content_type}    Get Text    ${label.assign_doc.default_content_type}
    ${doc_no}    Get Text    ${label.assign_doc.default_doc_no}
    IF    '${approved_data}'=='GetDetails'
        Set To Dictionary    ${APPROVED_DOC_DETAILS}    Doc No    ${doc_no}
        ${doc_title}    Get Text    ${label.content.document.doc_title}
        Set To Dictionary    ${APPROVED_DOC_DETAILS}    Document Title    ${doc_title}
        ${description}    Get Text    ${label.content.document.description}
        Set To Dictionary    ${APPROVED_DOC_DETAILS}    Description    ${description}
    END
    ${entity_name}    Get Text    ${label.assign_doc.default_entity_name}
    ${entity_no}    Get Text    ${label.assign_doc.default_entity_no}
    IF    'Button' in ${author_document_data}    Select Submit/Reset Button    ${author_document_data}[Button]
    ${logged_user}    ${date_time}    Handle Electronic Sign    ${username}    ${password}    ${author_document_data}[Button]
    IF    '${approved_data}'=='GetDetails'
        ${time_zone}    Get Timezone
        Select Frame    ${iframe.framecontent}
        ${date_time_zone}    Set Variable    ${date_time} (${time_zone})
        Set To Dictionary    ${APPROVED_DOC_DETAILS}    Approved By    ${logged_user}
        Set To Dictionary    ${APPROVED_DOC_DETAILS}    Approved On    ${date_time_zone}
    END
    Wait Until Element Is Visible    ${label.notification_popup.message}    ${MEDIUM_WAIT}    Message is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_msg}    Get Text    ${label.notification_popup.message}
    IF    '${author_document_data}[ConfirmRoute]'=='rdoApprovalYes'
        ${expected_message}    Set Variable    ${content_type} document ${doc_no} for ${entity_name} - ${entity_no} has been Approved
        Verify String Should Be Equal    ${actual_msg}    ${expected_message}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Create Multiple Tasks And Verify Success Message
    # robocop: disable=unused-variable
    [Arguments]    ${count}    ${initiate_data}
    [Documentation]    This keyword will Create One or Multiple Tasks For Existing Entity and Verify success message
    FOR    ${key}    IN RANGE    0    ${count}
        Initiate Authoring Task    ${initiate_data}
        Verify Success Message    ${initiate_data}[Message]    btnMessageOk
    END

Verify Column Values Are Sorted In Entity Details Table
    [Arguments]    ${column}
    [Documentation]    Verify All Column Values Are Sorted out In Entity view Details Page
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${count}    Get Element Count    ${label.view_icon.table.row}
    Wait Until Time    4
    @{list}    Create List
    FOR    ${index}    IN RANGE    1    ${count}+1
        ${value}    Get Text    (${label.view_icon.table.row})[${index}]//td[${column}]
        Append To List    ${list}    ${value}
    END
    ${actual_list}    Copy List    ${list}
    Sort List    ${list}
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${list}    ${actual_list}
    # Log Actual And Expected Results    ${actual_list} list is sorted    ${list} list should be sorted

Delete Selected Task
    [Documentation]    This Keyword will select Task from initiated section and Delete it.
    Select The Section    Initiated
    Wait Until Time    2
    Wait Until Element Is Visible    ${dropdown.content.assign.document.initiated.task_id}    ${MEDIUM_WAIT}    Task id dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${dropdown.content.assign.document.initiated.task_id}
    Wait Until Time    2
    Wait Until Element Is Visible    ${checkbox.content.author.doc.initiated.tasks}    ${MEDIUM_WAIT}
    Click Element    ${checkbox.content.author.doc.initiated.tasks}
    Click Element    ${icon.initiated.tasks.del}
    Enter Comments/Description    val1_txtReason    Remove
    Select Submit/Reset Button    TermYes

Select Document From WIP Documents
    [Arguments]    ${document_number}
    [Documentation]    It is used to Select Document From WIP Documents
    Navigate To Module Tab    Content    Edit    Document    Document to Edit
    Select The Section    WIP Documents
    Search And Select The Document    ${document_number}

Search And Select The Document
    [Arguments]    ${document_number}
    [Documentation]    It is used to Search And Select The Document and select it from the section
    Search And Select The Value From The Section    ${document_number}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}

Select Approvers/Reviewers From Group
    [Arguments]    ${workflow_table}    ${grid_list}
    [Documentation]    Select Approvers/Reviewers From Group in WorkFlow
    ${dropdown.content.edit_doc.workflow_table.newgroup}    Update Dynamic Value    ${dropdown.content.edit_doc.workflow_table.group}    ${workflow_table}
    Wait Until Time    2
    Wait Until Element Is Visible    ${dropdown.content.edit_doc.workflow_table.newgroup}    ${MEDIUM_WAIT}    ${workflow_table} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Scroll Element Into View    ${dropdown.content.edit_doc.workflow_table.newgroup}
    Click Element    ${dropdown.content.edit_doc.workflow_table.newgroup}
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.content.document.workflow.group_plus}    ${MEDIUM_WAIT}    Group plus icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.content.document.workflow.group_plus}
    Wait Until Time    2
    Wait Until Element Is Visible    ${checkbox.content.edit_doc.group_header}    ${MEDIUM_WAIT}    Group checkbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${checkbox.content.edit_doc.group_header}
    Select Users From Group    ${grid_list}
    Click Element    ${button.content.assign.document.approver.save}

Select Users From Group
    [Arguments]    ${grid_list}
    [Documentation]    It is used to select users from Group
    @{list}    Split String    ${grid_list}    |
    FOR    ${key}    IN    @{list}
        ${checkbox.content.edit_doc.group.newuser}    Update Dynamic Value    ${checkbox.content.edit_doc.group.user}    ${key}
        Wait Until Time    1
        Wait Until Element Is Visible    ${checkbox.content.edit_doc.group.newuser}    ${MEDIUM_WAIT}    ${key} is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${checkbox.content.edit_doc.group.newuser}
    END

Route Back To Author
    [Arguments]    ${peer_review_data}
    [Documentation]    It is used to Route Back To Author
    IF    'Reviewers' in ${peer_review_data}    Select Approvers/Reviewers From Group    ReviewTable    ${peer_review_data}[Reviewers]
    IF    'RouteBack' in ${peer_review_data}    Select Value For Radio Button    Route    ${peer_review_data}[RouteBack]
    IF    'Comments' in ${peer_review_data}    Enter Text In Mandatory Fields    Comments    ${peer_review_data}[Comments]
    ${content_type}    Get Text    ${label.assign_doc.default_content_type}
    ${doc_no}    Get Text    ${label.assign_doc.default_doc_no}
    ${entity_name}    Get Text    ${label.assign_doc.default_entity_name}
    ${entity_no}    Get Text    ${label.assign_doc.default_entity_no}
    IF    'Button' in ${peer_review_data}    Select Submit/Reset Button    ${peer_review_data}[Button]
    IF    '${peer_review_data}[RouteBack]'=='rbtnYes'
        ${EXP_SUCCESS_MSG}    Set Variable    ${content_type} document authoring task ${doc_no} for ${entity_name} - ${entity_no} has been edited
        Set Test Variable    ${EXP_SUCCESS_MSG}
    END

Verify Document Is Edited
    [Arguments]    ${user_name}    ${user_password}    ${message}
    [Documentation]    It is used to Verify Document is Edited
    Handle Electronic Sign    ${user_name}    ${user_password}    Submit
    Wait Until Element Is Visible    ${label.notification_popup.message}    ${MEDIUM_WAIT}    Message is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_msg}    Get Text    ${label.notification_popup.message}
    Verify String Should Be Equal    ${actual_msg}    ${message}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Wait Until Time    3
    Wait Until Element Is Visible    ${button.success_alert.ok}    ${MEDIUM_WAIT}    Ok button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.success_alert.ok}

Verify Document Screen Is Opened
    [Arguments]    ${expected_doc_no}
    [Documentation]    This Keyword will Verify document screen is Opened
    ${actual_document_no}    Get Text    ${button.tab_title.document_id}
    Verify String Should Be Equal    ${actual_document_no}    ${expected_doc_no}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Navigate To Document And Click Verify Mapping
    [Arguments]    ${message}    ${page_title}    ${login_user}    ${login_password}
    [Documentation]    Navigate To Author Document And Click Verify Mapping
    Accept Document And Accept The Popup    ${message}
    Navigate To Page Title Tab    ${page_title}
    ${content_type}    Get Text    ${label.assign_doc.default_content_type}
    ${entity_name}    Get Text    ${label.assign_doc.default_entity_name}
    ${entity_no}    Get Text    ${label.assign_doc.default_entity_no}
    ${doc_no}    Get Text    ${label.assign_doc.default_doc_no}
    Click Element    ${button.verify_mapping}
    Wait Until Time    3
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${textbox.electronic_sign.user}    ${SHORT_WAIT}
    IF    '${status}'=='True'
        Handle Electronic Sign    ${login_user}    ${login_password}    Submit
        Verify Notification Popup    Auto mapping has been initiated    btnMessageOk
        Wait Until Time    190
        Click Element    ${button.verify_mapping}
    END
    ${EXPECTED_MSG}    Set Variable    Table Mapping for ${content_type} document ${doc_no} for ${entity_name} - ${entity_no} has been edited
    Set Test Variable    ${EXPECTED_MSG}

Update Table Mapping
    [Arguments]    ${text}    ${login_user}    ${login_password}    ${value}
    [Documentation]    This keyword will check update in document auto mapping screen
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Time    3
    Wait Until Element Is Visible    ${checkbox.document.auto_mapping.include}    ${MEDIUM_WAIT}
    ${status}    Run Keyword And Return Status    Checkbox Should Be Selected    ${checkbox.document.auto_mapping.include}
    IF    '${status}'=='False'    Click Element    ${checkbox.document.auto_mapping.include}
    Document Auto Mapping For Multiple Fixes    ${text}    ${value}
    # Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}
    Click Button In VLMS    Update
    Handle Electronic Sign    ${login_user}    ${login_password}    Submit

Document Auto Mapping For Multiple Fixes
    [Arguments]    ${text}    ${col_types}
    [Documentation]    It is used to document auto mapping for multiple fixes
    ${link.document.auto_mapping.newfix/show}    Update Dynamic Value    ${link.document.auto_mapping.fix/show}    ${text}
    ${status}    Run Keyword And Return Status    Element Should Be Visible    ${link.document.auto_mapping.newfix/show}
    IF    '${status}'=='True'
        ${links_count}    Get Element Count    ${link.document.auto_mapping.newfix/show}
        ${column_types}    Set Variable    ${col_types}
        ${splitted_column_types}    Split String    ${column_types}    |
        FOR    ${link}    IN RANGE    0    ${links_count}
            ${updated_link}    Evaluate    ${link}+1
            ${fix_column_types}    Set Variable    ${splitted_column_types}[${link}]
            ${splitted_fix_column_types}    Split String    ${fix_column_types}    ,
            Click Element    (${link.document.auto_mapping.newfix/show})[${updated_link}]
            Select Frame    ${iframe.fix.table_header&type}
            ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${dropdown.auto_mapping.fix.column_type.select}
            IF    '${status}'=='True'
                ${webelements}    Get Element Count    ${dropdown.auto_mapping.fix.column_type.select}
                FOR    ${key}    IN RANGE    1    ${webelements}+1
                    ${updated_key}    Evaluate    ${key}-1
                    Wait Until Element Is Visible    ${dropdown.auto_mapping.fix.column_type.select}    ${MEDIUM_WAIT}
                    Click Element    (${dropdown.auto_mapping.fix.column_type.select})[${key}]
                    ${label.auto_mapping.fix.column_type.select.newvalue}    Update Dynamic Value    (${label.auto_mapping.fix.column_type.select.value})[${key}]    ${splitted_fix_column_types}[${updated_key}]
                    Click Element    ${label.auto_mapping.fix.column_type.select.newvalue}
                    Wait Until Time    2
                END
            END
            Click Button In VLMS    Submit
            IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
            Verify Success Message    Mapping Keyword has been created    btnMessageOkMap
        END
    END

Verify Audit Trail And Activities
    [Arguments]    ${value}    ${author_data}
    [Documentation]    Verify Audit Trail And Activities
    Wait Until Time    2
    Scroll Element Into View    ${label.add_info.audit_trail.reviewer}
    Wait Until Element Is Visible    ${label.add_info.audit_trail.reviewer}    ${MEDIUM_WAIT}
    ${label.document.add_info.audit_trail.activity}    Update Dynamic Value    ${label.module.tab.content.page}    ${value}
    Scroll To Element    ${label.document.add_info.audit_trail.activity}
    Wait Until Element Is Visible    ${label.document.add_info.audit_trail.activity}    ${MEDIUM_WAIT}
    Wait Until Time    3
    Click Element    ${label.document.add_info.audit_trail.activity}
    Click Button In Vlms    View More
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.content.author.document.audit_trail.pagination}    ${MEDIUM_WAIT}    Pagination is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${pages_count}    Get Element Count    ${label.content.author.document.audit_trail.pagination}
    ${index}    Set Variable    2
    @{activities}    Split String    ${author_data}[AuditActivities]    |
    FOR    ${key}    IN    @{activities}
        ${activity_user}    Get From Dictionary    ${AUDIT_TRAIL_USERS}    ${key}
        ${activity_date}    Get From Dictionary    ${AUDIT_TRAIL_DATES}    ${key}
        @{list}    Split String    ${key}    ^
        ${activity}    Set Variable    ${list}[0]
        ${label.content.author.document.audit_trail.activity.completed_by.newuser_date}    Update Dynamic Values    ${label.content.author.document.audit_trail.activity.completed_by.user_date}    ${activity}    ${activity_user}    ${activity_date}
        ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.content.author.document.audit_trail.activity.completed_by.newuser_date}    ${SHORT_WAIT}    ${activity} by ${activity_user} on ${activity_date} is not visible after waiting for ${SHORT_WAIT} seconds
        IF    '${status}'=='False'
            ${index}    Convert To String    ${index}
            IF    ${index}<=${pages_count}
                ${label.content.author.document.audit_trail.newpage_number}    Update Dynamic Value    ${label.content.author.document.audit_trail.page_number}    ${index}
                Wait Until Time    1
                Wait Until Element Is Visible    ${label.content.author.document.audit_trail.newpage_number}    ${MEDIUM_WAIT}    Page number is not visible after waiting for ${MEDIUM_WAIT} seconds
                Click Element    ${label.content.author.document.audit_trail.newpage_number}
            END
            Wait Until Time    1
            Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.content.author.document.audit_trail.activity.completed_by.newuser_date}    ${SHORT_WAIT}    ${activity} by ${activity_user} on ${activity_date} is not visible after waiting for ${SHORT_WAIT} seconds
            ${index}    Evaluate    ${index}+1
        END
        # Log Actual And Expected Results    "${activity}" by ${activity_user} on ${activity_date} is Displayed    "${activity}" by ${activity_user} on ${activity_date} should be Displayed
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Review And Edit Document
    [Arguments]    ${message}    ${comment}    ${text_message}
    [Documentation]    This Keyword is used to Review And Edit Document
    Accept Document And Accept The Popup    ${message}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.document.edit}
    IF    '${status}'=='True'
        Click Button In VLMS    Edit
        Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
        Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}
    END
    Wait Until Time    3
    Scroll Down In Document    40
    ${EDITED_DOC_DATA}    Get Unique Test Data    ReviewUNIQUE
    Set Suite Variable    ${EDITED_DOC_DATA}
    Edit Document In Vlms    ${EDITED_DOC_DATA}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Navigate To Comments And Comment In Document    ${comment}
    Navigate To Chat Box And Enter Text    ${text_message}
    Click Button In VLMS    Save Draft
    Verify Notification Popup    Document Saved    btnMessageOk

Reply To The Reviewer Comments
    [Arguments]    ${comment}    ${text_message}
    [Documentation]    This Keyword is used to Verify the comments from reviewer and add reply
    Select Edit/SaveDraft Button    Edit
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}
    Wait Until Time    3
    Scroll Down In Document    40
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Navigate To Left Menu In Document    comments
    Wait Until Element Is Visible    (${label.document.recent_added_comment})[1]    ${MEDIUM_WAIT}    Added Comment is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Element Should Contain    (${label.document.recent_added_comment})[1]    ${comment}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.document.comment.add_reply}    ${MEDIUM_WAIT}    Add Reply is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.document.comment.add_reply}
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.document.add_reply}    ${MEDIUM_WAIT}    Reply textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    Input Text    ${textbox.document.add_reply}    Done
    Click Element    ${button.document.add_reply.reply_button}
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    Navigate To Chat Box And Enter Text    ${text_message}
    Click Button In VLMS    Save Draft
    Verify Notification Popup    Document Saved    btnMessageOk

Add Attachments
    [Documentation]    This Keyword is used to Add Attachments
    Navigate To Page Title Tab    Attachments
    Wait Until Element Is Visible    ${link.document.attachments.add}    ${MEDIUM_WAIT}    Add link is not visible after waiting for ${MEDIUM_WAIT} seconds
    Scroll Element Into View    ${link.document.attachments.add}
    Wait Until Time    2
    Click Element    ${link.document.attachments.add}
    Unselect Frame
    Wait Until Time    2
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Element Is Visible    ${label.document.attachments.add.upload_attachment}    ${MEDIUM_WAIT}    Upload Attachment screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    Enter Text In Mandatory Fields    Attachments    Attach File
    Wait Until Time    3
    Choose File    ${textbox.attachments.browse.input}    ${IMAGE_FOLDER}
    Wait Till Loading Icon Is Invisible    ${label.document.attachments.add.upload_attachment.status}
    Wait Until Time    2
    Wait Until Element Is Visible    ${button.document.add_attachments.upload}    ${MEDIUM_WAIT}    Upload button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${button.document.add_attachments.upload}

Verify Success Message For Attachments
    [Documentation]    This Keyword will Verify success message for add attachements and close the screen.
    Verify Notification Popup    Uploaded Successfully    btnConfirmOk
    Click Navigation Buttons In Screen    Close

Expand Tree View
    [Arguments]    ${locator}    ${tree_view}    ${entity_nme}
    [Documentation]    Is is used to expand the tree view
    @{splitted_tree_view}    Split String    ${tree_view}    ,
    ${tree_view_count}    Get Length    ${splitted_tree_view}
    FOR    ${key}    IN RANGE    0    ${tree_view_count}
        IF    '${splitted_tree_view}[${key}]'=='$'
            ${icon.inventory.tree_view.newplus}    Update Dynamic Values    ${icon.inventory.tree_view.plus}    ${locator}    ${entity_nme}
            Wait Until Time    2
            Scroll Element Into View    ${icon.inventory.tree_view.newplus}
            Wait Until Element Is Visible    ${icon.inventory.tree_view.newplus}    ${MEDIUM_WAIT}    ${tree_view} plus is not visible after waiting for ${MEDIUM_WAIT} seconds
            ${status}    Run Keyword And Return Status    Click Element    ${icon.inventory.tree_view.newplus}
            IF    '${status}'=='False'    Javascript Click    ${icon.inventory.tree_view.newplus}
        ELSE
            ${icon.inventory.tree_view.newplus}    Update Dynamic Values    ${icon.inventory.tree_view.plus}    ${locator}    ${splitted_tree_view}[${key}]
            Wait Until Time    2
            Scroll Element Into View    ${icon.inventory.tree_view.newplus}
            Wait Until Element Is Visible    ${icon.inventory.tree_view.newplus}    ${MEDIUM_WAIT}    ${tree_view} plus is not visible after waiting for ${MEDIUM_WAIT} seconds
            ${status}    Run Keyword And Return Status    Click Element    ${icon.inventory.tree_view.newplus}
            IF    '${status}'=='False'    Javascript Click    ${icon.inventory.tree_view.newplus}
        END
    END

Verify Document Approved Status
    [Arguments]    ${doc_id}    ${expected}
    [Documentation]    It is used to Verify document status
    Click Button In VLMS    ${doc_id}
    Select Frame    ${iframe.home.inventory_details}
    Wait Until Element Is Visible    ${label.home.inventory.entity.approved_status}    ${MEDIUM_WAIT}    Status is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_status}    Get Text    ${label.home.inventory.entity.approved_status}
    Verify String Should Be Equal    ${actual_status}    ${expected}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Enter Details In Assign Document Authoring
    [Arguments]    ${assign_document_data}
    [Documentation]    It is used to enter details in assign document authoring page
    IF    'AuthoringWith' in ${assign_document_data}    Select Value For Radio Button    DocType    ${assign_document_data}[AuthoringWith]
    IF    'Template' in ${assign_document_data}    Select Value From Dropdown    Template    ${assign_document_data}[Template]
    Wait Until Time    ${SHORT_WAIT}
    ${content_type}    Get Text    ${label.assign_doc.default_content_type}
    Set Test Variable    ${CONTENT_TYPE}
    ${entity_name}    Get Text    ${label.assign_doc.default_entity_name}
    Set Test Variable    ${ENTITY_NAME}
    ${entity_no}    Get Text    ${label.assign_doc.default_entity_no}
    Set Test Variable    ${ENTITY_NO}
    IF    'DocumentTitle' in ${assign_document_data}    Enter Text In Mandatory Fields    BoxDocumentTitle    ${assign_document_data}[DocumentTitle]
    IF    'Description' in ${assign_document_data}    Enter Text In Mandatory Fields    BoxDescription    ${assign_document_data}[Description]
    ${DOC_NO}    Get Text    ${label.assign_doc.default_doc_no}
    IF    'TargetDateType' in ${assign_document_data}
        Click Calendar Icon In Vlms    ${icon.content.assign_doc.calendar}
        Select Target Date    ${assign_document_data}[TargetDateType]    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${assign_document_data}[Year]    ${assign_document_data}[Month]    ${assign_document_data}[Date]
    END
    Wait Until Time    ${SHORT_WAIT}
    IF    'EntityNames' in ${assign_document_data}    Include Additional Entities    ${assign_document_data}[EntityNames]    ${assign_document_data}[BindAs]
    IF    'EnableDecisionTree' in ${assign_document_data}    Enable/Disable Decision Tree Action    ${assign_document_data}[EnableDecisionTree]    ${assign_document_data}[SelectDecisionTree]
    IF    'Assignment' in ${assign_document_data}    Choose Assignee Type    ${assign_document_data}[Assignment]    ${assign_document_data}[AssignTo]
    IF    'WorkFlow' in ${assign_document_data}    Select Work Flow    ${assign_document_data}[WorkFlow]
    IF    'SerialorParallel1' in ${assign_document_data}    Select Value From Dropdown    select2-vgw_grvReview_ctl02_ddlS    ${assign_document_data}[SerialorParallel1]
    IF    'SerialorParallel2' in ${assign_document_data}    Select Value From Dropdown    select2-vgw_grvReview_ctl03_ddlS    ${assign_document_data}[SerialorParallel2]
    IF    '${assign_document_data}[Assignment]'!='assignMe'
        ${EXPECTED_MSG}    Set Variable    ${CONTENT_TYPE} document authoring task ${DOC_NO} for ${ENTITY_NAME} - ${ENTITY_NO} has been Assigned to ${assign_document_data}[AssignTo]
        Set Test Variable    ${EXPECTED_MSG}
    END
    RETURN    ${DOC_NO}

Verify Document Notification Popup
    [Arguments]    ${message}    ${button_option}
    [Documentation]    It is used to Verify notification popup and click ok/cancel button
    ${label.notification.newmessage}    Update Dynamic Value    ${label.notification.message}    ${message}
    ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.notification.newmessage}    ${MEDIUM_WAIT}
    IF    '${status}'=='True'
        # Log Actual And Expected Results    ${message}    ${message}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END
    ${button.notification.newok/cancel}    Update Dynamic Value    ${button.notification.ok/cancel}    ${button_option}
    Wait Until Element Is Visible    ${button.notification.newok/cancel}    ${MEDIUM_WAIT}    ${button_option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.notification.newok/cancel}

Navigate To Create External Document
    [Documentation]    This keyword is used to navigate to the upload document authored externally page
    Navigate To Module Tab    Content    Author    External Document    Select Document to Author
    Click Button In VLMS    Create
    Wait Until Time    3

Get Entity ID
    [Documentation]    This keyword is used to get the entity type id
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.system.create.entity}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_entity_id}    Get Text    ${label.system.create.entity_code}
    ${updated_entity_id}    Remove String    ${actual_entity_id}    <    >
    ${ENTITY_ID}    Set Variable    ${updated_entity_id}
    Set Suite Variable    ${ENTITY_ID}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Get Entity ID_Prerequisite
    [Arguments]    ${entity_name}
    [Documentation]    This keyword is used to get the entity type id
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.system.create.entity.pre}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting ${MEDIUM_WAIT} seconds
    ${actual_entity_no}    Get Text    ${label.system.create.entity.pre}
    ${updated_entity_id}    Remove String    ${actual_entity_no}    <    >
    ${ENTITY_ID}    Set Variable    ${entity_name} - ${updated_entity_id}
    Set Global Variable    ${ENTITY_ID}

Enter Details And Submit In Upload Document Authored Externally
    [Arguments]    ${content_author_data}
    [Documentation]    This keyword is used to enter details in author external document and submit
    IF    'AuthoringFor' in ${content_author_data}    Select Value For Radio Button    DevFor    ${content_author_data}[AuthoringFor]
    IF    'TaskType' in ${content_author_data}    Select Value For Radio Button    DocType    ${content_author_data}[TaskType]
    IF    'FolderName' in ${content_author_data}    Select Value From Dropdown    ddlListSiteFolder    ${content_author_data}[FolderName]
    IF    'Entity' in ${content_author_data}
        Select Entity    ${content_author_data}[Entity]
    ELSE
        Select Entity    ${ENTITY}
    END
    IF    'ContentType' in ${content_author_data}    Select Value From Dropdown    ddlValidationType    ${content_author_data}[ContentType]
    Get Entity ID
    IF    'InitiateAs' in ${content_author_data}    Select Value For Radio Button    DeliverableType    ${content_author_data}[InitiateAs]
    Wait Until Time    3
    IF    'DocumentTitle' in ${content_author_data}    Enter Text In Mandatory Fields    DocumentTitle    ${content_author_data}[DocumentTitle]
    IF    'Description' in ${content_author_data}    Enter Text In Mandatory Fields    Description    ${content_author_data}[Description]
    IF    'TargetDateType' in ${content_author_data}
        Click Calendar Icon In Vlms    ${icon.content.assign_doc.calendar}
        Select Target Date    ${content_author_data}[TargetDateType]    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${content_author_data}[Year]    ${content_author_data}[Month]    ${content_author_data}[Date]
    END
    IF    'CCRNo.' in ${content_author_data}    Enter Text In Mandatory Fields    ChreqNo    ${content_author_data}[CCRNo.]
    IF    'DocumentMetadataForm' in ${content_author_data}    Select Value From Dropdown    ddlDocMeta    ${content_author_data}[DocumentMetadataForm]
    IF    'FileName' in ${content_author_data}    Upload External Document And Verify Success Message    ${content_author_data}[FileName]
    IF    'OriginalAuthor' in ${content_author_data}    Select Original Author    ${content_author_data}
    IF    '${content_author_data}[Button]'=='Save Draft'
        Click Button In VLMS    ${content_author_data}[Button]
        RETURN
    END
    IF    'ConfirmRoute' in ${content_author_data}    Select Checkbox    ${checkbox.content.author.doc.confirm_routing}
    IF    'ApprovalRequired' in ${content_author_data}    Select Value For Radio Button    check    ${content_author_data}[ApprovalRequired]
    IF    'WorkFlow' in ${content_author_data}    Select Value From Dropdown    select2-ddWorkFlow-container    ${content_author_data}[WorkFlow]
    IF    'RouteFor' in ${content_author_data}    Select Value From Dropdown    ddlUserType    ${content_author_data}[RouteFor]
    IF    'Comments' in ${content_author_data}    Enter Comments/Description    txtComments    ${content_author_data}[Comments]
    IF    'Button' in ${content_author_data}    Select Submit/Reset Button    ${content_author_data}[Button]

Upload External Document And Verify Success Message
    [Arguments]    ${file_name}
    [Documentation]    This keyword is used to upload external document and Verify the success message
    Wait Until Time    3
    Choose File    ${textbox.attachments.browse.input}    ${EXECDIR}\\ImportFiles\\${file_name}
    #Wait Until Time    2
    #Wait Till Loading Icon Is Invisible    ${label.document.attachments.add.upload_attachment.status}    ${SHORT_WAIT}
    ${Expected_result}    Set Variable    Uploaded Successfully
    Get Value From Toast Message    ${Expected_result}

Select Entity
    [Arguments]    ${entity}
    [Documentation]    This keyword is used to search entity
    Select Value From Table Dropdown    ${entity}
    Wait Until Element Is Visible    ${label.content.author.external_document.entity}
    ${entity}    Get Text    ${label.content.author.external_document.entity}
    ${splitted_entity}    Split String    ${entity}
    ${ENTITY_NAME}    Set Variable    ${splitted_entity}[0]
    Set Global Variable    ${ENTITY_NAME}
    ${actual_entity_number}    Get Text    ${label.content.author.external_document.entity_number}
    ${ENTITY_NUMBER}    Set Variable    ${actual_entity_number}
    Set Global Variable    ${ENTITY_NUMBER}
    ${EXPECTED_ENTITY_NAME}    Set Variable    ${ENTITY_NAME} - ${ENTITY_NUMBER}
    Set Test Variable    ${EXPECTED_ENTITY_NAME}

Select Original Author
    [Arguments]    ${content_author_data}
    [Documentation]    This keyword is used to select original author
    Wait Until Time    2
    IF    'OriginalAuthor' in ${content_author_data}    Select Value For Radio Button    OAcheck    ${content_author_data}[OriginalAuthor]
    IF    'AssignAuthorAs' in ${content_author_data}    Select Value From Dropdown    ddAssignInternalAuthor    ${content_author_data}[AssignAuthorAs]
    IF    'FirstName' in ${content_author_data}    Enter Text In Mandatory Fields    OAExtFName    ${content_author_data}[FirstName]
    IF    'LastName' in ${content_author_data}    Enter Text In Mandatory Fields    OAExtLName    ${content_author_data}[LastName]
    IF    'Department' in ${content_author_data}    Enter Text In Mandatory Fields    OAExtDepartment    ${content_author_data}[Department]
    IF    'Title' in ${content_author_data}    Enter Text In Mandatory Fields    OAExtTitle    ${content_author_data}[Title]

Verify Entity
    [Arguments]    ${username}    ${password}    ${content_author_data}
    [Documentation]    This keyword is used Verify created entity
    IF    '${content_author_data}[ApprovalRequired]'=='rdoAppYes' or '${content_author_data}[ApprovalRequired]'=='rdoYes'
        Verify Document Is Routed For Peer Review/Review/Approval    ${username}    ${password}    ${content_author_data}[ContentType] document ${ENTITY_ID} for ${expected_entity_name} has been routed for ${content_author_data}[RouteFor]
    ELSE IF    '${content_author_data}[ApprovalRequired]'=='rdoAppNo' or '${content_author_data}[ApprovalRequired]'=='rdoNo'
        Verify Document Is Routed For Peer Review/Review/Approval    ${username}    ${password}    ${content_author_data}[ContentType] document ${ENTITY_ID} for ${expected_entity_name} has been approved
    END

Verify Saved External Document Success Message
    [Arguments]    ${content_author_data}
    [Documentation]    It is used to verify the saved external document alert
    IF    '${content_author_data}[FileType]'=='PDF'
        ${PDF_DOCUMENT_NO}    Set Variable    ${ENTITY_ID}
        Set Suite Variable    ${PDF_DOCUMENT_NO}
        ${SAVED_SUCCESS_MESSAGE}    Set Variable    ${content_author_data}[ContentType] document ${PDF_DOCUMENT_NO} for ${ENTITY_NAME} - ${ENTITY_NUMBER} has been saved
        Set Suite Variable    ${SAVED_SUCCESS_MESSAGE}
    ELSE IF    '${content_author_data}[FileType]'=='EXCEL'
        ${EXCEL_DOCUMENT_NO}    Set Variable    ${ENTITY_ID}
        Set Suite Variable    ${EXCEL_DOCUMENT_NO}
        ${SAVED_SUCCESS_MESSAGE}    Set Variable    ${content_author_data}[ContentType] document ${EXCEL_DOCUMENT_NO} for ${ENTITY_NAME} - ${ENTITY_NUMBER} has been saved
        Set Suite Variable    ${SAVED_SUCCESS_MESSAGE}
    ELSE IF    '${content_author_data}[FileType]'=='WORD'
        ${WORD_DOCUMENT_NO}    Set Variable    ${ENTITY_ID}
        Set Suite Variable    ${WORD_DOCUMENT_NO}
        ${SAVED_SUCCESS_MESSAGE}    Set Variable    ${content_author_data}[ContentType] document ${WORD_DOCUMENT_NO} for ${ENTITY_NAME} - ${ENTITY_NUMBER} has been saved
        Set Suite Variable    ${SAVED_SUCCESS_MESSAGE}
    END
    Verify Notification Popup    ${SAVED_SUCCESS_MESSAGE}    btnMessageOk

Verify Author Is Assigned For Document Authoring
    [Arguments]    ${assign_document_data}    ${option}
    [Documentation]    This will Verify document is assigned, store document number & Handle Notification pop-up by clicking with Ok or Home button
    Wait Until Element Is Visible    ${label.notification_popup}    ${MEDIUM_WAIT}    Notification pop-up is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Visible    ${label.notification.doc_no}    ${MEDIUM_WAIT}    Document number is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${document_number}    Get Text    ${label.notification.doc_no}
    Verify String Should Be Equal    ${doc_no}    ${document_number}
    Wait Until Element Is Visible    ${label.assign_doc.submit.popup.message}
    ${actual_msg}    Get Text    ${label.assign_doc.submit.popup.message}
    Log    ${actual_msg}
    IF    '${assign_document_data}[Assignment]'=='assignMe'
        @{list}    Split String    ${loggedin_user}    -
        ${assigned_user}    Set Variable    ${list}[0]
        ${assigned_user}    Replace String    ${assigned_user}    ${SPACE}\[    ${EMPTY}\[
        ${assigned_user1}    Strip String    ${assigned_user}
        ${EXPECTED_MSG1}    Set Variable    ${content_type} document authoring task ${doc_no} for ${entity_name} - ${entity_no} has been Assigned to ${assigned_user1}
        Verify String Should Be Equal    ${EXPECTED_MSG1}    ${actual_msg}
    END
    IF    '${assign_document_data}[Assignment]'!='assignMe'    Verify String Should Be Equal    ${actual_msg}    ${EXPECTED_MSG}
    # ${DOCUMENT_NO}    Set Variable    ${doc_no}
    # Set Suite Variable    ${DOCUMENT_NO}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    IF    '${option}'=='Ok'
        Click Element    ${button.notification_popup.ok}
    ELSE IF    '${option}'=='Home'
        Click Element    ${button.notification_popup.home}
        Unselect Frame
        Wait Until Element Is Visible    ${label.home.task_list}    ${MEDIUM_WAIT}
    END
    # RETURN    ${DOCUMENT_NO}

Navigate To Document Mapping Screen
    [Documentation]    It is used to navigate to the Document mapping screen
    Wait Until Time    4
    Navigate To Page Title Tab    Upload Document Authored Externally
    Wait Until Time    2
    Click Button In VLMS    Verify Mapping
    Wait Until Time    3
    Unselect Frame
    Select Frame    ${iframe.library_frame.screen}

Enter Details In Document Mapping
    [Arguments]    ${content_author_data}    ${login_user}    ${login_password}
    [Documentation]    It used to enter all details in document mapping screen
    Select Value From Dropdown    ddlWorkSheet    ${content_author_data}[SheetName]
    Wait Until Time    2
    Input Text    ${textbox.content.author.external_document.mapping.row_start}    ${content_author_data}[RowStart]
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.content.author.external_document.mapping.row_end}
    Input Text    ${textbox.content.author.external_document.mapping.row_end}    ${content_author_data}[RowEnd]
    Wait Until Time    2
    Input Text    ${textbox.content.author.external_document.mapping.col_start}    ${content_author_data}[ColStart]
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.content.author.external_document.mapping.col_end}
    Input Text    ${textbox.content.author.external_document.mapping.col_end}    ${content_author_data}[ColEnd]
    Wait Until Time    2
    Click Button In VLMS    Map
    Select Column Types    ${content_author_data}[FileType]    ${content_author_data}[ColumnTypes]    None
    Verify Confirmation Popup    ${content_author_data}[SheetName] Excel Mapping has been saved    btnMessageOk
    Click Button In VLMS    Submit
    Handle Electronic Sign    ${login_user}    ${login_password}    Submit    Initiation

Select Column Types
    [Arguments]    ${file_type}    ${column_types}    ${select_property}
    [Documentation]    It is used to select different column types in document mapping screen
    Wait Until Time    2
    ${splitted_column_types}    Split String    ${column_types}    ,
    ${splitted_column_types_count}    Get Length    ${splitted_column_types}
    FOR    ${key}    IN RANGE    0    ${splitted_column_types_count}
        ${updated_key}    Evaluate    ${key}+2
        IF    '${file_type}'=='EXCEL'
            ${updated_key1}    Evaluate    "${updated_key}".zfill(2)
            ${dropdown.content.author.external_document.mapping.excel.newcol_type}    Update Dynamic Value    ${dropdown.content.author.external_document.mapping.excel.col_type}    ${updated_key1}
            Wait Until Time    1
            Wait Until Element Is Visible    ${dropdown.content.author.external_document.mapping.excel.newcol_type}    ${MEDIUM_WAIT}
            Select From List By Label    ${dropdown.content.author.external_document.mapping.excel.newcol_type}    ${splitted_column_types}[${key}]
        ELSE IF    '${file_type}'=='PDF'
            ${updated_key}    Evaluate    ${key}+1
            Select From List By Label    (${dropdown.content.author.external_document.mapping.pdf.col_type})[${updated_key}]    ${splitted_column_types}[${key}]
            IF    '${splitted_column_types}[${key}]'=='Dropdown Result'
                Select Properties    ${updated_key}    ${select_property}
            END
        END
    END
    IF    '${file_type}'=='EXCEL'    Click Button In VLMS    Save Map

Select Properties
    [Arguments]    ${key}    ${select_properties}
    [Documentation]    It is used to select properties for column types
    Click Element    (${label.content.author.external_document.pdf.col_type.setting})[${key}]
    ${splitted_select_properties}    Split String    ${select_properties}    ,
    ${splitted_select_properties_count}    Get Length    ${splitted_select_properties}
    FOR    ${property}    IN RANGE    0    ${splitted_select_properties_count}
        ${checkbox.content.author.external_document.pdf.col_type.newsetting}    Update Dynamic Value    ${checkbox.content.author.external_document.pdf.col_type.setting}    ${splitted_select_properties}[${property}]
        Select Checkbox    ${checkbox.content.author.external_document.pdf.col_type.newsetting}
    END
    Click Element    ${button.content.author.external_document.pdf.col_type.setting.save}

Submit Upload Document Authored Externally
    [Arguments]    ${content_author_data}    ${login_user}    ${login_password}
    [Documentation]    It is used to submit the uploaded document authored externally
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    Wait Until Element Is Visible    ${checkbox.content.author.doc.confirm_routing}    ${MEDIUM_WAIT}
    Select Checkbox    ${checkbox.content.author.doc.confirm_routing}
    IF    'ApprovalRequired' in ${content_author_data}    Select Value For Radio Button    check    ${content_author_data}[ApprovalRequired]
    Click Button In VLMS    Submit
    ${SUCCESS_MESSAGE}    Set Variable    ${content_author_data}[ContentType] document ${ENTITY_ID} for ${ENTITY_NAME} - ${ENTITY_NUMBER} has been Approved
    Set Suite Variable    ${SUCCESS_MESSAGE}
    Handle Electronic Sign    ${login_user}    ${login_password}    Submit    Route for Review

Map And Verify Table Properties
    [Arguments]    ${content_author_data}    ${no_of_rows}
    [Documentation]    It is used to map and verify the table properties
    Map Tables    ${content_author_data}    ${no_of_rows}
    Enter And Verify Document Cell Properties    ${no_of_rows}    ${content_author_data}
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    Wait Until Time    ${LONG_WAIT}

Map Tables
    [Arguments]    ${excel_mapping_data}    ${row_nos}
    [Documentation]    It is used to select column types and properties to map table
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Select Frame    ${iframe.content.document_frame}
    Wait Until Element Is Visible    ${label.content.author.external_document.pdf.map_tables}    ${MEDIUM_WAIT}
    Click Element    ${label.content.author.external_document.pdf.map_tables}
    Wait Until Time    3
    Click Element    ${button.content.author.external_document.pdf.page}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.content.author.external_document.pdf.map_tables.circle_blue}    ${MEDIUM_WAIT}
    Click Element    ${label.content.author.external_document.pdf.map_tables.circle_blue}
    Select Column Types    ${excel_mapping_data}[FileType]    ${excel_mapping_data}[ColumnTypes]    ${excel_mapping_data}[SelectProperties]
    Click Button In VLMS    Submit
    Wait Until Element Is Visible    ${label.content.author.external_document.pdf.map_tables.circle_green}    ${MEDIUM_WAIT}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Verify Result Column Type In PDF Document    ${row_nos}

Verify Result Column Type In PDF Document
    [Arguments]    ${no_of_rows}
    [Documentation]    It is used to verify the selected column type in table for dropdown
    FOR    ${row}    IN RANGE    1    ${no_of_rows}+1
        Run Keyword And Continue On Failure    Wait Until Element Is Visible    (${dropdown.content.author.external_document.pdf.table_result})[${row}]    ${MEDIUM_WAIT}    Select dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    END

Enter And Verify Document Cell Properties
    [Arguments]    ${no_of_rows}    ${content_author_data}
    [Documentation]    It is used to enter and verify document cell properties in the right side table
    ${column_textbox_values}    Set Variable    ${content_author_data}[TextboxProperties]
    ${splitted_column_textbox_values}    Split String    ${column_textbox_values}    ,
    ${column_checkbox_values}    Set Variable    ${content_author_data}[TextboxCheckboxProprties]
    ${splitted_column_checkbox_values}    Split String    ${column_checkbox_values}    |
    ${column_dropdown_textbox_values}    Set Variable    ${content_author_data}[DropdownTextboxProperties]
    ${splitted_dropdown_textbox_types}    Split String    ${column_dropdown_textbox_values}    ,
    ${column_types}    Set Variable    ${content_author_data}[ColumnTypes]
    ${splitted_column_types}    Split String    ${column_types}    ,
    ${splitted_column_types_count}    Get Length    ${splitted_column_types}
    ${col_count}    Evaluate    ${no_of_rows}*(${splitted_column_types_count}-1)
    FOR    ${key}    IN RANGE    0    ${col_count}
        ${updated_key}    Evaluate    ${key}+1
        Wait Until Time    2
        Double Click Element    (${textbox.execution.execute.electronic_execution.table.cell})[${updated_key}]
        Wait Until Time    2
        Enter Textbox Properties    ${splitted_column_textbox_values}[${key}]    ${splitted_column_checkbox_values}[${key}]
        IF    ${updated_key}>(${splitted_column_types_count}-1)
            ${updated_key}    Evaluate    ${updated_key}+1
            ${actual_textbox_value}    Get Text By Using Javascript    (${label.execution.execute.electronic_execution.table.cell})[${updated_key}]
            Verify String Should Be Equal    ${splitted_column_textbox_values}[${key}]    ${actual_textbox_value}
        ELSE
            ${actual_textbox_value}    Get Text By Using Javascript    (${label.execution.execute.electronic_execution.table.cell})[${updated_key}]
            Verify String Should Be Equal    ${splitted_column_textbox_values}[${key}]    ${actual_textbox_value}
        END
    END
    FOR    ${row}    IN RANGE    0    ${no_of_rows}
        ${updated_row}    Evaluate    ${row}+1
        Double Click Element    (${dropdown.execution.execute.electronic_execution.table.cell})[${updated_row}]
        Enter Dropdown Properties    ${splitted_dropdown_textbox_types}[${row}]    ${content_author_data}[DropdownCheckboxProprties]
        ${updated_key}    Evaluate    ${updated_row}*${splitted_column_types_count}
        ${actual_textbox_value}    Get Text By Using Javascript    (${label.execution.execute.electronic_execution.table.cell})[${updated_key}]
        Verify String Should Be Equal    ${splitted_dropdown_textbox_types}[${row}]    ${actual_textbox_value}
    END

Enter Textbox Properties
    [Arguments]    ${textbox_value}    ${checkbox_values}
    [Documentation]    It used to enter one cell textbox properties
    Wait Until Time    1
    Wait Until Element Is Visible    ${textbox.execution.execute.electronic_execution.table.cell.name}    ${MEDIUM_WAIT}    Name textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    Input Text    ${textbox.execution.execute.electronic_execution.table.cell.name}    ${textbox_value}
    Input Text    ${textbox.execution.execute.electronic_execution.table.cell.tooltip}    ${textbox_value}
    Input Text    ${textbox.execution.execute.electronic_execution.table.cell.value}    ${textbox_value}
    ${checkbox.execution.execute.electronic_execution.newtextbox_properties}    Update Dynamic Value    ${checkbox.execution.execute.electronic_execution.textbox_properties}    ${checkbox_values}
    Click Element    ${checkbox.execution.execute.electronic_execution.newtextbox_properties}
    Click Button    ${button.execution.execute.electronic_execution.textbox_properties.ok}
    Wait Until Time    2

Enter Dropdown Properties
    [Arguments]    ${textbox_value}    ${checkbox_values}
    [Documentation]    It used to enter one cell dropdown textbox properties
    Input Text    ${textbox.execution.execute.electronic_execution.table.cell.name}    ${textbox_value}
    Input Text    ${textbox.execution.execute.electronic_execution.table.cell.tooltip}    ${textbox_value}
    ${checkbox_values}    Set Variable    ${checkbox_values}
    ${splitted_checkbox_values}    Split String    ${checkbox_values}    ,
    FOR    ${checkbox_value}    IN    @{splitted_checkbox_values}
        ${checkbox.execution.execute.electronic_execution.newtextbox_properties}    Update Dynamic Value    ${checkbox.execution.execute.electronic_execution.textbox_properties}    ${checkbox_value}
        Click Element    ${checkbox.execution.execute.electronic_execution.newtextbox_properties}
    END
    Click Button    ${button.execution.execute.electronic_execution.textbox_properties.ok}
    Wait Until Time    1

Accept/Reject Review Changes
    [Arguments]    ${tab}    ${dropdown_name}    ${option}
    [Documentation]    It used to Accept/Reject Review Changes in a Document
    Navigate To Page Title Tab    ${tab}
    Select Frame    ${iframe.content.document_frame}
    Select Frame    ${iframe.content.document.frame_editor}
    Wait Until Element Is Visible    ${label.content.author.document.review_changes_popup}    ${MEDIUM_WAIT}    Review Changes is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${dropdown.content.author.document.review_changes_popup.newdropdown_id}    Update Dynamic Value    ${dropdown.content.author.document.review_changes_popup.dropdown_id}    ${dropdown_name}
    Wait Until Time    2
    Wait Until Element Is Visible    ${dropdown.content.author.document.review_changes_popup.newdropdown_id}    ${MEDIUM_WAIT}    ${dropdown_name} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${dropdown.content.author.document.review_changes_popup.newdropdown_id}
    ${dropdown.content.author.document.review_changes_popup.dropdown_id.newoption}    Update Dynamic Value    ${dropdown.content.author.document.review_changes_popup.dropdown_id.option}    ${option}
    Wait Until Time    2
    Wait Until Element Is Visible    ${dropdown.content.author.document.review_changes_popup.dropdown_id.newoption}    ${MEDIUM_WAIT}    ${option} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${dropdown.content.author.document.review_changes_popup.dropdown_id.newoption}
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Delete Comments In A Document
    [Documentation]    It used to Delete Comments in a Document
    # robocop: disable=unused-variable
    Navigate To Left Menu In Document    comments
    Wait Until Element Is Visible    ${icon.content.author.document.comments.delete}    ${MEDIUM_WAIT}    Added Comment is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${comments_count}    Get Element Count    ${icon.content.author.document.comments.delete}
    FOR    ${key}    IN RANGE    1    ${comments_count}+1
        Wait Until Time    1
        Wait Until Element Is Visible    ${icon.content.author.document.comments.delete}    ${MEDIUM_WAIT}    Delete icon is not visible after waiting for ${MEDIUM_WAIT} seconds
        Wait Until Keyword Succeeds    6s    2s    Click Element    (${icon.content.author.document.comments.delete})[1]
    END

Navigate To Vault Documents Page And Search Document
    [Arguments]    ${author_doc_data}    ${approved_doc_no}
    [Documentation]    It is used to Navigate To Vault Documents Page And Search Document
    Navigate To Module Tab    Vault    View    Document    Vault Documents    True
    Navigate To Tab In Vault Documents    Approved
    Navigate To Tab In Vault Documents    Search
    Wait Until Time    2
    Enter Details In Parametric Search    ${author_doc_data}    ${approved_doc_no}

Navigate To Tab In Vault Documents
    [Arguments]    ${tab}
    [Documentation]    It is used to select tab option in Vault Documents page
    ${label.vault.view.document.newtab}    Update Dynamic Value    ${label.vault.view.document.tab}    ${tab}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.vault.view.document.newtab}    ${MEDIUM_WAIT}    ${tab} tab is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Clickable And Click    ${label.vault.view.document.newtab}    10

Enter Details In Parametric Search
    [Arguments]    ${approved_doc_data}    ${approved_doc_no}
    [Documentation]    It is used to Enter Details In Parametric Search Section
    Select Frame    ${iframe.vault.view.document.doc_details}
    Wait Until Time    3
    Wait Until Element Is Visible    ${checkbox.vault.view.document.approved.search.parametric_search.all}    ${MEDIUM_WAIT}    Select All checkbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'Expression' in ${approved_doc_data}    Enter Text In Mandatory Fields    pSearch    ${approved_doc_no}
    IF    'Size' in ${approved_doc_data}    Enter Text In Mandatory Fields    limit    ${approved_doc_data}[Size]
    IF    'MetaDataSearch' in ${approved_doc_data}    Select Value For Radio Button    gp    ${approved_doc_data}[MetaDataSearch]
    IF    'IncludeDocument' in ${approved_doc_data}    Select Value For Radio Button    cs    ${approved_doc_data}[IncludeDocument]
    IF    'Parameters' in ${approved_doc_data}
        Scroll Till Element Is Visible    ${checkbox.vault.view.document.approved.search.parametric_search.all}
        IF    '${approved_doc_data}[Parameters]'=='SelectAll'
            Select Checkbox    ${checkbox.vault.view.document.approved.search.parametric_search.all}
        ELSE IF    '${approved_doc_data}[Parameters]'!='SelectAll'
            Unselect Checkbox    ${checkbox.vault.view.document.approved.search.parametric_search.all}
            Wait Until Time    2
            @{select_parameters}    Split String    ${approved_doc_data}[Parameters]    ,
            FOR    ${key}    IN    @{select_parameters}
                ${checkbox.vault.view.document.approved.search.parametric_search.newlabel_checkbox}    Update Dynamic Value    ${checkbox.vault.view.document.approved.search.parametric_search.parameter_checkbox}    ${key}
                Wait Until Time    1
                Wait Until Element Is Visible    ${checkbox.vault.view.document.approved.search.parametric_search.newlabel_checkbox}    ${MEDIUM_WAIT}    ${key} checkbox is not visible after waiting for ${MEDIUM_WAIT} seconds
                Scroll Till Element Is Visible    ${checkbox.vault.view.document.approved.search.parametric_search.newlabel_checkbox}
                Select Checkbox    ${checkbox.vault.view.document.approved.search.parametric_search.newlabel_checkbox}
            END
        END
    END
    IF    'SearchName' in ${approved_doc_data}    Enter Text In Mandatory Fields    SearchName    ${approved_doc_data}[SearchName]
    IF    'SearchIcon' in ${approved_doc_data}    Click Element    ${icon.vault.view.document.approved.search.parametric_section.search}
    IF    'SaveSearch' in ${approved_doc_data}    Click Element    ${button.vault.view.document.approved.search.parametric_section.save_search}
    Wait Until Time    5

Select View And Verify Approved Document Details
    [Arguments]    ${approved_doc_data}    ${approved_doc_no}
    [Documentation]    It is used to Select View link And Validate Approved Document Details
    # robocop: disable=too-long-keyword
    Select View In Approved Document Details    ${approved_doc_no}
    @{details}    Split String    ${approved_doc_data}[ApprovedDocDetails]    ,
    ${index}    Set Variable    1
    FOR    ${key}    IN    @{details}
        ${index}    Convert To String    ${index}
        IF    '${key}'=='Authoring Completed On' or '${key}'=='Approved On'
            ${col_value}    Get From Dictionary    ${APPROVED_DOC_DETAILS}    ${key}
            ${label.vault.view.document.approved_doc_details.table.newcolumn_name}    Update Dynamic Values    ${label.vault.view.document.approved_doc_details.table.column_name}    ${index}    ${key}
            Wait Until Time    1
            Wait Until Element Is Visible    ${label.vault.view.document.approved_doc_details.table.newcolumn_name}    ${SHORT_WAIT}    ${key} is not visible after waiting ${SHORT_WAIT} seconds
            ${label.vault.view.document.approved_doc_details.table.column.newdate}    Update Dynamic Value    ${label.vault.view.document.approved_doc_details.table.column.date}    ${index}
            Wait Until Time    1
            Wait Until Element Is Visible    ${label.vault.view.document.approved_doc_details.table.column.newdate}    ${SHORT_WAIT}    Date is not visible after waiting ${SHORT_WAIT} seconds
            ${date_timezone_value}    Get Text    ${label.vault.view.document.approved_doc_details.table.column.newdate}
            ${actual_date}    Fetch From Left    ${date_timezone_value}    (
            ${actual_date}    Strip String    ${actual_date}
            ${actual_timezone}    Fetch From Right    ${date_timezone_value}    (
            ${actual_timezone}    Remove String    ${actual_timezone}    )
            ${expected_date}    Fetch From Left    ${col_value}    (
            ${expected_date}    Strip String    ${expected_date}
            ${exp_timezone}    Fetch From Right    ${col_value}    (
            ${exp_timezone}    Remove String    ${exp_timezone}    )
            ${time_differ}    Subtract Date From Date    ${actual_date}    ${expected_date}    number    False    date1_format=%d/%m/%Y %I:%M:%S %p    date2_format=%d/%m/%Y %I:%M:%S %p
            IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
            Run Keyword And Continue On Failure    Should Be True    ${time_differ}<30
            Run Keyword And Continue On Failure    Should Be Equal    ${exp_timezone}    ${actual_timezone}
            # Log Actual And Expected Results    "${key}" column with "${col_value}" is Displayed    "${key}" column with "${col_value}" should be Displayed
        ELSE
            ${col_value}    Get From Dictionary    ${APPROVED_DOC_DETAILS}    ${key}
            ${label.vault.view.document.approved_doc_details.table.newcolumn_name}    Update Dynamic Values    ${label.vault.view.document.approved_doc_details.table.column_name}    ${index}    ${key}
            Wait Until Time    1
            Wait Until Element Is Visible    ${label.vault.view.document.approved_doc_details.table.newcolumn_name}    ${SHORT_WAIT}    ${key} is not visible after waiting ${SHORT_WAIT} seconds
            ${label.vault.view.document.approved_doc_details.table.newcolumn.value}    Update Dynamic Values    ${label.vault.view.document.approved_doc_details.table.column.value}    ${index}    ${col_value}
            Wait Until Time    1
            Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${label.vault.view.document.approved_doc_details.table.newcolumn.value}    ${SHORT_WAIT}    ${col_value} is not visible after waiting ${SHORT_WAIT} seconds
            # Log Actual And Expected Results    "${key}" column with "${col_value}" is Displayed    "${key}" column with "${col_value}" should be Displayed
            IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        END
        ${index}    Evaluate    ${index}+1
    END

Select View In Approved Document Details
    [Arguments]    ${approved_doc_no}
    [Documentation]    It is used to select the view link in Approved Document details
    Select Frame    ${iframe.vault.view.document.approved_doc_details}
    ${link.vault.view.document.approved_doc_details.newview}    Update Dynamic Value    ${link.vault.view.document.approved_doc_details.view}    ${approved_doc_no}
    Wait Until Time    3
    Wait Until Element Is Visible    ${link.vault.view.document.approved_doc_details.newview}    ${MEDIUM_WAIT}    View link is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${link.vault.view.document.approved_doc_details.newview}
    Switch To Parent Frame
    Wait Until Time    2
    Select Frame    ${iframe.vault.view.document.approved_doc_details}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.vault.view.document.approved_doc_details.table}    ${MEDIUM_WAIT}    Table is not visible after waiting ${MEDIUM_WAIT} seconds

Enable PDF
    [Arguments]    ${author_doc_data}    ${approved_doc_no}
    [Documentation]    It is used to enable the pdf doc
    Unselect Frame
    Click Top Menu Icons    Refresh
    Select Frame    ${iframe.framecontent}
    Navigate To Tab In Vault Documents    Approved
    Navigate To Tab In Vault Documents    Search
    Wait Until Time    2
    Enter Details In Parametric Search    ${author_doc_data}    ${approved_doc_no}
    Select View In Approved Document Details    ${approved_doc_no}
    Click Element    ${img.vault.view.document.approved_doc_details.table.pdf}

Download And Verify Approved PDF Document
    [Arguments]    ${login_user}    ${login_password}    ${author_doc_data}    ${approved_doc_no}
    [Documentation]    It is used to download and verify the approved pdf document
    Wait Until Time    6
    ${status}    Run Keyword And Return Status    Click Element    ${img.vault.view.document.approved_doc_details.table.pdf}
    IF    '${status}'=='False'    Wait Until Keyword Succeeds    ${PDF_LOADING_TIME}    10    Enable PDF    ${author_doc_data}    ${approved_doc_no}
    Wait Until Time    5
    Unselect Frame
    Select Frame    ${iframe.library_frame.screen}
    Click Element    ${label.vault.view.document.approved_doc_details.table.pdf.download}
    Enter Comments/Description    valtxtReason    ${author_doc_data}[Comments]
    Click Button    ${button.vault.view.document.approved_doc_details.table.pdf.download.comment.submit}
    Handle Electronic Sign    ${login_user}    ${login_password}    Submit
    Verify Success Message    Download has been initiated, document will be ready in a while with watermark. We will notify a task in home page to proceed further.    btnMessageOk
    Unselect Frame
    Click Element    ${button.content.author.document.trace_matrix.uncovered_test_cases.close}
    Unselect Frame
    Logout From VLMS Application
    Login To VLMS Application    ${login_user}    ${login_password}
    Download PDF Report    ${approved_doc_no}
    Verify String Should Contain    ${EXPECTED_PDF_DETAILS}    ${approved_doc_no}
    ${doc_title}    Get From Dictionary    ${APPROVED_DOC_DETAILS}    Document Title
    Verify String Should Contain    ${EXPECTED_PDF_DETAILS}    ${doc_title}
    Verify String Should Contain    ${EXPECTED_PDF_DETAILS}    ${EDITED_DOC_DATA}

Create Audit Trail Details
    [Arguments]    ${initiate_data}
    [Documentation]    It is used to Create Audit Trail Details Lists
    ${AUDIT_TRAIL_USERS}    Create Dictionary
    Set Suite Variable    ${AUDIT_TRAIL_USERS}
    @{AUDIT_ACTIVITIES_LIST}    Split String    ${initiate_data}[AuditActivities]    |
    Set Suite Variable    @{AUDIT_ACTIVITIES_LIST}
    ${AUDIT_TRAIL_DATES}    Create Dictionary
    Set Suite Variable    ${AUDIT_TRAIL_DATES}

Append User Activities For Audit Trail
    [Arguments]    ${index}
    [Documentation]    It is used to Append User Activities For Audit Trail to the list
    ${login_username}    Get Login Username
    Select Frame    ${iframe.framecontent}
    Set To Dictionary    ${AUDIT_TRAIL_USERS}    ${AUDIT_ACTIVITIES_LIST}[${index}]    ${login_username}
    ${date}    Get Current Date
    ${date_time}    Convert Date    ${date}    %d/%m/%Y
    Set To Dictionary    ${AUDIT_TRAIL_DATES}    ${AUDIT_ACTIVITIES_LIST}[${index}]    ${date_time}

Navigate To Content Generation And Click Select
    [Documentation]    This keyword will navigate to content generation tab and clicks on select hyperlink
    Navigate To Page Title Tab    Content Generation
    Wait Until Time    3
    Wait Until Element Is Visible    ${link.content_library.select}    ${MEDIUM_WAIT}
    Click Element    ${link.content_library.select}

Accept Review Changes And Delete Comments
    [Arguments]    ${doc_no}
    [Documentation]    This keyword will Accept Review Changes And Delete Comments in the document
    ${status}    Run Keyword And Return Status    Wait Until Page Contains    Do you want to proceed?    ${SHORT_WAIT}
    IF    '${status}'=='True'    Verify Notification Popup    Document mapping not verified. Do you want to proceed?    btnSubmitConfirm
    Wait Until Time    2
    Verify Success Message    Document contains review changes that need to be accepted/rejected    val1_btnAlertOk
    Accept/Reject Review Changes    ${doc_no}    accept    Accept All Changes
    Delete Comments In A Document
    Wait Until Time    2

Add Table In The Embedded Word Doc
    [Arguments]    ${no_of_rows}    ${no_of_columns}    ${content_author_data}
    [Documentation]    It is used to add table in embedded word document
    Wait Until Time    2
    Scroll Down In Document    6
    Wait Until Time    2
    # \ue007 is for enter key
    Press Keys    None    ENTER
    Click Element    ${label.content.author.external_document.word.insert.table}
    Click Element    ${img.content.author.external_document.word.insert.table}
    Click Element    ${label.content.author.external_document.word.insert_custom_table}
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.content.author.external_document.word.table.rows}
    Input Text    ${textbox.content.author.external_document.word.table.rows}    ${no_of_rows}
    Wait Until Time    1
    Wait Until Element Is Visible    ${textbox.content.author.external_document.word.table.cols}
    Input Text    ${textbox.content.author.external_document.word.table.cols}    ${no_of_columns}
    Click Button    ${button.execution.execute.electronic_execution.textbox_properties.ok}
    Wait Until Time    2
    Add Table Values    ${content_author_data}[TableHeaders]    ${content_author_data}[TableRowValues]
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Append Data On Embedded Word Doc
    [Arguments]    ${search_value}    ${replace_value}
    [Documentation]    It is used to append cell data of a table on embedded word document
    Press Keyboard Keypairs    ctrl    f
    Wait Until Time    2
    Input Text    ${textbox.content.author.external_document.word.search}    ${search_value}
    Wait Until Time    2
    Click Element    ${label.content.author.external_document.word.replace}
    Wait Until Time    2
    Input Text    ${textbox.content.author.external_document.word.replace}    ${replace_value}
    Wait Until Time    2
    # Click Element    ${button.content.author.external_document.word.search.back}
    Click Element    ${button.content.author.external_document.word.search.replace}
    Click Element    ${button.content.author.external_document.word.search.replace}
    Wait Until Time    2
    Click Element    ${button.content.author.external_document.word.search.ok}
    Click Element    ${label.content.author.external_document.word.find_text.close}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Delete Data On Embedded Word Doc
    [Arguments]    ${search_value}
    [Documentation]    It is used to delete cell data from table on embedded word document
    Wait Until Time    2
    Press Keyboard Keypairs    ctrl    f
    Wait Until Time    2
    Input Text    ${textbox.content.author.external_document.word.search}    ${search_value}
    Wait Until Element Is Visible    ${label.content.author.external_document.word.replace}
    Click Element    ${label.content.author.external_document.word.replace}
    Wait Until Time    2
    Click Element    ${textbox.content.author.external_document.word.replace}
    Input Text    ${textbox.content.author.external_document.word.replace}    ${EMPTY}
    Wait Until Time    2
    # Click Element    ${button.content.author.external_document.word.search.back}
    Click Element    ${button.content.author.external_document.word.search.replace}
    Click Element    ${button.content.author.external_document.word.search.replace}
    Wait Until Time    2
    Click Element    ${button.content.author.external_document.word.search.ok}
    Wait Until Time    2
    Click Element    ${label.content.author.external_document.word.find_text.close}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Delete Row On Embedded Doc
    [Documentation]    It is used to delete row from the table in embedded word document
    Wait Until Time    2
    Press Keyboard Key    up
    Wait Until Time    2
    Select Cells    7    left
    Wait Until Time    2
    Press Multiple Keyboard Keys    shiftright    shiftleft    delete
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Edit Word Document
    [Arguments]    ${document_no}    ${no_of_rows}    ${no_of_columns}    ${content_author_data}
    [Documentation]    It is used to edit the embedded word document
    Search And Select The Value From The Section    ${document_no}
    Wait Until Time    2
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}
    Select Frame    ${iframe.content.document_frame}
    Select Frame    ${iframe.content.document.frame_editor}
    Wait Until Time    5
    Click Page Down And Left
    Wait Until Time    2
    Add New Row Values    ${content_author_data}[Table1NewRowValues]
    Delete Row On Embedded Doc
    Add Table In The Embedded Word Doc    ${no_of_rows}    ${no_of_columns}    ${content_author_data}
    Append Data On Embedded Word Doc    Udhay    ${content_author_data}[AppendedVal]
    Delete Data On Embedded Word Doc    Uday123
    Unselect Frame
    Select Frame    ${iframe.framecontent}
    Navigate To Page Title Tab    Upload Document Authored Externally

Checkout Document
    [Documentation]    It is used to checkout the document
    Wait Until Time    2
    Select Value For Radio Button    radio    rbtnConfirmYes
    Click Element    ${link.content.author.external_document.check_out}
    Verify Notification Popup    Do you want to proceed Check Out Process?    btnCheckoutOK
    Wait Until Time    10
    Unselect Frame
    Get Downloads Folder Path

Checkin Document
    [Arguments]    ${documet_no}    ${file_path}
    [Documentation]    It is used to checkin the document
    Search And Select The Value From The Section    ${documet_no}
    Navigate To Page Title Tab    Upload Document Authored Externally
    Choose File    ${textbox.checkout.attachments.browse.input}    ${file_path}
    Wait Till Loading Icon Is Invisible    ${label.document.attachments.add.upload_attachment.status}
    Verify Notification Popup    Uploaded Successfully    btnConfirmOk
    Wait Until Time    2
    Click Element    ${link.content.author.external_document.check_in}
    Wait Until Time    5

Verify Word Document And Submit
    [Arguments]    ${documet_no}    ${content_author_data}
    [Documentation]    It is used to verify and submit the word document
    Navigate To Page Title Tab    ${documet_no}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.vg_logo}
    Wait Till Loading Icon Is Invisible    ${web.img.vlms.loading_document}
    Select Frame    ${iframe.content.document_frame}
    Select Frame    ${iframe.content.document.frame_editor}
    Wait Until Element Is Visible    ${label.content.author.external_document.word}
    Wait Until Time    3
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Unselect Frame
    Remove File    ${DOWNLOADS_FOLDER}\\${WORD_DOCUMENT_NO}.docx
    Select Frame    ${iframe.framecontent}
    Navigate To Page Title Tab    Upload Document Authored Externally
    Wait Until Time    2
    Wait Until Element Is Visible    ${checkbox.content.author.doc.confirm_routing}    ${MEDIUM_WAIT}
    Select Checkbox    ${checkbox.content.author.doc.confirm_routing}
    IF    'ApprovalRequired' in ${content_author_data}    Select Value For Radio Button    check    ${content_author_data}[ApprovalRequired]
    Click Button In VLMS    Submit

Verify Workflow Diagram Is Displayed
    [Arguments]    ${author_data}
    [Documentation]    Verify Workflow Diagram Is Displayed In Additional Information
    Scroll Element Into View    ${img.add_info.workflow.diagram}
    Wait Until Element Is Visible    ${img.add_info.workflow.diagram}    ${MEDIUM_WAIT}    Workflow Diagram is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    5
    Click Element    ${img.add_info.workflow.diagram}
    Wait Until Element Is Visible    ${label.content.author.document.workflow_diagram.initiated}    ${MEDIUM_WAIT}    Initiated activity is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{activities}    Split String    ${author_data}[AuditActivities]    |
    @{wf_list}    Split String    ${author_data}[WorkFlowDetails]    |
    FOR    ${key}    IN    @{wf_list}
        @{index_list}    Split String    ${key}    -
        ${audit_index}    Set Variable    ${index_list}[0]
        ${svg_indexes}    Set Variable    ${index_list}[1]
        Get And Verify Activities In WorkFlow Diagram    ${svg_indexes}    ${activities}[${audit_index}]
    END
    Scroll Element Into View    ${label.content.author.document.workflow_diagram.approver}
    ${approver}    Get Text    ${label.content.author.document.workflow_diagram.approver}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Run Keyword And Continue On Failure    Should Be Equal    ${approver}    ${AUTHOR_DOC_APPROVER}

Get Activity Details From WorkFlow Diagram
    [Arguments]    ${svg_indexes}
    [Documentation]    This keyword will Get Activity Details From WorkFlow Diagram
    @{svg_index_list}    Split String    ${svg_indexes}    ,
    ${user}    Get Text    (${label.content.author.document.workflow_diagram.activity_details})[${svg_index_list}[0]]
    ${activity}    Get Text    (${label.content.author.document.workflow_diagram.activity_details})[${svg_index_list}[1]]
    Scroll Element Into View    (${label.content.author.document.workflow_diagram.activity_details})[${svg_index_list}[2]]
    ${date}    Get Text    (${label.content.author.document.workflow_diagram.activity_details})[${svg_index_list}[2]]
    RETURN    ${activity}    ${user}    ${date}

Get And Verify Activities In WorkFlow Diagram
    [Arguments]    ${svg_indexes}    ${audit_activity}
    [Documentation]    This keyword will Get and Verify Activities In WorkFlow Diagram
    ${wf_activity}    ${wf_user}    ${wf_date}    Get Activity Details From WorkFlow Diagram    ${svg_indexes}
    ${activity_user}    Get From Dictionary    ${AUDIT_TRAIL_USERS}    ${audit_activity}
    ${activity_date}    Get From Dictionary    ${AUDIT_TRAIL_DATES}    ${audit_activity}
    Run Keyword And Continue On Failure    Should Contain    ${activity_date}    ${wf_date}
    Run Keyword And Continue On Failure    Should Contain    ${activity_user}    ${wf_user}
    # Log Actual And Expected Results    ${wf_activity} by ${wf_user} on ${wf_date}    ${wf_activity} by ${activity_user} on ${activity_date}

Navigate To Author External Document
    [Documentation]    This keyword is used to navigate to the Author External Document page
    Navigate To Module Tab    Content    Author    External Document    Select Document to Author

Navigate To External Document
    [Documentation]    This keyword is used to navigate to the external document
    Menu Navigation_5.0   Content    Document
    Click Button In VLMS    Upload

Get Document ID_Prerequisite
    [Documentation]    This keyword is used to get the entity type id
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.system.create.entity}    ${MEDIUM_WAIT}    Create Entity type page is not visible after waiting ${MEDIUM_WAIT} seconds
    ${actual_Doc_id}    Get Text    ${label.system.create.entity_code}
    ${updated_entity_id}    Remove String    ${actual_Doc_id}    <    >
    ${DOC_ID}    Set Variable    ${updated_entity_id}
    Set Global Variable    ${DOC_ID}

Author Documnet Externally
    [Arguments]    ${content_type_data}    ${USER}    ${USER_PASSWORD}
    [Documentation]    This keyword is used to enter details in author external document and submit
    ${count}    Get Length    ${content_type_data}
    Navigate To External Document
    FOR    ${key}    IN RANGE    0    ${count}
        ${content_author_data}    Set Variable    ${content_type_data}[${key}]
        IF    'AuthoringFor' in ${content_author_data}    Select Value For Radio Button    DevFor    ${content_author_data}[AuthoringFor]
        IF    'TaskType' in ${content_author_data}    Select Value For Radio Button    DocType    ${content_author_data}[TaskType]
        IF    'FolderName' in ${content_author_data}    Select Value From Dropdown    ddlListSiteFolder    ${content_author_data}[FolderName]
        IF    'Entity' in ${content_author_data}    Select Entity    ${content_author_data}[Entity]
        IF    'ContentType' in ${content_author_data}    Select Value From Dropdown    ddlValidationType_chosen    ${content_author_data}[ContentType]
        Get Entity ID_Prerequisite    ${content_author_data}[Entity]
        Get Document ID_Prerequisite
        IF    'InitiateAs' in ${content_author_data}    Select Value For Radio Button    DeliverableType    ${content_author_data}[InitiateAs]
        Wait Until Time    2
        IF    'DocumentTitle' in ${content_author_data}    Enter Text In Mandatory Fields    DocumentTitle    ${content_author_data}[DocumentTitle]
        IF    'Description' in ${content_author_data}    Enter Text In Mandatory Fields    Description    ${content_author_data}[Description]
        IF    'TargetDateType' in ${content_author_data}
            Click Calendar    ${icon.content.assign_doc.calendar}
            Select Target Date    ${content_author_data}[TargetDateType]    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${content_author_data}[Year]    ${content_author_data}[Month]    ${content_author_data}[Date]
        END
        IF    'CCRNo.' in ${content_author_data}    Enter Text In Mandatory Fields    ChreqNo    ${content_author_data}[CCRNo]
        IF    'DocumentMetadataForm' in ${content_author_data}    Select Value From Dropdown    ddlDocMeta_chosen    ${content_author_data}[DocumentMetadataForm]
        IF    'FileName' in ${content_author_data}    Upload External Document And Verify Success Message    ${content_author_data}[FileName]
        IF    'OriginalAuthor' in ${content_author_data}    Select Original Author    ${content_author_data}
        IF    'ConfirmRoute' in ${content_author_data}    Select Checkbox    ${checkbox.content.author.doc.confirm_routing}
        IF    'ApprovalRequired' in ${content_author_data}    Select Value For Radio Button    check    ${content_author_data}[ApprovalRequired]
        IF    'WorkFlow' in ${content_author_data}    Select Value From Dropdown    select2-ddWorkFlow-container    ${content_author_data}[WorkFlow]
        IF    'RouteFor' in ${content_author_data}    Select Value From Dropdown    ddlUserType    ${content_author_data}[RouteFor]
        #IF    'Comments' in ${content_author_data}    Enter Comments/Description    txtComments    ${content_author_data}[Comments]
        IF    'Button' in ${content_author_data}    Select Submit/Reset Button    ${content_author_data}[Button]
        ${status}    Run Keyword And Return Status    Wait Until Page Contains    Do you want to proceed?    ${SHORT_WAIT}
        IF    '${status}'=='True'    Verify Notification Popup    Document mapping not verified. Do you want to proceed?    btnSubmitConfirm
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        ${Expected_result}    Set Variable    ${content_author_data}[ContentType] document ${DOC_ID} for ${ENTITY_ID} has been approved
        #[Teardown]    Get Value From Toast Message    ${ExpectedResult}
        Get Value From Toast Message    ${Expected_result}
        Click Button In VLMS    Upload
        
    END

Create Template Group
    [Documentation]    Fill the template group
    [arguments]    ${tg_data}
    ${count}    Get Length    ${tg_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${dict_data}    Set Variable    ${tg_data}[${key}]
        Click Button In VLMS    Create
        IF    'GroupName' in ${dict_data}    Enter Text In Mandatory Fields    boxTitle    ${dict_data}[GroupName]
        IF    'Description' in ${dict_data}    Enter Text In Mandatory Fields    boxDescription    ${dict_data}[Description]
        IF    'Button' in ${dict_data}    Select Submit/Reset Button    ${dict_data}[Button]
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        ${Expected_Result}    Set Variable    ${dict_data}[GroupName] Template Group has been created.    
        Get Value From Toast Message    ${Expected_Result}
    END

Create Template
    [Documentation]    Create Template
    [arguments]    ${tg_data}    ${USER}    ${USER_PASSWORD}
    ${count}    Get Length    ${tg_data}
    FOR    ${key}    IN RANGE    0    ${count}
        ${create_data}    Set Variable    ${tg_data}[${key}]
        Navigate To Create Template
        IF    'TaskType' in ${create_data}    Select Value For Radio Button    rbtNew    ${create_data}[TaskType]
        IF    'Template For' in ${create_data}    Select Value From Dropdown    ddlTempType_chosen    ${create_data}[Template For]
        Wait Until Time    5
        ${tempfor}    Set Variable    ${create_data}[Template For]
        IF    '${tempfor}'=='Document'    Select Value From Dropdown    ddlTemplateType_chosen    ${create_data}[Template Type]
        Wait Until Time    5
        IF    'Template Group' in ${create_data}    Select Value From Dropdown    ddlTemplateGroup_chosen    ${create_data}[Template Group]
        Wait Until Time    5
        IF    'TemplateName' in ${create_data}    Enter Text In Mandatory Fields    BoxName    ${create_data}[TemplateName]
        ${TEMPLATE_NAME}    Set Variable    ${create_data}[TemplateName]
        Set Suite Variable    ${TEMPLATE_NAME}
        Wait Until Time    5
        IF    'TemplatePrefix' in ${create_data}    Enter Text In Mandatory Fields    Prefix    ${create_data}[TemplatePrefix]
        ${TEMPLATE_PREFIX}    Set Variable    ${create_data}[TemplatePrefix]
        Set Suite Variable    ${TEMPLATE_PREFIX}
        Wait Until Time    5
        IF    'TemplateDescription' in ${create_data}
            Select Frame    ${iframe.content.template.description}
            Javascript Click    ${body.template.description}
            Press Keys    ${body.template.description}    ${create_data}[TemplateDescription]
            Switch To Parent Frame
        END    
        Wait Until Time    5
        Upload External Document And Verify Success Message    ${create_data}[File]
        Select Checkbox    ${checkbox.content.author.doc.confirm_routing}
        IF    'ApprovalRequired' in ${create_data}    Select Value For Radio Button    check    ${create_data}[ApprovalRequired]
        IF    'TargetDateType' in ${create_data}
            Click Calendar    ${icon.content.assign_doc.calendar}
            Select Target Date    ${create_data}[TargetDateType]    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${create_data}[Year]    ${create_data}[Month]    ${create_data}[Date]
        END
        IF    'WorkFlow' in ${create_data}    Select Value From Dropdown    select2-ddWorkFlow-container    ${create_data}[WorkFlow]
        IF    'RouteFor' in ${create_data}    Select Value From Dropdown    ddlUserType    ${create_data}[RouteFor]
        #IF    'Comments' in ${create_data}    Enter Comments/Description    txtComments    ${create_data}[Comments]
        ${template_id}    Get Text    ${tab.template.id}
        Set Suite Variable    ${template_id}
        Wait Until Time    5
        IF    'Button' in ${create_data}    Select Submit/Reset Button    ${create_data}[Button]
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        Wait Until Time    4
        ${Expected_Result}    Set Variable    ${create_data}[TemplateName]-${template_id} Template has been created
        Get Value From Toast Message    ${Expected_Result}
        Wait Until Element Is Enabled    ${icon.home}    ${MEDIUM_WAIT}
        Unselect Frame
        Mouse Over   ${icon.home.common}
        Wait Until Time    ${MEDIUM_WAIT}
        #Click Element    ${icon.home.common}
        Menu Navigation_5.0    System    Bind    Template
        Enter Details In Bind Template Page    ${create_data}    ${template_id}
        Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
        ${Expected_Result}    Set Variable    Template has been Bound
        Get Value From Toast Message    ${Expected_Result}
    END

Navigate To Create Template
    [Documentation]    This keyword will navigate to create template page
    Menu Navigation_5.0    Content    Template
    Click Button In VLMS    Create
    Wait Until Time    5
    Wait Until Element Is Visible    ${tab.template.create}

Enter Details In Bind Template Page
    [Arguments]    ${bind_data}    ${templateid}
    [Documentation]    This will bind the created template as specified by user
    ${button.boundTo.new}    Update Dynamic Value    ${button.boundTo}    ${bind_data}[BoundTo]
    Wait Until Element Is Visible    ${button.boundTo.new}    ${MEDIUM_WAIT}    ${bind_data}[BoundTo] button is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${button.boundTo.new}
    Wait Until Time    3
    Select Content To Bind Template    ${bind_data}
    Select Value From Dropdown    ddlTemplateType_chosen    ${bind_data}[Template Type]
    Wait Until Time    3
    Click Element    ${dropdown.template.tobind}
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.template.tobind.search}    ${MEDIUM_WAIT}    Search box is not visible after waiting ${MEDIUM_WAIT} seconds
    Input Text    ${textbox.template.tobind.search}    ${templateid}
    ${checkbox.system.create.bind_task.newentity}    Update Dynamic Value    ${checkbox.system.create.bind_task.entity}   ${templateid}
    Wait Until Element Is Visible    ${checkbox.system.create.bind_task.newentity}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting ${MEDIUM_WAIT} seconds
    Click Element    ${checkbox.system.create.bind_task.newentity}
    Wait Until Time    2
    Click Element    ${dropdown.template.tobind}
    Click Button In VLMS    Save
    Wait Until Time    2
    Click Element    ${checkbox.bind.template.contenttype}
    Wait Until Time    2
    Click Element    ${checkbox.bind.template.workflow.applicableto}
    IF    'Comments' in ${bind_data}    Enter Comments/Description    txtComments    ${bind_data}[Comments]
    IF    'Button' in ${bind_data}    Select Submit/Reset Button    ${bind_data}[Button]

Select Content To Bind Template
     [Arguments]    ${bind_data}
    [Documentation]    This will select Caterory or SubCategory or Entity as mentioned in user input
    Click Element    ${dropdown.content.bind.template}
    Wait Until Time    3
    @{list}    Split String    ${bind_data}[BindTemplateWith]    ,
    FOR    ${key}    IN    @{list}
        IF    '${bind_data}[BoundTo]' == 'Category'
            Wait Until Element Is Visible    (${textbox.bindto.search})[1]    ${MEDIUM_WAIT}    Search box is not visible after waiting ${MEDIUM_WAIT} seconds
            Wait Until Time    2
            Input Text    (${textbox.bindto.search})[1]    ${key}
            ${checkbox.system.create.bind_task.newentity}    Update Dynamic Value    ${checkbox.system.create.bind_task.entity}   ${key}
            Wait Until Element Is Visible    ${checkbox.system.create.bind_task.newentity}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting ${MEDIUM_WAIT} seconds
            Click Element    ${checkbox.system.create.bind_task.newentity}
            Clear Element Text    (${textbox.bindto.search})[1]
        ELSE IF    '${bind_data}[BoundTo]' == 'Entity'
            Wait Until Element Is Visible    (${textbox.bindto.search})[3]    ${MEDIUM_WAIT}    Search box is not visible after waiting ${MEDIUM_WAIT} seconds
            Wait Until Time    2
            Input Text    (${textbox.bindto.search})[3]    ${key}
            ${checkbox.system.create.bind_task.newentity}    Update Dynamic Value    ${checkbox.system.create.bind_task.entity}   ${key}
            Wait Until Element Is Visible    ${checkbox.system.create.bind_task.newentity}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting ${MEDIUM_WAIT} seconds
            Click Element    ${checkbox.system.create.bind_task.newentity}
            Clear Element Text    (${textbox.bindto.search})[3]
        ELSE
            Wait Until Element Is Visible    (${textbox.bindto.search})[2]    ${MEDIUM_WAIT}    Search box is not visible after waiting ${MEDIUM_WAIT} seconds
            Wait Until Time    2
            Input Text    (${textbox.bindto.search})[2]    ${key}
            ${checkbox.system.create.bind_task.newentity}    Update Dynamic Value    ${checkbox.system.create.bind_task.entity}   ${key}
            Wait Until Element Is Visible    ${checkbox.system.create.bind_task.newentity}    ${MEDIUM_WAIT}    Checkbox is not visible after waiting ${MEDIUM_WAIT} seconds
            Click Element    ${checkbox.system.create.bind_task.newentity}
            Clear Element Text    (${textbox.bindto.search})[2]    
        END
    END
    Wait Until Time    2
    Click Element    ${dropdown.content.bind.template}
    Wait Until Time    2

Create Content Library_Prerequisite
    [Arguments]    ${table_name_list}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Create Content Library
    ${count}    Get Length    ${table_name_list}
    FOR    ${key}    IN RANGE    0    ${count}
        ${content_data}    Set Variable     ${table_name_list}[${key}]
        #Click Button In VLMS    Create
        Initiate Content Library_Prerequisite    ${content_data}    ${user_name}    ${password}
        Navigate To Author Content Library Page_Prerequisite
        Author Content Library    ${content_data}

        # Author Content Library_Prerequisite    ${content_data}
        # Approve Content Library_Prerequisite    ${content_data}
    END

Initiate Content Library_Prerequisite
    [Arguments]    ${content_data}    ${user_name}    ${password}
    [Documentation]    This Keyword is used to Initiate Content Library
    Navigate To Initiate Content Library Page
    Wait Until Element Is Visible    ${label.content.create.content_library.create.initiate_content_library}    ${MEDIUM_WAIT}    Initiate Content Library screen is not visible after waiting ${MEDIUM_WAIT} seconds
    IF    'ContentLibraryType' in ${content_data}    Select Value For Radio Button    TestType    ${content_data}[ContentLibraryType]
    Wait Until Time    2
    IF    '${content_data}[ContentLibraryType]'=='rbtEntity'
        IF    'TaskType' in ${content_data}    Select Value For Radio Button by ID    rbtnlstTFnDocType    ${content_data}[TaskType]
        IF    'SelectEntity' in ${content_data}    Select Value From Table Dropdown    ${content_data}[SelectEntity]
        IF    'ReferenceContentType' in ${content_data}    Select Value From Dropdown    ddlValidationType    ${content_data}[ReferenceContentType]
        Wait Until Time    2
        Select Last Value From Dropdown    ddlRequirement
    END
    IF    '${content_data}[ContentLibraryType]'=='rbtGeneric'
         IF    'TaskType' in ${content_data}    Select Value For Radio Button by ID    rbtnlstTFnDocType    ${content_data}[TaskType]
         Wait Until Time    4
         IF    'ContentLibraryGroup' in ${content_data}    Select Value From Dropdown    ddlTemplateGroup_chosen    ${content_data}[ContentLibraryGroup]
    END
    IF    'Assignment' in ${content_data}    Choose Assignee Type    ${content_data}[Assignment]    ${content_data}[AssignTo]
    IF    'TargetDateType' in ${content_data}
        Click Calendar    ${icon.content.assign_doc.calendar}
        Select Target Date    ${content_data}[TargetDateType]    txtBoxTargetDate    txtBoxTargetDate_DrpPnl_Calendar1_506    txtBoxTargetDate_DrpPnl_Calendar1_504    ${content_data}[Year]    ${content_data}[Month]    ${content_data}[Date]
    END
    IF    'Comments' in ${content_data}    Enter Text In Mandatory Fields    Comments    ${content_data}[Comments]
    IF    'Button' in ${content_data}    Select Submit/Reset Button    ${content_data}[Button]
    Handle Electronic Sign    ${user_name}    ${password}    Submit
    ${Expected_result}    Set Variable    Content Library has been initiated
    Get Value From Toast Message    ${Expected_result}

Navigate To Author Content Library Page_Prerequisite
    [Arguments]
    [Documentation]    This keyword will Navigate To Author Content Library Page
    #Unselect Frame
    #Menu Navigation_5.0    Content    Content Library
    Filter The Option And Search The Text    Assigned
    Press Key    ${label.contentlibrarytask.content.contentlibrary}    TAB
    Click Element    ${label.contentlibrarytask.content.contentlibrary}
    Wait Until Time    3
    Click Element    ${label.contentlibrarytask.content.contentlibrary}
    Wait Until Element Is Visible    ${link.contentlibrarytask.content.contentlibrary}
    Click Element    ${link.contentlibrarytask.content.contentlibrary}
    

Author Content Library
    [Arguments]    ${content_data}
    [Documentation]    This keyword is used to Author Content Library
    IF    '${content_data}[ContentLibraryType]'=='rbtEntity'
        Wait Until Element Is Visible    ${label.content.author.content_library.select.content_lib_task.author}    ${LONG_WAIT}    Author Content Library screen is not visible after waiting ${LONG_WAIT} seconds
        Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create}    ${MEDIUM_WAIT}    Create Link is not visible after waiting ${MEDIUM_WAIT} seconds
        Click Element    ${link.content.author.content_library.select_task.create}
        Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create.select_req}    ${MEDIUM_WAIT}    Select Link is not visible after waiting ${MEDIUM_WAIT} seconds
    END
    IF    'SelectRequirements' in ${content_data}
        Click Element    ${link.content.author.content_library.select_task.create.select_req}
        Select Requirements    ${content_data}[SelectRequirements]
    END
    Wait Until Element Is Visible    ${label.contentlibraryNo.content.author.contentlibrary}    ${MEDIUM_WAIT}
    ${CONTENT_LIBRARY_NO}    Get Text    ${label.contentlibraryNo.content.author.contentlibrary}
    Set Test Variable    ${CONTENT_LIBRARY_NO}
    IF    '${content_data}[ContentLibraryType]'=='rbtEntity'
        IF    'ContentLibraryName' in ${content_data}    Enter Text In Mandatory Fields    TestFnTitle    ${content_data}[ContentLibraryName]
        ${ContentLibraryName}    Set Variable    ${content_data}[ContentLibraryName]
        Set Suite Variable    ${ContentLibraryName}
        IF    'Prefix' in ${content_data}    Enter Text In Mandatory Fields    TestFnPrefix    ${content_data}[Prefix]
        IF    'Description' in ${content_data}    Enter Comments/Description    txtBoxDesc   ${content_data}[Description]
    END
    IF    '${content_data}[ContentLibraryType]'=='rbtGeneric'
        IF    'ContentLibraryName' in ${content_data}    Enter Text In Mandatory Fields    BoxName    ${content_data}[ContentLibraryName]
        ${ContentLibraryName}    Set Variable    ${content_data}[ContentLibraryName]
        Set Suite Variable    ${ContentLibraryName}
        IF    'Description' in ${content_data}    Enter Comments/Description    txtBoxDesc   ${content_data}[Description]
    END
    IF    '${content_data}[ContentLibraryType]'=='rbtGeneric'
        Upload External Document And Verify Success Message    ${content_data}[FileName]
    END
    IF    'ContentLibraryStructure' in ${content_data}    Select Value From Dropdown    ddlTable    ${content_data}[ContentLibraryStructure]
    IF    'RowDetails1' in ${content_data}
        Wait Until Element Is Visible    ${icon.content.author.content_library.create.table.add_row}    ${MEDIUM_WAIT}    Add a row icon is not visible after waiting for ${MEDIUM_WAIT} seconds
        Click Element    ${icon.content.author.content_library.create.table.add_row}
        Select Requirements From Content Table And Verify Displayed Details    ${content_data}[RowNo1]    ${content_data}[ContentTableRequirements]
        Enter Details In Content Library Table    ${content_data}[RowNo1]    ${content_data}[RowDetails1]
    END
    IF    '${content_data}[ContentLibraryType]'=='rbtGeneric'
        Select Checkbox    ${checkbox.content.author.doc.confirm_routing}
        IF    '${content_data}[Approval]'=='rdoYes'
            IF    'ApprovalRequired' in ${content_data}    Select Value For Radio Button    check    ${content_data}[Approval]
            IF    'WorkFlow' in ${content_data}    Select Value From Dropdown    select2-ddWorkFlow-container    ${content_data}[WorkFlow]
            IF    'RouteFor' in ${content_data}    Select Value From Dropdown    ddlUserType    ${content_data}[RouteFor]
            IF    'Comments' in ${content_data}    Enter Comments/Description    txtComments    ${content_data}[Comments]
            IF    'Button' in ${content_data}    Select Submit/Reset Button    ${content_data}[Button]
            ${EXPECTED_SUCCESS_MSG}    Set Variable    Content Library ${content_data}[ContentLibraryName]--${CONTENT_LIBRARY_NO} has been routed for Review
            Set Test Variable    ${EXPECTED_SUCCESS_MSG}
            Verify Document Is Routed For Peer Review/Review/Approval    ${AUTHOR}    ${AUTHOR_PASSWORD}    ${EXPECTED_SUCCESS_MSG}
            Logout From VLMS Application
            #Content library Review process    ${content_data}
            # Content library route to approval    ${content_data}
            # Content Library Approval Process    ${content_data}
        ELSE
            IF    'ApprovalRequired' in ${content_data}    Select Value For Radio Button    check    ${content_data}[Approval]
            IF    'Button' in ${content_data}    Select Submit/Reset Button    ${content_data}[Button]
            Handle Electronic Sign    ${USER}    ${USER_PASSWORD}    Submit
            ${EXPECTED_SUCCESS_MSG}    Set Variable    ${content_data}[ContentLibraryName]--${CONTENT_LIBRARY_NO} Content Library has been created
            Set Test Variable    ${EXPECTED_SUCCESS_MSG}
            Get Value From Toast Message    ${EXPECTED_SUCCESS_MSG}
            Logout From VLMS Application
        END
    ELSE
            Verify Entered Details In The Content Library Grid    ${content_data}[RowNo1]    ${content_data}[RowDetails1]
            Approve Content Library    ${content_data}
            IF    'ApprovalRequired' in ${content_data}    Select Value For Radio Button    check    ${content_data}[Approval]
            IF    'Button' in ${content_data}    Select Submit/Reset Button    ${content_data}[Button]
            ${EXPECTED_SUCCESS_MSG}    Set Variable    Content Library Task ${CONTENT_LIBRARY_TASKID}-Set-01 has been approved
            Set Test Variable    ${EXPECTED_SUCCESS_MSG}
            Get Value From Toast Message    ${EXPECTED_SUCCESS_MSG}
            Logout From VLMS Application
    END


Select Requirements
    [Arguments]    ${table_req_list}
    [Documentation]    This keyword is used to Select Requirements in Author Content Library
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Element Is Visible    ${label.content.author.content_library.select_task.create.select_req_screen}    ${MEDIUM_WAIT}    Select Requirement screen is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Element Is Visible    ${dropdown.content.author.content_library.select_req.select_table}    ${MEDIUM_WAIT}    Select table dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{table_list}    Split String    ${table_req_list}    |
    FOR    ${key}    IN    @{table_list}
        @{list}    Split String    ${key}    _
        ${tableno}    Set Variable    ${list}[0]
        ${select_list}    Set Variable    ${list}[1]
        @{select_reqlist}    Split String    ${select_list}    ,
        Select From List By Label    ${dropdown.content.author.content_library.select_req.select_table}    ${tableno}
        Wait Until Time    2
        FOR    ${key}    IN    @{select_reqlist}
            ${checkbox.content.author.content_library.select_req.newselect_req_no}    Update Dynamic Value    ${checkbox.content.author.content_library.select_req.select_req_no}    ${key}
            Wait Until Element Is Visible    ${checkbox.content.author.content_library.select_req.newselect_req_no}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
            Select Checkbox    ${checkbox.content.author.content_library.select_req.newselect_req_no}
        END
    END
    Click Button In VLMS    Save
    Verify Confirmation Popup    Requirements have been saved    btnMessageOk
    Click Navigation Buttons In Screen    Close

Enter Details In Content Library Table
    [Arguments]    ${row_no}    ${details}
    [Documentation]    This keyword is used to Enter Details in Content Library Table
    ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${row_no}
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${MEDIUM_WAIT}    ${row_no} row is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{details_list}    Split String    ${details}    |
    ${col_no}    Set Variable    1
    FOR    ${key}    IN    @{details_list}
        IF    "${key}"!="None"
            Wait Until Element Is Visible    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]    ${MEDIUM_WAIT}    cell is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]
            Wait Until Time    1
            Press Keys    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]    ${key}
        END
        ${col_no}    Evaluate    ${col_no}+1
    END

Verify Entered Details In The Content Library Grid
    [Arguments]    ${row_no}    ${details}
    [Documentation]    This keyword is used to Verify Entered Details In The Content Library Grid In Author Content Library Screen
    ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${row_no}
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${MEDIUM_WAIT}    ${row_no} row is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{details_list}    Split String    ${details}    |
    ${col_no}    Set Variable    1
    FOR    ${key}    IN    @{details_list}
        IF    "${key}"!="None"
            Wait Until Element Is Visible    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]    ${MEDIUM_WAIT}    cell is not visible after waiting for ${MEDIUM_WAIT} seconds
            Click Element    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]
            Wait Until Time    1
            Press Keys    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]    BACKSPACE
            ${value}    Get Element Attribute    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[${col_no}]/input    value
            Should Be Equal    ${key}    ${value}
            Log Expected And Actual Results    ${key}    ${value}
        END
        ${col_no}    Evaluate    ${col_no}+1
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Select Requirements From Content Table And Verify Displayed Details
    [Arguments]    ${row_no}    ${table_with_list}
    [Documentation]    This keyword is used to Select Requirements From Content Table Reference Column and Verify displayed details in Reference cell
    Wait Until Element Is Visible    (${icon.content.author.content_library.table.reference.search_icon})[${row_no}]    ${MEDIUM_WAIT}    Search icon is not visible after waiting for ${MEDIUM_WAIT} seconds
    @{selected_requirements}    Create List
    @{table_list}    Split String    ${table_with_list}    |
    FOR    ${key}    IN    @{table_list}
        Click Element   (${icon.content.author.content_library.table.reference.search_icon})[${row_no}]
        Wait Until Element Is Visible    ${dropdown.content.author.content_library.table.reference.select_requirements}    ${MEDIUM_WAIT}    Select table dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
        @{list}    Split String    ${key}    _
        ${table}    Set Variable    ${list}[0]
        ${select_req_list}    Set Variable    ${list}[1]
        @{req_list}    Split String    ${select_req_list}    ,
        Select From List By Label    ${dropdown.content.author.content_library.table.reference.select_requirements}    ${table}
        Wait Until Time    2
        FOR    ${value}    IN    @{req_list}
            ${checkbox.content.author.content_library.table.reference.newselect_requirements}    Update Dynamic Value    ${checkbox.content.author.content_library.table.reference.select_requirements}    ${value}
            Wait Until Element Is Visible    ${checkbox.content.author.content_library.table.reference.newselect_requirements}    ${SHORT_WAIT}    Checkbox is not visible after waiting for ${SHORT_WAIT} seconds
            Select Checkbox    ${checkbox.content.author.content_library.table.reference.newselect_requirements}
        END
        Click Element    ${button.content.author.content_library.table.search.save}
        Verify Notification Popup    Reference saved successfully    btnConfirmOk
        Click Button In VLMS    Close
        Append To List    ${selected_requirements}    @{req_list}
    END
    Log    ${selected_requirements}
    ##Wait Until Element Is Visible    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[4]    ${MEDIUM_WAIT}    Reference cell is not visible after waiting for ${MEDIUM_WAIT} seconds
    ##Wait Until Time    3
    ##Click Element    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[3]
    ##Wait Until Time    10
    ##Press Keys    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[4]    BACKSPACE
    ##Wait until time    10
    ##${value}    Get Element Attribute    (${label.content.author.content_library.create.content_table.cell})[${row_no}]/td[3]/input    value
    ##${displayed_values}    Split String    ${value}    ,
    ##Lists Should Be Equal    ${selected_requirements}    ${displayed_values}
    ##Log Expected And Actual Results    ${selected_requirements}    ${displayed_values}

Import Testcase In Author Content Library
    [Arguments]    ${content_data}
    [Documentation]    This keyword is used to Import Testcase In Author Content Library Screen
    Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create.import}   ${MEDIUM_WAIT}    Import link is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${link.content.author.content_library.select_task.create.import}
    Unselect Frame
    Wait Until Element Is Visible    ${iframe.library_frame.screen}    ${MEDIUM_WAIT}    Frame is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Frame    ${iframe.library_frame.screen}
    Wait Until Element Is Visible    ${button.content.author.content_library.import.browse}    ${MEDIUM_WAIT}    Browse button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Time    4
    Choose File    ${textbox.content.author.content_library.import.fileupload}    ${SAMPLE_EXCEL_FOLDER}
    Wait Until Time    3
    Click Element    ${link.content.author.content_library.import.browse.upload}
    Wait Until Element Is Visible    ${label.content.author.content_library.import.browse.upload.tableheader}    ${MEDIUM_WAIT}    Table header is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    'HeadersList' in ${content_data}
        @{header_list}    Split String    ${content_data}[HeadersList]    ,
        ${index}    Set Variable    1
        FOR    ${key}    IN    @{header_list}
            Wait Until Element Is Visible    (${dropdown.content.author.content_library.import.upload.headers})[${index}]    ${MEDIUM_WAIT}    Header dropdown is not visible after waiting for ${MEDIUM_WAIT} seconds
            Select From List By Label    (${dropdown.content.author.content_library.import.upload.headers})[${index}]    ${key}
            ${index}    Evaluate    ${index}+1
        END
    END
    Click Element    ${button.content.author.content_library.import.upload.save}
    Verify Notification Popup    Do you want to append the Content ?    btnDevDiscussionAlertOk
    Unselect Frame
    Select Frame    ${iframe.framecontent}

Insert A Row In The Content Table
    [Arguments]    ${select_row_to_insert}
    [Documentation]    This keyword is used to Insert a Row In The Content Table
    Wait Until Element Is Visible    ${link.content.author.content_library.select_task.create.import}   ${MEDIUM_WAIT}    Import link is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${label.content.author.content_library.create.add_row.newrow_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.row_no}    ${select_row_to_insert}
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newrow_no}    ${LONG_WAIT}    ${select_row_to_insert} row is not visible after waiting for ${LONG_WAIT} seconds
    Wait Until Time    2
    ${row_count_before_insert}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    Click Element    ${label.content.author.content_library.create.add_row.newrow_no}
    ${label.content.author.content_library.create.add_row.newselected_row_no}    Update Dynamic Value    ${label.content.author.content_library.create.add_row.selected_row_no}    ${select_row_to_insert}
    Wait Until Element Is Visible    ${label.content.author.content_library.create.add_row.newselected_row_no}    ${MEDIUM_WAIT}    selected row is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${icon.content.author.content_library.create.table.insert_row}
    Wait Until Time    4
    ${row_count_after_insert}    Get Element Count    ${label.content.author.content_library.create.content_table.rows}
    ${exp_count}    Evaluate    ${row_count_before_insert}+1
    Should Be Equal    ${row_count_after_insert}    ${exp_count}

Delete A Row From The Content Table
    [Arguments]    ${select_row_to_delete}
    [Documentation]    This keyword is used to Delete a Row From The Content Table
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

Approve Content Library
    [Arguments]    ${content_data}
    [Documentation]    This keyword is used to Approve Content Library
    Click Button In VLMS    Save and Complete
    Verify Confirmation Popup    Content Library Task has been completed    btnMessageOk
    ${checkbox.content.author.content_library.select_content_libno.newcheckbox}    Update Dynamic Value    ${checkbox.content.author.content_library.select_content_libno.checkbox}    ${CONTENT_LIBRARY_NO}
    Wait Until Element Is Visible    ${checkbox.content.author.content_library.select_content_libno.newcheckbox}    ${MEDIUM_WAIT}    ${CONTENT_LIBRARY_NO} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Select Checkbox    ${checkbox.content.author.content_library.select_content_libno.newcheckbox}
    ${CONTENT_LIBRARY_TASKNO}    Get Text    ${label.content.author.content_library.author_content_lib.content_lib_task_no}
    Set Test Variable    ${CONTENT_LIBRARY_TASKNO}
    ${Content_library_TaskID}    Get Text    ${label.contentlibraryNo.content.author.contentlibrary}
    Set Test Variable    ${CONTENT_LIBRARY_TASKID}
    ##IF    'Approval' in ${content_data}
        Select Value For Radio Button    WorkflowReq    ${content_data}[Approval]
        IF    '${content_data}[Approval]'=='rbtnWorkflowYes'
            Wait Until Time    2
            IF    'Workflow' in ${content_data}    Select Value From Dropdown    ddlWorkflow    ${content_data}[Workflow]
            IF    'RouteTaskFor' in ${content_data}    Select Value From Dropdown    ddlWorkflowTransfer    ${content_data}[RouteTaskFor]
        END
    ##END
    ##IF    'ApproveComments' in ${content_data}    Enter Comments/Description    txtComments    ${content_data}[ApproveComments]
    ##IF    'Button1' in ${content_data}    Select Submit/Reset Button    ${content_data}[Button1]
    ##${EXPECTED_MESSAGE}    Set Variable    Content Library Task ${CONTENT_LIBRARY_TASKNO}-Set-01 has been Approved
    ##RETURN    ${EXPECTED_MESSAGE}

