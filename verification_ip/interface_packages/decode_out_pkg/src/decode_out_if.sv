interface decode_out_if
(
    input wire clock_s,
    input wire [5:0]    e_cntrl_s,
    input wire          m_cntrl_s,
    input wire [1:0]    w_cntrl_s,
    input wire [15:0]   Instr_Reg_s,
    input wire [15:0]   npc_out_s,
    input wire          en_de_s
);

    // Modports
    modport monitor_port
    (
        input clock_s,
        input e_cntrl_s,
        input m_cntrl_s,
        input w_cntrl_s,
        input Instr_Reg_s,
        input npc_out_s,
        input en_de_s
        
    );



endinterface