`timescale 1ns/1ps
`define SIZE 64


module testbench;
reg [`SIZE - 1:0] digit;

wire               out_eth;
wire              out;


assign out_eth = (!(digit % 3));

is_div_3_top #(.SIZE(`SIZE)) DUT (
        .digit(digit),
        .out(out)
 );

integer i;
initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        digit = 'h0;
        #1;
        repeat (128) begin
                digit = digit + 1;
                #1;
                if (out !=out_eth) begin
                        $display("ERROR");
                        $stop;
                end
        end
        $finish;
end
endmodule