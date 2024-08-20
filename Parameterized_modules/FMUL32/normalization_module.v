module normalization_module
#(
        parameter MANT_W = 8
)
(
        input  wire [MANT_W - 1         : 0] vector,
        input  wire [1                  : 0] exp_condition,
        input  wire [7                  : 0] denorm_shift,
        input  wire [1                  : 0] exp_change_pose,
        input  wire [7                  : 0] exp_res_tmp,
        output wire [MANT_W - 1         : 0] out,
        output wire [$clog2(MANT_W) - 1 : 0] leading_zero_num,
        output wire                          exp_incr,
        output wire [7 : 0] mant_shift,
        output wire                          not_full_norm
);

//wire [7 : 0] mant_shift;

leading_zero_counter 
#(
        .DATA_W         (MANT_W          )
) leading_zero_counter_1
(
        .vector         (vector          ),
        .zero_num       (leading_zero_num)
);

assign exp_incr = (vector[MANT_W - 1 : MANT_W - 2] > 1);

assign not_full_norm = (leading_zero_num > 1);


assign mant_shift = (|exp_condition                                  ) ? 8'd48                                 :
                    ((denorm_shift == 1) && exp_change_pose          ) ? 8'b0                                  :
                    ((denorm_shift >= 2) && exp_change_pose          ) ? denorm_shift - exp_change_pose        :
                    ( denorm_shift       && not_full_norm            ) ? denorm_shift + leading_zero_num - 2'd2:
                    ( denorm_shift                                   ) ? denorm_shift                          :

                    (not_full_norm && exp_res_tmp <= leading_zero_num) ? leading_zero_num - exp_res_tmp - 1'b1 :
                    (not_full_norm                                   ) ? 8'b0                                  :

                    (exp_change_pose == 2'b10 && exp_res_tmp == 253 ||
                     exp_change_pose == 2'b01 && exp_res_tmp == 254  ) ? 8'd48                                 :
                                                                         8'b0                                  ;



wire [MANT_W - 1 : 0] data_tmp;

assign data_tmp = vector << leading_zero_num;
assign out      = data_tmp >> mant_shift; 
endmodule