module decoder(
	input  wire [2:0] digit,
	output wire [7:0] vector
);

assign vector [0] = ~digit[2] & ~digit[1] & ~digit[0];
assign vector [1] = ~digit[2] & ~digit[1] &  digit[0];
assign vector [2] = ~digit[2] &  digit[1] & ~digit[0];
assign vector [3] = ~digit[2] &  digit[1] &  digit[0];
assign vector [4] =  digit[2] & ~digit[1] & ~digit[0];
assign vector [5] =  digit[2] & ~digit[1] &  digit[0];
assign vector [6] =  digit[2] &  digit[1] & ~digit[0];
assign vector [7] =  digit[2] &  digit[1] &  digit[0];


endmodule