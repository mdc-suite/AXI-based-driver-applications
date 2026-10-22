   dfg.operator @roberts_x inputs(%p0 : i8, %p1 : i8, %p2 : i8, %p3 : i8) outputs(%out : i14) {
    %s0 = arith.extui %p0 : i8 to i14
    %s3 = arith.extui %p3 : i8 to i14
    %difference = arith.subi %s0, %s3 : i14
    dfg.output %difference : i14
  }

  dfg.operator @roberts_y inputs(%p0 : i8, %p1 : i8, %p2 : i8, %p3 : i8) outputs(%out : i14) {
    %s1 = arith.extui %p1 : i8 to i14
    %s2 = arith.extui %p2 : i8 to i14
    %difference = arith.subi %s1, %s2 : i14
    dfg.output %difference : i14
  }

 dfg.operator @sobel_x inputs(%p0 : i8, %p1 : i8, %p2 : i8, %p3 : i8, %p4 : i8, %p5 : i8, %p6 : i8, %p7 : i8, %p8 : i8) outputs(%out : i14) {
  %s0 = arith.extui %p0 : i8 to i14
  %s3 = arith.extui %p3 : i8 to i14
  %s6 = arith.extui %p6 : i8 to i14
  %s2 = arith.extui %p2 : i8 to i14
  %s5 = arith.extui %p5 : i8 to i14
  %s8 = arith.extui %p8 : i8 to i14

  %two = arith.constant 2 : i14
  %weighted_a = arith.muli %s3, %two : i14
  %weighted_b = arith.muli %s5, %two : i14

  %positive_pair = arith.addi %s0, %weighted_a : i14
  %positive = arith.addi %positive_pair, %s6 : i14

  %negative_pair = arith.addi %s2, %weighted_b : i14
  %negative = arith.addi %negative_pair, %s8 : i14

  %gradient = arith.subi %positive, %negative : i14
  dfg.output %gradient : i14
}

