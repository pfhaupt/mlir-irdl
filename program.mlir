module @patterns {
    pdl.pattern : benefit(1) {
        %resultType = pdl.type
        %i1 = pdl.operand
        %i2 = pdl.operand
        %root = pdl.operation "math.mul"(%i1, %i2: !pdl.value, !pdl.value) -> (%resultType : !pdl.type)
        pdl.rewrite %root {
            %new = pdl.operation "llvm.mul"(%i1, %i2: !pdl.value, !pdl.value) -> (%resultType : !pdl.type)
            pdl.replace %root with %new
        }
    }
    pdl.pattern : benefit(1) {
        %resultType = pdl.type
        %i1 = pdl.operand
        %i2 = pdl.operand
        %root = pdl.operation "math.add"(%i1, %i2: !pdl.value, !pdl.value) -> (%resultType : !pdl.type)
        pdl.rewrite %root {
            %new = pdl.operation "llvm.add"(%i1, %i2: !pdl.value, !pdl.value) -> (%resultType : !pdl.type)
            pdl.replace %root with %new
        }
    }
}
module @ir {
    func.func @main() -> i64 {
        %a = "arith.constant"(){value = 12 : i64} : () -> i64
        %b = "arith.constant"(){value = 19 : i64} : () -> i64
        %r1 = "math.add"(%a, %b) : (i64, i64) -> i64
        %r2 = "math.mul"(%r1, %a) : (i64, i64) -> i64
        return %r2 : i64
    }
}
