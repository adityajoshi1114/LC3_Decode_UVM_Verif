class decode_environment extends uvm_env;

    // Environment Class Components
    decode_in_agent             agent_in;
    decode_out_agent            agent_out;
    decode_predictor            predictor;
    decode_scoreboard           scoreboard;

    // Config
    decode_env_configuration    conf;

    // Sequencer handles
    uvm_sequencer #(decode_in_seq_item) in_sqr;

    function new (string name = "", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);

        // Instantiate all the components
        agent_in = new("agent_in",this);
        agent_out = new("agent_out",this);
        predictor = new("predictor",this);
        scoreboard = new("scoreboard",this);

        // Assign config handles to the respective agents
        agent_in.conf = conf.de_in_config;
        agent_out.conf = conf.de_out_config;

        // Assign flags to Scoreboard
        scoreboard.wait_drain       = conf.scbd_drain;
        scoreboard.check_empty_eot      = conf.scbd_empty;
        scoreboard.check_activity_eot   = conf.scbd_active;

    endfunction



    virtual function void connect_phase(uvm_phase phase);
    
        // Agent_in and Pred
        agent_in.ap.connect(predictor.analysis_export);

        // Pred and Scbd
        predictor.ap.connect(scoreboard.analysis_export_expected);

        // Scbd and Agent_out
        agent_out.ap.connect(scoreboard.analysis_export_actual);

    endfunction
endclass