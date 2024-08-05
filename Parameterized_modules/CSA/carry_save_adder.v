module CSA
#(
        parameter DATA_W = 8
)
(
        input  wire [DATA_W - 1 : 0] op_A,
        input  wire [DATA_W - 1 : 0] op_B,
        input  wire [DATA_W - 1 : 0] op_C,
        output wire [DATA_W + 1 : 0] res
);

wire [DATA_W - 1 : 0] ps;
wire [DATA_W - 1 : 0] pc;


genvar i;
generate for (i = 0; i < DATA_W; i = i + 1)
begin: loop
        assign ps[i] = op_A[i] ^ op_B[i] ^ op_C[i];
        assign pc[i] = (op_A[i] & op_B[i]) | (op_A[i] & op_C[i]) | (op_B[i] & op_C[i]);
end     
endgenerate

assign res = ps + (pc << 1);


endmodule