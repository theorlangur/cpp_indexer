@echo off

SET ccls_dir=%1
SET ccls_commit=%2
SET llvm_dir=%3

IF "%1"=="" (SET ccls_dir=build\ccls)
IF "%2"=="" (SET ccls_commit=master)
IF "%3"=="" (SET llvm_dir=build\llvm)

IF NOT EXIST %llvm_dir% (
    ECHO "Expected to find llvm repo in '%llvm_dir%' but failed"
    EXIT 1
)

IF NOT EXIST %llvm_dir%\Release (
    ECHO "Cannot find '%llvm_dir%\Release'. LLVM must be configured first."
    EXIT 2
)


md %ccls_dir%
IF EXIST %ccls_dir%\^.git (
    pushd %ccls_dir%
    git reset --hard
    IF %ccls_commit%==master (git pull --ff-only)
    popd
) ELSE (
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls %ccls_dir%
)

pushd %ccls_dir%
git checkout %ccls_commit%
popd

git apply --directory=%ccls_dir% ccls_dependencies.patch

cmake -H%ccls_dir% -B%ccls_dir%\Release -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=clang-cl -DCMAKE_PREFIX_PATH="%CD%\%llvm_dir%\Release;%CD%\%llvm_dir%\Release\tools\clang;%CD%\%llvm_dir%\llvm;%CD%\%llvm_dir%\clang;%CD%\%llvm_dir%\tools\clang"
rem ninja -C %ccls_dir%\Release

