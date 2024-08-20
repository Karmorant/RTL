module operation_analyzer
#(
        parameter OPERATION_NUM = 4
)
(
        input  wire [$clog2(OPERATION_NUM) - 1 : 0] operation,
        output wire                                 MUL,
        output wire                                 INV_S,
        output wire                                 ABS_W,
        output wire                                 IDLE
);

assign {IDLE, ABS_W, INV_S, MUL} = {OPERATION_NUM{operation == 0}} & 4'b0001 |
                                   {OPERATION_NUM{operation == 1}} & 4'b0010 |
                                   {OPERATION_NUM{operation == 2}} & 4'b0100 |
                                   {OPERATION_NUM{operation >= 3}} & 4'b1000 ;

endmodule