package decode_in_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Include all the classes
    `include "src/decode_in_transaction.svh"
    `include "src/decode_in_seq_item.svh"
    `include "src/decode_in_driver.svh"
    `include "src/decode_in_monitor.svh"    
    `include "src/decode_in_coverage.svh"
    `include "src/decode_in_configuration.svh"
    `include "src/decode_in_agent.svh"
    
endpackage