#!/usr/bin/env bash
set -e

[ -d .coffee.mk ] && (
    cd .coffee.mk
    git fetch
    git diff ..origin/master
)
