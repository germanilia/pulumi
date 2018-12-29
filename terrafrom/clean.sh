

#!/bin/bash
#Create new pulumi stack
cd converted
pulumi stack select converted-dev
pulumi destroy --yes
cd ..
rm -r -f converted
pulumi stack rm converted-dev