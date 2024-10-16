class decode_scoreboard #(type T = decode_out_transaction) extends uvm_component;
    
    // Required Variables
    T expected_results [$];
    event got_trx;      // For when an actual transaction is receieved
    uvm_comparer comp;
    string report_string;

    // Count variables
    int match_cnt, mismatch_cnt, trx_cnt;    

    // Analysis Exports
    `uvm_analysis_imp_decl(_actual)
    uvm_analysis_imp_actual #(T, decode_scoreboard #(T)) analysis_export_actual;
    `uvm_analysis_imp_decl(_expected)
    uvm_analysis_imp_expected #(T, decode_scoreboard #(T)) analysis_export_expected;

    // Flags
    bit wait_drain, check_empty_eot, check_activity_eot;

    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
        match_cnt = 0;
        trx_cnt = 0;
        mismatch_cnt = 0;
    endfunction

    virtual function void build_phase (uvm_phase phase);
        analysis_export_actual      = new("analysis_export_actual",this);
        analysis_export_expected    = new("analysis_export_expected",this);
        comp                        = new();
    endfunction

    virtual function void write_expected (T exp_trx);
        //`uvm_info("Decode_Scoreboard","Transaction receieved from Predictor",UVM_MEDIUM)
        //$display("Received trx from Pred : %s",exp_trx.convert2string());
        expected_results.push_front(exp_trx);
        trx_cnt++;
    endfunction

    virtual function void write_actual (T dut_trx);

        // To store the predicted trx
        T pred_trx;

        // Print info
        //`uvm_info("Decode_Scoreboard","Transaction receieved from DUT",UVM_MEDIUM)

        // Trigger the event
        ->got_trx;

        // Extract the oldest item from queue if the queue is not empty
        if(!expected_results.size()) begin 
            `uvm_error("Decode_Scoreboard","No Expected Transactions to compare with Actual Transaction!!")
        end else begin 
            //$display("Expected_results[0] : %s",expected_results[0].convert2string());
            pred_trx = expected_results.pop_back();
            

            // Compare 
            if (dut_trx.compare(pred_trx,comp)) begin 
                match_cnt++;
                `uvm_info("Decode_Scoreboard","Transaction MATCH!",UVM_MEDIUM)        // For this project, all 50 transactions should match
            end else begin 
                mismatch_cnt++;
                `uvm_error("Decode_Scoreboard","Transaction MISMATCH!")
                $display("Predicted Trans - %s",pred_trx.convert2string());
                $display("Actual Trans - %s",dut_trx.convert2string());
            end
        end

    endfunction

    virtual function void phase_ready_to_end (uvm_phase phase);

        // Extend run phase until expected array is empty
        if (phase.get_name() == "run") begin 
            if(wait_drain) begin         // If waiting for scoreboard to drain is enabled
                phase.raise_objection(this, "Objection raised by Scoreboard to extend run phase");
                fork
                    begin
                        wait_for_drain();
                        phase.drop_objection(this, "Objection dropped by Scoreboard");
                    end 
                join_none
            end
        end

    endfunction

    virtual task wait_for_drain();
        while (expected_results.size() != 0) begin 
            wait(got_trx.triggered);
        end
    endtask

    virtual function void check_phase (uvm_phase phase);

        // Activity Check
        if (check_activity_eot && !trx_cnt) begin 
            `uvm_error("Decode_Scoreboard","Scoreboard EOT Activity check failed!")
        end
        
        // Empty Check
        if (check_empty_eot && (expected_results.size() != 0)) begin          // If scbd is supposed to be empty after run phase
            `uvm_error("Decode_Scoreboard","Scoreboard EOT empty check failed!")
        end

    endfunction

    virtual function void report_phase (uvm_phase phase);
        report_string = $sformatf("Total Transactions : %0d  Transaction Matches : %0d  Transaction Mismatches : %0d ",trx_cnt,match_cnt,mismatch_cnt);
        `uvm_info("Scoreboard_Summary",report_string,UVM_MEDIUM)
    endfunction

endclass