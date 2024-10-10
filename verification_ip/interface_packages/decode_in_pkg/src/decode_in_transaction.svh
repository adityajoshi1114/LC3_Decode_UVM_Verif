class decode_in_transaction extends uvm_transaction;

    // Variables 
    time start_time, end_time;
    int transaction_view_h;
    bit [15:0] instruction, next_pc;

    function new (string name = "");
        super.new(name);
    endfunction

    virtual function string convert2string();
        return $sformatf("Instruction:0x%x npc:0x%x",instruction,next_pc);
    endfunction

    virtual function void wave_view(int transaction_viewing_stream_h);
       transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"decode_in_transaction",start_time);
       $add_attribute(transaction_view_h,instruction,"instruction");
       $add_attribute(transaction_view_h,next_pc,"npc");
       $end_transaction(transaction_view_h,end_time);
       $free_transaction(transaction_view_h);
    endfunction

endclass
