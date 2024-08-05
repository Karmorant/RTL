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
        output wire [31                        : 0] result,
        output wire                                 val


);


wire [DATA_W - 1 : 0] out_A;                 //send to reg(mant)
wire                  is_op_val_A;
wire                  is_NAN_A;
wire                  is_INF_A;
wire                  is_ZERO_A;

operand_analyzer
#(
        .DATA_W(DATA_W)
) operand_A
(
        .digit(op1),
        .out_digit(out_A),
        .op_val(is_op_val_A),
        .NAN(is_NAN_A),
        .INF(is_INF_A),
        .ZERO(is_ZERO_A)

);


wire [DATA_W - 1 : 0] out_B;                   //send to reg(mant)
wire                  is_op_val_B;
wire                  is_NAN_B;
wire                  is_INF_B;
wire                  is_ZERO_B;

operand_analyzer
#(
        .DATA_W(DATA_W)
) operand_B
(
        .digit(op2),
        .out_digit(out_B),
        .op_val(is_op_val_B),
        .NAN(is_NAN_B),
        .INF(is_INF_B),
        .ZERO(is_ZERO_B)

);


wire MUL;
wire INV_S;
wire ABS_W;
wire IDLE;

operation_analyzer
#(
        .OPERATION_NUM(OPERATION_NUM)
) operation_analyzer
(
        .operation(opc),
        .MUL(MUL),
        .INV_S(INV_S),
        .ABS_W(ABS_W),
        .IDLE(IDLE)
);


wire res_sign;                  //semd to reg  
wire res_val;                   //semd to reg
wire res_NAN;                   //semd to reg
wire res_INF;                   //semd to reg
wire res_ZERO;                  //semd to reg 

prev_res pre_vres
(
        .operand_A_sign(out_A[DATA_W - 1]),
        .operand_A_val(is_op_val_A),
        .operand_A_NAN(is_NAN_A),
        .operand_A_INF(is_INF_A),
        .operand_A_ZERO(is_ZERO_A),
        .operand_B_sign(out_B[DATA_W - 1]),
        .operand_B_val(is_op_val_B),
        .operand_B_NAN(is_NAN_B),
        .operand_B_INF(is_INF_B),
        .operand_B_ZERO(is_ZERO_B),
        .MUL(MUL),
        .INV_S(INV_S),
        .ABS_W(ABS_W),
        .IDLE(IDLE),
        .res_sign(res_sign),
        .res_val(res_val),
        .res_NAN(res_NAN),
        .res_INF(res_INF),
        .res_ZERO(res_ZERO)
);


wire [7:0] exp_res;                     //send to reg
wire [1:0] flow_bits;                   //send to reg
wire [1:0] exp_degree;                  //send to reg

exp_sum exp_sum
(
        .exp_A(out_A[DATA_W - 1 - 1 : DATA_W - 1 - 8]),
        .exp_B(out_B[DATA_W - 1 - 1 : DATA_W - 1 - 8]),
        .exp_res(exp_res),
        .flow_bits(flow_bits),
        .exp_degree(exp_degree)
);


reg [62:0] first_stage;

always @(posedge clk) begin
        first_stage[62:40] <= out_A;
        first_stage[39:17] <= out_B;
        first_stage[16:12] <= {res_sign, res_val, res_NAN, res_INF, res_ZERO};
        first_stage[11:0 ] <= {flow_bits, exp_degree, exp_res};
end




endmodule