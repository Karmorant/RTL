module exp_res_form
#(
        parameter DATA_W = 32
)
(
        input  wire [7                      : 0] exp_res_tmp,
        input  wire [2                      : 0] prev_res,
        input  wire [7                      : 0] denorm_shift,
        input  wire [1                      : 0] exp_condition,
        input  wire [$clog2(2*(DATA_W - 8)) : 0] leading_zero_num,
        input  wire                              exp_incr,
        input  wire                              not_full_norm,
        input  wire                              mant_overfl,
        output wire [7                      : 0] exp_fin,
        output wire [7                      : 0] mant_shift
);

wire [1 : 0] exp_change_pose;

assign exp_change_pose = exp_incr + mant_overfl;


assign exp_fin = {8{prev_res[2] || prev_res[1]                      }} & {8{1'b1}   }                                 |
                 {8{prev_res[0]                                     }} & {8{1'b0}   }                                 |
                 {8{exp_condition[0]                                }} & {8{1'b1}   }                                 |

                 ((denorm_shift <  2) && exp_change_pose          ) ? {8{1'b0}   } + exp_change_pose                  :
                 ((denorm_shift == 2) && exp_change_pose          ) ?  8'b00000001 - (denorm_shift - exp_change_pose) :
                 (denorm_shift                                    ) ? {8{1'b0}   }                                    :

                 (exp_condition[1] && not_full_norm               ) ? exp_res_tmp - leading_zero_num                  :
                 (exp_condition[1]                                ) ? {8{1'b1}   }                                    :

                 (exp_change_pose == 2 && exp_res_tmp == 253 ||
                  exp_change_pose == 1 && exp_res_tmp == 254      ) ? {8{1'b1}   }                                    :
                 (exp_change_pose                                 ) ? exp_res_tmp + exp_change_pose                   :

                 (not_full_norm && exp_res_tmp >  leading_zero_num) ? exp_res_tmp - leading_zero_num                  :
                 (not_full_norm && exp_res_tmp <= leading_zero_num) ? {8{1'b0}   }                                    :
                                                                      exp_res_tmp                                     ;


assign mant_shift = ((denorm_shift <  2) && exp_change_pose          ) ? 8'b0                                  :
                    ((denorm_shift >= 2) && exp_change_pose          ) ? denorm_shift - exp_change_pose        :
                    ( denorm_shift       && not_full_norm            ) ? denorm_shift + leading_zero_num       :
                    ( denorm_shift                                   ) ? denorm_shift                          :

                    (not_full_norm && exp_res_tmp <= leading_zero_num) ? leading_zero_num - exp_res_tmp - 1'b1 :
                    (not_full_norm                                   ) ? 8'b0                                  :
                                                                         8'b0                                  ;

endmodule