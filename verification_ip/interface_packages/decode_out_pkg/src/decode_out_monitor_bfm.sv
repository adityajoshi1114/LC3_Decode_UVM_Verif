interface decode_out_monitor_bfm(decode_out_if sig_bndl);

    // Internal signals for ease of monitoring
    wire            clock_i;
    wire [5:0]      e_cntrl_i;
    wire            m_cntrl_i;
    wire [1:0]      w_cntrl_i;
    wire [15:0]     Instr_Reg_i;
    wire [15:0]     npc_out_i;
    wire            en_de_i;

    // Flags
    bit stop;


    // Assign the bus values to the internal signals
    assign clock_i      =   sig_bndl.clock_s;
    assign e_cntrl_i    =   sig_bndl.e_cntrl_s;
    assign m_cntrl_i    =   sig_bndl.m_cntrl_s;
    assign w_cntrl_i    =   sig_bndl.w_cntrl_s;
    assign Instr_Reg_i  =   sig_bndl.Instr_Reg_s;
    assign npc_out_i    =   sig_bndl.npc_out_s;
    assign en_de_i      =   sig_bndl.en_de_s;

    // Monitoring 
    task monitor (output bit [5:0] e_cntrl, output bit m_cntrl, output bit [1:0] w_cntrl, output bit [15:0] Instr_Reg, output bit [15:0] npc_out, output time start_t, output time end_t);

        
        // Only for valid transactions
        if (!en_de_i) begin 

            @(posedge en_de_i);
            @(posedge clock_i);

        end else begin 

            // Start time    
            start_t =$time;

            // Capture values at the neg edge
            @(negedge clock_i);
            e_cntrl     = e_cntrl_i;
            m_cntrl     = m_cntrl_i;
            w_cntrl     = w_cntrl_i;
            Instr_Reg   = Instr_Reg_i;
            npc_out     = npc_out_i;

            // Skip to the start of the next transaction
            @(posedge clock_i);
            
            // End time
            end_t = $time;

        end

        
    endtask

    initial begin : wait_for_end

        @(posedge en_de_i);
        @(negedge en_de_i);
        stop = 1;
       
    end

    



endinterface