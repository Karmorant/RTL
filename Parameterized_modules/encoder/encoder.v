module encoder
#(
        parameter IN_SIZE  = 8,
        parameter OUT_SIZE = $clog2(IN_SIZE)
)
(
        input  wire [IN_SIZE  - 1:0] in,
        output wor  [OUT_SIZE - 1:0] pow
);


genvar g;
generate for (g = 0; g < IN_SIZE; g = g + 1)
begin: loop_1
        assign pow = (in[g]) ? g : 0;
end
endgenerate


endmodule