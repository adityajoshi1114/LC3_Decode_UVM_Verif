class decode_predictor extends uvm_subscriber #(.T(decode_in_transaction));

    // Required variables
    decode_out_transaction prediction;
    uvm_analysis_port #(decode_out_transaction) ap;


    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void write (T t);

        // Make a prediction
        decode_model(t.instruction, t.next_pc, prediction.ir, prediction.npc_out, prediction.E_ctrl, prediction.W_ctrl, prediction.M_ctrl);

        // Broadcast it to the scoreboard
        ap.write(prediction);

    endfunction


endclass