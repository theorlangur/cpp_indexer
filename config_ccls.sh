#!/bin/sh

ccls_dir=$1
llvm_dir=$2

if [ -z "$1" ]; then
    ccls_dir="build/ccls"
fi

if [ -z "$2" ]; then
    llvm_dir="build/llvm"
fi

if [ ! -d "$llvm_dir" ]; then
    echo "Expected to find llvm repo in '$llvm_dir' but failed"
    exit 1
fi

if [ ! -d "$llvm_dir/Release" ]; then
    echo "Cannot find '$llvm_dir/Release'. LLVM must be configured first."
    exit 2
fi


if [ ! -d "$ccls_dir" ]; then
  echo "ccls dir '$ccls_dir' doesn't exist"
  exit 3
fi

cur_dir=$(pwd)

cmake -H$ccls_dir -B$ccls_dir/Release -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_EXE_LINKER_FLAGS=-fuse-ld=lld -DCMAKE_PREFIX_PATH="$cur_dir/$llvm_dir/Release;$cur_dir/$llvm_dir/llvm;$cur_dir/$llvm_dir/clang"
#ninja -C $ccls_dir/Release

