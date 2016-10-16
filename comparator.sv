`define N_TRANS ($system($sformatf("ls trans -1 | wc -l")))

class comparator #(type T = packet_in) extends uvm_scoreboard;
   typedef comparator #(T) this_type;
   `uvm_component_utils(this_type)
    
    uvm_tlm_fifo #(T) from_refmod;
    uvm_tlm_fifo#(T) from_refmod_low;    
    
     T tr1, tr2;
     int match, mismatch;
     const int num_trans =`N_TRANS;

     event end_of_simulation;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        from_refmod = new("from_refmod", null, 1); 
        from_refmod_low = new("from_refmod_low", null, 1);
        tr1 = new("tr1");
        tr2 = new("tr2");
    endfunction
     
    function void connect_phase(uvm_phase phase);
        uvmc_tlm1 #(T)::connect(from_refmod.put_export, "refmod_i.out");
        uvmc_tlm1#(T)::connect(from_refmod_low.put_export, "refmod_low_i.out");
    endfunction: connect_phase
   
    task run();
      $display("number of transactions: %d", num_trans);
      forever begin
        from_refmod.get(tr1);
        from_refmod_low.get(tr2);
        compare();
      end
    endtask: run

    virtual function void compare();
      $display("Entered compare: %s %s %d", tr1.message, tr2.message, num_trans);
      if(tr1.message == tr2.message) begin
        $display("Comparator MATCH");
        match++;
      end
      else begin
        $display("Comparator MISMATCH");
        mismatch++;
      end
      $display("trans %d",num_trans);
      if(match+mismatch > 10) 
        $finish();   
    endfunction: compare
   
endclass: comparator
