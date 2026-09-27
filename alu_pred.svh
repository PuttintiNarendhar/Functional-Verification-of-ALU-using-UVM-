function my_transaction my_predictor::alu_pred(my_transaction t);
  
  my_transaction pred_t;
  
  pred_t = my_transaction::type_id::create("pred_t");
  
  pred_t.in1 = t.in1;
  pred_t.in2 = t.in2;
  pred_t.op = t.op;
  
  
  case(t.op)
    B_AND: pred_t.result = t.in1 & t.in2;
    //B_AND: pred_t.result = t.in1 & t.in2 & 32'hBBBBBBBB;
    B_OR: pred_t.result = t.in1 | t.in2;
    //Test for a mismatched case
    //ADD: pred_t.result = t.in1 + t.in2 + 32'hAAAAAAAA;
    ADD: pred_t.result = t.in1 + t.in2;
    SUB: pred_t.result = t.in1 - t.in2;
    S_LT: pred_t.result = (t.in1 < t.in2) ? 32'h1: 32'h0;
    LSL: pred_t.result = t.in1 << t.in2;
    LSR: pred_t.result = t.in1 >> t.in2;
    MUL: pred_t.result = t.in1 * t.in2;
    //B_XOR: pred_t.result = t.in1 ^ t.in2 ^ 32'hFFFFFFFF;
    B_XOR: pred_t.result = t.in1 ^ t.in2;
  endcase
  
  return(pred_t);
endfunction