

#!/bin/bash
#Create new pulumi stack
pulumi new typescript --dir converted
tf2pulumi >converted/index.ts
