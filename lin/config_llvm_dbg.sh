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

cmake -H$llvm_dir/llvm -B$llvm_dir/build/Debug -G Ninja -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLLVM_ENABLE_LLD=1 -DLLVM_ENABLE_LTO=Off -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"
