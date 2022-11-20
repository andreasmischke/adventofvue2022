#!/usr/bin/env bash

indexFile="./docs/index.html"
directories="$(ls -1 ./ | grep -e '^\d\d')"

echo "---" > $indexFile
echo "layout: default" >> $indexFile
echo "days:" >> $indexFile

for dir in $directories; do
    echo "  - $dir" >> $indexFile
    pushd $dir;
    npm run build -- --outDir=../docs/$dir --emptyOutDir --base=/adventofvue2022/$dir/ .
    popd;
done;

echo "---" >> $indexFile
