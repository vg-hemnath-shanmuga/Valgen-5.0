*** Settings ***
Documentation     This report resource file has all the report menu keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Select Status From Data Source
    [Arguments]    ${data_source}
    [Documentation]    This keyword is used to select the required status from data source in ad hoc report
    Wait Until Time    3
    Wait Until Element Is Visible    ${checkbox.report.create.ad_hoc_report.status.all}    ${MEDIUM_WAIT}    All checkbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${check_box_status}    Run Keyword And Return Status    Checkbox Should Be Selected    ${checkbox.report.create.ad_hoc_report.status.all}
    IF    '${check_box_status}'=='True'
        Click Element    ${checkbox.report.create.ad_hoc_report.status.all}
        ${splitted_data_source}    Split String    ${data_source}    ,
        ${data_source_count}    Get Length    ${splitted_data_source}
        FOR    ${key}    IN RANGE    0    ${data_source_count}
            ${checkbox.report.create.ad_hoc_report.newstatus}    Update Dynamic Value    ${checkbox.report.create.ad_hoc_report.status}    ${splitted_data_source}[${key}]
            Select Checkbox    ${checkbox.report.create.ad_hoc_report.newstatus}
        END
    END

Enter Adhoc Reports Details
    [Arguments]    ${report_data}
    [Documentation]    This keyword is used to enter report details
    IF    'ReportTitle' in ${report_data}    Input Text    ${textbox.report.create.ad_hoc_report.title}    ${report_data}[ReportTitle]
    ${REPORT_TITLE}    Set Variable    ${report_data}[ReportTitle]
    Set Test Variable    ${REPORT_TITLE}
    IF    'AccessMode' in ${report_data}    Select Value For Radio Button    radio		${report_data}[AccessMode]
    IF    'ReportType' in ${report_data}    Select Value From Dropdown    ddlReportType		${report_data}[ReportType]
    IF    'DataSourceStatus' in ${report_data}    Select Status From Data Source    ${report_data}[DataSourceStatus]
    Wait Until Time    2
    Click Element    ${label.report.create.ad_hoc_report.filters}
    IF    'DataGroup' in ${report_data}    Select Value For Radio Button    radio    ${report_data}[DataGroup]
    Navigate To Page Title Tab    Preview
    Wait Until Element Is Visible    ${label.report.create.ad_hoc_report.preview.excel}    ${MEDIUM_WAIT}    Excel img is not visible after waiting for ${MEDIUM_WAIT} seconds

Get Tool Tip Text From Bar Chart
    [Arguments]    ${status_fill}
    [Documentation]    This keyword is used to get the tool tip text from bar chart
    ${img.report.create.ad_hoc_report.preview.summary_view.newstatus}    Update Dynamic Value    ${img.report.create.ad_hoc_report.preview_bar_chart}    ${status_fill}
    Wait Until Element Is Visible    ${img.report.create.ad_hoc_report.preview.summary_view.newstatus}    ${MEDIUM_WAIT}    Approved status bar is not visible after waiting for ${MEDIUM_WAIT} seconds
    Mouse Over    ${img.report.create.ad_hoc_report.preview.summary_view.newstatus}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${tool_tip_text}    Get Text    ${label.report.create.ad_hoc_report.preview.tool_tip.text}
    Log    ${tool_tip_text}

Verify Preview Of Ad Hoc Report
    [Arguments]    ${report_data}
    [Documentation]    This keyword is used to Verify fields under preview tab
    Wait Until Time    4
    Get Tool Tip Text From Bar Chart    ${report_data}[Status]
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.report.create.ad_hoc_report.preview.details_view}
    Wait Until Element Is Visible    ${label.report.create.ad_hoc_report.preview.excel}
    Wait Until Element Is Visible    ${label.report.create.ad_hoc_report.preview.summary_view}
    Wait Until Element Is Visible    ${label.report.create.ad_hoc_report.preview.print}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    ${SUMMARY_VIEW_DETAILS}    Get Summary View Details From Ad Hoc Report
    Set Suite Variable    ${SUMMARY_VIEW_DETAILS}
    ${PROJECT_IDS}    Get Project IDs From Ad Hoc Report    APPROVED
    Set Suite Variable    ${PROJECT_IDS}

Get Summary View Details From Ad Hoc Report
    [Documentation]    This keyword is used to get all summary view detals of report from Application
    ${summary_keys}    Create List
    FOR    ${key}    IN RANGE    1    7
        ${summary_key}    Get Text    (${label.report.create.ad_hoc_report.preview.details})[${key}]
        Append To List    ${summary_keys}    ${summary_key}
    END
    ${summary_values}    Create List
    FOR    ${key}    IN RANGE    7    13
        ${summary_value}    Get Text    (${label.report.create.ad_hoc_report.preview.details})[${key}]
        Append To List    ${summary_values}    ${summary_value}
    END
    ${summary_view_details}    Create Dictionary From Two Lists    ${summary_keys}    ${summary_values}
    RETURN    ${summary_view_details}

