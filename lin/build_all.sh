#!/bin/sh

./prepare_llvm.sh
./prepare_ccls.sh
./build_llvm.sh "" -j10
./build_ccls.sh "" -j10
