`timescale 1ns/1ps

module testbench;
reg  [7:0] vector;
wire [2:0] num;

priority_encoder DUT (vector, num);

initial begin
        $dumpfile("out.vcd");
        $dumpvars(0,testbench);

        vector = 8'b10100110;
        #10;
        vector = 8'b00000010;
        #10;
        vector = 8'b00111000;
        #10;
        vector = 8'b11111111;
        #10;
        vector = 8'b00000001;
        #10;


        $finish;

end
endmodule