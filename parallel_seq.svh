class parallel_seq extends uvm_sequence#(my_transaction);
 //register to the factory
 //uvm_object
  `uvm_object_utils(parallel_seq) //register my_sequence with the factory and uvm_object is dynamic(we can use any instance out of this class)
  
  one_func_seq one_func;
  any_func_seq any_func;
  
  //constructor for uvm object
  function new(string name = "");
    super.new(name);// instance is name, therefore it is dynamic only one parameter 
  endfunction
  
  virtual task body();
    
    fork
      
      `uvm_do(one_func);
   	  `uvm_do(any_func);
      
    join
    
  endtask : body
  
  
endclass : parallel_seq