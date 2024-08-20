`timescale 1ns/1ps
`define SIZE 32 

module testbench;
reg clk;
reg [`SIZE - 1 : 0] op1;
reg [`SIZE - 1 : 0] op2;
reg [1         : 0] opc;
reg [1         : 0] r_mode;



initial begin
        clk = 0;

end
always #1 clk = ~clk;


FMUL32 #(.DATA_W(`SIZE), .OPERATION_NUM(4)) DUT (
        .clk(clk),
        .op1(op1),
        .op2(op2),
        .opc(opc),
        .r_mode(r_mode)
);





initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        #10;
        opc = 0;
        r_mode = 0;
        #2;
        op1 = 32'b01111111101000010001110111000101;
        op2 = 32'b00111010110100011110101101011000;

        #1000;

        $finish;
end






endmodule