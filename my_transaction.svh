class my_transaction extends uvm_sequence_item;
  `uvm_object_utils(my_transaction) // register my_transaction with the factory and uvm_object is dynamic(we can use any instance out of this class)
  
  
  
  //properties
  rand logic [31:0] in1, in2;
  rand op_e op;
  logic [31:0] result;
  
  //constructor
  function new (string name = "");
    super.new(name);
  endfunction
  
  
endclass : my_transaction

  