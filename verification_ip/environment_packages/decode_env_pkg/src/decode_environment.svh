class decode_environment extends uvm_environment;

    // Environment Class Components
    decode_in_agent             agent_in;
    decode_out_agent            agent_out;
    decode_predictor            predictor;
    decode_scoreboard           scoreboard;

    // Config
    decode_env_configuration    conf;



    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);

    endfunction



    virtual function void connect_phase(uvm_phase phase);
    
        // Agent_in and Pred
        decode_in_agent.ap.connect(predictor.analysis_export);

        // Pred and Scbd


        // Scbd and Agent_out


    endfunction
endclass