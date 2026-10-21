module {
  dfg.process @line_buffer inputs(%in0 : i6, %in1 : i6, %in2 : i8) outputs(%out0 : i8) {
    dfg.loop inputs (%in0 : i6, %in1 : i6, %in2 : i8) outputs (%out0 : i8) {
      %pull0 = dfg.pull %in0 : i6
      %pull1 = dfg.pull %in1 : i6
      %pull2 = dfg.pull %in2 : i8
      %0 = arith.addi %pull0, %pull1 : i6
      %1 = arith.extui %0 : i6 to i8
      %2 = arith.addi %pull2, %1 : i8
      dfg.push(%2) %out0 : i8
    }
  }
  dfg.process @delay inputs(%in0 : i8) outputs(%out0 : i8) {
    dfg.loop inputs (%in0 : i8) outputs (%out0 : i8) {
      %pull0 = dfg.pull %in0 : i8
      dfg.push(%pull0) %out0 : i8
    }
  }
  dfg.process @roberts_x inputs(%in0 : i8, %in1 : i8, %in2 : i8, %in3 : i8) outputs(%out0 : i14) {
    dfg.loop inputs (%in0 : i8, %in1 : i8, %in2 : i8, %in3 : i8) outputs (%out0 : i14) {
      %pull0 = dfg.pull %in0 : i8
      %pull1 = dfg.pull %in1 : i8
      %pull2 = dfg.pull %in2 : i8
      %pull3 = dfg.pull %in3 : i8
      %0 = arith.addi %pull0, %pull1 : i8
      %1 = arith.addi %pull2, %pull3 : i8
      %2 = arith.addi %0, %1 : i8
      %3 = arith.extui %2 : i8 to i14
      dfg.push(%3) %out0 : i14
    }
  }
  dfg.process @roberts_y inputs(%in0 : i8, %in1 : i8, %in2 : i8, %in3 : i8) outputs(%out0 : i14) {
    dfg.loop inputs (%in0 : i8, %in1 : i8, %in2 : i8, %in3 : i8) outputs (%out0 : i14) {
      %pull0 = dfg.pull %in0 : i8
      %pull1 = dfg.pull %in1 : i8
      %pull2 = dfg.pull %in2 : i8
      %pull3 = dfg.pull %in3 : i8
      %0 = arith.addi %pull0, %pull1 : i8
      %1 = arith.addi %pull2, %pull3 : i8
      %2 = arith.addi %0, %1 : i8
      %3 = arith.extui %2 : i8 to i14
      dfg.push(%3) %out0 : i14
    }
  }
  dfg.process @sobel_x inputs(%in0 : i8, %in1 : i8, %in2 : i8, %in3 : i8, %in4 : i8, %in5 : i8, %in6 : i8, %in7 : i8, %in8 : i8) outputs(%out0 : i14) {
    dfg.loop inputs (%in0 : i8, %in1 : i8, %in2 : i8, %in3 : i8, %in4 : i8, %in5 : i8, %in6 : i8, %in7 : i8, %in8 : i8) outputs (%out0 : i14) {
      %pull0 = dfg.pull %in0 : i8
      %pull1 = dfg.pull %in1 : i8
      %pull2 = dfg.pull %in2 : i8
      %pull3 = dfg.pull %in3 : i8
      %pull4 = dfg.pull %in4 : i8
      %pull5 = dfg.pull %in5 : i8
      %pull6 = dfg.pull %in6 : i8
      %pull7 = dfg.pull %in7 : i8
      %pull8 = dfg.pull %in8 : i8
      %0 = arith.addi %pull0, %pull1 : i8
      %1 = arith.addi %pull3, %pull4 : i8
      %2 = arith.addi %0, %1 : i8
      %3 = arith.extui %2 : i8 to i14
      dfg.push(%3) %out0 : i14
    }
  }
  dfg.process @sobel_y inputs(%in0 : i8, %in1 : i8, %in2 : i8, %in3 : i8, %in4 : i8, %in5 : i8, %in6 : i8, %in7 : i8, %in8 : i8) outputs(%out0 : i14) {
    dfg.loop inputs (%in0 : i8, %in1 : i8, %in2 : i8, %in3 : i8, %in4 : i8, %in5 : i8, %in6 : i8, %in7 : i8, %in8 : i8) outputs (%out0 : i14) {
      %pull0 = dfg.pull %in0 : i8
      %pull1 = dfg.pull %in1 : i8
      %pull2 = dfg.pull %in2 : i8
      %pull3 = dfg.pull %in3 : i8
      %pull4 = dfg.pull %in4 : i8
      %pull5 = dfg.pull %in5 : i8
      %pull6 = dfg.pull %in6 : i8
      %pull7 = dfg.pull %in7 : i8
      %pull8 = dfg.pull %in8 : i8
      %0 = arith.addi %pull0, %pull1 : i8
      %1 = arith.addi %pull3, %pull4 : i8
      %2 = arith.addi %0, %1 : i8
      %3 = arith.extui %2 : i8 to i14
      dfg.push(%3) %out0 : i14
    }
  }
  dfg.process @abs_sum inputs(%in0 : i14, %in1 : i14) outputs(%out0 : i14) {
    dfg.loop inputs (%in0 : i14, %in1 : i14) outputs (%out0 : i14) {
      %pull0 = dfg.pull %in0 : i14
      %pull1 = dfg.pull %in1 : i14
      %0 = arith.addi %pull0, %pull1 : i14
      dfg.push(%0) %out0 : i14
    }
  }
  dfg.process @thr inputs(%in0 : i14) outputs(%out0 : i8) {
    dfg.loop inputs (%in0 : i14) outputs (%out0 : i8) {
      %pull0 = dfg.pull %in0 : i14
      %0 = arith.trunci %pull0 : i14 to i8
      dfg.push(%0) %out0 : i8
    }
  }
  dfg.process @remove_2x2 inputs(%in0 : i6, %in1 : i8) outputs(%out0 : i8) {
    dfg.loop inputs (%in0 : i6, %in1 : i8) outputs (%out0 : i8) {
      %pull0 = dfg.pull %in0 : i6
      %pull1 = dfg.pull %in1 : i8
      %0 = arith.extui %pull0 : i6 to i8
      %1 = arith.addi %pull1, %0 : i8
      dfg.push(%1) %out0 : i8
    }
  }
  dfg.process @remove_3x3 inputs(%in0 : i6, %in1 : i8) outputs(%out0 : i8) {
    dfg.loop inputs (%in0 : i6, %in1 : i8) outputs (%out0 : i8) {
      %pull0 = dfg.pull %in0 : i6
      %pull1 = dfg.pull %in1 : i8
      %0 = arith.extui %pull0 : i6 to i8
      %1 = arith.addi %pull1, %0 : i8
      dfg.push(%1) %out0 : i8
    }
  }
  dfg.process @Sbox1x2int6 inputs(%in0 : i6) outputs(%out0 : i6, %out1 : i6) {
    dfg.loop inputs (%in0 : i6) outputs (%out0 : i6, %out1 : i6) {
      %pull0 = dfg.pull %in0 : i6
      dfg.push(%pull0) %out0 : i6
      dfg.push(%pull0) %out1 : i6
    }
  }
  dfg.process @Sbox2x1int6 inputs(%in0 : i6, %in1 : i6) outputs(%out0 : i6) {
    dfg.loop inputs (%in0 : i6, %in1 : i6) outputs (%out0 : i6) {
      %pull0 = dfg.pull %in0 : i6
      %pull1 = dfg.pull %in1 : i6
      dfg.push(%pull0) %out0 : i6
    }
  }
  dfg.process @Sbox1x2int8 inputs(%in0 : i8) outputs(%out0 : i8, %out1 : i8) {
    dfg.loop inputs (%in0 : i8) outputs (%out0 : i8, %out1 : i8) {
      %pull0 = dfg.pull %in0 : i8
      dfg.push(%pull0) %out0 : i8
      dfg.push(%pull0) %out1 : i8
    }
  }
  dfg.process @Sbox2x1int8 inputs(%in0 : i8, %in1 : i8) outputs(%out0 : i8) {
    dfg.loop inputs (%in0 : i8, %in1 : i8) outputs (%out0 : i8) {
      %pull0 = dfg.pull %in0 : i8
      %pull1 = dfg.pull %in1 : i8
      dfg.push(%pull0) %out0 : i8
    }
  }
  dfg.process @Sbox1x2int14 inputs(%in0 : i14) outputs(%out0 : i14, %out1 : i14) {
    dfg.loop inputs (%in0 : i14) outputs (%out0 : i14, %out1 : i14) {
      %pull0 = dfg.pull %in0 : i14
      dfg.push(%pull0) %out0 : i14
      dfg.push(%pull0) %out1 : i14
    }
  }
  dfg.process @Sbox2x1int14 inputs(%in0 : i14, %in1 : i14) outputs(%out0 : i14) {
    dfg.loop inputs (%in0 : i14, %in1 : i14) outputs (%out0 : i14) {
      %pull0 = dfg.pull %in0 : i14
      %pull1 = dfg.pull %in1 : i14
      dfg.push(%pull0) %out0 : i14
    }
  }
  dfg.region @top inputs(%in0 : i8, %in1 : i6)  outputs(%out0 : i8)  {
    %in_chan_0, %out_chan_0 = dfg.channel(1) : i6
    %in_chan_1, %out_chan_1 = dfg.channel(1) : i6
    %in_chan_2, %out_chan_2 = dfg.channel(1) : i8
    %in_chan_3, %out_chan_3 = dfg.channel(1) : i8
    %in_chan_4, %out_chan_4 = dfg.channel(1) : i8
    %in_chan_5, %out_chan_5 = dfg.channel(1) : i8
    %in_chan_6, %out_chan_6 = dfg.channel(1) : i8
    %in_chan_7, %out_chan_7 = dfg.channel(1) : i14
    %in_chan_8, %out_chan_8 = dfg.channel(1) : i14
    %in_chan_9, %out_chan_9 = dfg.channel(1) : i8
    %in_chan_10, %out_chan_10 = dfg.channel(1) : i8
    %in_chan_11, %out_chan_11 = dfg.channel(1) : i8
    %in_chan_12, %out_chan_12 = dfg.channel(1) : i8
    %in_chan_13, %out_chan_13 = dfg.channel(1) : i8
    %in_chan_14, %out_chan_14 = dfg.channel(1) : i8
    %in_chan_15, %out_chan_15 = dfg.channel(1) : i8
    %in_chan_16, %out_chan_16 = dfg.channel(1) : i8
    %in_chan_17, %out_chan_17 = dfg.channel(1) : i14
    %in_chan_18, %out_chan_18 = dfg.channel(1) : i14
    %in_chan_19, %out_chan_19 = dfg.channel(1) : i14
    %in_chan_20, %out_chan_20 = dfg.channel(1) : i14
    %in_chan_21, %out_chan_21 = dfg.channel(1) : i14
    %in_chan_22, %out_chan_22 = dfg.channel(1) : i8
    %in_chan_23, %out_chan_23 = dfg.channel(1) : i8
    %in_chan_24, %out_chan_24 = dfg.channel(1) : i8
    %in_chan_25, %out_chan_25 = dfg.channel(1) : i8
    %in_chan_26, %out_chan_26 = dfg.channel(1) : i8
    dfg.instantiate @Sbox2x1int8 inputs(%out_chan_25, %out_chan_26) outputs(%out0) : (i8, i8) -> i8 {config = {networks = ["top1", "top2"], values = [true, false]}, infrastructure}
    dfg.instantiate @Sbox1x2int8 inputs(%in0) outputs(%in_chan_2, %in_chan_3) : (i8) -> (i8, i8) {config = {networks = ["top1", "top2"], values = [true, false]}, infrastructure}
    dfg.instantiate @Sbox1x2int6 inputs(%in1) outputs(%in_chan_0, %in_chan_1) : (i6) -> (i6, i6) {config = {networks = ["top1", "top2"], values = [true, false]}, infrastructure}
    dfg.instantiate @delay inputs(%out_chan_3) outputs(%in_chan_6) : (i8) -> i8 {orig_region = "top1"}
    dfg.instantiate @delay inputs(%out_chan_4) outputs(%in_chan_5) : (i8) -> i8 {orig_region = "top1"}
    dfg.instantiate @delay inputs(%out_chan_9) outputs(%in_chan_13) : (i8) -> i8 {orig_region = "top2"}
    dfg.instantiate @delay inputs(%out_chan_10) outputs(%in_chan_11) : (i8) -> i8 {orig_region = "top2"}
    dfg.instantiate @delay inputs(%out_chan_15) outputs(%in_chan_16) : (i8) -> i8 {orig_region = "top2"}
    dfg.instantiate @delay inputs(%out_chan_2) outputs(%in_chan_15) : (i8) -> i8 {orig_region = "top2"}
    dfg.instantiate @delay inputs(%out_chan_13) outputs(%in_chan_14) : (i8) -> i8 {orig_region = "top2"}
    dfg.instantiate @delay inputs(%out_chan_11) outputs(%in_chan_12) : (i8) -> i8 {orig_region = "top2"}
    dfg.instantiate @roberts_x inputs(%out_chan_5, %out_chan_4, %out_chan_6, %out_chan_3) outputs(%in_chan_7) : (i8, i8, i8, i8) -> i14 {orig_region = "top1"}
    dfg.instantiate @roberts_y inputs(%out_chan_5, %out_chan_4, %out_chan_6, %out_chan_3) outputs(%in_chan_8) : (i8, i8, i8, i8) -> i14 {orig_region = "top1"}
    dfg.instantiate @line_buffer inputs(%out_chan_1, %out_chan_1, %out_chan_3) outputs(%in_chan_4) : (i6, i6, i8) -> i8 {orig_region = "top1"}
    dfg.instantiate @line_buffer inputs(%out_chan_0, %out_chan_0, %out_chan_2) outputs(%in_chan_9) : (i6, i6, i8) -> i8 {orig_region = "top2"}
    dfg.instantiate @line_buffer inputs(%out_chan_0, %out_chan_0, %out_chan_9) outputs(%in_chan_10) : (i6, i6, i8) -> i8 {orig_region = "top2"}
    dfg.instantiate @sobel_x inputs(%out_chan_12, %out_chan_11, %out_chan_10, %out_chan_14, %out_chan_13, %out_chan_9, %out_chan_16, %out_chan_15, %out_chan_2) outputs(%in_chan_17) : (i8, i8, i8, i8, i8, i8, i8, i8, i8) -> i14 {orig_region = "top2"}
    dfg.instantiate @sobel_y inputs(%out_chan_12, %out_chan_11, %out_chan_10, %out_chan_14, %out_chan_13, %out_chan_9, %out_chan_16, %out_chan_15, %out_chan_2) outputs(%in_chan_18) : (i8, i8, i8, i8, i8, i8, i8, i8, i8) -> i14 {orig_region = "top2"}
    dfg.instantiate @Sbox2x1int14 inputs(%out_chan_18, %out_chan_8) outputs(%in_chan_20) : (i14, i14) -> i14 {config = {networks = ["top1", "top2"], values = [true, false]}, infrastructure}
    dfg.instantiate @Sbox1x2int8 inputs(%out_chan_22) outputs(%in_chan_23, %in_chan_24) : (i8) -> (i8, i8) {config = {networks = ["top1", "top2"], values = [true, false]}, infrastructure}
    dfg.instantiate @Sbox2x1int14 inputs(%out_chan_17, %out_chan_7) outputs(%in_chan_19) : (i14, i14) -> i14 {config = {networks = ["top1", "top2"], values = [true, false]}, infrastructure}
    dfg.instantiate @abs_sum inputs(%out_chan_19, %out_chan_20) outputs(%in_chan_21) : (i14, i14) -> i14 {orig_region = "top2", shared = 2 : i14}
    dfg.instantiate @thr inputs(%out_chan_21) outputs(%in_chan_22) : (i14) -> i8 {orig_region = "top2", shared = 2 : i8}
    dfg.instantiate @remove_2x2 inputs(%out_chan_1, %out_chan_24) outputs(%in_chan_26) : (i6, i8) -> i8 {orig_region = "top1"}
    dfg.instantiate @remove_3x3 inputs(%out_chan_0, %out_chan_23) outputs(%in_chan_25) : (i6, i8) -> i8 {orig_region = "top2"}
  }
}

