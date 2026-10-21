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
  dfg.process @remove_3x3 inputs(%in0 : i6, %in1 : i8) outputs(%out0 : i8) {
    dfg.loop inputs (%in0 : i6, %in1 : i8) outputs (%out0 : i8) {
      %pull0 = dfg.pull %in0 : i6
      %pull1 = dfg.pull %in1 : i8
      %0 = arith.extui %pull0 : i6 to i8
      %1 = arith.addi %pull1, %0 : i8
      dfg.push(%1) %out0 : i8
    }
  }
  dfg.region @top inputs(%in0 : i8, %in1 : i6)  outputs(%out0 : i8)  {
    %in_chan_0, %out_chan_0 = dfg.channel(1) : i8
    %in_chan_1, %out_chan_1 = dfg.channel(1) : i8
    %in_chan_2, %out_chan_2 = dfg.channel(1) : i8
    %in_chan_3, %out_chan_3 = dfg.channel(1) : i8
    %in_chan_4, %out_chan_4 = dfg.channel(1) : i8
    %in_chan_5, %out_chan_5 = dfg.channel(1) : i8
    %in_chan_6, %out_chan_6 = dfg.channel(1) : i8
    %in_chan_7, %out_chan_7 = dfg.channel(1) : i8
    %in_chan_8, %out_chan_8 = dfg.channel(1) : i14
    %in_chan_9, %out_chan_9 = dfg.channel(1) : i14
    %in_chan_10, %out_chan_10 = dfg.channel(1) : i14
    %in_chan_11, %out_chan_11 = dfg.channel(1) : i8
    dfg.instantiate @line_buffer inputs(%in1, %in1, %in0) outputs(%in_chan_0) : (i6, i6, i8) -> i8
    dfg.instantiate @line_buffer inputs(%in1, %in1, %out_chan_0) outputs(%in_chan_1) : (i6, i6, i8) -> i8
    dfg.instantiate @delay inputs(%out_chan_1) outputs(%in_chan_2) : (i8) -> i8
    dfg.instantiate @delay inputs(%out_chan_2) outputs(%in_chan_3) : (i8) -> i8
    dfg.instantiate @delay inputs(%out_chan_0) outputs(%in_chan_4) : (i8) -> i8
    dfg.instantiate @delay inputs(%out_chan_4) outputs(%in_chan_5) : (i8) -> i8
    dfg.instantiate @delay inputs(%in0) outputs(%in_chan_6) : (i8) -> i8
    dfg.instantiate @delay inputs(%out_chan_6) outputs(%in_chan_7) : (i8) -> i8
    dfg.instantiate @sobel_x inputs(%out_chan_3, %out_chan_2, %out_chan_1, %out_chan_5, %out_chan_4, %out_chan_0, %out_chan_7, %out_chan_6, %in0) outputs(%in_chan_8) : (i8, i8, i8, i8, i8, i8, i8, i8, i8) -> i14
    dfg.instantiate @sobel_y inputs(%out_chan_3, %out_chan_2, %out_chan_1, %out_chan_5, %out_chan_4, %out_chan_0, %out_chan_7, %out_chan_6, %in0) outputs(%in_chan_9) : (i8, i8, i8, i8, i8, i8, i8, i8, i8) -> i14
    dfg.instantiate @abs_sum inputs(%out_chan_8, %out_chan_9) outputs(%in_chan_10) : (i14, i14) -> i14
    dfg.instantiate @thr inputs(%out_chan_10) outputs(%in_chan_11) : (i14) -> i8
    dfg.instantiate @remove_3x3 inputs(%in1, %out_chan_11) outputs(%out0) : (i6, i8) -> i8
  }
}

