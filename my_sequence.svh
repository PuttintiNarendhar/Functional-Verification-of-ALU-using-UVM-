class my_sequence extends uvm_sequence#(my_transaction);
 //register to the factory
 //uvm_object
  `uvm_object_utils(my_sequence) //register my_sequence with the factory and uvm_object is dynamic(we can use any instance out of this class)
  
  //constructor for uvm object
  function new(string name = "");
    super.new(name);// instance is name, therefore it is dynamic only one parameter 
  endfunction
  
  task body;
    repeat(16) begin
      
      req = my_transaction::type_id::create("req"); //instance creation or creating the transaction
      
      start_item(req); //to initiate the transfer and waiting for request from the driver
      
      
      if(!req.randomize())begin  //generate the randomized number in1,in2 and cmd
        `uvm_error("MY_SEQUENCE", "randomize() failed")
      end
      
      finish_item(req); //blocked until the transaction is processed
      
      
    end
    
    
  endtask : body
  
  
endclass : my_sequence