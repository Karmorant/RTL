`timescale 1ns/1ps

module testbench;
reg  [7:0] in;
wire [2:0] pow;

encoder DUT (in, pow);

initial begin
$dumpfile("out.vcd");
$dumpvars(0,testbench);

	in = 8'b00000001;
	#10;

	in = 8'b00000010;
	#10;

	in = 8'b00010000;
	#10;

	in = 8'b10000000;
	#10;

$finish;
end
endmodule
