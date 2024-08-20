`ifndef TIMESCALE
`timescale 10ns/1ns
`endif

module sys_sig
(
	output reg clk,
	output reg reset
);

always #1 clk = ~clk;

initial begin
	clk = 0;
	reset = 0;
	@(posedge clk)
	reset <= 1;
	repeat(3) @(negedge clk);
	reset <= 0;
end

endmodule

