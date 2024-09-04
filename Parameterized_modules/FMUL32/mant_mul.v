module mant_mul
#(
        parameter DATA_W = 32
)
(
        input  wire [DATA_W - 9         : 0] mant_A,
        input  wire [DATA_W - 9         : 0] mant_B,
        input  wire [1                  : 0] op_NAN,
        output wire [2*(DATA_W - 8) - 1 : 0] prev_mant_res

);

assign prev_mant_res = (&op_NAN       ) ? {mant_A[22:0], 25'b0} :
                       {48{op_NAN[1] }} & {mant_A[22:0], 25'b0} |
                       {48{op_NAN[0] }} & {mant_B[22:0], 25'b0} |
                       {48{~(|op_NAN)}} &  mant_A * mant_B;
                       
endmodule