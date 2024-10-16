class decode_env_configuration extends uvm_object;

    // Sub Configs
    decode_in_configuration     de_in_config;
    decode_out_configuration    de_out_config;

    // Scoreboard flags
    bit scbd_drain  = 1;
    bit scbd_empty  = 1;
    bit scbd_active = 1;

    function new (string name = "");
        super.new(name);
        de_in_config = new("de_in_config");
        de_out_config = new("de_out_config");
    endfunction

    virtual function void initialize(bit [1:0] activity_flags, string interface_names[4], bit [2:0] scbd_flags);

        // Interface names for decode_in
        string de_in_interfaces [2];

        // Interface names for decode_out
        string de_out_interfaces [2];

        // Create inputs for initialize functions
        de_in_interfaces[0] = interface_names[0];
        de_in_interfaces[1] = interface_names[1];
        de_out_interfaces[0] = interface_names[2];
        de_out_interfaces[1] = interface_names[3];

        // Initialize sub configs
        de_in_config.initialize(activity_flags[0], de_in_interfaces);
        de_out_config.initialize(activity_flags[1], de_out_interfaces);

        // Scbd flags
        scbd_drain  = scbd_flags[0];
        scbd_active = scbd_flags[1];
        scbd_empty  = scbd_flags[2];

    endfunction


endclass