Get Project IDs From Ad Hoc Report
    [Arguments]    ${report_status}
    [Documentation]    This keyword is used to get all approved project ids of reports from application
    ${summary_view_details}    Get Summary View Details From Ad Hoc Report
    ${approved_count}    Get From Dictionary    ${summary_view_details}    ${report_status}
    ${approved_count}    Convert To Integer    ${approved_count}
    ${project_ids_count}    Evaluate    26+${approved_count}
    ${project_ids}    Create List
    FOR    ${key}    IN RANGE    26    ${project_ids_count}
        ${project_id}    Get Text    (${label.report.create.ad_hoc_report.preview.details})[${key}]
        Append To List    ${project_ids}    ${project_id}
    END
    RETURN    ${project_ids}

Download Excel Report
    [Documentation]    This keyword is used to download the report xls file and change into xlsx file
    Click Element    ${label.report.create.ad_hoc_report.preview.excel}
    Wait Until Time    3
    Get Downloads Folder Path
    Convert Xls 2 Xlsx    ${DOWNLOADS_FOLDER}\\Report.xls    ${UPDATED_EXCEL_PATH}

Verify Summary Details From Excel Report
    [Arguments]    ${report_summary_view_details}
    [Documentation]    This keyword is used to Verify the summary report details from application with downloaded excel file
    ${excel_summary_view_details}    Get Summary View Details From Excel    ${UPDATED_EXCEL_PATH}
    ${excel_summary_details_count}    Get Length    ${excel_summary_view_details}
    FOR    ${key}    IN RANGE    0    ${excel_summary_details_count}
        ${excel_keys}    Get Dictionary Keys    ${excel_summary_view_details}
        ${report_keys}    Get Dictionary Keys    ${report_summary_view_details}
        Verify String Should Contain    ${report_keys}[${key}]    ${excel_keys}[${key}]
        ${excel_summary_values}    Get From Dictionary    ${excel_summary_view_details}    ${excel_keys}[${key}]
        ${excel_summary_values}    Convert To String    ${excel_summary_values}
        ${report_summary_values}    Get From Dictionary    ${report_summary_view_details}    ${report_keys}[${key}]
        ${excel_summary_values}    Convert To String    ${excel_summary_values}
        Verify String Should Contain    ${report_summary_values}    ${excel_summary_values}
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Project IDs From Excel Report
    [Arguments]    ${report_project_ids}
    [Documentation]    This keyword is used to Verify report project ids from aplication and from downloaded excel file
    ${report_project_id_count}    Get Length    ${report_project_ids}
    ${report_project_id_count}    Convert To Integer    ${report_project_id_count}
    ${excel_project_ids}    Get Project Ids From Excel    ${UPDATED_EXCEL_PATH}    ${report_project_id_count}
    ${excel_project_ids_count}    Get Length    ${excel_project_ids}
    FOR    ${key}    IN RANGE    0    ${excel_project_ids_count}
        Verify String Should Contain    ${report_project_ids}[${key}]    ${excel_project_ids}[${key}]
    END
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Verify Excel Report
    [Documentation]    This keyword is used to Verify summary and project ids from applcation report details and from downloaded excel file
    Verify Summary Details From Excel Report    ${SUMMARY_VIEW_DETAILS}
    Verify Project IDs From Excel Report    ${PROJECT_IDS}
    Remove File    ${DOWNLOADS_FOLDER}\\Report.xls
    Remove File    ${UPDATED_EXCEL_PATH}

Print Preview
    [Arguments]    ${report_data}
    [Documentation]    This keyword is used to print the preview
    Click Element    ${label.report.create.ad_hoc_report.preview.print}
    Verify Success Message    ${report_data}[PrintMessage]    val1_btnErrorAlertPopok
    # Verify Confirmation Popup    ${report_data}[PrintMessage]    val1_btnErrorAlertPopok
    ${EXPECTED_SUCCESS_MSG}    Set Variable    Report Title ${report_data}[ReportTitle] has been created
    Set Test Variable    ${EXPECTED_SUCCESS_MSG}

