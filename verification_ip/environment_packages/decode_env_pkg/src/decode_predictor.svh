class decode_predictor extends uvm_subscriber #(.T(decode_in_transaction));

    // Required variables
    decode_out_transaction prediction;
    uvm_analysis_port #(decode_out_transaction) ap;
    bit [3:0] opcode;

    // Last E_control bit 
    bit e_ctrl_bit;


    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void write (T t);

        `uvm_info("Decode_Predictor","Transaction receieved",UVM_MEDIUM);
        //$display("Transaction received by Predictor : %s",t.convert2string());

        // Make a prediction
        prediction = new("prediction");
        decode_model(t.instruction, t.next_pc, prediction.ir, prediction.npc_out, prediction.E_ctrl, prediction.W_ctrl, prediction.M_ctrl);

        // If the instruction is a NOT - keep the last E_Ctrl bit same as previous -> because for some reason the design doesnt clear it out but clears it out for the opcodes?...
        opcode = t.instruction[15:12];
        if (opcode == 9) begin 
            prediction.E_ctrl[0] = e_ctrl_bit;
        end

        // Store e_ctrl bit
        e_ctrl_bit = prediction.E_ctrl[0];
        //$display("Decode Model O/P : %s",prediction.convert2string());
        // Broadcast it to the scoreboard
        ap.write(prediction);

    endfunction

    virtual function void build_phase (uvm_phase phase);
        ap = new("ap",this);
    endfunction


endclass