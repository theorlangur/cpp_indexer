@echo off

prepare_llvm.bat
build_llvm.bat "" -j6
prepare_ccls.bat
build_ccls.bat "" -j6
