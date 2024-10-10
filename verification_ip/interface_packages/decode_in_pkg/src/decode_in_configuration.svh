class decode_in_configuration extends uvm_object;

    // BFM Handles
    virtual decode_in_driver_bfm driver_bfm_hndl;
    virtual decode_in_monitor_bfm monitor_bfm_hndl;

    // Activity - 0 for passive and 1 for active
    bit Activity;

    // Sequencer for decode_in_agent
    uvm_sequencer #(decode_in_seq_item) sqr;

    
    function new (string name = "");
        super.new(name);
    endfunction

    // For test to store the sequencer handle
    function void set_sqr (uvm_sequencer #(decode_in_seq_item) agent_sqr);
        sqr = agent_sqr;
    endfunction

    // Convert to string function
    virtual function string convert2string();
        return {super.convert2string};
    endfunction

    // Initialize Function
    virtual function void initialize(bit activity, string interface_names[2], string path_to_agent);

        Activity = activity;

        // Get the BFM handles via the config db
        if (!(uvm_config_db#(virtual decode_in_monitor_bfm)::get(null,get_name(),interface_names[0],monitor_bfm_hndl))) begin 
            `uvm_fatal("de_in_config","Failed to get monitor_bfm handle!")
        end
        if (!(uvm_config_db#(virtual decode_in_driver_bfm)::get(null,get_name(),interface_names[1],driver_bfm_hndl))) begin 
            `uvm_fatal("de_in_config","Failed to get driver_bfm handle!")
        end

        // Passes itself to its agent
        uvm_config_db#(decode_in_configuration)::set(null,path_to_agent,"conf_de_in_ag",this);

    endfunction

endclass