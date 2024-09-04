module normalization_module
#(
        parameter MANT_W = 8
)
(
        input  wire [MANT_W - 1         : 0] vector,
        input  wire [1                  : 0] exp_condition,
        input  wire [7                  : 0] denorm_shift,
        input  wire [7                  : 0] exp_res_tmp,
        input  wire [1                  : 0] denorm_AB,
        input  wire [1                  : 0] op_NAN,
        output wire [MANT_W - 1         : 0] out,
        output wire [7                  : 0] leading_zero_num,
        output wire                          exp_incr
);

wire [8 : 0] mant_shift;
wire [9 : 0] leading_zero_tmp;



leading_zero_counter 
#(
        .DATA_W         (MANT_W          )
) leading_zero_counter_1
(
        .vector         (vector          ),
        .zero_num       (leading_zero_num)
);

assign exp_incr         = (vector[MANT_W - 1 : MANT_W - 2] > 1);


assign mant_shift = (op_NAN                                                                         ) ?  9'b0                                                         :
                    (|exp_condition                                                                 ) ? {1'b0, 8'd48                                                } :

                    (leading_zero_num > 1 && leading_zero_num - 1'b1 >  exp_res_tmp && !denorm_shift) ? {1'b1, exp_res_tmp + denorm_AB[1] + denorm_AB[0]            } :
                    (leading_zero_num > 1 && leading_zero_num - 1'b1 <= exp_res_tmp && !denorm_shift) ? {1'b1, leading_zero_num - 1'b1 + denorm_AB[1] + denorm_AB[0]} :
                    (!denorm_shift && !exp_res_tmp && leading_zero_num == 1                         ) ? {1'b1, 8'b0 + denorm_AB[1] + denorm_AB[0]                   } :
                    (denorm_shift       && exp_incr                                                 ) ? {1'b0, denorm_shift                                         } :
                    (exp_res_tmp == 254 && exp_incr                                                 ) ? {1'b0, 8'd48                                                } :
                    (exp_incr                                                                       ) ?  9'b0                                                         :
                    (denorm_shift                                                                   ) ? {1'b0, denorm_shift - denorm_AB[1] - denorm_AB[0]           } :
                                                                                                        {1'b1, 8'b1                                                 } ;




assign out = (mant_shift[8]) ? vector << mant_shift[7:0] : vector >> mant_shift[7:0]; 
endmodule