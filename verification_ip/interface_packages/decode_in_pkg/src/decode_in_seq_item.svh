class decode_in_seq_item extends uvm_sequence_item;

    // Variables for Decode 
    randc bit [3:0] opcode;
    rand bit [11:0]      instr_tail;     // Remaining instruction
    bit [15:0]      next_pc;


    function new (string name = "");
        super.new(name);
        // Initialize next_pc
        next_pc = 3000;
    endfunction

    // Constraint to keep the opcode valid while randomizing
    constraint valid_instr      {opcode inside {[0:3],[5:7],[9:12],14};}
    constraint not_instr_tail   {opcode == 5'b1001 -> instr_tail == 6'b111111;}

    virtual function string convert2string();
        return $sformatf("Instruction:0x%x npc:0x%x",{opcode,instr_tail},next_pc);
    endfunction


endclass