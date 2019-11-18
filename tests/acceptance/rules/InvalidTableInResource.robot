*** Settings ***
| Documentation | Tests for the rule 'InvalidTableInResource'
| Resource      | ../SharedKeywords.robot
|
| Test Teardown
| ... | Run keyword if | "${TEST STATUS}" == "FAIL"
| ... | log | ${result.stdout}\n${result.stderr}

*** Test Cases ***
| Verify all invalid table names in a resource file are detected
| | [Documentation]
| | ... | Verify that all invalid table names in a resource
| | ... | file cause errors, and all valid names do not.
| | ... | Note: the test data is a collection of both valid
| | ... | and invalid names.
| |
| | [Setup] | Run rf-lint with the following options:
| | ... | --no-filename
| | ... | --ignore | all
| | ... | --error  | InvalidTableInResource
| | ... | test_data/acceptance/rules/InvalidTableInResource_Data.robot
| |
| | rflint return code should be | 5
| | rflint should report 5 errors
| | rflint should report 0 warnings

| Verify that the proper error message is returned
| | [Documentation]
| | ... | Verify that InvalidTableInResource returns the
| | ... | expected message for every error
| |
| | [Setup] | Run rf-lint with the following options:
| | ... | --no-filename
| | ... | --ignore | all
| | ... | --error  | InvalidTableInResource
| | ... | test_data/acceptance/rules/InvalidTableInResource_Data.robot
| |
| | Output should contain
| | ... | E: 6, 0: Unknown table name '' (InvalidTableInResource)
| | ... | E: 7, 0: Unknown table name '' (InvalidTableInResource)
| | ... | E: 8, 0: Unknown table name '' (InvalidTableInResource)
| | ... | E: 9, 0: Unknown table name 'Key word' (InvalidTableInResource)
| | ... | E: 33, 0: Unknown table name 'bogus' (InvalidTableInResource)
