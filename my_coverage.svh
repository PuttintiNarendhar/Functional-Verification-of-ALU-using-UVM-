class my_coverage extends uvm_subscriber#(my_transaction);
  `uvm_component_utils(my_coverage)
  
  my_transaction transaction;
  real cov;
  
  covergroup alu_cg;
    
    option.per_instance = 1;
    option.auto_bin_max = 9;
    
    in1_value: coverpoint transaction.in1 {
      
      bins zero = {0};
      bins max_pos = {32'h7FFFFFFF};
      bins most_neg = {32'h80000000};
      bins middle_pos = {32'h0000000F};
      bins middle_neg = {32'h8000000F};
      
    }
    
    in2_value: coverpoint transaction.in2 {
      
      bins zero = {0};
      bins max_pos = {32'h7FFFFFFF};
      bins most_neg = {32'h80000000};
      bins middle_pos = {32'h0000000F};
      bins middle_neg = {32'h8000000F};
      
    }
   
    op_code: coverpoint transaction.op{
      
      
      bins bin_AND = {B_AND};
      bins bin_OR = {B_OR};
      bins bin_ADD = {ADD};
      bins bin_SUB = {SUB};
      bins bin_LT = {S_LT};
      bins bin_LSL = {LSL};
      bins bin_LSR = {LSR};
      bins bin_MUL = {MUL};
      bins bin_XOR = {B_XOR};
    }
    
    cross op_code, in1_value{
      ignore_bins op_code_zero_in1 = binsof(op_code) intersect {0};
      //ignore_bins op_code_middle_in1 = binsof(op_code) intersect {2};
    }
    
    cross op_code, in2_value{
      //ignore_bins op_code_zero_in2 = binsof(op_code) intersect {0};
      ignore_bins op_code_middle_in2 = binsof(op_code) intersect {2};
    }
   
    cross in2_value, in1_value{
      ignore_bins in2_value_middle_in1 = binsof(in2_value) intersect {32'h0000000F};
    }
    
    cross in1_value, in2_value{
      ignore_bins in1_value_mid_in2 = binsof(in1_value) intersect {32'h0000000A};
    }
    
  endgroup
  
  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent); 
    alu_cg = new();
    
  endfunction
  
  virtual function void write(my_transaction t);
    transaction = t;
    alu_cg.sample();
    
  endfunction
  
  function void extract_phase(uvm_phase phase);
    cov = alu_cg.get_coverage();
    
  endfunction
  
  function void report_phase(uvm_phase phase);
    
    `uvm_info(get_full_name(), $sformatf("Coverage is %d%%", cov), UVM_NONE)
    
  endfunction
  
  
  
endclass : my_coverage