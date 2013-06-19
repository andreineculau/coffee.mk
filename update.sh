#!/usr/bin/env bash
set -e

[ -d .coffee.mk ] && (
    cd .coffee.mk
    git fetch
    git checkout master
    git fetch
    git reset --hard origin/master
    cd -
    .coffee.mk/install.sh
)
