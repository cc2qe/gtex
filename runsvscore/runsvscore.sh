#!/bin/bash

#rsync -avP /gscmnt/gc2719/halllab/users/lganel/SVScore/gtex_splits/split.pl .
#rsync -avP /gscmnt/gc2719/halllab/users/lganel/SVScore/gtex_splits/generatesvscorecalls.pl .

echo "Splitting file..."
zless $1 | awk '$0~"^#" { print $0; next } { print $0 | "sort -k3,3" }' | python split_vcf.py # Split the VCF into chunks of ~1000 variants + header

echo "Generating calls...";
perl generatesvscorecalls.pl . > svscorecalls.sh # Create bomb calls
sh svscorecalls.sh # Execute bomb calls
