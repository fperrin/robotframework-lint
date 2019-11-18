import re

from rflint.common import ResourceRule

class InvalidTableInResource(ResourceRule):
    '''Verify that there are no invalid table headers'''
    def apply(self, resource):
        for table in resource.tables:
            if (not re.match(r'^(comments?|settings?|metadata|tasks?|(user )?keywords?|variables?)$',
                             table.name, re.IGNORECASE)):
                self.report(resource, "Unknown table name '%s'" % table.name, table.linenumber)
