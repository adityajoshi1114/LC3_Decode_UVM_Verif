`timescale 1ns / 10ps
interface decode_in_driver_bfm (decode_in_if sig_bndl);

    // Internal driver variables
    logic [15:0]    dout_int ;
    bit             enable_decode_int ;
    logic [15:0]    npc_in_int;
    
    // Connect
    assign sig_bndl.dout_s                  = dout_int ;
    assign sig_bndl.enable_decode_s         = enable_decode_int ;
    assign sig_bndl.npc_in_s                = npc_in_int;


    // Write the task to drive 
    task drive (input bit [15:0] instruction, input bit [15:0] next_pc ); 

        // Start driving signals if the reset is done
        fork
            begin 
                wait(!sig_bndl.reset_s) ;
            end
            begin 
                #200ns;
                $fatal("Driver BFM:Timeout reached waiting for reset signal!!");
            end
        join_any
        disable fork;

        //Drive the signals on the next posedge
        @(posedge sig_bndl.clock_s);

        // Enable if not done already 
        if (enable_decode_int != 1) begin       
            enable_decode_int <= 1;     // NBA to avoid race condition
        end

        // Drive
        dout_int     <= instruction;
        npc_in_int   <= next_pc ;


    endtask


endinterface