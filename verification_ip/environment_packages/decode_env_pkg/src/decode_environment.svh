class decode_environment extends uvm_environment;




    virtual function void connect_phase(uvm_phase phase);
    
        // Agent_in and Pred
        decode_in_agent.ap.connect(predictor.analysis_export);

        // Pred and Scbd


        // Scbd and Agent_out


    endfunction
endclass