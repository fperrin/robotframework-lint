*** Settings ***
| Documentation | Tests for the suite rule 'EmptyContinuation'
| Resource      | ../SharedKeywords.robot
|
| Test Teardown
| ... | Run keyword if | "${TEST STATUS}" == "FAIL"
| ... | log | ${result.stdout}\n${result.stderr}

*** Test Cases ***
| Verify deprecated empty continuation lines raise an error
| | [Documentation]
| | ... | Verify deprecated empty continuation lines raise an error in keywords
| |
| | [Setup] | Run rf-lint with the following options:
| | ... | --no-filename
| | ... | --ignore | all
| | ... | --error  | EmptyContinuationInKeyword
| | ... | test_data/acceptance/rules/EmptyContinuationInKeyword_Data.robot
| |
| | Stderr should be | ${EMPTY}
| | Stdout should be
| | ... | E: 5, 0: Ignoring lines with only continuation marker '...' is deprecated (EmptyContinuationInKeyword)
| | ... | E: 21, 0: Ignoring lines with only continuation marker '...' is deprecated (EmptyContinuationInKeyword)

| Verify deprecated empty continuation lines raise an error in test cases
| | [Documentation]
| | ... | Verify deprecated empty continuation lines raise an error in testcases
| |
| | [Setup] | Run rf-lint with the following options:
| | ... | --no-filename
| | ... | --ignore | all
| | ... | --error  | EmptyContinuationInTest
| | ... | test_data/acceptance/rules/EmptyContinuationTestCase_Data.robot
| |
| | Stderr should be | ${EMPTY}
| | Stdout should be
| | ... | E: 4, 0: Ignoring lines with only continuation marker '...' is deprecated (EmptyContinuationInTest)
| | ... | E: 11, 0: Ignoring lines with only continuation marker '...' is deprecated (EmptyContinuationInTest)
| | ... | E: 15, 0: Ignoring lines with only continuation marker '...' is deprecated (EmptyContinuationInTest)
