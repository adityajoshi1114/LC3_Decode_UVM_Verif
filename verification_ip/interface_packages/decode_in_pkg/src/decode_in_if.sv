//==================== Signal bundle interface ====================//

interface decode_in_if
(
    input wire           clock_s,
    input wire           reset_s,
    input wire [15:0]    dout_s,
    input wire           enable_decode_s,
    input wire [15:0]    npc_in_s
    
);

    // Modports
    
    modport monitor_port    // For monitor bfm
    (
        input enable_decode_s,
        input dout_s,
        input npc_in_s,
        input clock_s,
        input reset_s
    );

    modport driver_port     // For driver bfm
    (
        output enable_decode_s,
        output dout_s,
        output npc_in_s,
        input  clock_s,
        input  reset_s

    );


endinterface

//=================================================================//