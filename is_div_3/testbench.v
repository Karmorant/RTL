`timescale 1ns/1ps

module testbench;
reg [7:0] digit;
wire OUT;

is_div_3 DUT (digit, OUT);
initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        digit = 8'b11111111;
        #5;
        digit = 8'b01010010;
        #5;
        digit = 8'b01000000;
        #5;
        digit = 8'b00011111;
        #5;
        digit = 8'b00000000;
        #5;
        digit = 8'b00000011;
        #5;
        digit = 8'b00000110;
        #5;
        digit = 8'b11111100;
        #5;
        digit = 8'b00011000;
        #5;
        digit = 8'b00110110;
        #5;
        digit = 8'b10001100;
        #5;
        $finish;
end
endmodule