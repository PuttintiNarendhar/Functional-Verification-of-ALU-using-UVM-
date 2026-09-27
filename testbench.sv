// Code your testbench here
// or browse Examples

`include "uvm_macros.svh"
`include "my_testbench_pkg.svh"


module top;
  import uvm_pkg::*;
  import my_testbench_pkg::*;
  
  bit clock;
  
  //Instantiate the interface
  dut_if dut_if1(clock);
  my_test test;
  
  //Instantiate the DUT and connect it to the interface
  dut dut1(.clock(dut_if1.clock), .reset(dut_if1.reset), .in1(dut_if1.in1), .in2(dut_if1.in2), .cmd(dut_if1.cmd), .result(dut_if1.result));
  
  //Generate the clock
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end
  
  initial begin
    //place interface into the UVM configuration database
    uvm_config_db#(virtual dut_if.TESTPORT)::set(null, "*" , "dut_vif" , dut_if1);
    uvm_config_db#(virtual dut_if.MONITORPORT)::set(null, "*" , "dut_vif_m" , dut_if1);
    
    uvm_config_db#(int)::set(null, "*", "num_repeat", 20); //it is a uvm object which is dynamic, then there is no static path so put "*"
    uvm_config_db#(int)::set(null, "*", "max", 15);
    
    
    //start the test
    
    test = my_test::type_id::create("test", null); //explicitly instantiate the test from factory to start the test 
    
    run_test();
    
  end
  
  initial begin
    `uvm_info("TESTTOP","my UVM testbench!", UVM_NONE); //printing the message similar to $display
  end
  
  //Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end
  
  
endmodule