module prev_res
(
        input  wire operand_A_sign,
        input  wire operand_A_val,
        input  wire operand_A_NAN,
        input  wire operand_A_INF,
        input  wire operand_A_ZERO,
        input  wire operand_B_sign,
        input  wire operand_B_val,
        input  wire operand_B_NAN,
        input  wire operand_B_INF,
        input  wire operand_B_ZERO,
        input  wire MUL,
        input  wire INV_S,
        input  wire ABS_W,
        input  wire IDLE,
        output wire res_sign,
        output wire res_val,
        output wire res_NAN,
        output wire res_INF,
        output wire res_ZERO
);

assign res_val = ~IDLE;


assign res_sign = {MUL  } &   operand_A_sign ^ operand_B_sign  |
                  {INV_S} & ~(operand_A_sign ^ operand_B_sign) |
                  {ABS_W} &   1'b0                             ;


assign res_NAN = (operand_A_NAN  || operand_B_NAN  ||
                  operand_A_ZERO && operand_B_INF  ||
                  operand_A_INF  && operand_B_ZERO);

assign res_INF = (operand_A_INF  && operand_B_INF ||
                  operand_A_INF  && operand_B_val ||
                  operand_A_val  && operand_B_INF );

assign res_zero = (operand_A_ZERO && operand_B_ZERO ||
                   operand_A_ZERO && operand_B_val  ||
                   operand_A_val  && operand_B_ZERO);


endmodule