#!/usr/bin/env bash

com_errors=0
for com in "jq" "yq"
do
    if ! hash $com
    then
        echo "command $com not found; please install before proceeding" && \
        com_errors=$((com_errors + 1))
    fi
done

if [ $com_errors -ne 0 ]
then
    exit $com_errors
fi

if ! yq --version | grep mikefarah >/dev/null
then
    echo "This requires Go-based yq; please install"
    exit 4
fi

yq -o json . ./*yaml | jq -s '.[0] * .[1]' > final.json