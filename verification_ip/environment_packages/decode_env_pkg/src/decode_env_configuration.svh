class decode_env_configuration extends uvm_object;

    // Sub Configs
    decode_in_configuration de_in_config;
    decode_out_configuration de_out_config;

    // Scoreboard flags
    bit scbd_drain  = 1;
    bit scbd_empty  = 1;
    bit scbd_active = 1;


    function new (string name = "");
        super.new(name);
        de_in_config = new("de_in_config");
        de_out_config = new("de_out_config");
    endfunction

    virtual function void initialize();

        decode_in_configuration.initialize();
        decode_out_configuration.initialize();

        // Do a set call to store itself in the config db

    endfunction


endclass