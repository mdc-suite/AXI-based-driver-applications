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
dfg.operator @sobel_x inputs(%pel00: i8,%pel01: i8,%pel02: i8,%pel10: i8,%pel11: i8,%pel12: i8,%pel20: i8,%pel21: i8, %pel22: i8 ) outputs(%out_pel: i14) {
    %0 = arith.addi %pel00,%pel01 : i8
    %1 = arith.addi %pel10,%pel11 : i8
    %2 = arith.addi %0,%1 : i8
    %3 = arith.extui %2 : i8 to i14
    dfg.output %3: i14
}
dfg.operator @sobel_y inputs(%pel00: i8,%pel01: i8,%pel02: i8,%pel10: i8,%pel11: i8,%pel12: i8,%pel20: i8,%pel21: i8, %pel22: i8 ) outputs(%out_pel: i14) {
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
dfg.operator @remove_3x3 inputs(%in_size:i6, %in_pel: i8) outputs(%out_pel: i8) {
    %0 = arith.extui %in_size : i6 to i8 
    %1 = arith.addi %in_pel, %0 : i8
    dfg.output %1: i8  
}
dfg.region @top inputs(%in_pel: i8,%in_size: i6) outputs(%out_pel: i8) {
    %ch0:2 = dfg.channel(1) : i8
    %ch1:2 = dfg.channel(1) : i8
    %ch2:2 = dfg.channel(1) : i8
    %ch3:2 = dfg.channel(1) : i8
    %ch4:2 = dfg.channel(1) : i8
    %ch5:2 = dfg.channel(1) : i8
    %ch6:2 = dfg.channel(1) : i8
    %ch7:2 = dfg.channel(1) : i8
    %ch8:2 = dfg.channel(1) : i14
    %ch9:2 = dfg.channel(1) : i14
    %ch10:2 = dfg.channel(1) : i14
    %ch11:2 = dfg.channel(1) : i8

    dfg.instantiate @line_buffer inputs(%in_size,%in_size,%in_pel) outputs(%ch0#0) : (i6,i6,i8) -> i8
    dfg.instantiate @line_buffer inputs(%in_size,%in_size,%ch0#1) outputs(%ch1#0) : (i6,i6,i8) -> i8

    dfg.instantiate @delay inputs(%ch1#1) outputs(%ch2#0) : (i8) -> i8
    dfg.instantiate @delay inputs(%ch2#1) outputs(%ch3#0) : (i8) -> i8

    dfg.instantiate @delay inputs(%ch0#1) outputs(%ch4#0) : (i8) -> i8
    dfg.instantiate @delay inputs(%ch4#1) outputs(%ch5#0) : (i8) -> i8

    dfg.instantiate @delay inputs(%in_pel) outputs(%ch6#0) : (i8) -> i8
    dfg.instantiate @delay inputs(%ch6#1) outputs(%ch7#0) : (i8) -> i8

    dfg.instantiate @sobel_x inputs(%ch3#1,%ch2#1,%ch1#1,%ch5#1,%ch4#1,%ch0#1, %ch7#1,%ch6#1,%in_pel) outputs(%ch8#0) : (i8,i8,i8,i8,i8,i8,i8,i8,i8) -> i14
    dfg.instantiate @sobel_y inputs(%ch3#1,%ch2#1,%ch1#1,%ch5#1,%ch4#1,%ch0#1, %ch7#1,%ch6#1,%in_pel) outputs(%ch9#0) : (i8,i8,i8,i8,i8,i8,i8,i8,i8) -> i14

    dfg.instantiate @abs_sum inputs(%ch8#1,%ch9#1) outputs(%ch10#0) : (i14,i14) -> i14
    dfg.instantiate @thr inputs(%ch10#1) outputs(%ch11#0) : (i14) -> i8
    dfg.instantiate @remove_3x3 inputs(%in_size,%ch11#1) outputs(%out_pel) : (i6,i8) -> i8

}