Submit Electronic Sign And Verify Notification Message
    [Arguments]    ${login_user}    ${login_password}    ${excepted_msg}    ${reason}=None
    [Documentation]    This keyword is used to submit Electronic Popup and Verify notification message
    IF    '${reason}'!='None'
        Handle Electronic Sign    ${login_user}    ${login_password}    Submit    ${reason}
    ELSE
        Handle Electronic Sign    ${login_user}    ${login_password}    Submit
    END
    Wait Until Element Is Visible    ${label.notification_popup.message}    ${MEDIUM_WAIT}    Message is not visible after waiting for ${MEDIUM_WAIT} seconds
    ${actual_msg}    Get Text    ${label.notification_popup.message}
    Verify String Should Be Equal    ${actual_msg}    ${excepted_msg}
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
    Wait Until Time    1
    Wait Until Element Is Visible    ${button.success_alert.ok}    ${MEDIUM_WAIT}    Ok button is not visible after waiting for ${MEDIUM_WAIT} seconds
    Javascript Click    ${button.success_alert.ok}

Get PDF Text
    [Documentation]    This keyword is used to read text from PDF
    ${expected_pdf_details}    Convert Pdf To Txt    ${DOWNLOADS_FOLDER}\\Report.pdf
    RETURN    ${expected_pdf_details}

Search For PDF Report
    [Arguments]    ${report_name}
    [Documentation]    This keyword is used to search for pdf report
    Unselect Frame
    #Click Top Menu Icons    Refresh
    Select Frame    ${iframe.framecontent}
    Javascript Click    ${textbox.home.search}
    Javascript Input Text    ${textbox.home.search}    ${report_name}
    ${label.home.newdocument}    Update Dynamic Value    ${label.home.document}    ${report_name}
    Wait Until Time    2
    Click Using Javascript    ${label.home.newdocument}

Download PDF Report
    [Arguments]    ${report_name}    ${pdf_name}=None
    [Documentation]    This keyword is used to download PDF report
    #Click Top Menu Icons    Home
    Navigate To Dashboard Title Tabs    Task List    My Task
    Wait Until Time    2
    Wait Until Element Is Visible    ${textbox.home.search}    ${MEDIUM_WAIT}    Search textbox is not visible after waiting for ${MEDIUM_WAIT} seconds
    Wait Until Keyword Succeeds    ${PDF_LOADING_TIME}     10    Search For PDF Report    ${report_name}
    Wait Until Time    4
    Get Downloads Folder Path
    IF    '${pdf_name}'=='None'
        ${pdf_name}    Set Variable    ${report_name}.pdf
    END
    Wait Until Keyword Succeeds    25s    1s    File Should Exist    ${DOWNLOADS_FOLDER}\\${pdf_name}
    ${EXPECTED_PDF_DETAILS}    Get Pdf Content    ${DOWNLOADS_FOLDER}\\${pdf_name}
    Set Suite Variable    ${EXPECTED_PDF_DETAILS}
    Unselect Frame

Verify PDF Report
    [Arguments]    ${report_data}    ${report_summary_view_details}    ${report_project_ids}
    [Documentation]    This keyword is used to validtae the summary report details from application with downloaded pdf report
    Open File And Take Screenshot    ${DOWNLOADS_FOLDER}\\Report.pdf    ${EXECDIR}\\DownloadedFiles\\${report_data}[FileName]
    ${report_summary_details_count}    Get Length    ${report_summary_view_details}
    FOR    ${report_key}    IN RANGE    0    ${report_summary_details_count}
        ${keys}    Get Dictionary Keys    ${report_summary_view_details}
        Verify String Should Contain    ${EXPECTED_PDF_DETAILS}    ${keys}[${report_key}]
        ${summary_values}    Get From Dictionary    ${report_summary_view_details}    ${keys}[${report_key}]
        Verify String Should Contain    ${EXPECTED_PDF_DETAILS}    ${summary_values}
    END
    ${report_project_ids_count}    Get Length    ${report_project_ids}
    FOR    ${key}    IN RANGE    0    ${report_project_ids_count}
        Verify String Should Contain    ${EXPECTED_PDF_DETAILS}    ${project_ids}[${key}]
    END
    Remove File    ${DOWNLOADS_FOLDER}\\Report.pdf

Expand Treeview In Audit Trail Report
    [Arguments]    ${tree_menu}    ${tree_sub_menu}
    [Documentation]    This keyword is used to expand treeview in the audit trail report page
    Wait Until Time    2
    ${label.report.view.audit_trail_report.newtree_menu}    Update Dynamic Value    ${label.report.view.audit_trail_report.tree_menu}    ${tree_menu}
    Wait Until Element Is Visible    ${label.report.view.audit_trail_report.newtree_menu}    ${MEDIUM_WAIT}
    Click Element    ${label.report.view.audit_trail_report.newtree_menu}
    ${label.report.view.audit_trail_report.newtree_sub_menu}    Update Dynamic Value    ${label.report.view.audit_trail_report.tree_sub_menu}    ${tree_sub_menu}
    Wait Until Time    2
    Wait Until Element Is Visible    ${label.report.view.audit_trail_report.newtree_sub_menu}    ${MEDIUM_WAIT}    ${tree_sub_menu} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Click Element    ${label.report.view.audit_trail_report.newtree_sub_menu}
    ${label.newsection}    Update Dynamic Value    ${label.section}    ${tree_sub_menu}
    Wait Until Element Is Visible    ${label.newsection}    ${MEDIUM_WAIT}    ${tree_sub_menu} section is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot

