class decode_in_coverage extends uvm_subscriber #(.T(decode_in_transaction));

    // Received transaction
    decode_in_transaction   mntr_trx;

    covergroup  decode_in_cg;
        trx_opcode : coverpoint mntr_trx.instruction[15:12]
        {
            ignore_bins inv_instr = {4,8,13,15};
        }
    endgroup
    
    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
        decode_in_cg = new();
    endfunction

    virtual function void write(T t);
        `uvm_info("Decode_in_Coverage","Transaction receieved",UVM_HIGH);
        mntr_trx = t;
        decode_in_cg.sample();
    endfunction

endclass