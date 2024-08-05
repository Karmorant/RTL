`timescale 1ns/1ps


module testbench;
reg [7:0] op_A;
reg [7:0] op_B;
reg [7:0] op_C;
wire [9:0] res;

CSA #(.DATA_W(8)) DUT
(
        .op_A(op_A),
        .op_B(op_B),
        .op_C(op_C),
        .res(res)
);

wire [9:0] res_eth; 

assign res_eth = op_A+op_B+op_C;

initial
begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);

        
        op_A = 8'b11111111;
        op_B = 8'b11111111;
        op_C = 8'b11111111;
        if (res != res_eth)
                begin
                        $display("ERROR");
                        $stop();
                end
                #2;

        repeat (1000)
        begin
                op_A = $random;
                op_B = $random;
                op_C = $random;
                #2;
                if (res != res_eth)
                begin
                        $display("ERROR");
                        $stop();
                end
        end

        $finish;
end
endmodule