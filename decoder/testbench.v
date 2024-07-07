`timescale 1ns/1ps

module testbench;
reg  [2:0] digit;
wire [7:0] vector;

decoder_shift DUT (digit, vector);

initial begin
	$dumpfile("out.vcd");
	$dumpvars(0,testbench);

	digit = 3'b000;
	#10;
	digit = 3'b001;
	#10;

	digit = 3'b010;
	#10;

	digit = 3'b011;
	#10;

	$finish;
end
endmodule
