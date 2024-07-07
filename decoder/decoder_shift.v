module decoder_shift(
	input  wire [2:0] digit,
	output wire [7:0] vector
);

assign vector = 8'b00000001 << digit;


endmodule