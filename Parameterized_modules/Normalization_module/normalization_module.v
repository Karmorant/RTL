module normalization_module
#(
        parameter MANT_W = 8
)
(
        input  wire [MANT_W - 1     : 0] vector,
        output wire [MANT_W - 1     : 0] out,
        output wire [$clog2(MANT_W) : 0] leading_zero_num,
        output wire                      exp_incr,
        output wire                      not_full_norm
);



leading_zero_counter 
#(
        .DATA_W(MANT_W)
) leading_zero_counter_1
(
        .vector(vector),
        .zero_num(leading_zero_num)
);

assign exp_incr = (vector[MANT_W - 1 : MANT_W - 2] > 1);

assign not_full_norm = (leading_zero_num > 1);


assign out = vector << leading_zero_num;

endmodule