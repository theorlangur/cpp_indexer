#!/bin/sh

llvm_dir=$1
llvm_commit=$2

if [ -z "$1" ]; then
    llvm_dir="build/llvm"
fi

if [ -z "$2" ]; then
    llvm_commit="main"
fi

mkdir -p $llvm_dir
if [ -d "$llvm_dir/.git" ]
then
    pushd $llvm_dir
    if [[ "$llvm_commit" == "main" ]]; then
	git pull --ff-only
    fi
    popd
else
    git clone https://github.com/theorlangur/llvm-project.git $llvm_dir
fi

cmake -H$llvm_dir/llvm -B$llvm_dir/build/Release -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -Wno-dev
#ninja -C $llvm_dir/Release clangd clangFormat clangFrontendTool clangIndex clangTooling clang

