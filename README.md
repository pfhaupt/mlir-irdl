# MLIR-IRDL
## About
Simple proof of concept of using IRDL and the PDL dialect to define a simple [IR](./irdl.mlir) and conversion pass
to convert it to an executable, without needing to write a single line of C++.

Needs `clang`, `mlir-opt`, `mlir-translate` and various Unix tools like `cat` and `grep`.

Tested with LLVM version 20.1.7.
```console
$ mlir-opt --version
LLVM (http://llvm.org/):
  LLVM version 20.1.7
  Optimized build.
$ mlir-translate --version
LLVM (http://llvm.org/):
  LLVM version 20.1.7
  Optimized build.
$ make all
$ ./program
$ echo $?
189
```
