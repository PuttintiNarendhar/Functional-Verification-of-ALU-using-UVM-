class my_test extends uvm_test;
  `uvm_component_utils(my_test) //it is also a uvm component because this class have a static my_env which is a uvm component, eventhough my_sequence is dynamic.
  
  //my_sequence seq; //dynamic
  //same_op_seq seq;
  //any_func_seq seq;
  //uvm_do_seq seq;
  //parallel_seq seq;
  many_func_virtual_seq vseq;
  my_env env;   //static
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase); //only create uvm_component objects in build_phase
    env = my_env::type_id::create("env", this);
    
  endfunction
  
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    vseq = many_func_virtual_seq::type_id::create("many_func_virtual_seq");
    
    
    env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_FIFO); //default
    //env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_WEIGHTED);
    //env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_RANDOM);
    //env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_STRICT_RANDOM);
    //env.agent.sequencer.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
    
    
    //create dynamic object in run_phase
    vseq = many_func_virtual_seq::type_id::create("vseq");
    //connecting the virtual sequencers to the physical sequencer
    vseq.seqr1 = env.agent.sequencer;
    vseq.seqr2 = env.agent.sequencer;
    vseq.seqr3 = env.agent.sequencer;
    vseq.seqr4 = env.agent.sequencer;
    vseq.seqr5 = env.agent.sequencer;
    
    vseq.randomize();
    
    vseq.start(null);
    
    
    //seq.start(env.agent.sequencer);
    
    #20;// extra simulation time for the output
    
    phase.drop_objection(this);
    
  endtask
  
  
endclass : my_test