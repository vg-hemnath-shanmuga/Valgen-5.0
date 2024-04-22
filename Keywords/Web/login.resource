*** Settings ***
Documentation     This login Resource file has all the login keywords
Resource          ../../Config/super.resource


*** Keywords ***
# robocop: disable=unnecessary-string-conversion
Login To VLMS Application
    [Arguments]    ${username}    ${password}
    [Documentation]    Login To VLMS Application
    Launch Web Application    ${BROWSER_NAME}    ${BASE_URL}
    Wait Until Element Is Visible    ${textbox.login.username}    ${LONG_WAIT}    Login page is not visible after waiting for ${LONG_WAIT} seconds
    Input Text    ${textbox.login.username}    ${username}
    Input Text    ${textbox.login.password}    ${password}
    ${button.newsubmit/reset}    Update Dynamic Value    ${button.submit/reset}    Submit
    Javascript Click    ${button.newsubmit/reset}
    ${alert_status}    Run Keyword And Return Status    Wait Until Element Is Visible    ${label.home.expire_password_alert}    ${SHORT_WAIT}    Expire password alert is not visible after waiting for ${MEDIUM_WAIT} seconds
    IF    '${alert_status}'=='True'    Click Button In VLMS    Ok
    Wait Until Time    ${MEDIUM_WAIT}
    Mouse Over    ${icon.home}     
    Wait Until Element Is Visible    ${icon.home}    ${LONG_WAIT}    Home page is not visible after waiting for ${LONG_WAIT} seconds
