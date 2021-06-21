@echo off

SET llvm_dir=%1
IF "%1"=="" (SET llvm_dir=build\llvm)

ninja %2 -C %llvm_dir%\build\RelWithDebInfo clangd clangFormat clangFrontendTool clangIndex clangTooling clang
