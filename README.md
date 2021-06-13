# cpp_indexer
no patches. basically set of primitive scripts to checkout and build custom llvm (clangd), that supports dependencies in compile_commands.json
and supports precompiled headers in clangd and compile_commands.json

it basically allows the following compile_commands.json format:

[
 {
   "directory": "some path",
   "file": "file/that/gets/compiled",
   "command": "-some --options -to --compile",
   "dependencies": [
       {
        "file": "some/other/file/that/actually/is/involved",
        "add": [
          "-some_flag",
          "-some other flag"
        ]
        "remove":[
           "-some",
           "1:-to" <--remove '-to' and the 1 next parameter
        ]
       }
   ]
 }
]
