module FMUL32
#(
        parameter DATA_W        = 32,
        parameter OPERATION_NUM = 4
)
(
        input  wire                                 clk,
        input  wire [DATA_W - 1                : 0] op1,
        input  wire [DATA_W - 1                : 0] op2,
        input  wire [$clog2(OPERATION_NUM) - 1 : 0] opc,
        input  wire [1                         : 0] r_mode,
        output wire [31                        : 0] result,
        output wire                                 val


);


wire [7                  : 0] exp_A;
wire [DATA_W - 9         : 0] mant_A;      
wire                          is_op_val_A;
wire [1                  : 0] is_NAN_A;
wire                          is_INF_A;
wire                          is_ZERO_A;
wire [1                  : 0] denorm_AB;

wire [7                  : 0] exp_B;
wire [DATA_W - 9         : 0] mant_B;    
wire                          is_op_val_B;
wire [1                  : 0] is_NAN_B;
wire                          is_INF_B;
wire                          is_ZERO_B;

wire                          MUL;
wire                          INV_S;
wire                          ABS_W;
wire                          IDLE;

wire                          res_sign;                    
wire                          res_val;                   
wire [1                  : 0] res_NANs;                   
wire                          res_INF;                   
wire                          res_ZERO;

wire [9                  : 0] exp_res;      

wire [7                  : 0] denorm_shift;
wire                          prev_inf;
wire                          prev_overflow;
wire [2*(DATA_W - 8) - 1 : 0] prev_mant_res;

wire [2*(DATA_W - 8) - 1 : 0] mant_norm;
wire [7                  : 0] leading_zero_num;
wire                          exp_incr;
wire                          not_full_norm;

wire [22                 : 0] mant_rounded;
wire                          mant_overfl;

wire [7                  : 0] exp_fin;
wire [1                  : 0] exp_change_pose;

reg [DATA_W - 9          : 0] mant_A_1ST;
reg [DATA_W - 9          : 0] mant_B_1ST;
reg [9                   : 0] exp_res_1ST;
reg [5                   : 0] prev_res_1ST;
reg [1                   : 0] rounding_mode_1ST;
reg [1                   : 0] op_NAN_1ST;
reg [1                   : 0] denorm_AB_1ST;

reg [7                   : 0] exp_res_2ST;
reg [5                   : 0] prev_res_2ST;
reg [1                   : 0] rounding_mode_2ST;
reg [7                   : 0] denorm_shift_2ST;
reg [1                   : 0] exp_condition_2ST;
reg [2*(DATA_W - 8) - 1  : 0] prev_mant_res_2ST;
reg [1                   : 0] op_NAN_2ST;
reg [1                   : 0] denorm_AB_2ST;


operand_analyzer
#(
        .DATA_W         (DATA_W      )
) operand_A
(
        .digit          (op1         ),
        .exp            (exp_A       ),
        .mant           (mant_A      ),
        .op_val         (is_op_val_A ),
        .NANs           (is_NAN_A    ),
        .INF            (is_INF_A    ),
        .ZERO           (is_ZERO_A   ),
        .DENORM         (denorm_AB[1])

);



operand_analyzer
#(
        .DATA_W         (DATA_W      )
) operand_B
(
        .digit          (op2         ),
        .exp            (exp_B       ),
        .mant           (mant_B      ),
        .op_val         (is_op_val_B ),
        .NANs           (is_NAN_B    ),
        .INF            (is_INF_B    ),
        .ZERO           (is_ZERO_B   ),
        .DENORM         (denorm_AB[0])

);


operation_analyzer
#(
        .OPERATION_NUM  (OPERATION_NUM)
) operation_analyzer
(
        .operation      (opc          ),
        .MUL            (MUL          ),
        .INV_S          (INV_S        ),
        .ABS_W          (ABS_W        ),
        .IDLE           (IDLE         )
);



