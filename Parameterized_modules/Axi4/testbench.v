`timescale 1ns/1ps


module testbench;
reg clk;
reg reset;
reg write;
reg ready;
reg [1 : 0] marker_pos;
reg [7 : 0] buffer_in;


initial begin
        clk = 0;
        reset = 1;
        marker_pos = 2'b00;
        write = 1;
        ready = 0;
end
always #1 clk = ~clk;


master #(.PACK_SIZE(8), .MARK_SIZE(8)) DUT (
        .clk(clk),
        .reset(reset),
        .write(write),
        .ready(ready),
        .buffer_in(buffer_in),
        .marker_pos(marker_pos)
);





initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        #11;
        reset = 0;
        
        buffer_in = 8'b11011111;
        #2;
        buffer_in = 8'b00000000;
        #2;
        buffer_in = 8'b11110000;
        #2;
        buffer_in = 8'b00001111;
        #2;
        write = 0;
        #20;
        #2;
        ready = 1;
        #2;
        #2;

        #1000;

        $finish;
end






endmodule