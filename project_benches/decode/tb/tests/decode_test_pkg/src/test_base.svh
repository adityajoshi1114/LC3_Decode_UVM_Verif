class test_base extends uvm_test;

    `include "uvm_macros.svh"

    // Register the test with the factory
    `uvm_component_utils(test_base)

    // Test components
    decode_environment          de_env;
    decode_env_configuration    de_env_config;
    decode_in_random_sequence   de_in_se;
    
    // Config Initialize variables
    string interface_names [4];
    bit [1:0] Activity_flags;
    bit [2:0] scbd_flags;

    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        
        // Config Heirarchy
        // Build 
        de_env_config   =   new("de_env_config");
        // Initialize
        interface_names[0]  = "de_im_bfm";
        interface_names[1]  = "de_id_bfm";
        interface_names[2]  = "de_om_bfm";
        interface_names[3]  = "null";
        Activity_flags      = 2'b01;
        scbd_flags          = 3'b111;
        de_env_config.initialize(Activity_flags,interface_names,scbd_flags);

        // Component Heirarchy
        de_env      = new("de_env",this);
        de_in_se    = new("de_in_se");

        // Assign config handles 
        de_env.conf = de_env_config;

    endfunction

    virtual task run_phase (uvm_phase phase);

        // Run the test
        phase.raise_objection(this,"Objection raised by test_base");
        repeat (50) begin 
            de_in_se.start(de_env.agent_in.sqr);
        end
        phase.drop_objection(this,"Objection dropped by test_base");

    endtask

endclass