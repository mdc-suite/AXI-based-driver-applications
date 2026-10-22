module {
  dfg.process @roberts_x inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>, %in2: !dfg.output<i8>, %in3: !dfg.output<i8>) outputs(%out0: !dfg.input<i14>) {
    dfg.loop inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>, %in2: !dfg.output<i8>, %in3: !dfg.output<i8>) outputs(%out0: !dfg.input<i14>) {
      %token0 = dfg.pull %in0 : !dfg.output<i8>
      %token1 = dfg.pull %in1 : !dfg.output<i8>
      %token2 = dfg.pull %in2 : !dfg.output<i8>
      %token3 = dfg.pull %in3 : !dfg.output<i8>
      %0 = arith.extui %token0 : i8 to i14
      %1 = arith.extui %token3 : i8 to i14
      %2 = arith.subi %0, %1 : i14
      dfg.push %2 to %out0 : !dfg.input<i14>
    }
  }
  dfg.process @roberts_y inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>, %in2: !dfg.output<i8>, %in3: !dfg.output<i8>) outputs(%out0: !dfg.input<i14>) {
    dfg.loop inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>, %in2: !dfg.output<i8>, %in3: !dfg.output<i8>) outputs(%out0: !dfg.input<i14>) {
      %token0 = dfg.pull %in0 : !dfg.output<i8>
      %token1 = dfg.pull %in1 : !dfg.output<i8>
      %token2 = dfg.pull %in2 : !dfg.output<i8>
      %token3 = dfg.pull %in3 : !dfg.output<i8>
      %0 = arith.extui %token1 : i8 to i14
      %1 = arith.extui %token2 : i8 to i14
      %2 = arith.subi %0, %1 : i14
      dfg.push %2 to %out0 : !dfg.input<i14>
    }
  }
  dfg.process @sobel_x inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>, %in2: !dfg.output<i8>, %in3: !dfg.output<i8>, %in4: !dfg.output<i8>, %in5: !dfg.output<i8>, %in6: !dfg.output<i8>, %in7: !dfg.output<i8>, %in8: !dfg.output<i8>) outputs(%out0: !dfg.input<i14>) {
    %c2_i14 = arith.constant 2 : i14
    dfg.loop inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>, %in2: !dfg.output<i8>, %in3: !dfg.output<i8>, %in4: !dfg.output<i8>, %in5: !dfg.output<i8>, %in6: !dfg.output<i8>, %in7: !dfg.output<i8>, %in8: !dfg.output<i8>) outputs(%out0: !dfg.input<i14>) {
      %token0 = dfg.pull %in0 : !dfg.output<i8>
      %token1 = dfg.pull %in1 : !dfg.output<i8>
      %token2 = dfg.pull %in2 : !dfg.output<i8>
      %token3 = dfg.pull %in3 : !dfg.output<i8>
      %token4 = dfg.pull %in4 : !dfg.output<i8>
      %token5 = dfg.pull %in5 : !dfg.output<i8>
      %token6 = dfg.pull %in6 : !dfg.output<i8>
      %token7 = dfg.pull %in7 : !dfg.output<i8>
      %token8 = dfg.pull %in8 : !dfg.output<i8>
      %0 = arith.extui %token0 : i8 to i14
      %1 = arith.extui %token3 : i8 to i14
      %2 = arith.extui %token6 : i8 to i14
      %3 = arith.extui %token2 : i8 to i14
      %4 = arith.extui %token5 : i8 to i14
      %5 = arith.extui %token8 : i8 to i14
      %6 = arith.muli %1, %c2_i14 : i14
      %7 = arith.muli %4, %c2_i14 : i14
      %8 = arith.addi %0, %6 : i14
      %9 = arith.addi %8, %2 : i14
      %10 = arith.addi %3, %7 : i14
      %11 = arith.addi %10, %5 : i14
      %12 = arith.subi %9, %11 : i14
      dfg.push %12 to %out0 : !dfg.input<i14>
    }
  }
  dfg.process @sobel_y inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>, %in2: !dfg.output<i8>, %in3: !dfg.output<i8>, %in4: !dfg.output<i8>, %in5: !dfg.output<i8>, %in6: !dfg.output<i8>, %in7: !dfg.output<i8>, %in8: !dfg.output<i8>) outputs(%out0: !dfg.input<i14>) {
    %c2_i14 = arith.constant 2 : i14
    dfg.loop inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>, %in2: !dfg.output<i8>, %in3: !dfg.output<i8>, %in4: !dfg.output<i8>, %in5: !dfg.output<i8>, %in6: !dfg.output<i8>, %in7: !dfg.output<i8>, %in8: !dfg.output<i8>) outputs(%out0: !dfg.input<i14>) {
      %token0 = dfg.pull %in0 : !dfg.output<i8>
      %token1 = dfg.pull %in1 : !dfg.output<i8>
      %token2 = dfg.pull %in2 : !dfg.output<i8>
      %token3 = dfg.pull %in3 : !dfg.output<i8>
      %token4 = dfg.pull %in4 : !dfg.output<i8>
      %token5 = dfg.pull %in5 : !dfg.output<i8>
      %token6 = dfg.pull %in6 : !dfg.output<i8>
      %token7 = dfg.pull %in7 : !dfg.output<i8>
      %token8 = dfg.pull %in8 : !dfg.output<i8>
      %0 = arith.extui %token0 : i8 to i14
      %1 = arith.extui %token1 : i8 to i14
      %2 = arith.extui %token2 : i8 to i14
      %3 = arith.extui %token6 : i8 to i14
      %4 = arith.extui %token7 : i8 to i14
      %5 = arith.extui %token8 : i8 to i14
      %6 = arith.muli %1, %c2_i14 : i14
      %7 = arith.muli %4, %c2_i14 : i14
      %8 = arith.addi %0, %6 : i14
      %9 = arith.addi %8, %2 : i14
      %10 = arith.addi %3, %7 : i14
      %11 = arith.addi %10, %5 : i14
      %12 = arith.subi %9, %11 : i14
      dfg.push %12 to %out0 : !dfg.input<i14>
    }
  }
  dfg.process @abs_sum inputs(%in0: !dfg.output<i14>, %in1: !dfg.output<i14>) outputs(%out0: !dfg.input<i14>) {
    %c0_i14 = arith.constant 0 : i14
    dfg.loop inputs(%in0: !dfg.output<i14>, %in1: !dfg.output<i14>) outputs(%out0: !dfg.input<i14>) {
      %token0 = dfg.pull %in0 : !dfg.output<i14>
      %token1 = dfg.pull %in1 : !dfg.output<i14>
      %0 = arith.subi %c0_i14, %token0 : i14
      %1 = arith.subi %c0_i14, %token1 : i14
      %2 = arith.cmpi slt, %token0, %c0_i14 : i14
      %3 = arith.cmpi slt, %token1, %c0_i14 : i14
      %4 = arith.select %2, %0, %token0 : i14
      %5 = arith.select %3, %1, %token1 : i14
      %6 = arith.addi %4, %5 : i14
      dfg.push %6 to %out0 : !dfg.input<i14>
    }
  }
  dfg.process @thr inputs(%in0: !dfg.output<i14>) outputs(%out0: !dfg.input<i8>) {
    %c0_i8 = arith.constant 0 : i8
    %c-1_i8 = arith.constant -1 : i8
    %c80_i14 = arith.constant 80 : i14
    dfg.loop inputs(%in0: !dfg.output<i14>) outputs(%out0: !dfg.input<i8>) {
      %token0 = dfg.pull %in0 : !dfg.output<i14>
      %0 = arith.cmpi sgt, %token0, %c80_i14 : i14
      %1 = arith.select %0, %c-1_i8, %c0_i8 : i8
      dfg.push %1 to %out0 : !dfg.input<i8>
    }
  }
  dfg.process @delay inputs(%in0: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) {
    %c0 = arith.constant 0 : index
    %c0_i8 = arith.constant 0 : i8
    %alloc = memref.alloc() {mdc.persistent} : memref<1xi8>
    memref.store %c0_i8, %alloc[%c0] : memref<1xi8>
    dfg.loop inputs(%in0: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) {
      %token0 = dfg.pull %in0 : !dfg.output<i8>
      %0 = memref.load %alloc[%c0] : memref<1xi8>
      dfg.push %0 to %out0 : !dfg.input<i8>
      memref.store %token0, %alloc[%c0] : memref<1xi8>
    }
  }
  dfg.process @line_buffer inputs(%in0: !dfg.output<i6>, %in1: !dfg.output<i6>, %in2: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) {
    %c1_i6 = arith.constant 1 : i6
    %true = arith.constant true
    %c64 = arith.constant 64 : index
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %false = arith.constant false
    %c0_i6 = arith.constant 0 : i6
    %c0_i8 = arith.constant 0 : i8
    %alloc = memref.alloc() {mdc.persistent} : memref<1xi1>
    memref.store %false, %alloc[%c0] : memref<1xi1>
    %alloc_0 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_0[%c0] : memref<1xi6>
    %alloc_1 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_1[%c0] : memref<1xi6>
    %alloc_2 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
    %alloc_3 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_3[%c0] : memref<1xi6>
    %alloc_4 = memref.alloc() {mdc.persistent} : memref<64xi8>
    scf.for %arg0 = %c0 to %c64 step %c1 {
      memref.store %c0_i8, %alloc_4[%arg0] : memref<64xi8>
    }
    dfg.loop inputs(%in0: !dfg.output<i6>, %in1: !dfg.output<i6>, %in2: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) {
      %0 = memref.load %alloc[%c0] : memref<1xi1>
      %1 = arith.cmpi eq, %0, %false : i1
      scf.if %1 {
        %token0 = dfg.pull %in1 : !dfg.output<i6>
        %token1 = dfg.pull %in0 : !dfg.output<i6>
        %2 = arith.subi %token1, %c1_i6 : i6
        memref.store %2, %alloc_0[%c0] : memref<1xi6>
        memref.store %token0, %alloc_1[%c0] : memref<1xi6>
        memref.store %true, %alloc[%c0] : memref<1xi1>
      } else {
        %token2 = dfg.pull %in2 : !dfg.output<i8>
        %2 = memref.load %alloc_2[%c0] : memref<1xi6>
        %3 = arith.index_castui %2 : i6 to index
        %4 = memref.load %alloc_4[%3] : memref<64xi8>
        dfg.push %4 to %out0 : !dfg.input<i8>
        memref.store %token2, %alloc_4[%3] : memref<64xi8>
        %5 = memref.load %alloc_2[%c0] : memref<1xi6>
        %6 = memref.load %alloc_0[%c0] : memref<1xi6>
        %7 = arith.cmpi ult, %5, %6 : i6
        %8 = memref.load %alloc_3[%c0] : memref<1xi6>
        %9 = memref.load %alloc_1[%c0] : memref<1xi6>
        %10 = arith.cmpi ult, %8, %9 : i6
        %11 = arith.andi %7, %10 : i1
        scf.if %11 {
          %12 = memref.load %alloc_2[%c0] : memref<1xi6>
          %13 = arith.addi %12, %c1_i6 : i6
          memref.store %13, %alloc_2[%c0] : memref<1xi6>
        } else {
          %12 = memref.load %alloc_1[%c0] : memref<1xi6>
          %13 = arith.subi %12, %c1_i6 : i6
          %14 = memref.load %alloc_3[%c0] : memref<1xi6>
          %15 = arith.cmpi ult, %14, %13 : i6
          scf.if %15 {
            %16 = memref.load %alloc_3[%c0] : memref<1xi6>
            %17 = arith.addi %16, %c1_i6 : i6
            memref.store %17, %alloc_3[%c0] : memref<1xi6>
            memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
          } else {
            memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
            memref.store %c0_i6, %alloc_3[%c0] : memref<1xi6>
            memref.store %false, %alloc[%c0] : memref<1xi1>
          }
        }
      }
    }
  }
  dfg.process @remove_2x2 inputs(%in0: !dfg.output<i6>, %in1: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) {
    %c1_i6 = arith.constant 1 : i6
    %c-2_i2 = arith.constant -2 : i2
    %c1_i2 = arith.constant 1 : i2
    %c0 = arith.constant 0 : index
    %c0_i2 = arith.constant 0 : i2
    %c0_i6 = arith.constant 0 : i6
    %alloc = memref.alloc() {mdc.persistent} : memref<1xi2>
    memref.store %c0_i2, %alloc[%c0] : memref<1xi2>
    %alloc_0 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_0[%c0] : memref<1xi6>
    %alloc_1 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_1[%c0] : memref<1xi6>
    %alloc_2 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
    dfg.loop inputs(%in0: !dfg.output<i6>, %in1: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) {
      %0 = memref.load %alloc[%c0] : memref<1xi2>
      %1 = arith.cmpi eq, %0, %c0_i2 : i2
      scf.if %1 {
        %token0 = dfg.pull %in0 : !dfg.output<i6>
        %2 = arith.subi %token0, %c1_i6 : i6
        memref.store %2, %alloc_0[%c0] : memref<1xi6>
        memref.store %c1_i2, %alloc[%c0] : memref<1xi2>
      } else {
        %token1 = dfg.pull %in1 : !dfg.output<i8>
        %2 = memref.load %alloc[%c0] : memref<1xi2>
        %3 = arith.cmpi eq, %2, %c1_i2 : i2
        scf.if %3 {
          %4 = memref.load %alloc_2[%c0] : memref<1xi6>
          %5 = memref.load %alloc_0[%c0] : memref<1xi6>
          %6 = arith.cmpi ult, %4, %5 : i6
          scf.if %6 {
            %7 = memref.load %alloc_2[%c0] : memref<1xi6>
            %8 = arith.addi %7, %c1_i6 : i6
            memref.store %8, %alloc_2[%c0] : memref<1xi6>
          } else {
            %7 = memref.load %alloc_1[%c0] : memref<1xi6>
            %8 = arith.addi %7, %c1_i6 : i6
            memref.store %8, %alloc_1[%c0] : memref<1xi6>
            memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
            memref.store %c-2_i2, %alloc[%c0] : memref<1xi2>
          }
        } else {
          %4 = memref.load %alloc_0[%c0] : memref<1xi6>
          %5 = arith.addi %4, %c1_i6 : i6
          %6 = memref.load %alloc_1[%c0] : memref<1xi6>
          %7 = arith.cmpi ult, %6, %5 : i6
          %8 = memref.load %alloc_2[%c0] : memref<1xi6>
          %9 = arith.cmpi ult, %8, %c1_i6 : i6
          %10 = arith.andi %9, %7 : i1
          scf.if %10 {
            %11 = memref.load %alloc_2[%c0] : memref<1xi6>
            %12 = arith.addi %11, %c1_i6 : i6
            memref.store %12, %alloc_2[%c0] : memref<1xi6>
          } else {
            dfg.push %token1 to %out0 : !dfg.input<i8>
            %11 = memref.load %alloc_2[%c0] : memref<1xi6>
            %12 = memref.load %alloc_0[%c0] : memref<1xi6>
            %13 = arith.cmpi ult, %11, %12 : i6
            %14 = arith.andi %13, %7 : i1
            scf.if %14 {
              %15 = memref.load %alloc_2[%c0] : memref<1xi6>
              %16 = arith.addi %15, %c1_i6 : i6
              memref.store %16, %alloc_2[%c0] : memref<1xi6>
            } else {
              %15 = memref.load %alloc_1[%c0] : memref<1xi6>
              %16 = memref.load %alloc_0[%c0] : memref<1xi6>
              %17 = arith.cmpi ult, %15, %16 : i6
              scf.if %17 {
                %18 = memref.load %alloc_1[%c0] : memref<1xi6>
                %19 = arith.addi %18, %c1_i6 : i6
                memref.store %19, %alloc_1[%c0] : memref<1xi6>
                memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
              } else {
                memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
                memref.store %c0_i6, %alloc_1[%c0] : memref<1xi6>
                memref.store %c0_i2, %alloc[%c0] : memref<1xi2>
              }
            }
          }
        }
      }
    }
  }
  dfg.process @remove_3x3 inputs(%in0: !dfg.output<i6>, %in1: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) {
    %c2_i6 = arith.constant 2 : i6
    %c1_i6 = arith.constant 1 : i6
    %c-2_i2 = arith.constant -2 : i2
    %c1_i2 = arith.constant 1 : i2
    %c0 = arith.constant 0 : index
    %c0_i2 = arith.constant 0 : i2
    %c0_i6 = arith.constant 0 : i6
    %alloc = memref.alloc() {mdc.persistent} : memref<1xi2>
    memref.store %c0_i2, %alloc[%c0] : memref<1xi2>
    %alloc_0 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_0[%c0] : memref<1xi6>
    %alloc_1 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_1[%c0] : memref<1xi6>
    %alloc_2 = memref.alloc() {mdc.persistent} : memref<1xi6>
    memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
    dfg.loop inputs(%in0: !dfg.output<i6>, %in1: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) {
      %0 = memref.load %alloc[%c0] : memref<1xi2>
      %1 = arith.cmpi eq, %0, %c0_i2 : i2
      scf.if %1 {
        %token0 = dfg.pull %in0 : !dfg.output<i6>
        %2 = arith.subi %token0, %c1_i6 : i6
        memref.store %2, %alloc_0[%c0] : memref<1xi6>
        memref.store %c1_i2, %alloc[%c0] : memref<1xi2>
      } else {
        %token1 = dfg.pull %in1 : !dfg.output<i8>
        %2 = memref.load %alloc[%c0] : memref<1xi2>
        %3 = arith.cmpi eq, %2, %c1_i2 : i2
        scf.if %3 {
          %4 = memref.load %alloc_2[%c0] : memref<1xi6>
          %5 = memref.load %alloc_0[%c0] : memref<1xi6>
          %6 = memref.load %alloc_1[%c0] : memref<1xi6>
          %7 = arith.cmpi ult, %6, %c2_i6 : i6
          scf.if %7 {
            %8 = arith.cmpi ult, %4, %5 : i6
            scf.if %8 {
              %9 = arith.addi %4, %c1_i6 : i6
              memref.store %9, %alloc_2[%c0] : memref<1xi6>
            } else {
              %9 = arith.addi %6, %c1_i6 : i6
              memref.store %9, %alloc_1[%c0] : memref<1xi6>
              memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
            }
          } else {
            %8 = arith.addi %4, %c1_i6 : i6
            memref.store %8, %alloc_2[%c0] : memref<1xi6>
            memref.store %c-2_i2, %alloc[%c0] : memref<1xi2>
          }
        } else {
          %4 = memref.load %alloc_0[%c0] : memref<1xi6>
          %5 = arith.addi %4, %c1_i6 : i6
          %6 = memref.load %alloc_1[%c0] : memref<1xi6>
          %7 = arith.cmpi ult, %6, %5 : i6
          %8 = memref.load %alloc_2[%c0] : memref<1xi6>
          %9 = arith.cmpi ult, %8, %c2_i6 : i6
          %10 = arith.andi %9, %7 : i1
          scf.if %10 {
            %11 = memref.load %alloc_2[%c0] : memref<1xi6>
            %12 = arith.addi %11, %c1_i6 : i6
            memref.store %12, %alloc_2[%c0] : memref<1xi6>
          } else {
            dfg.push %token1 to %out0 : !dfg.input<i8>
            %11 = memref.load %alloc_2[%c0] : memref<1xi6>
            %12 = memref.load %alloc_0[%c0] : memref<1xi6>
            %13 = arith.cmpi ult, %11, %12 : i6
            %14 = arith.andi %13, %7 : i1
            scf.if %14 {
              %15 = memref.load %alloc_2[%c0] : memref<1xi6>
              %16 = arith.addi %15, %c1_i6 : i6
              memref.store %16, %alloc_2[%c0] : memref<1xi6>
            } else {
              %15 = memref.load %alloc_1[%c0] : memref<1xi6>
              %16 = memref.load %alloc_0[%c0] : memref<1xi6>
              %17 = arith.cmpi ult, %15, %16 : i6
              scf.if %17 {
                %18 = memref.load %alloc_1[%c0] : memref<1xi6>
                %19 = arith.addi %18, %c1_i6 : i6
                memref.store %19, %alloc_1[%c0] : memref<1xi6>
                memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
              } else {
                memref.store %c0_i6, %alloc_2[%c0] : memref<1xi6>
                memref.store %c0_i6, %alloc_1[%c0] : memref<1xi6>
                memref.store %c0_i2, %alloc[%c0] : memref<1xi2>
              }
            }
          }
        }
      }
    }
  }
  dfg.region @top inputs(%in0 : !dfg.output<i6>, %in1 : !dfg.output<i8>)  outputs(%out0 : !dfg.input<i8>)  attributes {mdc.moreano, mdc.networks = ["roberts", "Sobel"], mdc.vertex_maps = [{network = "roberts", nodes = array<i64: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10>}, {network = "Sobel", nodes = array<i64: 0, 1, 2, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 8, 9, 21>}]} {
    %in_port_0, %out_port_0 = dfg.channel(1) : i8
    %in_port_1, %out_port_1 = dfg.channel(1) : i8
    %in_port_2, %out_port_2 = dfg.channel(1) : i8
    %in_port_3, %out_port_3 = dfg.channel(1) : i14
    %in_port_4, %out_port_4 = dfg.channel(1) : i14
    %in_port_5, %out_port_5 = dfg.channel(1) : i14
    %in_port_6, %out_port_6 = dfg.channel(1) : i8
    %in_port_7, %out_port_7 = dfg.channel() : i8
    %in_port_8, %out_port_8 = dfg.channel(1) : i8
    %in_port_9, %out_port_9 = dfg.channel(1) : i8
    %in_port_10, %out_port_10 = dfg.channel(1) : i8
    %in_port_11, %out_port_11 = dfg.channel(1) : i8
    %in_port_12, %out_port_12 = dfg.channel(1) : i8
    %in_port_13, %out_port_13 = dfg.channel(1) : i8
    %in_port_14, %out_port_14 = dfg.channel(1) : i8
    %in_port_15, %out_port_15 = dfg.channel(1) : i8
    %in_port_16, %out_port_16 = dfg.channel(1) : i14
    %in_port_17, %out_port_17 = dfg.channel(1) : i14
    %in_port_18, %out_port_18 = dfg.channel() : i8
    %in_port_19, %out_port_19 = dfg.channel() : i6
    %in_port_20, %out_port_20 = dfg.channel() : i6
    %in_port_21, %out_port_21 = dfg.channel() : i8
    %in_port_22, %out_port_22 = dfg.channel() : i8
    %in_port_23, %out_port_23 = dfg.channel(1) : i8
    %in_port_24, %out_port_24 = dfg.channel(1) : i8
    %in_port_25, %out_port_25 = dfg.channel(1) : i14
    %in_port_26, %out_port_26 = dfg.channel(1) : i14
    dfg.instantiate @line_buffer inputs(%out_port_19, %out_port_19, %out_port_21) outputs(%in_port_0) : (!dfg.output<i6>, !dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["roberts"], mdc.node_id = 3 : i64}
    dfg.instantiate @delay inputs(%out_port_0) outputs(%in_port_1) : (!dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["roberts"], mdc.node_id = 4 : i64}
    dfg.instantiate @delay inputs(%out_port_21) outputs(%in_port_2) : (!dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["roberts"], mdc.node_id = 5 : i64}
    dfg.instantiate @roberts_x inputs(%out_port_1, %out_port_0, %out_port_2, %out_port_21) outputs(%in_port_3) : (!dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>) -> !dfg.input<i14> {mdc.networks = ["roberts"], mdc.node_id = 6 : i64}
    dfg.instantiate @roberts_y inputs(%out_port_1, %out_port_0, %out_port_2, %out_port_21) outputs(%in_port_4) : (!dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>) -> !dfg.input<i14> {mdc.networks = ["roberts"], mdc.node_id = 7 : i64}
    dfg.instantiate @abs_sum inputs(%out_port_25, %out_port_26) outputs(%in_port_5) : (!dfg.output<i14>, !dfg.output<i14>) -> !dfg.input<i14> {mdc.networks = ["roberts", "Sobel"], mdc.node_id = 8 : i64}
    dfg.instantiate @thr inputs(%out_port_5) outputs(%in_port_6) : (!dfg.output<i14>) -> !dfg.input<i8> {mdc.networks = ["roberts", "Sobel"], mdc.node_id = 9 : i64}
    dfg.instantiate @remove_2x2 inputs(%out_port_19, %out_port_23) outputs(%in_port_7) : (!dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["roberts"], mdc.node_id = 10 : i64}
    dfg.instantiate @line_buffer inputs(%out_port_20, %out_port_20, %out_port_22) outputs(%in_port_8) : (!dfg.output<i6>, !dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["Sobel"], mdc.node_id = 11 : i64}
    dfg.instantiate @line_buffer inputs(%out_port_20, %out_port_20, %out_port_8) outputs(%in_port_9) : (!dfg.output<i6>, !dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["Sobel"], mdc.node_id = 12 : i64}
    dfg.instantiate @delay inputs(%out_port_9) outputs(%in_port_10) : (!dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["Sobel"], mdc.node_id = 13 : i64}
    dfg.instantiate @delay inputs(%out_port_10) outputs(%in_port_11) : (!dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["Sobel"], mdc.node_id = 14 : i64}
    dfg.instantiate @delay inputs(%out_port_8) outputs(%in_port_12) : (!dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["Sobel"], mdc.node_id = 15 : i64}
    dfg.instantiate @delay inputs(%out_port_12) outputs(%in_port_13) : (!dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["Sobel"], mdc.node_id = 16 : i64}
    dfg.instantiate @delay inputs(%out_port_22) outputs(%in_port_14) : (!dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["Sobel"], mdc.node_id = 17 : i64}
    dfg.instantiate @delay inputs(%out_port_14) outputs(%in_port_15) : (!dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["Sobel"], mdc.node_id = 18 : i64}
    dfg.instantiate @sobel_x inputs(%out_port_11, %out_port_10, %out_port_9, %out_port_13, %out_port_12, %out_port_8, %out_port_15, %out_port_14, %out_port_22) outputs(%in_port_16) : (!dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>) -> !dfg.input<i14> {mdc.networks = ["Sobel"], mdc.node_id = 19 : i64}
    dfg.instantiate @sobel_y inputs(%out_port_11, %out_port_10, %out_port_9, %out_port_13, %out_port_12, %out_port_8, %out_port_15, %out_port_14, %out_port_22) outputs(%in_port_17) : (!dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>, !dfg.output<i8>) -> !dfg.input<i14> {mdc.networks = ["Sobel"], mdc.node_id = 20 : i64}
    dfg.instantiate @remove_3x3 inputs(%out_port_20, %out_port_24) outputs(%in_port_18) : (!dfg.output<i6>, !dfg.output<i8>) -> !dfg.input<i8> {mdc.networks = ["Sobel"], mdc.node_id = 21 : i64}
    dfg.instantiate @Sbox1x2int6 inputs(%in0) outputs(%in_port_19, %in_port_20) : (!dfg.output<i6>) -> (!dfg.input<i6>, !dfg.input<i6>) {config = {networks = ["roberts", "Sobel"], values = [false, true]}, infrastructure, mdc.networks = ["roberts", "Sobel"], mdc.node_id = 22 : i64}
    dfg.instantiate @Sbox1x2int8 inputs(%in1) outputs(%in_port_21, %in_port_22) : (!dfg.output<i8>) -> (!dfg.input<i8>, !dfg.input<i8>) {config = {networks = ["roberts", "Sobel"], values = [false, true]}, infrastructure, mdc.networks = ["roberts", "Sobel"], mdc.node_id = 23 : i64}
    dfg.instantiate @Sbox1x2int8 inputs(%out_port_6) outputs(%in_port_23, %in_port_24) : (!dfg.output<i8>) -> (!dfg.input<i8>, !dfg.input<i8>) {config = {networks = ["roberts", "Sobel"], values = [false, true]}, infrastructure, mdc.networks = ["roberts", "Sobel"], mdc.node_id = 24 : i64}
    dfg.instantiate @Sbox2x1int8 inputs(%out_port_7, %out_port_18) outputs(%out0) : (!dfg.output<i8>, !dfg.output<i8>) -> !dfg.input<i8> {config = {networks = ["roberts", "Sobel"], values = [false, true]}, infrastructure, mdc.networks = ["roberts", "Sobel"], mdc.node_id = 25 : i64}
    dfg.instantiate @Sbox2x1int14 inputs(%out_port_3, %out_port_16) outputs(%in_port_25) : (!dfg.output<i14>, !dfg.output<i14>) -> !dfg.input<i14> {config = {networks = ["roberts", "Sobel"], values = [false, true]}, infrastructure, mdc.networks = ["roberts", "Sobel"], mdc.node_id = 26 : i64}
    dfg.instantiate @Sbox2x1int14 inputs(%out_port_4, %out_port_17) outputs(%in_port_26) : (!dfg.output<i14>, !dfg.output<i14>) -> !dfg.input<i14> {config = {networks = ["roberts", "Sobel"], values = [false, true]}, infrastructure, mdc.networks = ["roberts", "Sobel"], mdc.node_id = 27 : i64}
  }
  dfg.process @Sbox1x2int6 inputs(%in0: !dfg.output<i6>) outputs(%out0: !dfg.input<i6>, %out1: !dfg.input<i6>) attributes {mdc.external_switch, mdc.hls_placeholder} {
    %c0_i6 = arith.constant 0 : i6
    dfg.loop inputs(%in0: !dfg.output<i6>) outputs(%out0: !dfg.input<i6>, %out1: !dfg.input<i6>) {
      %token0 = dfg.pull %in0 : !dfg.output<i6>
      dfg.push %token0 to %out0 : !dfg.input<i6>
      dfg.push %c0_i6 to %out1 : !dfg.input<i6>
    }
  }
  dfg.process @Sbox1x2int8 inputs(%in0: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>, %out1: !dfg.input<i8>) attributes {mdc.external_switch, mdc.hls_placeholder} {
    %c0_i8 = arith.constant 0 : i8
    dfg.loop inputs(%in0: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>, %out1: !dfg.input<i8>) {
      %token0 = dfg.pull %in0 : !dfg.output<i8>
      dfg.push %token0 to %out0 : !dfg.input<i8>
      dfg.push %c0_i8 to %out1 : !dfg.input<i8>
    }
  }
  dfg.process @Sbox2x1int8 inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) attributes {mdc.external_switch, mdc.hls_placeholder} {
    dfg.loop inputs(%in0: !dfg.output<i8>, %in1: !dfg.output<i8>) outputs(%out0: !dfg.input<i8>) {
      %token0 = dfg.pull %in0 : !dfg.output<i8>
      %token1 = dfg.pull %in1 : !dfg.output<i8>
      %0 = arith.addi %token0, %token1 : i8
      dfg.push %0 to %out0 : !dfg.input<i8>
    }
  }
  dfg.process @Sbox2x1int14 inputs(%in0: !dfg.output<i14>, %in1: !dfg.output<i14>) outputs(%out0: !dfg.input<i14>) attributes {mdc.external_switch, mdc.hls_placeholder} {
    dfg.loop inputs(%in0: !dfg.output<i14>, %in1: !dfg.output<i14>) outputs(%out0: !dfg.input<i14>) {
      %token0 = dfg.pull %in0 : !dfg.output<i14>
      %token1 = dfg.pull %in1 : !dfg.output<i14>
      %0 = arith.addi %token0, %token1 : i14
      dfg.push %0 to %out0 : !dfg.input<i14>
    }
  }
}

