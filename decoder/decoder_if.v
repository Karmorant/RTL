module decoder_if(
	input  wire [2:0] digit,
	output wire [7:0] vector
);


assign vector = (digit == 0) ? 8'b00000001 :
		(digit == 1) ? 8'b00000010 :
		(digit == 2) ? 8'b00000100 :
		(digit == 3) ? 8'b00001000 :
		(digit == 4) ? 8'b00010000 :
		(digit == 5) ? 8'b00100000 :
		(digit == 6) ? 8'b01000000 :
		(digit == 7) ? 8'b10000000 : 0;







endmodule