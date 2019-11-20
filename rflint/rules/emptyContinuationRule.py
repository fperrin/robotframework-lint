from rflint.common import KeywordRule, TestRule, WARNING, normalize_name

def empty_continuation_apply(self, keyword_or_testcase):
    '''Lines with only continuation marker '...' is deprecated in Robot3.1.2

    See https://github.com/robotframework/robotframework/issues/3107

    Empty continuation lines is not allowed, except in Documentation sections'''
    in_documentation = False
    for row in keyword_or_testcase.rows:
        if len(row) == 1:
            continue
        elif normalize_name(row[1]) == normalize_name("[Documentation]"):
            in_documentation = True
        elif row[1] == "...":
            if in_documentation: 
                continue
            if len(row) == 2:
                self.report(keyword_or_testcase, "Ignoring lines with only " \
                    "continuation marker '...' is deprecated", row.linenumber)
        else:
            in_documentation = False


class EmptyContinuationInKeyword(KeywordRule):
    '''Lines with only continuation marker '...' is deprecated in Robot3.1.2'''

    def apply(self, keyword):
        return empty_continuation_apply(self, keyword)


class EmptyContinuationInTest(TestRule):
    '''Lines with only continuation marker '...' is deprecated in Robot3.1.2'''

    def apply(self, testcase):
        return empty_continuation_apply(self, testcase)
