@echo off

SET llvm_dir=%1
SET llvm_commit=%2

IF "%1"=="" (SET llvm_dir=build\llvm)
IF "%2"=="" (SET llvm_commit=main)

md %llvm_dir%
IF EXIST %llvm_dir%\^.git (
    pushd %llvm_dir%
    git reset --hard
    if %llvm_commit%==main (git pull --ff-only)
    popd
) ELSE (
    git clone https://github.com/llvm/llvm-project.git %llvm_dir%
)

pushd %llvm_dir%
git checkout %llvm_commit%
git clean -f
popd

git apply --directory=%llvm_dir% patch\clangd_dependencies_pch.patch


cmake -H%llvm_dir%\llvm -B%llvm_dir%\build\Release -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"
rem ninja -C $llvm_dir/Release clangd clangFormat clangFrontendTool clangIndex clangTooling clang

