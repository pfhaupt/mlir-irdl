irdl.dialect @math {
    irdl.operation @add {
        %0 = irdl.base "!builtin.integer"
        irdl.operands(a: %0, b: %0)
        irdl.results(res: %0)
    }
    irdl.operation @mul {
        %0 = irdl.base "!builtin.integer"
        irdl.operands(a: %0, b: %0, c: variadic %0)
        irdl.results(res: %0)
    }
}
