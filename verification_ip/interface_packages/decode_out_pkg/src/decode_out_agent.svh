class decode_out_agent extends uvm_agent;

    // Child Component
    decode_out_monitor          monitor;

    // Config Handle
    decode_out_configuration    conf;   // Handle assigned directly by the environment

    // Analysis Port
    uvm_analysis_port #(decode_out_transaction) ap;

    // This agent's activity state
    bit activity;

    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);

        super.build_phase();

        activity = conf.Activity;

        // Instantiate the components of this agent
        monitor = new("monitor",this);
        ap = new();

        // Not required since we do direct assignments in this project for efficiency
        // Do a get call for the corresponding config 
        // if (!(uvm_config_db #(decode_out_configuration)::get(this,"","conf_de_out_ag",conf))) begin 
        //     `uvm_fatal("Decode_out_Agent","Failed to get configuration handle!");
        // end
        
        // Pass the monitor bfm handle to the monitor
        monitor.bfm = conf.monitor_bfm_handle;

    endfunction

    virtual function void connect_phase(uvm_phase phase);

        // Connect Agent ap to monitor ap
        ap.connect(monitor.ap);
        
    endfunction



endclass