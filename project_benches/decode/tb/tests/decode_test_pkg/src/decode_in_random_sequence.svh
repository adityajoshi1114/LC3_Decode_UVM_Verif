class decode_in_random_sequence extends decode_in_sequence_base;

    `uvm_object_utils(decode_in_random_sequence)

    // The sequence and/or sequence item(s) to send/start
    decode_in_seq_item de_in_si;

    function new (string name = "");
        super.new(name);
        // Instantiate a transaction 
        de_in_si = new();
    endfunction

    virtual task body ();

        // Initiate
        `uvm_info("RANDOM SEQUENCE","Requesting sequencer for sending a transaction to the driver",UVM_HIGH);
        start_item(de_in_si);

        // Randomize 
        randomize_seq_item_in_seq : assert(de_in_si.randomize());
        de_in_si.next_pc = de_in_si.next_pc + 1;  // Incrementing npc for every transaction

        // Send 
        `uvm_info("RANDOM SEQUENCE",{"Sending:", de_in_si.convert2string()} ,UVM_HIGH);
        finish_item(de_in_si);

    endtask



endclass