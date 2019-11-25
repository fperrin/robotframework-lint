*** Settings ***
| Documentation
| ... | Runs rflint against the rflint test suites and resource files
|
| Library    | OperatingSystem
| Library    | Process
| Library    | SharedKeywords.py
| Resource   | SharedKeywords.robot

*** Test Cases ***
Run rflint on all files and verify there are no errors
| | [Documentation] | Self-test RFLint by running it against RFLint testcases
| | @{ALL ROBOT FILES} | List Robot files in | tests/
| | FOR | ${file} | IN | @{ALL ROBOT FILES}
| |     Run keyword and continue on failure
| |     ... | Run rflint and verify there are no errors or warnings | ${file}
| | END

*** Keywords ***
| Run rflint and verify there are no errors or warnings
| | [Arguments] | ${filename}
| | [Documentation]
| | ... | Run rflint against the rflint tests
| |
| | Run rf-lint with the following options:
| | ... | --format | {severity}: {linenumber}, {char}: {message} ({rulename})
| | ... | --configure | TooFewTestSteps:1
| | ... | --configure | TooFewKeywordSteps:1
| |       # Test cases quoting long output exceed accepted line length
| | ... | --configure | LineTooLong:120
| | ... | ${filename}
| |
| | @{messages}= | Split to lines | ${result.stdout}
| | ${warnings}= | Get match count | ${messages} | regexp=^W:
| | ${errors}=   | Get match count | ${messages} | regexp=^E:
| |
| | Run keyword if | ${result.rc} != 0 or ${warnings} != 0 or ${errors} != 0
| | ... | Fail | unexpected errors or warnings: \n${result.stdout}\n${result.stderr}
