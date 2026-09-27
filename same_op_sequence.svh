class same_op_sequence extends uvm_sequence#(my_transaction);
 //register to the factory
 //uvm_object
  `uvm_object_utils(same_op_sequence) //register my_sequence with the factory and uvm_object is dynamic(we can use any instance out of this class)
  
  int num_repeat = 8;
  int max;
  
  
  //constructor for uvm object
  function new(string name = "");
    super.new(name);// instance is name, therefore it is dynamic only one parameter 
  endfunction
  
  task body;
    
    if(!uvm_config_db#(int)::exists(null, "", "num_repeat"))
      `uvm_error("SEQ", "Couldn't find num_repeat")
    
    
    uvm_config_db#(int)::get(null, "", "num_repeat", num_repeat);
    uvm_config_db#(int)::get(null, "", "max", max);
    
    
    repeat(num_repeat) begin
      
      req = my_transaction::type_id::create("req"); //instance creation or creating the transaction
      
      start_item(req); //to initiate the transfer and waiting for request from the driver
      
      
      if(! (req.randomize() with {req.in1 <= max; req.in2 <= max; req.op == B_AND;}))begin  //generate the randomized nnumber in1,in2
        `uvm_error("MY_SEQUENCE", "randomize() failed")
      end
      
      finish_item(req); //blocked until the transaction is processed
      
      
    end
    
    
  endtask : body
  
  
endclass : same_op_sequence