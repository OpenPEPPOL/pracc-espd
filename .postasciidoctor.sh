#!/bin/sh

cp -r espd-edm/docs/src/main/asciidoc/images /target/guide/edm/

if [ -e /target/site ]; then
    mv /target/guide/* /target/site/
    rm -r /target/guide
fi
