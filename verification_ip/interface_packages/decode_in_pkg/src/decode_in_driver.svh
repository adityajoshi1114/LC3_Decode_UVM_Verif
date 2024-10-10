
/////////////////////////////////////////////////////////////////////////////
// When you extend your agent from uvm agent and your driver and sequencer // 
// from the respective uvm classes - it automatically creates the          //
// seq_item_port and seq_item_export                                       //
/////////////////////////////////////////////////////////////////////////////

class decode_in_driver extends uvm_driver #(.REQ(decode_in_seq_item), .RSP(decode_in_seq_item));

    // Required variables
    virtual decode_in_driver_bfm    bfm;
    decode_in_seq_item  seq_item;
    
    function new (string name  = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual task run_phase (uvm_phase phase);
        forever begin 
            `uvm_info("Driver","Requesting a transaction from the Sequencer",UVM_MEDIUM);
            seq_item_port.get_next_item(seq_item);

            // Extract the variables from this transaction and drive them using the bfm
            bfm.drive({seq_item.opcode,seq_item.instr_tail},seq_item.next_pc);
            `uvm_info ("Driver",{"Driven:",seq_item.convert2string()},UVM_MEDIUM)

            // Signal the sequencer to arbitrate amongst the next seq items
            seq_item_port.item_done(seq_item);
        end
    endtask



endclass