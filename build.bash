#!/usr/bin/env bash

singleDirectory="$1";
if [[ -n "$singleDirectory" ]] && [[ ! -d "$singleDirectory" ]]; then
    "Error: '$singleDirectory' is not a directory"
    exit 1
fi

indexFile="./docs/index.html"
directories="$(ls -1 ./ | grep -P '^\d\d')"

echo "---" > $indexFile
echo "layout: default" >> $indexFile
echo "days:" >> $indexFile

for dir in $directories; do
    echo "  - $dir" >> $indexFile

    if [[ -z "$singleDirectory" ]] || [[ "$dir" == "$(basename $singleDirectory)" ]]; then
        pushd $dir;
        npm run build -- --outDir=../docs/$dir --emptyOutDir --base=/adventofvue2022/$dir/ .
        popd;
    fi
done;

echo "---" >> $indexFile
