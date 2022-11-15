*** Settings ***
Documentation   Test suite to validate arithmetic operations
...
...             Keywords are imported from the resource file
Resource        keywords.resource
Library     AppiumLibrary   run_on_failure=AppiumLibrary.CapturePageScreenshot
Test Setup  Start Appium Server
Test Teardown  Stop Appium Server


*** Variables ***
# Test Data
${TD_OPERAND1}                              5
${TD_OPERAND2}                              2
${TD_PLUS_OPERATOR}                         plus
${TD_MINUS_OPERATOR}                        minus
${TD_MULTIPLY_OPERATOR}                     multiply
${TD_DIVIDE_OPERATOR}                       divide
${TD_EXPECTED_ADDITION_RESULT}              7
${TD_EXPECTED_SUBTRACTION_RESULT}           3
${TD_EXPECTED_MULTIPLICATION_RESULT}        10
${TD_EXPECTED_DIVISION_RESULT}              2.5
${TD_EXPECTED_DIVISION_SYMBOLIC_RESULT}     2 1⁄2


*** Test Cases ***
Addition Test case
    [Documentation]     Validates sum operation
    Open Calculator
    Enter Digits And Sum Operator   ${TD_OPERAND1}    ${TD_OPERAND2}    ${TD_PLUS_OPERATOR}
    View Result
    Verify Result   ${TD_EXPECTED_ADDITION_RESULT}

Subtraction Test case
    [Documentation]     Validates subtraction operation
    Open Calculator
    Enter Digits And Sum Operator   ${TD_OPERAND1}    ${TD_OPERAND2}    ${TD_MINUS_OPERATOR}
    View Result
    Verify Result   ${TD_EXPECTED_SUBTRACTION_RESULT}

Multiplication Test case
    [Documentation]     Validates multiply operation
    Open Calculator
    Enter Digits And Sum Operator   ${TD_OPERAND1}    ${TD_OPERAND2}    ${TD_MULTIPLY_OPERATOR}
    View Result
    Verify Result   ${TD_EXPECTED_MULTIPLICATION_RESULT}

Division Test case
    [Documentation]     Validates division operation
    Open Calculator
    Enter Digits And Sum Operator   ${TD_OPERAND1}    ${TD_OPERAND2}    ${TD_DIVIDE_OPERATOR}
    View Result
    Verify Result   ${TD_EXPECTED_DIVISION_RESULT}

Division With Symbolic Result Test case
    [Documentation]     Validates division operation and the symbolic representation of result
    Open Calculator
    Enter Digits And Sum Operator   ${TD_OPERAND1}    ${TD_OPERAND2}    ${TD_DIVIDE_OPERATOR}
    View Result
    Verify Symbolic Result   ${TD_EXPECTED_DIVISION_SYMBOLIC_RESULT}
