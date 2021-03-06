#!/usr/bin/env bash
set -e

[ -d .coffee.mk ] || (
    git submodule add git://github.com/andreineculau/coffee.mk .coffee.mk
)

SYMLINK=(
    "test/_utils.coffee"
    "test/mocha.opts"
    .coffeelint.json
    .npmignore
    Makefile
    testem.yml
)

for FILE in ${SYMLINK[*]}; do
    [ -e $FILE ] || [ -L $FILE ] || (
        DIR=`dirname $FILE`
        mkdir -p $DIR
        cd $DIR
        REL=`python -c "import os.path; print os.path.relpath('.coffee.mk/$FILE', '$DIR')" `
        ln -s "$REL" "`basename $FILE`"
    )
done

COPY=(
    "test/index.coffee"
    .gitignore
    .travis.yml
    bin
    custom.mk
    LICENSE
    README.md
    index.coffee
    package.json
    src
    test
)

for FILE in ${COPY[*]}; do
    [ -e $FILE ] || (
        mkdir -p `dirname $FILE`
        DIR=`dirname $FILE`
        cp -R .coffee.mk/$FILE $DIR
    )
done
