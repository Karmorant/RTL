`timescale 1ns/1ps

module testbench;
reg [7:0] digit;
wire OUT;

is_div_3 #(.SIZE(8)) DUT (
        .digit(digit),
        .out(out)
 );

integer i;
initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        digit = 0;
        repeat (255) begin
                digit = digit + 1;
                #1;
        end
        $finish;
end
endmodule