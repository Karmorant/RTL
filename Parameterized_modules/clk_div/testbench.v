`timescale 1ns/1ps


module testbench;
reg clk;
reg reset;



initial begin
        clk = 0;
        reset = 0;
end
always #1 clk = ~clk;


clk_div #(.DIV(6)) DUT (
        .clk(clk),
        .reset(reset)
        
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