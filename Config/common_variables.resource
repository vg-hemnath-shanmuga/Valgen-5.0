*** Settings ***
Documentation     This common variables file has all the common variable

*** Variables ***
${BASE_URL}       https://loadtest.valgenesis.net/VGV5AUTOTEST
${BROWSER_NAME}    chrome
${SYSTEMUSER}           sysman
${USER}           hem
${REVIEWER}       richard
${APPROVER}       richard
${DM_USER}           trevor
${DM_APPROVER}       paula
${TEST_USER}    guestqz
${PDF_LOADING_TIME}    9 min
${REVIEWER_PASSWORD}    welcome@2
${APPROVER_PASSWORD}    welcome@2
${TEST_PASSWORD}    test321
${DM_USER_PASSWORD}    welcome@1
${DM_APPROVER_PASSWORD}    welcome@1
${AUTHOR}    hem
${AUTHOR_PASSWORD}    valgen
${SYSTEM_PASSWORD}    valgen
${USER_PASSWORD}    valgen
${SHORT_WAIT}     5
${MEDIUM_WAIT}    20
${LONG_WAIT}      40
${TESTDATA_FOLDER}    ${EXECDIR}\\Testdata
${PREREQUISITESDATA_FOLDER}    ${EXECDIR}\\Testdata\\Prerequsite.xlsx
${IMAGE_FOLDER}    ${EXECDIR}\\ImportFiles\\VG_Logo.png
${UPDATED_EXCEL_PATH}    ${EXECDIR}\\DownloadedFiles\\Report.xlsx
${SAMPLE_EXCEL_FOLDER}    ${EXECDIR}\\ImportFiles\\VGexcel.xlsx
${SCREENSHOT}     True
${VIDEO}          False
@{DELIVERABLES}    Operational Qualification    Functional Requirement Specification    User Requirement Specification    Positive Testcase    Negative Testcase    QZ_Content    Performance Qualification    TC
${DM_ENTITY}    DesignEnt
${VERSION}    Ma01.Mi01.P02.SP0