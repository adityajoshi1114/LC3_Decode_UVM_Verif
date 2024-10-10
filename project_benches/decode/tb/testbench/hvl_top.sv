`timescale 1ns / 10ps
module hvl_top ();

    // Import the required packages
    import uvm_pkg::*;
    import decode_test_pkg::*;

    // Run the test
    initial begin
        run_test();
    end

endmodule