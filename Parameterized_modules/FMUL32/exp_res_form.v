module exp_res_form
#(
        parameter DATA_W = 32
)
(
        input  wire [7 : 0] exp_res_tmp,
        input  wire [3 : 0] prev_res,
        input  wire [7 : 0] denorm_shift,
        input  wire [1 : 0] exp_condition,
        input  wire [7 : 0] leading_zero_num,
        input  wire         exp_incr,
        input  wire         not_full_norm,
        input  wire [1 : 0] denorm_AB,
        output wire [7 : 0] exp_fin
);



assign exp_fin = (|prev_res[3 : 2] || prev_res[1]                 ) ? {8{1'b1}      }                        :
                 ( prev_res[0]                                    ) ? {8{1'b0}      }                        :
                 ( exp_condition[0]                               ) ? {8{1'b1}      }                        :

                 ((denorm_shift == 1) && exp_incr                 ) ? 8'b00000001                            :
                 (denorm_shift                                    ) ? {8{1'b0}      }                        :

                 (exp_condition[1] && not_full_norm               ) ? exp_res_tmp - leading_zero_num         :
                 (exp_condition[1]                                ) ? {8{1'b1}      }                        :

                 (exp_incr                                        ) ? exp_res_tmp + exp_incr                 :

                 (not_full_norm && exp_res_tmp >  leading_zero_num) ? exp_res_tmp - leading_zero_num + 2'b10 :
                 (not_full_norm && exp_res_tmp <= leading_zero_num) ? {8{1'b0}      } + denorm_AB[1] + denorm_AB[0]    :
                                                                      exp_res_tmp + denorm_AB[1] + denorm_AB[0];




endmodule