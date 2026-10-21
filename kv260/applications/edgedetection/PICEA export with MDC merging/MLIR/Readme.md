# Examples

## Prerequisites

To enable neural network functionality, additional utilities must be installed.
In addition, to use this Python utility, a dedicated LLVM build is required.
The LLVM version must match the one used to build IREE, and it must include the custom extensions, which are provided in the [llvm-iree](https://gitlab.abinsula.com/myrtus/dpe/step3/llvm-iree) repository.
The same CMake flags can be used to build this llvm-iree, as described in [build_dfg.sh](../build_dfg.sh).

## **Conversion and Translation for the MDC Backend**

To generate a valid MDC project from MLIR, we provide a conversion pass pipeline: `--convert-to-mdc`. This pipeline transforms the input MLIR code into a set of files and directories compatible with the **Orcc Environment**. All generated files are organized within an `MDC/` directory, which includes the subdirectories `bin/`, `references/`, and `src/`.

For each MLIR file, the pipeline produces:

* **An XDF network** representing the dataflow graph.
* **Multiple CAL actor files**, each corresponding to a function or subroutine in the MLIR.
* **Two subdirectories under `src/`**:

  * `baseline/`: contains the `.xdf` file (network definition) and `.xdfdiag` (graphical metadata).
  * `custom/`: contains the generated CAL actor files for each function/operator.

The MLIR dialects supported by this pipeline include `arith`, `index`, `math`, `scf`, and `dfg`. Their operations are translated into equivalent CAL actors.

---

### **Usage Instructions**

Assuming your MLIR input file is named `roberts.mlir`, follow the steps below to generate and inspect the MDC project:

1. **Generate MDC files**

   ```bash
   dfg-opt roberts.mlir --prepare-for-mdc | dfg-translate --dfg-to-mdc --output-dir=/path/to/output
   ```

2. **Inspect the generated files**
   Navigate to the output directory:

   ```bash
   cd /path/to/output/MDC/
   ```

3. **Open the project in Orcc**
   Copy the entire `MDC/` folder into an Orcc project directory. You can then use the Orcc IDE to:

   * Visualize the graphical network (via `.xdf` and `.xdfdiag` files).
   * Inspect and simulate the generated CAL actors.

---

### **Example: Shorted Roberts Filter**

The following code snippet defines two simple SDF operators, `@line_buffer` and `@delay`, each of which performs basic arithmetic operations and emits an output. They are instantiated and interconnected in the top-level region.

```mlir
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

dfg.region @top inputs (%in_size:i6, %in_pel: i8) outputs(%out_pel: i8) {
	%0:2 = dfg.channel(1) : i8
    dfg.instantiate @line_buffer inputs(%in_size,%in_size,%in_pel) outputs(%0#0) : (i6,i6,i8) -> i8
    dfg.instantiate @delay inputs(%0#1) outputs(%out_pel) : (i8) -> i8
}
```
This structure enables a **modular and composable design** and can be **automatically translated into XDF networks and CAL actors** for deployment within the Orcc toolchain. The generated files include `roberts.xdf` and `roberts.xdfdiag` (stored in the `baseline/` directory and always named consistently), as well as `line_buffer.cal` and `delay.cal` (stored in the `custom/` directory, named after the operators defined in the MLIR).

In the Orcc environment, you can import:

* [HDL components Libraries](https://github.com/mcheshfar/AXI-based-driver-applications/tree/main/kv260/applications/edgedetection/MDC_MLIR/vivado/src_hdl),
* [MDC files](https://github.com/mcheshfar/AXI-based-driver-applications/tree/main/kv260/applications/edgedetection/MDC_MLIR/MDC),
* and the [Vivado protocol file](https://github.com/mcheshfar/AXI-based-driver-applications/tree/main/kv260/applications/edgedetection/protocols).