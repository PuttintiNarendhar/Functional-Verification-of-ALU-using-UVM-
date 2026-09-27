class one_func_sequence extends any_func_seq;
 //register to the factory
 //uvm_object
  `uvm_object_utils(one_func_sequence) //register my_sequence with the factory and uvm_object is dynamic(we can use any instance out of this class)
  
  int num_repeat = 8;
  int max;
  
  
  //constructor for uvm object
  function new(string name = "one_func_seq");
    super.new(name);// instance is name, therefore it is dynamic only one parameter 
  endfunction
  
  task body;
    
    my_transaction req_starter;
    op_e one_op;
    req_starter = my_transaction::type_id::create("req_starter");
    req_starter.randomize() with {req_starter.op inside {5, 6, 8};};
    one_op = req_starter.op;
    
    if(!uvm_config_db#(int)::exists(null, "", "num_repeat"))
      `uvm_error("SEQ", "Couldn't find num_repeat")
    
    
    uvm_config_db#(int)::get(null, "", "num_repeat", num_repeat);
    uvm_config_db#(int)::get(null, "", "max", max);
    
    
    repeat(num_repeat) begin
      
      req = my_transaction::type_id::create("req"); //instance creation or creating the transaction
      
      start_item(req); //to initiate the transfer and waiting for request from the driver
      
      
      if(! (req.randomize() with {req.op == one_op;}))begin  //generate the randomized nnumber in1,in2
        `uvm_error("MY_SEQUENCE", "randomize() failed")
      end
      
      finish_item(req); //blocked until the transaction is processed
      
      
    end
    
    
  endtask : body
  
  
endclass : one_func_sequence