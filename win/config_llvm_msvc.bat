@echo off

SET llvm_dir=%1

IF "%1"=="" (SET llvm_dir=build\llvm)

IF NOT EXIST %llvm_dir% (
echo "llvm dir '%llvm_dir%' doesn't exist"
exit 1
)

cmake -H%llvm_dir%\llvm -B%llvm_dir%\build\MSVC -Thost=x64 -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=cl -DCMAKE_CXX_COMPILER=cl -DLLVM_TARGETS_TO_BUILD=X86 -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"
rem ninja -C $llvm_dir/Release clangd clangFormat clangFrontendTool clangIndex clangTooling clang

