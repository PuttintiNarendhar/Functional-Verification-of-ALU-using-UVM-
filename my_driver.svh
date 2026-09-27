class my_driver extends uvm_driver#(my_transaction); // inheritance and parameterized class
  `uvm_component_utils(my_driver) // uvm macro for including all utilites and register my_driver with the factory and uvm_component is static(we cannot use any instance out of this class)
  
  //declare the interface
  virtual dut_if.TESTPORT dut_vif;
  
  
  //constructor
  function new(string name, uvm_component parent); // function doesnot consumes the simulation time
    super.new(name, parent); // parent object creation or to create the instance from the base class
  endfunction
  
  function void build_phase(uvm_phase phase);
    //get interface reference from config database
    if(!uvm_config_db#(virtual dut_if.TESTPORT)::get(this, "", "dut_vif", dut_vif))begin
      `uvm_error("", "uvm_config_db::get failed")
    end
  endfunction
  
  
  task run_phase(uvm_phase phase); //task uses the clock or consumes simulation time
    //first wiggle reset
    dut_vif.reset = 1;
    @(posedge dut_vif.clock);
    @(posedge dut_vif.clock);
    @(posedge dut_vif.clock);
    
    #1;
    dut_vif.reset = 0;
    @(posedge dut_vif.clock);
    @(posedge dut_vif.clock);
    
    //TODO: drive the other interfacing signals
    //cmd, in1 and in2
    
    forever begin
      seq_item_port.get_next_item(req); //INITIATING THE PORT and calling the dynamic object
      
      //wiggle pins of DUT
      
      @(posedge dut_vif.clock);
      dut_vif.in1 <= req.in1;
      dut_vif.in2 <= req.in2;
      dut_vif.cmd <= req.op;
      
      seq_item_port.item_done();
      
    end
    
  endtask
      
endclass : my_driver;