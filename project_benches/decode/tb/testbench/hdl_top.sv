`timescale 1ns / 10ps
module hdl_top ();


    // Import packages
    import uvm_pkg::*;
    import decode_in_pkg::*;
    import decode_out_pkg::*;
    
    // Decode In signals
    bit             clk;
    bit             rst = 1;
    wire            en_de;
    wire [15:0]     instr;
    wire [15:0]     next_pc;

    // Decode Out signals
    bit [1:0]       w_cntrl;
    bit             m_cntrl;
    bit [5:0]       e_cntrl;
    bit [15:0]      Instr_Reg;
    bit [15:0]      next_pc_out;

    // Generate the clock
    initial begin 
        clk = 1'b1;
        forever begin 
            #5;
            clk = ~clk;
        end
    end

    // Generate the reset
    initial begin 
        #100;
        @(posedge clk);
        rst = ~rst;
    end
            
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // We wont be using the dut modport of the signal bundle because of 2 reasons :                             //
    // 1) The DUT module's portlist does not mention the interface, hence we need to provide individual signals //
    // 2) When multiple interfaces get involved - i/p and o/p, we wont be able to connect both to the DUT       //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////

    // Instantiate the signal bundle for input interface
    decode_in_if sig_bndl_in_if
    (
        .clock_s(clk),
        .reset_s(rst),
        .enable_decode_s(en_de),
        .dout_s(instr),
        .npc_in_s(next_pc)

    );
    
    
    // Instantiating the decode RTL
    Decode LC3_de
    (
        .clock(clk),
        .reset(rst),
        .enable_decode(en_de),
        .dout(instr),
        .npc_in(next_pc),
        .E_Control(e_cntrl),
        .Mem_Control(m_cntrl),
        .W_Control(w_cntrl),
        .IR(Instr_Reg),
        .npc_out(next_pc_out)

    );

    // Instantiate the signal bundle for output interface
    decode_out_if sig_bndl_out_if
    (
        .clock_s(clk),
        .e_cntrl_s(e_cntrl),
        .m_cntrl_s(m_cntrl),
        .w_cntrl_s(w_cntrl),
        .Instr_Reg_s(Instr_Reg),
        .npc_out_s(next_pc_out),
        .en_de_s(en_de)

    );

    // Decode In -> Instantiate the monitor and driver bfms and connect them with the signal bundle
    decode_in_monitor_bfm de_in_monitor_bfm    (.sig_bndl(sig_bndl_in_if.monitor_port)) ;
    decode_in_driver_bfm  de_in_driver_bfm     (.sig_bndl(sig_bndl_in_if.driver_port));

    // Decode Out -> Instantiate the monitor bfm and connect it with the signal bundle
    decode_out_monitor_bfm de_out_monitor_bfm  (.sig_bndl(sig_bndl_out_if.monitor_port));

    // Pass the bfm handles to the agent configuration
    initial begin :config_db_shenanigans

        // Decode In
        uvm_config_db#(virtual decode_in_monitor_bfm)::set(null,"de_in_config","de_im_bfm",de_in_monitor_bfm);
        uvm_config_db#(virtual decode_in_driver_bfm)::set(null,"de_in_config","de_id_bfm",de_in_driver_bfm);     

        // Decode Out
        uvm_config_db#(virtual decode_out_monitor_bfm)::set(null,"de_out_config","de_om_bfm",de_out_monitor_bfm);

    end

    


endmodule