dfg.operator @sobel_y inputs(%p0 : i8, %p1 : i8, %p2 : i8, %p3 : i8, %p4 : i8, %p5 : i8, %p6 : i8, %p7 : i8, %p8 : i8) outputs(%out : i14) {
  %s0 = arith.extui %p0 : i8 to i14
  %s1 = arith.extui %p1 : i8 to i14
  %s2 = arith.extui %p2 : i8 to i14
  %s6 = arith.extui %p6 : i8 to i14
  %s7 = arith.extui %p7 : i8 to i14
  %s8 = arith.extui %p8 : i8 to i14

  %two = arith.constant 2 : i14
  %weighted_a = arith.muli %s1, %two : i14
  %weighted_b = arith.muli %s7, %two : i14

  %positive_pair = arith.addi %s0, %weighted_a : i14
  %positive = arith.addi %positive_pair, %s2 : i14

  %negative_pair = arith.addi %s6, %weighted_b : i14
  %negative = arith.addi %negative_pair, %s8 : i14

  %gradient = arith.subi %positive, %negative : i14
  dfg.output %gradient : i14
}
  dfg.operator @abs_sum inputs(%x : i14, %y : i14) outputs(%out : i14) {
    %zero = arith.constant 0 : i14
    %nx = arith.subi %zero, %x : i14
    %ny = arith.subi %zero, %y : i14
    %cx = arith.cmpi slt, %x, %zero : i14
    %cy = arith.cmpi slt, %y, %zero : i14
    %ax = arith.select %cx, %nx, %x : i14
    %ay = arith.select %cy, %ny, %y : i14
    %sum = arith.addi %ax, %ay : i14
    dfg.output %sum : i14
  }

  dfg.operator @thr inputs(%g : i14)  outputs(%out : i8) {
    %threshold = arith.constant 80 : i14
    %white = arith.constant -1 : i8
    %black = arith.constant 0 : i8
    %above = arith.cmpi sgt, %g, %threshold : i14
    %pixel = arith.select %above, %white, %black : i8
    dfg.output %pixel : i8
  }

  dfg.process @delay inputs(%arg0: !dfg.output<i8>) outputs(%arg1: !dfg.input<i8>) {
    %init_idx0 = arith.constant 0 : index
    %init_zero_i8 = arith.constant 0 : i8
    %previous = memref.alloc() {mdc.persistent} : memref<1xi8>
    memref.store %init_zero_i8, %previous[%init_idx0] : memref<1xi8>
    dfg.loop inputs(%arg0: !dfg.output<i8>) outputs(%arg1: !dfg.input<i8>) {
      %pixel = dfg.pull %arg0 : !dfg.output<i8>
      %state_read_1 = memref.load %previous[%init_idx0] : memref<1xi8>
      dfg.push %state_read_1 to %arg1 : !dfg.input<i8>
      memref.store %pixel, %previous[%init_idx0] : memref<1xi8>
    }
  }

  dfg.process @line_buffer inputs(%arg0: !dfg.output<i6>, %arg1: !dfg.output<i6>, %arg2: !dfg.output<i8>) outputs(%arg3: !dfg.input<i8>) {
    %init_idx0 = arith.constant 0 : index
    %init_zero_i1 = arith.constant 0 : i1
    %init_zero_i6 = arith.constant 0 : i6
    %init_zero_i8 = arith.constant 0 : i8
    %state = memref.alloc() {mdc.persistent} : memref<1xi1>
    memref.store %init_zero_i1, %state[%init_idx0] : memref<1xi1>
    %max_h = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %max_h[%init_idx0] : memref<1xi6>
    %max_v = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %max_v[%init_idx0] : memref<1xi6>
    %cnt_h = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %cnt_h[%init_idx0] : memref<1xi6>
    %cnt_v = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %cnt_v[%init_idx0] : memref<1xi6>
    %buffer = memref.alloc() {mdc.persistent} : memref<64xi8>
    %init_idx1 = arith.constant 1 : index
    %init_idx64 = arith.constant 64 : index
    scf.for %init_i = %init_idx0 to %init_idx64 step %init_idx1 {
      memref.store %init_zero_i8, %buffer[%init_i] : memref<64xi8>
    }
    dfg.loop inputs(%arg0: !dfg.output<i6>, %arg1: !dfg.output<i6>, %arg2: !dfg.output<i8>) outputs(%arg3: !dfg.input<i8>) {
      // One state transition per loop iteration. State 0=IDLE, 1=WORK.
      %idle = arith.constant 0 : i1
      %work = arith.constant 1 : i1
      %zero = arith.constant 0 : i6
      %one = arith.constant 1 : i6
      %state_read_1 = memref.load %state[%init_idx0] : memref<1xi1>
      %is_idle = arith.cmpi eq, %state_read_1, %idle : i1
      scf.if %is_idle {
        %v_bits = dfg.pull %arg1 : !dfg.output<i6>
        %h_bits = dfg.pull %arg0 : !dfg.output<i6>
        %last_h = arith.subi %h_bits, %one : i6
        memref.store %last_h, %max_h[%init_idx0] : memref<1xi6>
        memref.store %v_bits, %max_v[%init_idx0] : memref<1xi6>
        memref.store %work, %state[%init_idx0] : memref<1xi1>
      } else {
        %pixel = dfg.pull %arg2 : !dfg.output<i8>
        %state_read_2 = memref.load %cnt_h[%init_idx0] : memref<1xi6>
        %index = arith.index_castui %state_read_2 : i6 to index
        %old = memref.load %buffer[%index] : memref<64xi8>
        dfg.push %old to %arg3 : !dfg.input<i8>
        memref.store %pixel, %buffer[%index] : memref<64xi8>
        %state_read_3 = memref.load %cnt_h[%init_idx0] : memref<1xi6>
        %state_read_4 = memref.load %max_h[%init_idx0] : memref<1xi6>
        %inside_h = arith.cmpi ult, %state_read_3, %state_read_4 : i6
        %state_read_5 = memref.load %cnt_v[%init_idx0] : memref<1xi6>
        %state_read_6 = memref.load %max_v[%init_idx0] : memref<1xi6>
        %inside_v = arith.cmpi ult, %state_read_5, %state_read_6 : i6
        %advance_h = arith.andi %inside_h, %inside_v : i1
        scf.if %advance_h {
          %state_read_7 = memref.load %cnt_h[%init_idx0] : memref<1xi6>
          %next_h = arith.addi %state_read_7, %one : i6
          memref.store %next_h, %cnt_h[%init_idx0] : memref<1xi6>
        } else {
          %state_read_8 = memref.load %max_v[%init_idx0] : memref<1xi6>
          %last_v = arith.subi %state_read_8, %one : i6
          %state_read_9 = memref.load %cnt_v[%init_idx0] : memref<1xi6>
          %advance_v = arith.cmpi ult, %state_read_9, %last_v : i6
          scf.if %advance_v {
            %state_read_10 = memref.load %cnt_v[%init_idx0] : memref<1xi6>
            %next_v = arith.addi %state_read_10, %one : i6
            memref.store %next_v, %cnt_v[%init_idx0] : memref<1xi6>
            memref.store %zero, %cnt_h[%init_idx0] : memref<1xi6>
          } else {
            memref.store %zero, %cnt_h[%init_idx0] : memref<1xi6>
            memref.store %zero, %cnt_v[%init_idx0] : memref<1xi6>
            memref.store %idle, %state[%init_idx0] : memref<1xi1>
          }
        }
      }
    }
  }

 dfg.process @remove_2x2 inputs(%arg0: !dfg.output<i6>, %arg1: !dfg.output<i8>) outputs(%arg2: !dfg.input<i8>) {
    %init_idx0 = arith.constant 0 : index
    %init_zero_i2 = arith.constant 0 : i2
    %init_zero_i6 = arith.constant 0 : i6
    %state = memref.alloc() {mdc.persistent} : memref<1xi2>
    memref.store %init_zero_i2, %state[%init_idx0] : memref<1xi2>
    %max = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %max[%init_idx0] : memref<1xi6>
    %line = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %line[%init_idx0] : memref<1xi6>
    %cnt = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %cnt[%init_idx0] : memref<1xi6>
    dfg.loop inputs(%arg0: !dfg.output<i6>, %arg1: !dfg.output<i8>) outputs(%arg2: !dfg.input<i8>) {
      // State 0=IDLE, 1=DROP, 2=WORK. Preserve six-bit wraparound.
      %idle = arith.constant 0 : i2
      %drop = arith.constant 1 : i2
      %work = arith.constant 2 : i2
      %zero = arith.constant 0 : i6
      %one = arith.constant 1 : i6
      %state_read_1 = memref.load %state[%init_idx0] : memref<1xi2>
      %is_idle = arith.cmpi eq, %state_read_1, %idle : i2
      scf.if %is_idle {
        %size_bits = dfg.pull %arg0 : !dfg.output<i6>
        %last = arith.subi %size_bits, %one : i6
        memref.store %last, %max[%init_idx0] : memref<1xi6>
        memref.store %drop, %state[%init_idx0] : memref<1xi2>
      } else {
        %pixel = dfg.pull %arg1 : !dfg.output<i8>
        %state_read_2 = memref.load %state[%init_idx0] : memref<1xi2>
        %is_drop = arith.cmpi eq, %state_read_2, %drop : i2
        scf.if %is_drop {
          %state_read_3 = memref.load %cnt[%init_idx0] : memref<1xi6>
          %state_read_4 = memref.load %max[%init_idx0] : memref<1xi6>
          %more = arith.cmpi ult, %state_read_3, %state_read_4 : i6
          scf.if %more {
            %state_read_5 = memref.load %cnt[%init_idx0] : memref<1xi6>
            %next = arith.addi %state_read_5, %one : i6
            memref.store %next, %cnt[%init_idx0] : memref<1xi6>
          } else {
            %state_read_6 = memref.load %line[%init_idx0] : memref<1xi6>
            %next_line = arith.addi %state_read_6, %one : i6
            memref.store %next_line, %line[%init_idx0] : memref<1xi6>
            memref.store %zero, %cnt[%init_idx0] : memref<1xi6>
            memref.store %work, %state[%init_idx0] : memref<1xi2>
          }
        } else {
          %state_read_7 = memref.load %max[%init_idx0] : memref<1xi6>
          %limit = arith.addi %state_read_7, %one : i6
          %state_read_8 = memref.load %line[%init_idx0] : memref<1xi6>
          %line_inside = arith.cmpi ult, %state_read_8, %limit : i6
          %state_read_9 = memref.load %cnt[%init_idx0] : memref<1xi6>
          %first = arith.cmpi ult, %state_read_9, %one : i6
          %discard = arith.andi %first, %line_inside : i1
          scf.if %discard {
            %state_read_10 = memref.load %cnt[%init_idx0] : memref<1xi6>
            %next = arith.addi %state_read_10, %one : i6
            memref.store %next, %cnt[%init_idx0] : memref<1xi6>
          } else {
            dfg.push %pixel to %arg2 : !dfg.input<i8>
            %state_read_11 = memref.load %cnt[%init_idx0] : memref<1xi6>
            %state_read_12 = memref.load %max[%init_idx0] : memref<1xi6>
            %col_inside = arith.cmpi ult, %state_read_11, %state_read_12 : i6
            %advance = arith.andi %col_inside, %line_inside : i1
            scf.if %advance {
              %state_read_13 = memref.load %cnt[%init_idx0] : memref<1xi6>
              %next = arith.addi %state_read_13, %one : i6
              memref.store %next, %cnt[%init_idx0] : memref<1xi6>
            } else {
              %state_read_14 = memref.load %line[%init_idx0] : memref<1xi6>
              %state_read_15 = memref.load %max[%init_idx0] : memref<1xi6>
              %more_lines = arith.cmpi ult, %state_read_14, %state_read_15 : i6
              scf.if %more_lines {
                %state_read_16 = memref.load %line[%init_idx0] : memref<1xi6>
                %next_line = arith.addi %state_read_16, %one : i6
                memref.store %next_line, %line[%init_idx0] : memref<1xi6>
                memref.store %zero, %cnt[%init_idx0] : memref<1xi6>
              } else {
                memref.store %zero, %cnt[%init_idx0] : memref<1xi6>
                memref.store %zero, %line[%init_idx0] : memref<1xi6>
                memref.store %idle, %state[%init_idx0] : memref<1xi2>
              }
            }
          }
        }
      }
    }
  }

  dfg.process @remove_3x3 inputs(%arg0: !dfg.output<i6>, %arg1: !dfg.output<i8>) outputs(%arg2: !dfg.input<i8>) {
    %init_idx0 = arith.constant 0 : index
    %init_zero_i2 = arith.constant 0 : i2
    %init_zero_i6 = arith.constant 0 : i6
    %state = memref.alloc() {mdc.persistent} : memref<1xi2>
    memref.store %init_zero_i2, %state[%init_idx0] : memref<1xi2>
    %max = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %max[%init_idx0] : memref<1xi6>
    %line = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %line[%init_idx0] : memref<1xi6>
    %cnt = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %init_zero_i6, %cnt[%init_idx0] : memref<1xi6>
    dfg.loop inputs(%arg0: !dfg.output<i6>, %arg1: !dfg.output<i8>) outputs(%arg2: !dfg.input<i8>) {
      // State 0=IDLE, 1=DROP, 2=WORK. Preserve six-bit wraparound.
      %idle = arith.constant 0 : i2
      %drop = arith.constant 1 : i2
      %work = arith.constant 2 : i2
      %zero = arith.constant 0 : i6
      %one = arith.constant 1 : i6
      %two = arith.constant 2 : i6
      %state_read_1 = memref.load %state[%init_idx0] : memref<1xi2>
      %is_idle = arith.cmpi eq, %state_read_1, %idle : i2
      scf.if %is_idle {
        %size_bits = dfg.pull %arg0 : !dfg.output<i6>
        %last = arith.subi %size_bits, %one : i6
        memref.store %last, %max[%init_idx0] : memref<1xi6>
        memref.store %drop, %state[%init_idx0] : memref<1xi2>
      } else {
        %pixel = dfg.pull %arg1 : !dfg.output<i8>
        %state_read_2 = memref.load %state[%init_idx0] : memref<1xi2>
        %is_drop = arith.cmpi eq, %state_read_2, %drop : i2
        scf.if %is_drop {
          %col = memref.load %cnt[%init_idx0] : memref<1xi6>
          %last_col = memref.load %max[%init_idx0] : memref<1xi6>
          %row = memref.load %line[%init_idx0] : memref<1xi6>
          %first_two_rows = arith.cmpi ult, %row, %two : i6
          scf.if %first_two_rows {
            %more_cols = arith.cmpi ult, %col, %last_col : i6
            scf.if %more_cols {
              %next_col = arith.addi %col, %one : i6
              memref.store %next_col, %cnt[%init_idx0] : memref<1xi6>
            } else {
              %next_row = arith.addi %row, %one : i6
              memref.store %next_row, %line[%init_idx0] : memref<1xi6>
              memref.store %zero, %cnt[%init_idx0] : memref<1xi6>
            }
          } else {
            // Consume column zero of row two while entering WORK.
            %next_col = arith.addi %col, %one : i6
            memref.store %next_col, %cnt[%init_idx0] : memref<1xi6>
            memref.store %work, %state[%init_idx0] : memref<1xi2>
          }
        } else {
          %state_read_7 = memref.load %max[%init_idx0] : memref<1xi6>
          %limit = arith.addi %state_read_7, %one : i6
          %state_read_8 = memref.load %line[%init_idx0] : memref<1xi6>
          %line_inside = arith.cmpi ult, %state_read_8, %limit : i6
          %state_read_9 = memref.load %cnt[%init_idx0] : memref<1xi6>
          %first = arith.cmpi ult, %state_read_9, %two : i6
          %discard = arith.andi %first, %line_inside : i1
          scf.if %discard {
            %state_read_10 = memref.load %cnt[%init_idx0] : memref<1xi6>
            %next = arith.addi %state_read_10, %one : i6
            memref.store %next, %cnt[%init_idx0] : memref<1xi6>
          } else {
            dfg.push %pixel to %arg2 : !dfg.input<i8>
            %state_read_11 = memref.load %cnt[%init_idx0] : memref<1xi6>
            %state_read_12 = memref.load %max[%init_idx0] : memref<1xi6>
            %col_inside = arith.cmpi ult, %state_read_11, %state_read_12 : i6
            %advance = arith.andi %col_inside, %line_inside : i1
            scf.if %advance {
              %state_read_13 = memref.load %cnt[%init_idx0] : memref<1xi6>
              %next = arith.addi %state_read_13, %one : i6
              memref.store %next, %cnt[%init_idx0] : memref<1xi6>
            } else {
              %state_read_14 = memref.load %line[%init_idx0] : memref<1xi6>
              %state_read_15 = memref.load %max[%init_idx0] : memref<1xi6>
              %more_lines = arith.cmpi ult, %state_read_14, %state_read_15 : i6
              scf.if %more_lines {
                %state_read_16 = memref.load %line[%init_idx0] : memref<1xi6>
                %next_line = arith.addi %state_read_16, %one : i6
                memref.store %next_line, %line[%init_idx0] : memref<1xi6>
                memref.store %zero, %cnt[%init_idx0] : memref<1xi6>
              } else {
                memref.store %zero, %cnt[%init_idx0] : memref<1xi6>
                memref.store %zero, %line[%init_idx0] : memref<1xi6>
                memref.store %idle, %state[%init_idx0] : memref<1xi2>
              }
            }
          }
        }
      }
    }
  }

  dfg.region @Roberts inputs(%in_size: !dfg.output<i6>, %in_pel: !dfg.output<i8>) outputs(%out_pel: !dfg.input<i8>) {
    %ch2:2 = dfg.channel(1) : i8
    %ch3:2 = dfg.channel(1) : i8
    %ch4:2 = dfg.channel(1) : i8
    %ch5:2 = dfg.channel(1) : i14
    %ch6:2 = dfg.channel(1) : i14
    %ch7:2 = dfg.channel(1) : i14
    %ch8:2 = dfg.channel(1) : i8
    dfg.instantiate @line_buffer inputs(%in_size, %in_size, %in_pel) outputs(%ch2#0) : (!dfg.output<i6>, !dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @delay inputs(%ch2#1) outputs(%ch3#0) : (!dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @delay inputs(%in_pel) outputs(%ch4#0) : (!dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @roberts_x inputs(%ch3#1, %ch2#1, %ch4#1, %in_pel) outputs(%ch5#0) : (!dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>) -> !dfg.input<i14>
    dfg.instantiate @roberts_y inputs(%ch3#1, %ch2#1, %ch4#1, %in_pel) outputs(%ch6#0) : (!dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>) -> !dfg.input<i14>
    dfg.instantiate @abs_sum inputs(%ch5#1, %ch6#1) outputs(%ch7#0) : (!dfg.output<i14>, !dfg.output<i14>) -> !dfg.input<i14>
    dfg.instantiate @thr inputs(%ch7#1) outputs(%ch8#0) : (!dfg.output<i14>) -> !dfg.input<i8>
    dfg.instantiate @remove_2x2 inputs(%in_size, %ch8#1) outputs(%out_pel) : (!dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8>
  }
  
  dfg.region @Sobel inputs(%in_size: !dfg.output<i6>, %in_pel: !dfg.output<i8>) outputs(%out_pel: !dfg.input<i8>) {
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
    dfg.instantiate @line_buffer inputs(%in_size, %in_size, %in_pel) outputs(%ch0#0) : (!dfg.output<i6>, !dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @line_buffer inputs(%in_size, %in_size, %ch0#1) outputs(%ch1#0) : (!dfg.output<i6>, !dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @delay inputs(%ch1#1) outputs(%ch2#0) : (!dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @delay inputs(%ch2#1) outputs(%ch3#0) : (!dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @delay inputs(%ch0#1) outputs(%ch4#0) : (!dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @delay inputs(%ch4#1) outputs(%ch5#0) : (!dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @delay inputs(%in_pel) outputs(%ch6#0) : (!dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @delay inputs(%ch6#1) outputs(%ch7#0) : (!dfg.output<i8>) -> !dfg.input<i8>
    dfg.instantiate @sobel_x inputs(%ch3#1, %ch2#1, %ch1#1, %ch5#1, %ch4#1, %ch0#1, %ch7#1, %ch6#1, %in_pel) outputs(%ch8#0) : (!dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>) -> !dfg.input<i14>
    dfg.instantiate @sobel_y inputs(%ch3#1, %ch2#1, %ch1#1, %ch5#1, %ch4#1, %ch0#1, %ch7#1, %ch6#1, %in_pel) outputs(%ch9#0) : (!dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>) -> !dfg.input<i14>
    dfg.instantiate @abs_sum inputs(%ch8#1, %ch9#1) outputs(%ch10#0) : (!dfg.output<i14>, !dfg.output<i14>) -> !dfg.input<i14>
    dfg.instantiate @thr inputs(%ch10#1) outputs(%ch11#0) : (!dfg.output<i14>) -> !dfg.input<i8>
    dfg.instantiate @remove_3x3 inputs(%in_size, %ch11#1) outputs(%out_pel) : (!dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8>
  }
