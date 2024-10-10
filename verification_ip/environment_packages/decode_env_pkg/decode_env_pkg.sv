package decode_env_pkg;

    import uvm_pkg::*;
    import lc3_prediction_pkg::*;
    import decode_in_pkg::*;
    import decode_out_pkg::*;
    `include "uvm_macros.svh"

    // Include all the env components
    `include "src/decode_predictor.svh"
    `include "src/decode_scoreboard.svh"
    `include "src/decode_env_configuration.svh"
    `include "src/decode_environment.svh"

endpackage