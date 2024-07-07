module decoder_case(
        input  wire [2:0] digit,
        output reg  [7:0] vector
);



always @(digit) begin
        vector = 8'b00000000;
        case(digit)
        3'd0: vector = 8'b00000001;
        3'd1: vector = 8'b00000010;
        3'd2: vector = 8'b00000100;
        3'd3: vector = 8'b00001000;
        3'd4: vector = 8'b00010000;
        3'd5: vector = 8'b00100000;
        3'd6: vector = 8'b01000000;
        3'd7: vector = 8'b10000000;

        endcase
        
end

endmodule
