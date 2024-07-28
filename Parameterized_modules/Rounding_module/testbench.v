`timescale 1ns/1ps

module testbench;
reg [34:0] vector;
reg [1:0] rouding_mode;

rounding_module #(.DATA_W(35)) DUT (
        .data(vector),
        .rouding_mode(rouding_mode)
 );

initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        rouding_mode = 0;
        #2;
        vector = 35'b0_10000010_00000000000001000000000_010;
        #2;
        vector = 35'b0_10000010_00000000000001000000000_100;
        #2;
        vector = 35'b0_10000010_00000000000001000000000_000;
        #2;
        vector = 35'b0_10000010_00000000000001000000001_010;
        #2;
        vector = 35'b0_10000010_00000000000000000000001_000;
        #2;
        vector = 35'b0_10000010_00000000000000000100101_000;
        #2;
        rouding_mode = 1;
        vector = 35'b0_10000010_00000000000100100000000_111;
        #2;
        vector = 35'b0_10000010_10000000000111111000000_001;
        #2;
        vector = 35'b0_10000010_10000000000000111100000_010;
        #2;
        vector = 35'b0_10000010_10000000000000000000010_100;
        #2;
        vector = 35'b0_10000010_10000000000000000000001_011;
        #2;

        $finish;
end
endmodule