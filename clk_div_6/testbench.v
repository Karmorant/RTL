`timescale 1ns/1ps


module testbench;
reg clk;
reg reset;
wire clk_div_6;


initial begin
        clk = 0;
        reset = 0;
end
always #1 clk = ~clk;


clk_div_6 DUT  (
        .clk(clk),
        .reset(reset),
        .clk_div_6(clk_div_6)
);





initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        #12;
        reset = 1;
        #2;
        reset = 0;

        #1000;

        $finish;
end






endmodule