`timescale 1ns/1ns
`define TIMESCALE

`include "sys_sig.v"

module fmul_top();

wire clk, reset;

sys_sig sys_sig (clk, reset);

reg [31:0] op1_f [999999 : 0];
reg [31:0] op2_f [999999 : 0];
reg [31:0] res_eth_f [999999 : 0];

initial $readmemh("arg_1.txt", op1_f);
initial $readmemh("arg_2.txt", op2_f);
initial $readmemh("res.txt", res_eth_f);

reg [31:0] op1;
reg [31:0] op2;
reg [31:0] res_eth;




FMUL32 #(.DATA_W(32), .OPERATION_NUM(4)) fmul
(
        .clk    (clk),
        .op1    (op1),
        .op2    (op2),
        .opc    (opcode),
        .r_mode (rmode),
        .result (result),
        .val    ()
);

integer g = 0;

always @(posedge clk) begin

        op1 <= op1_f[g];
        op2 <= op2_f[g];
        g = g + 1;   
end




integer i = 0;

initial begin

#5;
for (i = 0; i < 1000000; i = i + 1) begin

        res_eth <= res_eth_f[i];
        #2;
    end
end

reg [1:0]   opcode=0, rmode=0;
wire[31:0]  result;


always @(negedge clk) begin
    if(result != res_eth) begin
        $stop();
    end
end
initial 
begin
    $dumpfile("out.vcd");
    $dumpvars(0, fmul_top);
    #2100000;
    $display ("SUCCESS");

    $finish();
end
endmodule
