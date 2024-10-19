class decode_out_transaction extends uvm_transaction;

    // Variables
    bit [5:0]   E_ctrl;
    bit [1:0]   W_ctrl;
    bit         M_ctrl;
    bit [15:0]  ir;
    bit [15:0]  npc_out;
    time start_time, end_time;
    int transaction_view_h;

    function new (string name = "");
        super.new(name);
    endfunction

    virtual function string convert2string();
        return $sformatf("E_ctrl : %x, W_ctrl : %x, M_ctrl : %x, IR : %x, npc_out : %x",E_ctrl, W_ctrl, M_ctrl, ir, npc_out);
    endfunction

    virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        decode_out_transaction RHS;
        if (!$cast(RHS,rhs)) return 0;
        return (
                super.do_compare(rhs,comparer)
                &&(this.E_ctrl  == RHS.E_ctrl)
                &&(this.W_ctrl  == RHS.W_ctrl)
                &&(this.M_ctrl  == RHS.M_ctrl)
                &&(this.ir      == RHS.ir)
                &&(this.npc_out == RHS.npc_out)
                );
    endfunction

    virtual function void wave_view(int transaction_viewing_stream_h);
       transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"decode_out_transaction",start_time);
       $add_attribute(transaction_view_h,E_ctrl,"E_ctrl");
       $add_attribute(transaction_view_h,W_ctrl,"W_ctrl");
       $add_attribute(transaction_view_h,M_ctrl,"M_ctrl");
       $add_attribute(transaction_view_h,ir,"ir");
       $add_attribute(transaction_view_h,npc_out,"npc_out");
       $end_transaction(transaction_view_h,end_time);
       $free_transaction(transaction_view_h);
    endfunction



endclass