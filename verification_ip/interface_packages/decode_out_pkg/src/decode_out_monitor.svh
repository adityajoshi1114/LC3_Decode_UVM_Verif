class decode_out_monitor extends uvm_monitor;

    `uvm_component_utils(decode_out_monitor)

    // Required variables
    virtual decode_out_monitor_bfm  bfm;     // Virtual BFM handle
    decode_out_transaction          monitored_trx;

    // Analysis Port
    uvm_analysis_port #(decode_out_transaction) ap;

    function new(string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        ap = new("ap",this);
        monitored_trx = new("monitored_trx");
    endfunction

    virtual task run_phase (uvm_phase phase);

        // Monitor till the end of simulation
        forever begin 
            
            // Call the monitor task 
            bfm.monitor(monitored_trx.E_ctrl, monitored_trx.M_ctrl, monitored_trx.W_ctrl, monitored_trx.ir, monitored_trx.npc_out);

            // Broadcasting
            
            if ((monitored_trx.npc_out != 0) && (bfm.stop == 0) ) begin 
                `uvm_info ("Monitor_Out",{"Broadcasting:",monitored_trx.convert2string()},UVM_MEDIUM)
                ap.write(monitored_trx);        // Send to the Agent
            end
        end
        
    endtask


endclass