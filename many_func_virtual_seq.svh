class many_func_virtual_seq extends uvm_sequence;
 //register to the factory
 //uvm_object
  `uvm_object_utils(many_func_virtual_seq) //register my_sequence with the factory and uvm_object is dynamic(we can use any instance out of this class)
  
  one_func_seq one_func;
  any_func_seq any_func;
  same_op_seq same_op;
  same_op_sequence same_op2;
  one_func_sequence one_func2;
  
  my_sequencer seqr1;
  my_sequencer seqr2;
  my_sequencer seqr3;
  my_sequencer seqr4;
  my_sequencer seqr5;
  
  //constructor for uvm object
  function new(string name = "");
    super.new(name);// instance is name, therefore it is dynamic only one parameter 
  endfunction
  
  virtual task body();
	one_func = one_func_seq::type_id::create("one_func");
    any_func = any_func_seq::type_id::create("any_func");
    same_op = same_op_seq::type_id::create("same_op");
    same_op2 = same_op_sequence::type_id::create("same_op2");
    one_func2 = one_func_sequence::type_id::create("one_func2");
    
    fork
      one_func.start(seqr1, .this_priority(100));
      any_func.start(seqr2, .this_priority(100));
      same_op.start(seqr3, .this_priority(500));
      same_op2.start(seqr4, .this_priority(300));
      one_func2.start(seqr5, .this_priority(300));
      
    join
      
  endtask : body
  
  
endclass : many_func_virtual_seq