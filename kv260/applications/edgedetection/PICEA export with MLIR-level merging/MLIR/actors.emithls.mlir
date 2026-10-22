module attributes {mdc.hls_actors = ["roberts_x", "roberts_y", "sobel_x", "sobel_y", "abs_sum", "thr", "delay", "line_buffer", "remove_2x2", "remove_3x3"]} {
  emithls.include "ap_int.h"
  emithls.include "cstddef"
  emithls.include "hls_stream.h"
  emithls.func @roberts_x(%arg0: !emithls.stream<i8>, %arg1: !emithls.stream<i8>, %arg2: !emithls.stream<i8>, %arg3: !emithls.stream<i8>, %arg4: !emithls.stream<i14>) {
    %0 = emithls.stream.read %arg0 : !emithls.stream<i8> -> i8
    %1 = emithls.stream.read %arg1 : !emithls.stream<i8> -> i8
    %2 = emithls.stream.read %arg2 : !emithls.stream<i8> -> i8
    %3 = emithls.stream.read %arg3 : !emithls.stream<i8> -> i8
    %4 = emithls.arith.cast %0 : i8 to ui8
    %5 = emithls.arith.cast %4 : ui8 to i14
    %6 = emithls.arith.cast %3 : i8 to ui8
    %7 = emithls.arith.cast %6 : ui8 to i14
    %8 = emithls.arith.sub %5, %7 : i14
    emithls.stream.write %8 to %arg4 : i14 -> !emithls.stream<i14>
  }
  emithls.func @roberts_y(%arg0: !emithls.stream<i8>, %arg1: !emithls.stream<i8>, %arg2: !emithls.stream<i8>, %arg3: !emithls.stream<i8>, %arg4: !emithls.stream<i14>) {
    %0 = emithls.stream.read %arg0 : !emithls.stream<i8> -> i8
    %1 = emithls.stream.read %arg1 : !emithls.stream<i8> -> i8
    %2 = emithls.stream.read %arg2 : !emithls.stream<i8> -> i8
    %3 = emithls.stream.read %arg3 : !emithls.stream<i8> -> i8
    %4 = emithls.arith.cast %1 : i8 to ui8
    %5 = emithls.arith.cast %4 : ui8 to i14
    %6 = emithls.arith.cast %2 : i8 to ui8
    %7 = emithls.arith.cast %6 : ui8 to i14
    %8 = emithls.arith.sub %5, %7 : i14
    emithls.stream.write %8 to %arg4 : i14 -> !emithls.stream<i14>
  }
  emithls.func @sobel_x(%arg0: !emithls.stream<i8>, %arg1: !emithls.stream<i8>, %arg2: !emithls.stream<i8>, %arg3: !emithls.stream<i8>, %arg4: !emithls.stream<i8>, %arg5: !emithls.stream<i8>, %arg6: !emithls.stream<i8>, %arg7: !emithls.stream<i8>, %arg8: !emithls.stream<i8>, %arg9: !emithls.stream<i14>) {
    %const_int14_0 = emithls.variable as const i14 = 2
    %0 = emithls.stream.read %arg0 : !emithls.stream<i8> -> i8
    %1 = emithls.stream.read %arg1 : !emithls.stream<i8> -> i8
    %2 = emithls.stream.read %arg2 : !emithls.stream<i8> -> i8
    %3 = emithls.stream.read %arg3 : !emithls.stream<i8> -> i8
    %4 = emithls.stream.read %arg4 : !emithls.stream<i8> -> i8
    %5 = emithls.stream.read %arg5 : !emithls.stream<i8> -> i8
    %6 = emithls.stream.read %arg6 : !emithls.stream<i8> -> i8
    %7 = emithls.stream.read %arg7 : !emithls.stream<i8> -> i8
    %8 = emithls.stream.read %arg8 : !emithls.stream<i8> -> i8
    %9 = emithls.arith.cast %0 : i8 to ui8
    %10 = emithls.arith.cast %9 : ui8 to i14
    %11 = emithls.arith.cast %3 : i8 to ui8
    %12 = emithls.arith.cast %11 : ui8 to i14
    %13 = emithls.arith.cast %6 : i8 to ui8
    %14 = emithls.arith.cast %13 : ui8 to i14
    %15 = emithls.arith.cast %2 : i8 to ui8
    %16 = emithls.arith.cast %15 : ui8 to i14
    %17 = emithls.arith.cast %5 : i8 to ui8
    %18 = emithls.arith.cast %17 : ui8 to i14
    %19 = emithls.arith.cast %8 : i8 to ui8
    %20 = emithls.arith.cast %19 : ui8 to i14
    %21 = emithls.arith.mul %12, %const_int14_0 : i14
    %22 = emithls.arith.mul %18, %const_int14_0 : i14
    %23 = emithls.arith.add %10, %21 : i14
    %24 = emithls.arith.add %23, %14 : i14
    %25 = emithls.arith.add %16, %22 : i14
    %26 = emithls.arith.add %25, %20 : i14
    %27 = emithls.arith.sub %24, %26 : i14
    emithls.stream.write %27 to %arg9 : i14 -> !emithls.stream<i14>
  }
  emithls.func @sobel_y(%arg0: !emithls.stream<i8>, %arg1: !emithls.stream<i8>, %arg2: !emithls.stream<i8>, %arg3: !emithls.stream<i8>, %arg4: !emithls.stream<i8>, %arg5: !emithls.stream<i8>, %arg6: !emithls.stream<i8>, %arg7: !emithls.stream<i8>, %arg8: !emithls.stream<i8>, %arg9: !emithls.stream<i14>) {
    %const_int14_0 = emithls.variable as const i14 = 2
    %0 = emithls.stream.read %arg0 : !emithls.stream<i8> -> i8
    %1 = emithls.stream.read %arg1 : !emithls.stream<i8> -> i8
    %2 = emithls.stream.read %arg2 : !emithls.stream<i8> -> i8
    %3 = emithls.stream.read %arg3 : !emithls.stream<i8> -> i8
    %4 = emithls.stream.read %arg4 : !emithls.stream<i8> -> i8
    %5 = emithls.stream.read %arg5 : !emithls.stream<i8> -> i8
    %6 = emithls.stream.read %arg6 : !emithls.stream<i8> -> i8
    %7 = emithls.stream.read %arg7 : !emithls.stream<i8> -> i8
    %8 = emithls.stream.read %arg8 : !emithls.stream<i8> -> i8
    %9 = emithls.arith.cast %0 : i8 to ui8
    %10 = emithls.arith.cast %9 : ui8 to i14
    %11 = emithls.arith.cast %1 : i8 to ui8
    %12 = emithls.arith.cast %11 : ui8 to i14
    %13 = emithls.arith.cast %2 : i8 to ui8
    %14 = emithls.arith.cast %13 : ui8 to i14
    %15 = emithls.arith.cast %6 : i8 to ui8
    %16 = emithls.arith.cast %15 : ui8 to i14
    %17 = emithls.arith.cast %7 : i8 to ui8
    %18 = emithls.arith.cast %17 : ui8 to i14
    %19 = emithls.arith.cast %8 : i8 to ui8
    %20 = emithls.arith.cast %19 : ui8 to i14
    %21 = emithls.arith.mul %12, %const_int14_0 : i14
    %22 = emithls.arith.mul %18, %const_int14_0 : i14
    %23 = emithls.arith.add %10, %21 : i14
    %24 = emithls.arith.add %23, %14 : i14
    %25 = emithls.arith.add %16, %22 : i14
    %26 = emithls.arith.add %25, %20 : i14
    %27 = emithls.arith.sub %24, %26 : i14
    emithls.stream.write %27 to %arg9 : i14 -> !emithls.stream<i14>
  }
  emithls.func @abs_sum(%arg0: !emithls.stream<i14>, %arg1: !emithls.stream<i14>, %arg2: !emithls.stream<i14>) {
    %const_int14_0 = emithls.variable as const i14 = 0
    %0 = emithls.stream.read %arg0 : !emithls.stream<i14> -> i14
    %1 = emithls.stream.read %arg1 : !emithls.stream<i14> -> i14
    %2 = emithls.arith.sub %const_int14_0, %0 : i14
    %3 = emithls.arith.sub %const_int14_0, %1 : i14
    %4 = emithls.arith.cmp lt, %0, %const_int14_0 : i14
    %5 = emithls.arith.cmp lt, %1, %const_int14_0 : i14
    %6 = emithls.arith.select %4, %2, %0 : i14
    %7 = emithls.arith.select %5, %3, %1 : i14
    %8 = emithls.arith.add %6, %7 : i14
    emithls.stream.write %8 to %arg2 : i14 -> !emithls.stream<i14>
  }
  emithls.func @thr(%arg0: !emithls.stream<i14>, %arg1: !emithls.stream<i8>) {
    %const_int8_0 = emithls.variable as const i8 = 0
    %const_int8_1 = emithls.variable as const i8 = -1
    %const_int14_0 = emithls.variable as const i14 = 80
    %0 = emithls.stream.read %arg0 : !emithls.stream<i14> -> i14
    %1 = emithls.arith.cmp gt, %0, %const_int14_0 : i14
    %2 = emithls.arith.select %1, %const_int8_1, %const_int8_0 : i8
    emithls.stream.write %2 to %arg1 : i8 -> !emithls.stream<i8>
  }
  emithls.func @delay(%arg0: !emithls.stream<i8>, %arg1: !emithls.stream<i8>) {
    %const_index_0 = emithls.variable as const index = 0
    %var_array_0 = emithls.variable as !emithls.array<1xi8> = dense<0> {mdc.persistent}
    %0 = emithls.stream.read %arg0 : !emithls.stream<i8> -> i8
    %1 = emithls.array.read %var_array_0[%const_index_0] : !emithls.array<1xi8> -> i8
    emithls.stream.write %1 to %arg1 : i8 -> !emithls.stream<i8>
    emithls.array.write %0, %var_array_0[%const_index_0] : i8 -> !emithls.array<1xi8>
  }
  emithls.func @line_buffer(%arg0: !emithls.stream<i6>, %arg1: !emithls.stream<i6>, %arg2: !emithls.stream<i8>, %arg3: !emithls.stream<i8>) {
    %const_int6_0 = emithls.variable as const i6 = 1
    %const_int1_0 = emithls.variable as const i1 = true
    %const_index_0 = emithls.variable as const index = 0
    %const_int1_1 = emithls.variable as const i1 = false
    %const_int6_1 = emithls.variable as const i6 = 0
    %var_array_0 = emithls.variable as !emithls.array<1xi1> = dense<false> {mdc.persistent}
    %var_array_1 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %var_array_2 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %var_array_3 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %var_array_4 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %var_array_5 = emithls.variable as !emithls.array<64xi8> = dense<0> {mdc.persistent}
    %0 = emithls.array.read %var_array_0[%const_index_0] : !emithls.array<1xi1> -> i1
    %1 = emithls.arith.cmp eq, %0, %const_int1_1 : i1
    emithls.if %1 {
      %2 = emithls.stream.read %arg1 : !emithls.stream<i6> -> i6
      %3 = emithls.stream.read %arg0 : !emithls.stream<i6> -> i6
      %4 = emithls.arith.sub %3, %const_int6_0 : i6
      emithls.array.write %4, %var_array_1[%const_index_0] : i6 -> !emithls.array<1xi6>
      emithls.array.write %2, %var_array_2[%const_index_0] : i6 -> !emithls.array<1xi6>
      emithls.array.write %const_int1_0, %var_array_0[%const_index_0] : i1 -> !emithls.array<1xi1>
    } else {
      %2 = emithls.stream.read %arg2 : !emithls.stream<i8> -> i8
      %3 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
      %4 = emithls.arith.cast %3 : i6 to ui6
      %5 = emithls.arith.cast %4 : ui6 to index
      %6 = emithls.array.read %var_array_5[%5] : !emithls.array<64xi8> -> i8
      emithls.stream.write %6 to %arg3 : i8 -> !emithls.stream<i8>
      emithls.array.write %2, %var_array_5[%5] : i8 -> !emithls.array<64xi8>
      %7 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
      %8 = emithls.array.read %var_array_1[%const_index_0] : !emithls.array<1xi6> -> i6
      %9 = emithls.arith.cast %7 : i6 to ui6
      %10 = emithls.arith.cast %8 : i6 to ui6
      %11 = emithls.arith.cmp lt, %9, %10 : ui6
      %12 = emithls.array.read %var_array_4[%const_index_0] : !emithls.array<1xi6> -> i6
      %13 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
      %14 = emithls.arith.cast %12 : i6 to ui6
      %15 = emithls.arith.cast %13 : i6 to ui6
      %16 = emithls.arith.cmp lt, %14, %15 : ui6
      %17 = emithls.arith.and %11, %16 : i1
      emithls.if %17 {
        %18 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
        %19 = emithls.arith.add %18, %const_int6_0 : i6
        emithls.array.write %19, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
      } else {
        %18 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
        %19 = emithls.arith.sub %18, %const_int6_0 : i6
        %20 = emithls.array.read %var_array_4[%const_index_0] : !emithls.array<1xi6> -> i6
        %21 = emithls.arith.cast %20 : i6 to ui6
        %22 = emithls.arith.cast %19 : i6 to ui6
        %23 = emithls.arith.cmp lt, %21, %22 : ui6
        emithls.if %23 {
          %24 = emithls.array.read %var_array_4[%const_index_0] : !emithls.array<1xi6> -> i6
          %25 = emithls.arith.add %24, %const_int6_0 : i6
          emithls.array.write %25, %var_array_4[%const_index_0] : i6 -> !emithls.array<1xi6>
          emithls.array.write %const_int6_1, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
        } else {
          emithls.array.write %const_int6_1, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
          emithls.array.write %const_int6_1, %var_array_4[%const_index_0] : i6 -> !emithls.array<1xi6>
          emithls.array.write %const_int1_1, %var_array_0[%const_index_0] : i1 -> !emithls.array<1xi1>
        }
      }
    }
  }
  emithls.func @remove_2x2(%arg0: !emithls.stream<i6>, %arg1: !emithls.stream<i8>, %arg2: !emithls.stream<i8>) {
    %const_int6_0 = emithls.variable as const i6 = 1
    %const_int2_0 = emithls.variable as const i2 = -2
    %const_int2_1 = emithls.variable as const i2 = 1
    %const_index_0 = emithls.variable as const index = 0
    %const_int2_2 = emithls.variable as const i2 = 0
    %const_int6_1 = emithls.variable as const i6 = 0
    %var_array_0 = emithls.variable as !emithls.array<1xi2> = dense<0> {mdc.persistent}
    %var_array_1 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %var_array_2 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %var_array_3 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %0 = emithls.array.read %var_array_0[%const_index_0] : !emithls.array<1xi2> -> i2
    %1 = emithls.arith.cmp eq, %0, %const_int2_2 : i2
    emithls.if %1 {
      %2 = emithls.stream.read %arg0 : !emithls.stream<i6> -> i6
      %3 = emithls.arith.sub %2, %const_int6_0 : i6
      emithls.array.write %3, %var_array_1[%const_index_0] : i6 -> !emithls.array<1xi6>
      emithls.array.write %const_int2_1, %var_array_0[%const_index_0] : i2 -> !emithls.array<1xi2>
    } else {
      %2 = emithls.stream.read %arg1 : !emithls.stream<i8> -> i8
      %3 = emithls.array.read %var_array_0[%const_index_0] : !emithls.array<1xi2> -> i2
      %4 = emithls.arith.cmp eq, %3, %const_int2_1 : i2
      emithls.if %4 {
        %5 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
        %6 = emithls.array.read %var_array_1[%const_index_0] : !emithls.array<1xi6> -> i6
        %7 = emithls.arith.cast %5 : i6 to ui6
        %8 = emithls.arith.cast %6 : i6 to ui6
        %9 = emithls.arith.cmp lt, %7, %8 : ui6
        emithls.if %9 {
          %10 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
          %11 = emithls.arith.add %10, %const_int6_0 : i6
          emithls.array.write %11, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
        } else {
          %10 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
          %11 = emithls.arith.add %10, %const_int6_0 : i6
          emithls.array.write %11, %var_array_2[%const_index_0] : i6 -> !emithls.array<1xi6>
          emithls.array.write %const_int6_1, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
          emithls.array.write %const_int2_0, %var_array_0[%const_index_0] : i2 -> !emithls.array<1xi2>
        }
      } else {
        %5 = emithls.array.read %var_array_1[%const_index_0] : !emithls.array<1xi6> -> i6
        %6 = emithls.arith.add %5, %const_int6_0 : i6
        %7 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
        %8 = emithls.arith.cast %7 : i6 to ui6
        %9 = emithls.arith.cast %6 : i6 to ui6
        %10 = emithls.arith.cmp lt, %8, %9 : ui6
        %11 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
        %12 = emithls.arith.cast %11 : i6 to ui6
        %13 = emithls.arith.cast %const_int6_0 : i6 to ui6
        %14 = emithls.arith.cmp lt, %12, %13 : ui6
        %15 = emithls.arith.and %14, %10 : i1
        emithls.if %15 {
          %16 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
          %17 = emithls.arith.add %16, %const_int6_0 : i6
          emithls.array.write %17, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
        } else {
          emithls.stream.write %2 to %arg2 : i8 -> !emithls.stream<i8>
          %16 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
          %17 = emithls.array.read %var_array_1[%const_index_0] : !emithls.array<1xi6> -> i6
          %18 = emithls.arith.cast %16 : i6 to ui6
          %19 = emithls.arith.cast %17 : i6 to ui6
          %20 = emithls.arith.cmp lt, %18, %19 : ui6
          %21 = emithls.arith.and %20, %10 : i1
          emithls.if %21 {
            %22 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
            %23 = emithls.arith.add %22, %const_int6_0 : i6
            emithls.array.write %23, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
          } else {
            %22 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
            %23 = emithls.array.read %var_array_1[%const_index_0] : !emithls.array<1xi6> -> i6
            %24 = emithls.arith.cast %22 : i6 to ui6
            %25 = emithls.arith.cast %23 : i6 to ui6
            %26 = emithls.arith.cmp lt, %24, %25 : ui6
            emithls.if %26 {
              %27 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
              %28 = emithls.arith.add %27, %const_int6_0 : i6
              emithls.array.write %28, %var_array_2[%const_index_0] : i6 -> !emithls.array<1xi6>
              emithls.array.write %const_int6_1, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
            } else {
              emithls.array.write %const_int6_1, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
              emithls.array.write %const_int6_1, %var_array_2[%const_index_0] : i6 -> !emithls.array<1xi6>
              emithls.array.write %const_int2_2, %var_array_0[%const_index_0] : i2 -> !emithls.array<1xi2>
            }
          }
        }
      }
    }
  }
  emithls.func @remove_3x3(%arg0: !emithls.stream<i6>, %arg1: !emithls.stream<i8>, %arg2: !emithls.stream<i8>) {
    %const_int6_0 = emithls.variable as const i6 = 2
    %const_int6_1 = emithls.variable as const i6 = 1
    %const_int2_0 = emithls.variable as const i2 = -2
    %const_int2_1 = emithls.variable as const i2 = 1
    %const_index_0 = emithls.variable as const index = 0
    %const_int2_2 = emithls.variable as const i2 = 0
    %const_int6_2 = emithls.variable as const i6 = 0
    %var_array_0 = emithls.variable as !emithls.array<1xi2> = dense<0> {mdc.persistent}
    %var_array_1 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %var_array_2 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %var_array_3 = emithls.variable as !emithls.array<1xi6> = dense<0> {mdc.persistent}
    %0 = emithls.array.read %var_array_0[%const_index_0] : !emithls.array<1xi2> -> i2
    %1 = emithls.arith.cmp eq, %0, %const_int2_2 : i2
    emithls.if %1 {
      %2 = emithls.stream.read %arg0 : !emithls.stream<i6> -> i6
      %3 = emithls.arith.sub %2, %const_int6_1 : i6
      emithls.array.write %3, %var_array_1[%const_index_0] : i6 -> !emithls.array<1xi6>
      emithls.array.write %const_int2_1, %var_array_0[%const_index_0] : i2 -> !emithls.array<1xi2>
    } else {
      %2 = emithls.stream.read %arg1 : !emithls.stream<i8> -> i8
      %3 = emithls.array.read %var_array_0[%const_index_0] : !emithls.array<1xi2> -> i2
      %4 = emithls.arith.cmp eq, %3, %const_int2_1 : i2
      emithls.if %4 {
        %5 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
        %6 = emithls.array.read %var_array_1[%const_index_0] : !emithls.array<1xi6> -> i6
        %7 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
        %8 = emithls.arith.cast %7 : i6 to ui6
        %9 = emithls.arith.cast %const_int6_0 : i6 to ui6
        %10 = emithls.arith.cmp lt, %8, %9 : ui6
        emithls.if %10 {
          %11 = emithls.arith.cast %5 : i6 to ui6
          %12 = emithls.arith.cast %6 : i6 to ui6
          %13 = emithls.arith.cmp lt, %11, %12 : ui6
          emithls.if %13 {
            %14 = emithls.arith.add %5, %const_int6_1 : i6
            emithls.array.write %14, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
          } else {
            %14 = emithls.arith.add %7, %const_int6_1 : i6
            emithls.array.write %14, %var_array_2[%const_index_0] : i6 -> !emithls.array<1xi6>
            emithls.array.write %const_int6_2, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
          }
        } else {
          %11 = emithls.arith.add %5, %const_int6_1 : i6
          emithls.array.write %11, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
          emithls.array.write %const_int2_0, %var_array_0[%const_index_0] : i2 -> !emithls.array<1xi2>
        }
      } else {
        %5 = emithls.array.read %var_array_1[%const_index_0] : !emithls.array<1xi6> -> i6
        %6 = emithls.arith.add %5, %const_int6_1 : i6
        %7 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
        %8 = emithls.arith.cast %7 : i6 to ui6
        %9 = emithls.arith.cast %6 : i6 to ui6
        %10 = emithls.arith.cmp lt, %8, %9 : ui6
        %11 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
        %12 = emithls.arith.cast %11 : i6 to ui6
        %13 = emithls.arith.cast %const_int6_0 : i6 to ui6
        %14 = emithls.arith.cmp lt, %12, %13 : ui6
        %15 = emithls.arith.and %14, %10 : i1
        emithls.if %15 {
          %16 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
          %17 = emithls.arith.add %16, %const_int6_1 : i6
          emithls.array.write %17, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
        } else {
          emithls.stream.write %2 to %arg2 : i8 -> !emithls.stream<i8>
          %16 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
          %17 = emithls.array.read %var_array_1[%const_index_0] : !emithls.array<1xi6> -> i6
          %18 = emithls.arith.cast %16 : i6 to ui6
          %19 = emithls.arith.cast %17 : i6 to ui6
          %20 = emithls.arith.cmp lt, %18, %19 : ui6
          %21 = emithls.arith.and %20, %10 : i1
          emithls.if %21 {
            %22 = emithls.array.read %var_array_3[%const_index_0] : !emithls.array<1xi6> -> i6
            %23 = emithls.arith.add %22, %const_int6_1 : i6
            emithls.array.write %23, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
          } else {
            %22 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
            %23 = emithls.array.read %var_array_1[%const_index_0] : !emithls.array<1xi6> -> i6
            %24 = emithls.arith.cast %22 : i6 to ui6
            %25 = emithls.arith.cast %23 : i6 to ui6
            %26 = emithls.arith.cmp lt, %24, %25 : ui6
            emithls.if %26 {
              %27 = emithls.array.read %var_array_2[%const_index_0] : !emithls.array<1xi6> -> i6
              %28 = emithls.arith.add %27, %const_int6_1 : i6
              emithls.array.write %28, %var_array_2[%const_index_0] : i6 -> !emithls.array<1xi6>
              emithls.array.write %const_int6_2, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
            } else {
              emithls.array.write %const_int6_2, %var_array_3[%const_index_0] : i6 -> !emithls.array<1xi6>
              emithls.array.write %const_int6_2, %var_array_2[%const_index_0] : i6 -> !emithls.array<1xi6>
              emithls.array.write %const_int2_2, %var_array_0[%const_index_0] : i2 -> !emithls.array<1xi2>
            }
          }
        }
      }
    }
  }
  emithls.func @Sbox1x2int6(%arg0: !emithls.stream<i6>, %arg1: !emithls.stream<i6>, %arg2: !emithls.stream<i6>) {
    %const_int6_0 = emithls.variable as const i6 = 0
    %0 = emithls.stream.read %arg0 : !emithls.stream<i6> -> i6
    emithls.stream.write %0 to %arg1 : i6 -> !emithls.stream<i6>
    emithls.stream.write %const_int6_0 to %arg2 : i6 -> !emithls.stream<i6>
  }
  emithls.func @Sbox1x2int8(%arg0: !emithls.stream<i8>, %arg1: !emithls.stream<i8>, %arg2: !emithls.stream<i8>) {
    %const_int8_0 = emithls.variable as const i8 = 0
    %0 = emithls.stream.read %arg0 : !emithls.stream<i8> -> i8
    emithls.stream.write %0 to %arg1 : i8 -> !emithls.stream<i8>
    emithls.stream.write %const_int8_0 to %arg2 : i8 -> !emithls.stream<i8>
  }
  emithls.func @Sbox2x1int8(%arg0: !emithls.stream<i8>, %arg1: !emithls.stream<i8>, %arg2: !emithls.stream<i8>) {
    %0 = emithls.stream.read %arg0 : !emithls.stream<i8> -> i8
    %1 = emithls.stream.read %arg1 : !emithls.stream<i8> -> i8
    %2 = emithls.arith.add %0, %1 : i8
    emithls.stream.write %2 to %arg2 : i8 -> !emithls.stream<i8>
  }
  emithls.func @Sbox2x1int14(%arg0: !emithls.stream<i14>, %arg1: !emithls.stream<i14>, %arg2: !emithls.stream<i14>) {
    %0 = emithls.stream.read %arg0 : !emithls.stream<i14> -> i14
    %1 = emithls.stream.read %arg1 : !emithls.stream<i14> -> i14
    %2 = emithls.arith.add %0, %1 : i14
    emithls.stream.write %2 to %arg2 : i14 -> !emithls.stream<i14>
  }
  emithls.func @top(%arg0: !emithls.stream<i6>, %arg1: !emithls.stream<i8>, %arg2: !emithls.stream<i8>) {
    %var_stream_0 = emithls.variable as !emithls.stream<i8>
    %var_stream_1 = emithls.variable as !emithls.stream<i8>
    %var_stream_2 = emithls.variable as !emithls.stream<i8>
    %var_stream_0_0 = emithls.variable as !emithls.stream<i14>
    %var_stream_1_1 = emithls.variable as !emithls.stream<i14>
    %var_stream_2_2 = emithls.variable as !emithls.stream<i14>
    %var_stream_3 = emithls.variable as !emithls.stream<i8>
    %var_stream_4 = emithls.variable as !emithls.stream<i8>
    %var_stream_5 = emithls.variable as !emithls.stream<i8>
    %var_stream_6 = emithls.variable as !emithls.stream<i8>
    %var_stream_7 = emithls.variable as !emithls.stream<i8>
    %var_stream_8 = emithls.variable as !emithls.stream<i8>
    %var_stream_9 = emithls.variable as !emithls.stream<i8>
    %var_stream_10 = emithls.variable as !emithls.stream<i8>
    %var_stream_11 = emithls.variable as !emithls.stream<i8>
    %var_stream_12 = emithls.variable as !emithls.stream<i8>
    %var_stream_3_3 = emithls.variable as !emithls.stream<i14>
    %var_stream_4_4 = emithls.variable as !emithls.stream<i14>
    %var_stream_13 = emithls.variable as !emithls.stream<i8>
    %var_stream_0_5 = emithls.variable as !emithls.stream<i6>
    %var_stream_1_6 = emithls.variable as !emithls.stream<i6>
    %var_stream_14 = emithls.variable as !emithls.stream<i8>
    %var_stream_15 = emithls.variable as !emithls.stream<i8>
    %var_stream_16 = emithls.variable as !emithls.stream<i8>
    %var_stream_17 = emithls.variable as !emithls.stream<i8>
    %var_stream_5_7 = emithls.variable as !emithls.stream<i14>
    %var_stream_6_8 = emithls.variable as !emithls.stream<i14>
    emithls.call @line_buffer(%var_stream_0_5, %var_stream_0_5, %var_stream_14, %var_stream_0) : (!emithls.stream<i6>, !emithls.stream<i6>, !emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @delay(%var_stream_0, %var_stream_1) : (!emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @delay(%var_stream_14, %var_stream_2) : (!emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @roberts_x(%var_stream_1, %var_stream_0, %var_stream_2, %var_stream_14, %var_stream_0_0) : (!emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i14>) -> ()
    emithls.call @roberts_y(%var_stream_1, %var_stream_0, %var_stream_2, %var_stream_14, %var_stream_1_1) : (!emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i14>) -> ()
    emithls.call @abs_sum(%var_stream_5_7, %var_stream_6_8, %var_stream_2_2) : (!emithls.stream<i14>, !emithls.stream<i14>, !emithls.stream<i14>) -> ()
    emithls.call @thr(%var_stream_2_2, %var_stream_3) : (!emithls.stream<i14>, !emithls.stream<i8>) -> ()
    emithls.call @remove_2x2(%var_stream_0_5, %var_stream_16, %var_stream_4) : (!emithls.stream<i6>, !emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @line_buffer(%var_stream_1_6, %var_stream_1_6, %var_stream_15, %var_stream_5) : (!emithls.stream<i6>, !emithls.stream<i6>, !emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @line_buffer(%var_stream_1_6, %var_stream_1_6, %var_stream_5, %var_stream_6) : (!emithls.stream<i6>, !emithls.stream<i6>, !emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @delay(%var_stream_6, %var_stream_7) : (!emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @delay(%var_stream_7, %var_stream_8) : (!emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @delay(%var_stream_5, %var_stream_9) : (!emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @delay(%var_stream_9, %var_stream_10) : (!emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @delay(%var_stream_15, %var_stream_11) : (!emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @delay(%var_stream_11, %var_stream_12) : (!emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @sobel_x(%var_stream_8, %var_stream_7, %var_stream_6, %var_stream_10, %var_stream_9, %var_stream_5, %var_stream_12, %var_stream_11, %var_stream_15, %var_stream_3_3) : (!emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i14>) -> ()
    emithls.call @sobel_y(%var_stream_8, %var_stream_7, %var_stream_6, %var_stream_10, %var_stream_9, %var_stream_5, %var_stream_12, %var_stream_11, %var_stream_15, %var_stream_4_4) : (!emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i14>) -> ()
    emithls.call @remove_3x3(%var_stream_1_6, %var_stream_17, %var_stream_13) : (!emithls.stream<i6>, !emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @Sbox1x2int6(%arg0, %var_stream_0_5, %var_stream_1_6) : (!emithls.stream<i6>, !emithls.stream<i6>, !emithls.stream<i6>) -> ()
    emithls.call @Sbox1x2int8(%arg1, %var_stream_14, %var_stream_15) : (!emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @Sbox1x2int8(%var_stream_3, %var_stream_16, %var_stream_17) : (!emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @Sbox2x1int8(%var_stream_4, %var_stream_13, %arg2) : (!emithls.stream<i8>, !emithls.stream<i8>, !emithls.stream<i8>) -> ()
    emithls.call @Sbox2x1int14(%var_stream_0_0, %var_stream_3_3, %var_stream_5_7) : (!emithls.stream<i14>, !emithls.stream<i14>, !emithls.stream<i14>) -> ()
    emithls.call @Sbox2x1int14(%var_stream_1_1, %var_stream_4_4, %var_stream_6_8) : (!emithls.stream<i14>, !emithls.stream<i14>, !emithls.stream<i14>) -> ()
  }
}

