module @patterns {
    pdl.pattern : benefit(1) {
        // Base case:
        // replace c = math.mul(a, b)
        // with    c = llvm.mul(a, b)
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
        // Induction case:
        // replace c = math.mul(a, b, ...args)
        // with    t = llvm.mul(a, b)
        //         c = math.mul(t, ...args)
        %resultType = pdl.type
        %i1 = pdl.operand
        %i2 = pdl.operand
        %i3 = pdl.operands
        %root = pdl.operation "math.mul"(%i1, %i2, %i3: !pdl.value, !pdl.value, !pdl.range<value>) -> (%resultType : !pdl.type)
        pdl.rewrite %root {
            %new1 = pdl.operation "llvm.mul"(%i1, %i2: !pdl.value, !pdl.value) -> (%resultType : !pdl.type)
            %res = pdl.result 0 of %new1
            %new2 = pdl.operation "math.mul"(%res, %i3: !pdl.value, !pdl.range<value>) -> (%resultType : !pdl.type)
            pdl.replace %root with %new2
        }
    }
    pdl.pattern : benefit(1) {
        // replace c = math.add(a, b)
        // with    c = llvm.add(a, b)
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
        // computes (4 + 3) * 3^3 = 7*27 = 189
        %a = "arith.constant"(){value = 4 : i64} : () -> i64
        %b = "arith.constant"(){value = 3 : i64} : () -> i64
        %r1 = "math.add"(%a, %b) : (i64, i64) -> i64
        %r2 = "math.mul"(%r1, %b) : (i64, i64) -> i64
        %r3 = "math.mul"(%r2, %b, %b) : (i64, i64, i64) -> i64
        return %r3 : i64
    }
}
