dfg.operator @line_buffer inputs(%real_size: i6,%ext_size: i6, %in_pel: i8) outputs(%out_pel: i8) {      
    %0 = arith.addi %real_size,%ext_size : i6
    %2 = arith.extui %0 : i6 to i8
    %1 = arith.addi %in_pel, %2 : i8      
    dfg.output %1: i8
}
dfg.operator @delay inputs(%in_pel: i8) outputs(%out_pel: i8) {
    %0 = arith.constant 0 : i8
    %1 = arith.addi %in_pel, %0 : i8  
    dfg.output %1: i8  
}
dfg.operator @roberts_x inputs(%pel00: i8,%pel01: i8,%pel10: i8,%pel11: i8) outputs(%out_pel: i14) {
    %0 = arith.addi %pel00,%pel01 : i8
    %1 = arith.addi %pel10,%pel11 : i8
    %2 = arith.addi %0,%1 : i8
    %3 = arith.extui %2 : i8 to i14
    dfg.output %3: i14
}
dfg.operator @roberts_y inputs(%pel00: i8,%pel01: i8,%pel10: i8,%pel11: i8) outputs(%out_pel: i14) {
    %0 = arith.addi %pel00,%pel01 : i8
    %1 = arith.addi %pel10,%pel11 : i8
    %2 = arith.addi %0,%1 : i8
    %3 = arith.extui %2 : i8 to i14
    dfg.output %3: i14
}
dfg.operator @abs_sum inputs(%in_gx: i14,%in_gy: i14) outputs(%out_g: i14) {      
    %0 = arith.addi %in_gx,%in_gy : i14
    dfg.output %0: i14
}
dfg.operator @thr inputs(%in_pel: i14) outputs(%out_pel: i8) {
    %0 = arith.constant 0 : i14 
    %1 = arith.addi %in_pel, %0 : i14
    %2 = arith.trunci %1 : i14 to i8  
    dfg.output %2: i8  
}
dfg.operator @remove_2x2 inputs(%in_size:i6, %in_pel: i8) outputs(%out_pel: i8) {
    %0 = arith.extui %in_size : i6 to i8 
    %1 = arith.addi %in_pel, %0 : i8
    dfg.output %1: i8  
}
dfg.region @top1 inputs(%in_pel: i8,%in_size: i6) outputs(%out_pel: i8) {

    %ch2:2 = dfg.channel(1) : i8
    %ch3:2 = dfg.channel(1) : i8
    %ch4:2 = dfg.channel(1) : i8
    %ch5:2 = dfg.channel(1) : i14
    %ch6:2 = dfg.channel(1) : i14
    %ch7:2 = dfg.channel(1) : i14
    %ch8:2 = dfg.channel(1) : i8

    dfg.instantiate @line_buffer inputs(%in_size,%in_size,%in_pel) outputs(%ch2#0) : (i6,i6,i8) -> i8
    dfg.instantiate @delay inputs(%ch2#1) outputs(%ch3#0) : (i8) -> i8
    dfg.instantiate @delay inputs(%in_pel) outputs(%ch4#0) : (i8) -> i8
    dfg.instantiate @roberts_x inputs(%ch3#1,%ch2#1,%ch4#1,%in_pel) outputs(%ch5#0) : (i8,i8,i8,i8) -> i14
    dfg.instantiate @roberts_y inputs(%ch3#1,%ch2#1,%ch4#1,%in_pel) outputs(%ch6#0) : (i8,i8,i8,i8) -> i14
    dfg.instantiate @abs_sum inputs(%ch5#1,%ch6#1) outputs(%ch7#0) : (i14,i14) -> i14
    dfg.instantiate @thr inputs(%ch7#1) outputs(%ch8#0) : (i14) -> i8
    dfg.instantiate @remove_2x2 inputs(%in_size,%ch8#1) outputs(%out_pel) : (i6,i8) -> i8

}