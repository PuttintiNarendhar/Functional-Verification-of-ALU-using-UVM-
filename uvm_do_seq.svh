class uvm_do_seq extends uvm_sequence#(my_transaction);
 //register to the factory
 //uvm_object
  `uvm_object_utils(uvm_do_seq) //register my_sequence with the factory and uvm_object is dynamic(we can use any instance out of this class)
  
  one_func_seq one_func;
  
  //constructor for uvm object
  function new(string name = "");
    super.new(name);// instance is name, therefore it is dynamic only one parameter 
  endfunction
  
  task body;
    
    `uvm_do(req);
    `uvm_do(req);
    `uvm_do(one_func);
    `uvm_do_with(req, {req.op == 7;});
    `uvm_do_with(req, {req.op == 5;});
    
    
  endtask : body
  
  
endclass : uvm_do_seq