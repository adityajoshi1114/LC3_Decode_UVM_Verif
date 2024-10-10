interface decode_in_monitor_bfm (decode_in_if sig_bndl);

    
    // // Connect these to the interface signals
    // assign clock_int           = sig_bndl.clock_s;
    // assign dout_int             = sig_bndl.dout_s ;
    // assign enable_decode_int    = sig_bndl.enable_decode_s ;
    // assign npc_in_int           = sig_bndl.npc_in_s ;

    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // The reason for not using the above code is because we wish to use this in the driver                              //
    // Signal bundle interface has its signals defined as net types to avoid driver contention in the future             //
    // when its used for SOC level connections. Meanwhile, unless we do a cont. assign of the SBI signals' values to     //
    // the driver's variables, we cannot drive any signals inside the tasks because a wire cannot be driven inside a task//
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    task monitor (output time start_t, output time end_t, output bit [15:0] instr, output bit [15:0] nxt_pc);

        // Each monitoring call will last one clock cycle since there is no protocol
        // Hence the start time will be as soon as any change is observed on the bus
        fork
            begin 
                @(sig_bndl.dout_s);
            end
            begin 
                @(sig_bndl.npc_in_s);
            end
        join_any
        disable fork;
        start_t = $time;

        // Store the trx variables
        instr  = sig_bndl.dout_s;
        nxt_pc = sig_bndl.npc_in_s;

        // Store the end time for the transaction
        @(posedge sig_bndl.clock_s);
        end_t = $time;

    endtask



endinterface