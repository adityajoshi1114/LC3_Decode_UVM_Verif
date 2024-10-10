class test_base extends uvm_test;

    `include "uvm_macros.svh"

    // Register the test with the factory
    `uvm_component_utils(test_base)

    // Test components
    decode_in_agent             de_in_agent;
    decode_in_configuration     de_in_config;
    decode_in_random_sequence   de_in_se;

    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        de_in_config    =   new("de_in_config");
        de_in_agent     =   new("de_in_agent",this);
        de_in_se        =   new("de_in_se");
    endfunction

    virtual task run_phase (uvm_phase phase);
        
        // Store Sequencer handle in the config
        de_in_config.set_sqr(de_in_agent.sqr);

        // Run the test
        phase.raise_objection(this,"Objection raised by test_base");
        repeat (50) begin 
            de_in_se.start(de_in_config.sqr);
        end
        phase.drop_objection(this,"Objection dropped by test_base");

    endtask

endclass