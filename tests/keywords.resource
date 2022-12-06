*** Settings ***
Documentation   Keywords to enter operands and operators
...             and to check results
Library     Process


*** Variables ***
${REMOTE_URL}           http://127.0.0.1:4723/wd/hub
${PLATFORM_NAME}        Android
${PLATFORM_VERSION}     10.0
${DEVICE_NAME}          emulator-5554
${APP_PATH}             ${CURDIR}/../apps/calculator.apk

# Element locators
${EQUALS_SIGN}                  xpath=//android.widget.ImageButton[@content-desc="equals"]
${DISPLAYED_RESULT}             xpath=//*[contains(@resource-id,'com.google.android.calculator:id/result_final')]
${DISPLAYED_SYMBOLIC_RESULT}    xpath=//*[contains(@resource-id,'com.google.android.calculator:id/symbolic')]


*** Keywords ***
Start Appium Server
    [Documentation]     Starts Appium server
    Start Process  appium  shell=True  alias=appiumserver
    ...     stdout=${CURDIR}/appium_stdout.txt  stderr=${CURDIR}/appium_stderr.txt
    Process Should Be Running  appiumserver
    Sleep  10s

Stop Appium Server
    [Documentation]     Stops Appium server
    Terminate Process  appiumserver  kill=True

Open Calculator
    [Documentation]     Opens calculator
    Open Application   ${REMOTE_URL}
    ...     platformName=${PLATFORM_NAME}
    ...     platformVersion=${PLATFORM_VERSION}
    ...     deviceName=${DEVICE_NAME}
    ...     automationName=UiAutomator2
    ...     newCommandTimeout=2500
    ...     app=${CURDIR}/${APP_PATH}

Enter Digits And Sum Operator
    [Documentation]     Enters operands and operator for current arithmetic operation
    [Arguments]    ${operand1}    ${operand2}   ${operator}
    Click Element   xpath=//android.widget.ImageButton[@content-desc="${operand1}"]
    Click Element   xpath=//android.widget.ImageButton[@content-desc="${operator}"]
    Click Element   xpath=//android.widget.ImageButton[@content-desc="${operand2}"]

View Result
    [Documentation]     Select 'equals' key to show arithmetic opertion result
    Click Element    xpath=//android.widget.ImageButton[@content-desc="equals"]

Verify Result
    [Documentation]     Compares exptectd result with actual result
    [Arguments]     ${expected_result}
    ${displayed_result} =   Get Element Attribute   ${DISPLAYED_RESULT}     text
    Should Be Equal     ${displayed_result}     ${expected_result}

Verify Symbolic Result
    [Documentation]     Compares exptectd symbolic result with actual symbolic result
    [Arguments]     ${expected_result}
    ${displayed_result} =   Get Element Attribute   ${DISPLAYED_SYMBOLIC_RESULT}     text
    Should Be Equal     ${displayed_result}     ${expected_result}
