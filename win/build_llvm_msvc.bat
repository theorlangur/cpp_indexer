@echo off

SET llvm_dir=%1
IF "%1"=="" (SET llvm_dir=build\llvm)

cmake --build %llvm_dir%\build\MSVC --config Release --target clangd clangFormat clangFrontendTool clangIndex clangTooling clang
