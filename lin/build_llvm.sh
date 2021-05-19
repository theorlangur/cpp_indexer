#!/bin/sh

llvm_dir=$1
if [ -z "$1" ]; then
    llvm_dir="build/llvm"
fi

ninja $2 -C $llvm_dir/build/Release clangd clangFormat clangFrontendTool clangIndex clangTooling clang
