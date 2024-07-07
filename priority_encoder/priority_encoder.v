module priority_encoder(
        input  wire [7:0] vector,
        output wire [2:0] num
);

assign num =    (vector[7]) ? 3'd7 :
                (vector[6]) ? 3'd6 :
                (vector[5]) ? 3'd5 :
                (vector[4]) ? 3'd4 :
                (vector[3]) ? 3'd3 :
                (vector[2]) ? 3'd2 :
                (vector[1]) ? 3'd1 :
                (vector[0]) ? 3'd0 : 3'd0;


endmodule