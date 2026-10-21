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
  dfg.region @top inputs(%in0 : i8, %in1 : i6)  outputs(%out0 : i8)  {
    %in_chan_0, %out_chan_0 = dfg.channel(1) : i8
    %in_chan_1, %out_chan_1 = dfg.channel(1) : i8
    %in_chan_2, %out_chan_2 = dfg.channel(1) : i8
    %in_chan_3, %out_chan_3 = dfg.channel(1) : i14
    %in_chan_4, %out_chan_4 = dfg.channel(1) : i14
    %in_chan_5, %out_chan_5 = dfg.channel(1) : i14
    %in_chan_6, %out_chan_6 = dfg.channel(1) : i8
    dfg.instantiate @line_buffer inputs(%in1, %in1, %in0) outputs(%in_chan_0) : (i6, i6, i8) -> i8
    dfg.instantiate @delay inputs(%out_chan_0) outputs(%in_chan_1) : (i8) -> i8
    dfg.instantiate @delay inputs(%in0) outputs(%in_chan_2) : (i8) -> i8
    dfg.instantiate @roberts_x inputs(%out_chan_1, %out_chan_0, %out_chan_2, %in0) outputs(%in_chan_3) : (i8, i8, i8, i8) -> i14
    dfg.instantiate @roberts_y inputs(%out_chan_1, %out_chan_0, %out_chan_2, %in0) outputs(%in_chan_4) : (i8, i8, i8, i8) -> i14
    dfg.instantiate @abs_sum inputs(%out_chan_3, %out_chan_4) outputs(%in_chan_5) : (i14, i14) -> i14
    dfg.instantiate @thr inputs(%out_chan_5) outputs(%in_chan_6) : (i14) -> i8
    dfg.instantiate @remove_2x2 inputs(%in1, %out_chan_6) outputs(%out0) : (i6, i8) -> i8
  }
}

