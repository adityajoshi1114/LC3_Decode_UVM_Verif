class decode_env_configuration extends uvm_object;

    // Sub Configs
    decode_in_configuration     de_in_config;
    decode_out_configuration    de_out_config;

    // Scoreboard flags
    bit scbd_drain  = 1;
    bit scbd_empty  = 1;
    bit scbd_active = 1;

    // Agent Paths
    string ag1_path,ag2_path;

    function new (string name = "");
        super.new(name);
        de_in_config = new("de_in_config");
        de_out_config = new("de_out_config");
    endfunction

    virtual function void initialize(uvm_active_passive_enum [1:0] activity_flags, string interface_names[4], string env_path, bit [2:0] scbd_flags);

        // Interface names for decode_in
        string de_in_interfaces [2];

        // Interface names for decode_out
        string de_out_interfaces [2];

        // Create inputs for initialize functions
        de_in_interfaces[0]     = interface_names[0];
        de_in_interfaces[1]     = interface_names[1];
        de_out_interfaces[0]    = interface_names[2];
        de_out_interfaces[1]    = interface_names[3];
        ag1_path                = {env_path,".agent_in"};
        ag2_path                = {env_path,".agent_out"};                  


        // Initialize sub configs
        de_in_config.initialize(activity_flags[0], de_in_interfaces, ag1_path);
        de_out_config.initialize(activity_flags[1], de_out_interfaces, ag2_path);

        // Scbd flags
        scbd_drain  = scbd_flags[0];
        scbd_active = scbd_flags[1];
        scbd_empty  = scbd_flags[2];

    endfunction


endclass