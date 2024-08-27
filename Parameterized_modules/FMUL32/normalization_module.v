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
        output wire [MANT_W - 1         : 0] out,
        output wire [7                  : 0] leading_zero_num,
        output wire                          exp_incr,
        output wire [9 : 0] mant_shift,
        output wire [4 : 0] a,
        output wire                          not_full_norm
);

wire [9 : 0] shift_tmp;
wire         leading_zero_23;
wire [9 : 0] leading_zero_tmp;
wire         norm_condition;
wire         res_denorm;

leading_zero_counter 
#(
        .DATA_W         (MANT_W          )
) leading_zero_counter_1
(
        .vector         (vector          ),
        .zero_num       (leading_zero_num)
);

assign exp_incr         = (vector[MANT_W - 1 : MANT_W - 2] > 1);

assign not_full_norm    = (leading_zero_num > 1);

assign shift_tmp        = denorm_shift - leading_zero_num;


assign leading_zero_tmp = leading_zero_num - 8'd23;
assign leading_zero_23  = ~(|leading_zero_tmp) | &leading_zero_tmp[9:8];

assign norm_condition   = &shift_tmp[9:8] && !denorm_shift && !leading_zero_23;

assign res_denorm       = (not_full_norm && exp_res_tmp <= leading_zero_num);

assign a = {&shift_tmp[9:8] && !denorm_shift &&  leading_zero_23, leading_zero_23, leading_zero_num - 23 == exp_res_tmp, leading_zero_num - 23  < exp_res_tmp, leading_zero_num - 23  > exp_res_tmp};


assign mant_shift = (|exp_condition                                              ) ? {2'b00, 8'd48                                     } :

                    (denorm_shift       ==  leading_zero_num && denorm_shift     ) ? shift_tmp                                           :
                    (~(&shift_tmp[9:8]) && !leading_zero_num && denorm_shift     ) ? shift_tmp - exp_incr                                :
                    (~(&shift_tmp[9:8]) &&  leading_zero_num && denorm_shift     ) ? denorm_shift - 1'b1 - denorm_AB[1] - denorm_AB[0]   :

                    (( &shift_tmp[9:8]) &&  denorm_shift                         ) ? {2'b00, 8'b0                                      } :
                    ( exp_incr          &&  exp_res_tmp == 254                   ) ? {2'b00, 8'd48                                     } :

                    (( &shift_tmp[9:8]) && !denorm_shift &&  leading_zero_23     ) ? {2'b11, leading_zero_num - res_denorm} :

                    {10{(leading_zero_num - 23 == exp_res_tmp) && norm_condition}} & {2'b11, exp_res_tmp                               } |
                    {10{(leading_zero_num - 23  < exp_res_tmp) && norm_condition}} & {2'b11, leading_zero_num - 8'd23                  } |
                    {10{(leading_zero_num - 23  > exp_res_tmp) && norm_condition}} & {2'b11, (leading_zero_num - 8'd23 - exp_res_tmp  )} | 10'b0 ;



// assign mant_shift = {10{|exp_condition                                         }} & {2'b00, 8'd48                                     } |
// 
//                     {10{denorm_shift       ==  leading_zero_num                }} & {2'b00, denorm_shift                              } |
//                     {10{~(&shift_tmp[9:8]) && ~leading_zero_num                }} & shift_tmp                                           |
//                     {10{~(&shift_tmp[9:8]) &&  leading_zero_num                }} & {2'b00, denorm_shift - denorm_AB[1] - denorm_AB[0]} |
// 
//                     {10{( &shift_tmp[9:8]) &&  denorm_shift                    }} & {2'b00, denorm_shift + leading_zero_num           } |
//                     {10{ exp_incr          &&  exp_res_tmp == 254              }} & {2'b00, 8'd48                                     } |
// 
//                     {10{( &shift_tmp[9:8]) && ~denorm_shift &&  leading_zero_23}} & {2'b00, 8'b0                                      } |
// 
//                     (( &shift_tmp[9:8]) && !denorm_shift && !leading_zero_23) ?
//                     {10{leading_zero_num - 23 == exp_res_tmp                   }} & {2'b11, exp_res_tmp                               } |
//                     {10{leading_zero_num - 23  < exp_res_tmp                   }} & {2'b11, leading_zero_num - 8'd23                  } |
//                     {10{leading_zero_num - 23  > exp_res_tmp                   }} & {2'b11, (leading_zero_num - 8'd23 - exp_res_tmp  )} : 10'b0 ;
// 
                



// assign mant_shift = (|exp_condition                                  ) ? 8'd48                                 :
//                     ((denorm_shift == 1) && exp_incr          ) ? 8'b0                                  :
//                     ((denorm_shift >= 2) && exp_incr          ) ? denorm_shift - exp_incr        :
//                     ( denorm_shift       && not_full_norm            ) ? denorm_shift + leading_zero_num - 2'd2:
//                     ( denorm_shift                                   ) ? denorm_shift - denorm_AB[1] - denorm_AB[0]:

//                     (not_full_norm && exp_res_tmp <= leading_zero_num) ? leading_zero_num - exp_res_tmp - 1'b1 :
//                     (not_full_norm                                   ) ? 8'b0                                  :

//                     (exp_incr == 2'b10 && exp_res_tmp == 253 ||
//                      exp_incr == 2'b01 && exp_res_tmp == 254  ) ? 8'd48                                 :
//                                                                          8'b0                                  ;




assign out = (&mant_shift[9:8]) ? vector << mant_shift[7:0] : vector >> mant_shift; 
endmodule