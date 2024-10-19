class decode_predictor extends uvm_subscriber #(.T(decode_in_transaction));

    // Required variables
    decode_out_transaction prediction;
    uvm_analysis_port #(decode_out_transaction) ap;
    bit [3:0] opcode;

    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void write (T t);

        `uvm_info("Decode_Predictor","Transaction receieved",UVM_HIGH);
        //$display("Transaction received by Predictor : %s",t.convert2string());

        // Make a prediction
        prediction = new("prediction");
        decode_model(t.instruction, t.next_pc, prediction.ir, prediction.npc_out, prediction.E_ctrl, prediction.W_ctrl, prediction.M_ctrl);

        // Broadcast it to the scoreboard
        `uvm_info("Decode_Predictor",$sformatf("Broadcasting Predicted Transaction : %s",prediction.convert2string()),UVM_MEDIUM);
        ap.write(prediction);

    endfunction

    virtual function void build_phase (uvm_phase phase);
        ap = new("ap",this);
    endfunction


endclass