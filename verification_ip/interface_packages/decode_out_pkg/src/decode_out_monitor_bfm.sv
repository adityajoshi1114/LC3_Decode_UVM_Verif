interface decode_out_monitor_bfm(decode_out_if sig_bndl);

    // Internal signals for ease of monitoring
    wire            clock_i;
    wire [5:0]      e_cntrl_i;
    wire            m_cntrl_i;
    wire [1:0]      w_cntrl_i;
    wire [15:0]     Instr_Reg_i;
    wire [15:0]     npc_out_i;
    wire            en_de_i;

    // Assign the bus values to the internal signals
    assign clock_i      =   sig_bndl.clock_s;
    assign e_cntrl_i    =   sig_bndl.e_cntrl_s;
    assign m_cntrl_i    =   sig_bndl.m_cntrl_s;
    assign w_cntrl_i    =   sig_bndl.w_cntrl_s;
    assign Instr_Reg_i  =   sig_bndl.Instr_Reg_s;
    assign npc_out_i    =   sig_bndl.npc_out_s;
    assign en_de_i      =   sig_bndl.en_de_s;

    // Monitoring 
    task monitor (output e_cntrl, output m_cntrl, output w_cntrl, output Instr_Reg, output npc_out);

        // Every output is generated at the posedge
        @(posedge clock_i);

        // Only take valid outputs
        if (en_de_i) begin 
            e_cntrl     = e_cntrl_i;
            m_cntrl     = m_cntrl_i;
            w_cntrl     = w_cntrl_i;
            Instr_Reg   = Instr_Reg_i;
            npc_out     = npc_out_i;
        end
        
    endtask

    



endinterface