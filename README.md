# Functional Verification of a 32-bit ALU Using UVM

This repository contains a complete Universal Verification Methodology (UVM) environment designed to thoroughly verify the functional correctness of a parameterized *32-bit Arithmetic Logic Unit (ALU)*.

The verification environment leverages specialized sequences, a behavioral reference predictor, and an automated comparator to fully check the datapath, edge-case arithmetic boundaries, and bitwise combinations.

---

## 🏗️ UVM Testbench Hierarchy

The verification structure strictly adheres to standard UVM guidelines, segregating stimulus generation from checking mechanisms:

```text
uvm_top
 └── my_test
      └── my_env
           ├── my_agent
           │    ├── my_sequencer
           │    ├── my_driver (Drives dut_if via virtual interface)
           │    └── my_monitor
           ├── alu_pred (Behavioral reference model)
           ├── my_comparator (Automated transaction comparator)
           ├── my_coverage (Functional coverage monitor)
           └── my_scoreboard (Evaluates pass/fail metrics)
```

### Component Breakdown
* *Top-Level (testbench.sv)*: Instantiates the Device Under Test (DUT), binds the physical verification interfaces (dut_if), and executes run_test().
* *Predictor (alu_pred.svh)*: Implements a software-based golden reference model that duplicates the ALU execution logic to calculate expected outputs.
* *Comparator (my_comparator.svh)*: Performs real-time validation checks by comparing actual monitored interface results against the reference model's predicted metrics.
* *Driver (my_driver.svh)*: Coordinates with the sequencer to continuously drive synchronized inputs onto the bus using clean clocking block semantics.

---

## 🗺️ ALU Instruction Set Architecture (ISA)

The ALU supports a 4-bit operation control command bus (cmd [3:0]) decoding the following mathematical and bitwise operations:

| Opcode (cmd) | Operation | Description | Expression |
|:---|:---|:---|:---|
| *4'b0000* | *AND* | Bitwise Logical AND | result = in1 & in2 |
| *4'b0001* | *OR* | Bitwise Logical OR | result = in1 \| in2 |
| *4'b0010* | *ADD* | 32-bit Unsigned Addition | result = in1 + in2 |
| *4'b0011* | *SLL* | Shift Left Logical | result = in1 << in2 |
| *4'b0100* | *SUB* | 32-bit Unsigned Subtraction | result = in1 - in2 |
| *4'b0101* | *SRL* | Shift Right Logical | result = in1 >> in2 |
| *4'b0110* | *MUL* | 32-bit Unsigned Multiplication | result = in1 * in2 |
| *4'b0111* | *XOR* | Bitwise Logical Exclusive OR | result = in1 ^ in2 |
| *4'b1000* | *SLT* | Set Less Than (Conditional) | result = (in1 < in2) ? 1 : 0 |

---

## 📝 Verification Plan & Test Strategy

To achieve comprehensive coverage across all pipeline capabilities, the environment implements multiple sequence configurations:

* *Single-Function Focus (one_func_seq.svh)*: Targets individual operations in isolation to guarantee correct instruction routing.
* *Randomized Interleaving (many_func_virtual_seq.svh / any_func_seq.svh)*: Rapidly alternates random operational streams to unearth state leakage or pipelined path errors.
* *Consecutive Identical Ops (same_op_seq.svh)*: Sweeps consecutive variations of a single operation using extreme parameter bounds (e.g., maximum integer limits to trigger overflows).
* *Parallel Execution (parallel_seq.svh)*: Dispatches concurrent stimulus blocks to stretch interface validation.

---

## 📊 Functional Coverage Profiles (my_coverage.svh)

Verification progress is quantified explicitly inside SystemVerilog covergroups looking for targeted operational cross-matrices:
* *Command Distribution*: Validates that all 9 active opcode permutations (4'b0000 through 4'b1000) are thoroughly exercised.
* *Data Value Boundaries*: Tracks maximum limits (32'hFFFFFFFF), minimum limits (32'h0), and toggling bit masks (32'h55555555, 32'hAAAAAAAA) for both in1 and in2.
* *Command-to-Data Crosses*: Verifies that extreme value sets are applied to every individual mathematical instruction opcode.

---

## 💻 How to Run the Simulation

### Option 1: Terminal Build (Local Scripts)
To run using terminal tools like Riviera-PRO or Questa Sim:
bash
# Provide script permissions and run
chmod +x run.sh
./run.sh

Or initiate the native command script:
bash
vsim -c -do run.do


### Option 2: Cloud Simulation (EDA Playground)
1. Upload environment components directly into [EDA Playground](https://edaplayground.com).
2. Configure *Tools & Simulators* to an active simulator supporting full UVM libraries (e.g., Aldec Riviera-PRO or Siemens Questa).
3. Toggle the *UVM / OVM* checkbox selection active and click *Run*.
