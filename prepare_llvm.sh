#!/bin/sh

llvm_dir=$1
llvm_commit=$2

if [ -z "$1" ]; then
    llvm_dir="build/llvm"
fi

if [ -z "$2" ]; then
    llvm_commit="master"
fi

mkdir -p $llvm_dir
if [ -d "$llvm_dir/.git" ]
then
    pushd $llvm_dir
    git reset --hard
    if [[ "$llvm_commit" == "master" ]]; then
	git pull --ff-only
    fi
    popd
else
    git clone https://github.com/llvm/llvm-project.git $llvm_dir
fi

pushd $llvm_dir
git checkout $llvm_commit
popd

git apply --directory=$llvm_dir compile_db_dependencies.patch
git apply --directory=$llvm_dir clangd_fix_score.patch


cmake -H$llvm_dir/llvm -B$llvm_dir/Release -G Ninja -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"
#ninja -C $llvm_dir/Release clangd clangFormat clangFrontendTool clangIndex clangTooling clang

