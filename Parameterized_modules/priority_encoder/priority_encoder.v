module priority_encoder
#(
        parameter IN_SIZE  = 8,
        parameter OUT_SIZE = $clog2(IN_SIZE)
)
(
        input  wire [IN_SIZE  - 1:0] in,
        output wor  [OUT_SIZE - 1:0] pow
);

wire [IN_SIZE - 1:0] onehot;
wire [IN_SIZE - 1:0] onehot_rev;
wire [IN_SIZE - 1:0] in_rev;

genvar i;
generate for (i = 0; i < IN_SIZE; i = i + 1)
begin: loop_1
        assign onehot[IN_SIZE - 1 - i] = onehot_rev[i];
        assign in_rev[IN_SIZE - 1 - i] = in[i];
end
endgenerate

assign onehot_rev = in_rev & ~(in_rev - 1);

genvar g;
generate for (g = 0; g < IN_SIZE; g = g + 1)
begin: loop_2
        assign pow = (onehot[g]) ? g : 0;
end
endgenerate


endmodule