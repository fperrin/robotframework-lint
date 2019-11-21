*** Settings ***
| Documentation | Tests for the rule 'InvalidSetting'
| Resource      | ../SharedKeywords.robot
|
| Test Teardown
| ... | Run keyword if | "${TEST STATUS}" == "FAIL"
| ... | log | ${result.stdout}\n${result.stderr}

*** Test Cases ***
| Verify invalid setting names are detected
| | [Documentation]
| | ... | Verify that invalid setting names for keywords and
| | ... | test cases cause errors.
| |
| | [Setup] | Run rf-lint with the following options:
| | ... | --no-filename
| | ... | --ignore | all
| | ... | --error  | InvalidSetting
| | ... | --error  | InvalidSettingInKeyword
| | ... | test_data/acceptance/rules/InvalidSetting_Data.robot
| |
| | rflint return code should be | 4
| | rflint should report 4 errors
| | rflint should report 0 warnings

| Verify that the proper error message is returned
| | [Documentation]
| | ... | Verify that InvalidSetting returns the expected message
| | ... | for every error
| |
| | [Setup] | Run rf-lint with the following options:
| | ... | --no-filename
| | ... | --ignore | all
| | ... | --error  | InvalidSetting
| | ... | --error  | InvalidSettingInKeyword
| | ... | test_data/acceptance/rules/InvalidSetting_Data.robot
| |
| | Output should contain
| | ... | E: 4, 0: Non-existing setting 'Setup' (InvalidSettingInKeyword)
| | ... | E: 5, 0: Non-existing setting 'bogus' (InvalidSettingInKeyword)
| | ... | E: 11, 0: Non-existing setting 'Set up' (InvalidSetting)
| | ... | E: 12, 0: Non-existing setting 'Tear down' (InvalidSetting)
