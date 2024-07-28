`timescale 1ns/1ps

module testbench;
reg [7:0] vector;
wire [7:0] out;

normalization_module #(.DATA_W(8)) DUT (
        .vector(vector),
        .out(out)
 );

initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        vector = 8'b10000000;
        #2;
        vector = 8'b00001100;
        #2;
        vector = 8'b0100000;
        #2;
        vector = 8'b00100000;
        #2;
        vector = 8'b00010000;
        #2;
        vector = 8'b00001000;
        #2;
        vector = 8'b00000100;
        #2;
        vector = 8'b00000010;
        #2;
        vector = 8'b00000001;
        #2;
        vector = 8'b11111111;
        #2;
        vector = 8'b11000011;
        #2;
        vector = 8'b01111000;
        #2;

        $finish;
end
endmodule