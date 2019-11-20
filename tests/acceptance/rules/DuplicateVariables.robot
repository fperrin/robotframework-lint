*** Settings ***
| Documentation | Tests for the suite rule 'DuplicateVariables'
| Resource      | ../SharedKeywords.robot
|
| Test Teardown
| ... | Run keyword if | "${TEST STATUS}" == "FAIL"
| ... | log | ${result.stdout}\n${result.stderr}

*** Test Cases ***
| Verify duplicate variable definitions raise an error
| | [Documentation]
| | ... | Verify duplicate variable definitions raise an error
| |
| | [Setup] | Run rf-lint with the following options:
| | ... | --no-filename
| | ... | --ignore | all
| | ... | --error  | DuplicateVariables
| | ... | test_data/acceptance/rules/DuplicateVariables_Data.robot
| |
| | Stderr should be | ${EMPTY}
| | Stdout should be
| | ... | E: 3, 0: Duplicate definition of variable 'some_var' (previously defined line 2) (DuplicateVariables)
| | ... | E: 4, 0: Duplicate definition of variable 'SomeVar' (previously defined line 2) (DuplicateVariables)
