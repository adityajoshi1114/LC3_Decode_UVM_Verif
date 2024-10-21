class decode_out_configuration extends uvm_object;

    // Variables ~ Agent properties stored in the config
    virtual decode_out_monitor_bfm monitor_bfm_handle;
    uvm_active_passive_enum Activity;   // 0 for passive and 1 for active
    
    function new (string name = "");
        super.new(name);
    endfunction

    virtual function void initialize(uvm_active_passive_enum activity, string interface_names[2], string path_to_agent);
       
        Activity = activity;
        
        // Do a get call for the monitor bfm handle
        uvm_config_db#(virtual decode_out_monitor_bfm)::get(null,get_name(),interface_names[0],monitor_bfm_handle);

        // Not required since we do direct assignments in this project for efficiency
        // Passes itself to its agent
        uvm_config_db#(decode_out_configuration)::set(null,path_to_agent,"conf_de_out_ag",this);

    endfunction 


endclass