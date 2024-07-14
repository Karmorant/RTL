`timescale 1ns/1ps


module testbench;
reg  [7:0] in;
wire [2:0] pow;

priority_encoder #(.IN_SIZE(8)) DUT (
        .in(in),
        .pow(pow)
);

initial begin
$dumpfile("out.vcd");
$dumpvars(0,testbench);

	in = 8'b01000100;
	#10;

	in = 8'b11111010;
	#10;

	in = 8'b00000001;
	#10;

	in = 8'b00010000;
	#10;

$finish;
end
endmodule