prev_res prev_res
(
        .operand_A_sign         (op1[DATA_W - 1]),
        .operand_A_val          (is_op_val_A    ),
        .operand_A_NAN          (is_NAN_A       ),
        .operand_A_INF          (is_INF_A       ),
        .operand_A_ZERO         (is_ZERO_A      ),
        .operand_B_sign         (op2[DATA_W - 1]),
        .operand_B_val          (is_op_val_B    ),
        .operand_B_NAN          (is_NAN_B       ),
        .operand_B_INF          (is_INF_B       ),
        .operand_B_ZERO         (is_ZERO_B      ),
        .MUL                    (MUL            ),
        .INV_S                  (INV_S          ),
        .ABS_W                  (ABS_W          ),
        .IDLE                   (IDLE           ),
        .res_sign               (res_sign       ),
        .res_val                (res_val        ),
        .res_NANs               (res_NANs       ),
        .res_INF                (res_INF        ),
        .res_ZERO               (res_ZERO       )
);



exp_sum exp_sum
(
        .exp_A          (exp_A     ),
        .exp_B          (exp_B     ),
        .denorm_AB      (denorm_AB ),
        .exp_res        (exp_res   )
);



always @(posedge clk) begin
        mant_A_1ST        <= mant_A;

        mant_B_1ST        <= mant_B;

        exp_res_1ST       <= exp_res;

        prev_res_1ST      <= {res_sign, res_val, res_NANs, res_INF, res_ZERO};

        rounding_mode_1ST <= r_mode;

        op_NAN_1ST        <= {|is_NAN_A, |is_NAN_B};

        denorm_AB_1ST     <= denorm_AB;
end



exp_sum_analiz exp_sum_analiz
(
        .exp_res_tmp            (exp_res_1ST  ),
        .denorm_shift           (denorm_shift ),
        .prev_inf               (prev_inf     ),
        .prev_overflow          (prev_overflow)
);



mant_mul
#(
        .DATA_W         (DATA_W       )
) mant_mul
(
        .mant_A         (mant_A_1ST   ),
        .mant_B         (mant_B_1ST   ),
        .op_NAN         (op_NAN_1ST   ),
        .prev_mant_res  (prev_mant_res)
);




always @(posedge clk) begin
        exp_res_2ST       <= exp_res_1ST[7:0];

        prev_res_2ST      <= prev_res_1ST;

        rounding_mode_2ST <= rounding_mode_1ST;

        denorm_shift_2ST  <= denorm_shift;

        exp_condition_2ST <= {prev_inf, prev_overflow};

        prev_mant_res_2ST <= prev_mant_res;

        op_NAN_2ST        <= op_NAN_1ST;

        denorm_AB_2ST     <= denorm_AB_1ST;
end


normalization_module
#(
        .MANT_W                 (2*(DATA_W - 8)   )
) normalization_module
(
        .vector                 (prev_mant_res_2ST),
        .exp_condition          (exp_condition_2ST),
        .denorm_shift           (denorm_shift_2ST ),
        .exp_res_tmp            (exp_res_2ST      ),
        .denorm_AB              (denorm_AB_2ST    ),
        .op_NAN                 (op_NAN_2ST       ),
        .out                    (mant_norm        ),
        .leading_zero_num       (leading_zero_num ),
        .exp_incr               (exp_incr         )
);


rounding_module
#(
        .MANT_W                 (2*(DATA_W - 8)   )
) rounding_module
(
        .sign_bit               (prev_res_2ST[5]  ),
        .rouding_mode           (rounding_mode_2ST),
        .op_NAN                 (op_NAN_2ST       ),
        .data                   (mant_norm        ),
        .mant                   (mant_rounded     ),
        .mant_overfl            (mant_overfl      )
);




exp_res_form
#(
        .DATA_W                 (DATA_W             )
) exp_res_form
(
        .exp_res_tmp            (exp_res_2ST        ),
        .prev_res               (prev_res_2ST[3 : 0]),
        .denorm_shift           (denorm_shift_2ST   ),
        .exp_condition          (exp_condition_2ST  ),
        .leading_zero_num       (leading_zero_num   ),
        .exp_incr               (exp_incr           ),
        .denorm_AB              (denorm_AB_2ST      ),
        .exp_fin                (exp_fin            )
);


assign result = {32{|prev_res_2ST[3 : 2]}} & {prev_res_2ST[3], exp_fin, mant_rounded              } |
                                             {prev_res_2ST[5], exp_fin + mant_overfl, mant_rounded} ;
assign val    =  prev_res_2ST[4];

endmodule