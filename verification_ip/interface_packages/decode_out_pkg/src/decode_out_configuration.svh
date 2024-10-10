class decode_out_configuration extends uvm_object;

    // Variables ~ Agent properties stored in the config
    virtual decode_out_monitor_bfm vbfm;
    bit Activity;   // 0 for passive and 1 for active
    
    function new (string name = "");
        super.new(name);
    endfunction

    virtual function void initialize(bit activity, string interface_name, strng path_to_agent);
       
        Activity = activity;
        
        // Do a get call for the monitor bfm handle
        uvm_config_db#(virtual decode_out_monitor_bfm)::get(null,get_name(),interface_name,vbfm);

        // Do a set call to for the config to pass itself to the agent
        uvm_config_db#(decode_out_configuration)::set(null,path_to_agent,"conf_de_out_ag",this);

    endfunction 


endclass