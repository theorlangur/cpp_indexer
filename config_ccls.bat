@echo off

SET ccls_dir=%1
SET llvm_dir=%2

IF "%1"=="" (SET ccls_dir=build\ccls)
IF "%2"=="" (SET llvm_dir=build\llvm)

IF NOT EXIST %llvm_dir% (
    ECHO "Expected to find llvm repo in '%llvm_dir%' but failed"
    EXIT 1
)

IF NOT EXIST %llvm_dir%\Release (
    ECHO "Cannot find '%llvm_dir%\Release'. LLVM must be configured first."
    EXIT 2
)


IF NOT EXIST %ccls_dir% (
    ECHO "ccls dir '%ccls_dir%' doesn't exist"
    EXIT 3
) 

cmake -H%ccls_dir% -B%ccls_dir%\Release -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="%CD%\%llvm_dir%\Release;%CD%\%llvm_dir%\Release\tools\clang;%CD%\%llvm_dir%\llvm;%CD%\%llvm_dir%\clang;%CD%\%llvm_dir%\tools\clang"
rem ninja -C %ccls_dir%\Release

