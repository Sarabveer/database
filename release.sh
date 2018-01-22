#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

log_messages=$(git log -1 --format=%s)
major_re=\\bMAJOR\\b
minor_re=\\bMINOR\\b

echo ${log_messages}

if [[ ${log_messages} =~ ${major_re}  ]]; then
    echo "Major Release"
    release-it major -n --npm.access=public --github.release --github.assets=build/database.sqlite
elif [[ ${log_messages} =~ ${minor_re} ]]; then
    echo "Minor Release"
    release-it minor -n --npm.access=public --github.release --github.assets=build/database.sqlite
else
    echo "Patch Release"
    release-it patch -n --npm.access=public --github.release --github.assets=build/database.sqlite
fi