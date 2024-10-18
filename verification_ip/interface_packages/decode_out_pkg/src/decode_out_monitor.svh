class decode_out_monitor extends uvm_monitor;

    `uvm_component_utils(decode_out_monitor)

    // For transaction viewing 
    int transaction_viewing_stream_h;
    
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

    virtual function void start_of_simulation_phase (uvm_phase phase);
        super.start_of_simulation_phase(phase);
        transaction_viewing_stream_h = $create_transaction_stream({"..",get_full_name(),".","txn_stream"},"TVM");
    endfunction


    virtual task run_phase (uvm_phase phase);

        // Monitor till the end of simulation
        forever begin 
            
            // Call the monitor task 
            bfm.monitor(monitored_trx.E_ctrl, monitored_trx.M_ctrl, monitored_trx.W_ctrl, monitored_trx.ir, monitored_trx.npc_out, monitored_trx.start_time, monitored_trx.end_time);

            // Broadcasting and Transaction Viewing
            if ((monitored_trx.npc_out != 0) && (bfm.stop == 0) ) begin 
                monitored_trx.wave_view(transaction_viewing_stream_h);
                `uvm_info ("Monitor_Out",{"Broadcasting:",monitored_trx.convert2string()},UVM_MEDIUM)
                ap.write(monitored_trx);        // Send to the Agent
            end
        end
        
    endtask


endclass