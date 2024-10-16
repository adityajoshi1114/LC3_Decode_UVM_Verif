class decode_out_configuration extends uvm_object;

    // Variables ~ Agent properties stored in the config
    virtual decode_out_monitor_bfm monitor_bfm_handle;
    bit Activity;   // 0 for passive and 1 for active
    
    function new (string name = "");
        super.new(name);
    endfunction

    virtual function void initialize(bit activity, string interface_names[2]);
       
        Activity = activity;
        
        // Do a get call for the monitor bfm handle
        uvm_config_db#(virtual decode_out_monitor_bfm)::get(null,get_name(),interface_names[0],monitor_bfm_handle);

    endfunction 


endclass