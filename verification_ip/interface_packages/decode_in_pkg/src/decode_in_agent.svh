class decode_in_agent extends uvm_agent;

    // Child Components
    uvm_sequencer #(decode_in_seq_item)     sqr;
    decode_in_monitor                       monitor;
    decode_in_driver                        driver;
    decode_in_coverage                      coverage;

    // Analysis Port
    uvm_analysis_port #(decode_in_transaction) ap;

    // Config handle
    decode_in_configuration                 conf;

    // This agent's activity state
    uvm_active_passive_enum activity;

    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);

        //  Since youre overwriting the parent class' build phase function, make sure you call it here
        super.build_phase(phase);

        activity = conf.Activity;

        // Instantiate all the components of this agent  
        monitor = new("monitor",this);
        coverage = new("coverage",this);
        ap = new("ap",this);
        
        // Only instantiate sqr and driver if active
        if (activity == UVM_ACTIVE) begin 
            sqr = new("sqr",this);
            driver = new("driver",this);
        end
        

        // Not required since we do direct assignments in this project for efficiency
        // // Get the configuration handle
        // if (!(uvm_config_db #(decode_in_configuration)::get(this,"","conf_de_in_ag",conf))) begin 
        //     `uvm_fatal("Decode_in_Agent","Failed to get configuration handle!");
        // end

        // Pass the bfm handles to the components
        driver.bfm = conf.driver_bfm_hndl;
        monitor.bfm = conf.monitor_bfm_hndl;

        // Pass the sequencer handle to the config
        conf.set_sqr(sqr);


    endfunction
    
    
    virtual function void connect_phase (uvm_phase phase);        
        
        // Connect Sequencer and Driver's port export (s) if ACTIVE
        if (activity == UVM_ACTIVE) begin 
            driver.seq_item_port.connect(sqr.seq_item_export);
        end
        // Connect Monitor and Coverage
        monitor.ap.connect(coverage.analysis_export);

        // Connect agent ap to monitor ap
        monitor.ap.connect(this.ap);

    endfunction

   
endclass