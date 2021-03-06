#!/usr/bin/env bash

# runs on start up on heroku

set -e

# exports the slug for download at http://shaas.example.com/app/slug.tgz

slug_file=/app/slug.tgz
if [ ! -f $slug_file ]; then
    slug_tmp_file=/tmp/slug.tgz
    tar cz --transform s,^./,./app/, --owner=root -C /app . > $slug_tmp_file
    mv $slug_tmp_file $slug_file

    shasum --algorithm 256 $slug_file | cut -f 1 -d ' ' | tr -d '\n' > ${slug_file}.sha256
fi
