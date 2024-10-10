class decode_out_transaction extends uvm_transaction;

    // Variables
    bit [5:0]   E_ctrl;
    bit [1:0]   W_ctrl;
    bit         M_ctrl;
    bit [15:0]  ir,
    bit [15:0]  npc_out;

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
                &&(this.ncp_out == RHS.ncp_out)
                );
    endfunction


endclass