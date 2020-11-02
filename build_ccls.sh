#!/bin/sh

ccls_dir=$1
if [ -z "$1" ]; then
    ccls_dir="build/ccls"
fi

ninja $2 -C $ccls_dir/Release
