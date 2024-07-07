`timescale 1ns/1ps


module testbench;
reg clk;
reg reset;
wire OUT;


initial begin
        clk = 0;
        reset = 0;
end

always #1 clk = ~clk;

generator DUT(
        .clk(clk),
        .reset(reset),
        .OUT(OUT)
);
initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        #1000;


        $finish;
end
endmodule