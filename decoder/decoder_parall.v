module decoder_parall(
        input  wire [2:0] in,
        output wire [7:0] out
);

assign out =    {8{in == 3'd0}} & 8'b00000001 |
                {8{in == 3'd1}} & 8'b00000010 |
                {8{in == 3'd2}} & 8'b00000100 |
                {8{in == 3'd3}} & 8'b00001000 |
                {8{in == 3'd4}} & 8'b00010000 |
                {8{in == 3'd5}} & 8'b00100000 |
                {8{in == 3'd6}} & 8'b01000000 |
                {8{in == 3'd7}} & 8'b10000000 ;
endmodule