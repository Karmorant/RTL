`timescale 1ns/1ps

module testbench;
reg [63:0] digit;
wire OUT;

is_div_3_top #(.SIZE(64)) DUT (
        .digit(digit),
        .out(out)
 );

integer i;
initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        digit = 64'hFFFFFFFFFFFFFF00;
        #1;
        repeat (255) begin
                digit = digit + 1;
                #1;
        end
        $finish;
end
endmodule