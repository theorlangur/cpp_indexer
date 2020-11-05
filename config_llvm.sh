#!/bin/sh

llvm_dir=$1

if [ -z "$1" ]; then
    llvm_dir="build/llvm"
fi

if [ ! -d "$llvm_dir" ]
then
echo "llvm dir '$llvm_dir' doesn't exist"
exit 1
fi

cmake -H$llvm_dir/llvm -B$llvm_dir/Release -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"
#ninja -C $llvm_dir/Release clangd clangFormat clangFrontendTool clangIndex clangTooling clang