Search For Title In Audit Trail Report
    [Arguments]    ${title}
    [Documentation]    This keyword is used to search for title in audit trail report
    Input Text    ${textbox.report.view.audit_trail_report.search}    ${title}
    Click Element    ${button.report.view.audit_trail_report.search}
    ${label.report.view.audit_trail_report.newtitle_view}    Update Dynamic Value    ${label.report.view.audit_trail_report.project_title}    ${title}
    Wait Until Time    3
    Wait Until Element Is Visible    ${label.report.view.audit_trail_report.newtitle_view}    ${MEDIUM_WAIT}    ${title} is not visible after waiting for ${MEDIUM_WAIT} seconds
    Clear Element Text    ${textbox.report.view.audit_trail_report.search}

Get Title Status
    [Arguments]    ${title}
    [Documentation]    This keyword is used to get status of given report title
    ${label.report.view.audit_trail_report.title.newstatus}    Update Dynamic Value    ${label.report.view.audit_trail_report.title.status}    ${title}
    ${actual_title_status}    Get Text    ${label.report.view.audit_trail_report.title.newstatus}
    RETURN    ${actual_title_status}

Verify Project ID Status Using Searchbar
    [Arguments]    ${report_data}    ${project_ids}
    [Documentation]    This keyword is used to Verify all project status using search bar
    ${project_ids_count}    Get Length    ${project_ids}
    FOR    ${key}    IN RANGE    0    ${project_ids_count}
        Search For Title In Audit Trail Report    ${project_ids}[${key}]
        ${actual_title_status}    Get Title Status    ${project_ids}[${key}]
        Verify String Should Be Equal    ${report_data}[ProjectStatus]    ${actual_title_status}
        IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
        Wait Until Time    2
    END

Verify Project ID Status
    # robocop: disable=unused-variable
    [Arguments]    ${expected_project_ids}
    [Documentation]    This keyword is used to Verify all project status
    ${actual_project_id's}    Create List
    ${page}    Set Variable    1
    ${continue_loop}    Set Variable    ${TRUE}
    WHILE    ${continue_loop}
        ${element_count}    Get Element Count    ${label.report.view.audit_trial_report.title}
        FOR    ${element}    IN RANGE    1    ${element_count}+1
            # IF    '${SCREENSHOT}'=='True'    Capture Allure Screenshot
            Scroll Element Into View    (${label.report.view.audit_trial_report.title})[${element}]
            Wait Until Element Is Visible    (${label.report.view.audit_trial_report.title})[${element}]
            ${title}    Get Text    (${label.report.view.audit_trial_report.title})[${element}]
            ${splitted_id}    Split String    ${title}    (
            ${project_id}    Split String    ${splitted_id}[1]    )
            Append To List    ${actual_project_id's}    ${project_id}[0]
        END
        IF    '${page}' != '1'
            ${button.report.view.audit_trial_report.newpage}    Update Dynamic Value    ${button.report.view.audit_trial_report.page}    ${page}
            Scroll Till Element Is Visible    ${button.report.view.audit_trial_report.page_count}
            Wait Until Time    1
            ${status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.report.view.audit_trial_report.newpage}
            IF    '${status}'=='False'
                ${status1}    Run Keyword And Return Status    Wait Until Element Is Visible    ${button.report.view.audit_trial_report.page_double_right}
                IF    '${status1}'=='False'
                    ${continue_loop}    Set Variable    ${FALSE}
                    BREAK
                END
                IF    '${status1}'=='True'    Click Element    //a[text()='...']
            END
            IF    '${status}'=='True'    Click Element    ${button.report.view.audit_trial_report.newpage}
            Wait Until Time    3
        END
        ${page}    Evaluate    ${page}+1
        ${page}    Convert To String    ${page}
    END
    Log    ${actual_project_id's}
    Log    ${expected_project_ids}
    FOR    ${project}    IN    @{expected_project_ids}
        Run Keyword And Continue On Failure    List Should Contain Value    ${actual_project_id's}    ${project}
    END

Navigate To Audit Trail Report Page
    [Documentation]    This keyword will navigate to Audit Trail Report Page
    Navigate To Module Tab    Report    View    Audit Trail Report    Audit Trail Report    True
