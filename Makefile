.PHONY: all clean

all: program

program1.mlir: program.mlir irdl.mlir
	mlir-opt --irdl-file=irdl.mlir program.mlir -convert-pdl-to-pdl-interp > program1.mlir

program2.mlir: program1.mlir irdl.mlir
	mlir-opt --irdl-file=irdl.mlir program1.mlir -test-pdl-bytecode-pass --convert-arith-to-llvm --convert-func-to-llvm --llvm-legalize-for-export > program2.mlir

program3.mlir: program2.mlir
	cat program2.mlir | tail --lines=+$(shell grep -n 'module @ir' program2.mlir | cut -d: -f1) | head --lines=-2 > program3.mlir

program4.ll: program3.mlir
	mlir-translate --mlir-to-llvmir program3.mlir > program4.ll

program: program4.ll
	clang program4.ll -o program

clean:
	rm -f program program4.ll program3.mlir program2.mlir program1.mlir
