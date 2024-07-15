`timescale 1ns/1ps


module testbench;
reg clk;
reg reset;
reg write;
reg read;
reg [7:0] data_in;

initial begin
        clk = 0;
        reset = 0;
        write = 0;
        read = 0;
end
always #1 clk = ~clk;


LIFO_buffer #(.LIFO_SIZE(8), .DATA_W(8)) DUT (
        .clk(clk),
        .reset(reset),
        .write(write),
        .read(read),
        .data_in(data_in)
        
);





initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        #11;
        reset = 1;
        #2;
        reset = 0;
        #2;
        write = 1;
        data_in = 8'b11111111;
        #2;
        data_in = 8'b00000000;
        #2;
        data_in = 8'b11110000;
        #2;
        data_in = 8'b00001111;
        #2;
        write = 0;
        #5;
        read = 1;
        #2;
        read = 1;
        #2;
        read = 1;
        #2;
        read = 1;
        #2;
        read = 1;
        #2;
        read = 0;
        #2;
        write = 1;
        data_in = 8'b11111111;
        #2;
        data_in = 8'b00000000;
        #2;
        data_in = 8'b11110000;
        #2;
        data_in = 8'b00001111;
        #2;
        data_in = 8'b01010101;
        #2;
        data_in = 8'b01101100;
        #2;
        data_in = 8'b00010000;
        #2;
        read = 1;
        data_in = 8'b00000001;
        #2;
        write = 0;
        read = 0;
        #2;
        write = 1;
        data_in = 8'b10000001;
        #2;
        write = 0;
        #2;
        read = 1;
        #2;
        read = 0;
        #2;
        write = 1;
        data_in = 8'b10000001;
        #2;
        data_in = 8'b10000000;
        #2;
        write = 0;
        reset = 1;
        #2;
        reset = 0;
        



        #1000;

        $finish;
end






endmodule