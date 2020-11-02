# cpp_indexer
2 patches that modify llvm/clangd and ccls and add support of dependencies in the compile_commands.json. can be useful for unity-build-like configured projects

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
