

#!/bin/bash
#Create new pulumi stack
pulumi new typescript --dir converted
cp ./userdata.sh converted/userdata.sh
tf2pulumi >converted/index.ts
