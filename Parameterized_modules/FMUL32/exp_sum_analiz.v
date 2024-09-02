module exp_sum_analiz
(
        input  wire [9:0] exp_res_tmp,
        output wire [7:0] denorm_shift,
        output wire       prev_inf,
        output wire       prev_overflow
);





assign denorm_shift  =  (prev_denorm & ~(|exp_res_tmp[7:0])) ?   8'b0                  :
                        (prev_denorm                       ) ? ~(exp_res_tmp[7:0] - 1) : 0;

assign prev_inf      = ~(|exp_res_tmp[9:8]) & &exp_res_tmp[7:0];

assign prev_overflow =  ( exp_res_tmp[9:8] == 2'b01);

assign prev_denorm   =   &exp_res_tmp[9:8]  |
                       ~(|exp_res_tmp[9:8]) &
                       ~(|exp_res_tmp[7:0]) ;

endmodule