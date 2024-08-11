module mant_mul
#(
        parameter DATA_W = 24
)
(
        input  wire [DATA_W - 9         : 0] mant_A,
        input  wire [DATA_W - 9         : 0] mant_B,
        output wire [2*(DATA_W - 8) - 1 : 0] prev_mant_res

);

assign prev_mant_res = mant_A * mant_B;

endmodule