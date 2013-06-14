#!/usr/bin/env bash

[ -d .coffee.mk ] || (
    git submodule add git://github.com/andreineculau/coffee.mk .coffee.mk
)

COPY=(
    .gitignore
    bin
    LICENSE
    Makefile
    NOTICE
    README.md
    index.coffee
    package.json
    src
    test
)

for FILE in ${COPY[*]}; do
    [ -f $FILE ] || (
        cp -R .coffee.mk/$FILE ./
    )
done

SYMLINK=(
    "test/mocha.opts"
    "test/utils.coffee"
    .npmignore
    .travis.yml
    testem.yml
)

for FILE in ${SYMLINK[*]}; do
    [[ -f $FILE ]] || (
        ln -s ".coffee.mk/$FILE" "$FILE"
    )
done
