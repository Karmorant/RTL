module exp_sum
(
        input  wire [7:0] exp_A, 
        input  wire [7:0] exp_B,
        output wire [7:0] exp_res,
        output wire [1:0] flow_bits,
        output wire [1:0] exp_degree
);


wire [9:0] tmp_res;


CSA
#(
        .DATA_W(8)
) exp_CSA
(
        .op_A(exp_A),
        .op_B(exp_B),
        .op_C(8'b10000001),  //127
        .res(tmp_res)
);

assign flow_bits  = tmp_res[9:8];
assign exp_res    = tmp_res[7:0];
assign exp_degree = {exp_A[7], exp_B[7]};

endmodule