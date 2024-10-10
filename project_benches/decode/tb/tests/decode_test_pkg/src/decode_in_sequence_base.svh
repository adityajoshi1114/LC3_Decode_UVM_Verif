class decode_in_sequence_base extends uvm_sequence #(.REQ(decode_in_seq_item), .RSP(decode_in_seq_item));

    `uvm_object_utils(decode_in_sequence_base)

    function new (string name = "");
        super.new(name);
    endfunction

    virtual task body ();

        // Might need to add something for further projects

    endtask



endclass