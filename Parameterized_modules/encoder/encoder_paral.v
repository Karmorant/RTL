module encoder_paral
#(
        parameter IN_SIZE  = 8,
        parameter OUT_SIZE = $clog2(IN_SIZE)
)
(
        input  wire [IN_SIZE  - 1:0] in,
        output wire  [OUT_SIZE - 1:0] pow
);

wire [OUT_SIZE - 1:0] tmp [IN_SIZE:0];


genvar g;
generate for (g = 0; g < IN_SIZE + 1; g = g + 1)
begin: loop_1
        if (g == 0) assign tmp[g] = 'h0;
        else assign tmp[g] = {OUT_SIZE{in[g - 1]}} & (g - 1) | tmp[g - 1];
end
endgenerate


assign pow = tmp[IN_SIZE];

endmodule