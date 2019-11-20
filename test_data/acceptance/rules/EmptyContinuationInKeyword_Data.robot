*** Keywords ***
| Keyword 1
| | @{list}= | Create List
| | ... | Empty continuation lines in list definition are deprecated
| | ...
| | ... | In Robot 2 they're merely ignored

| Keyword 2
| | @{list2}= | Create List
| | ... | This list is different, its second element is the empty string.
| | ... | \
| | ... | That's fine, don't warn

| Keyword 3
| | [Documentation] |
| | ... | Documentation sections often use empty lines to break paragraphs
| | ... |
| | ... | That's fine, don't warn
| |
| | But do warn in a keyword body
| | ...
| | ... | Like here
