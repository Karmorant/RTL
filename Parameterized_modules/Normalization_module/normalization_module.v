module normalization_module
#(
        parameter DATA_W = 8
)
(
        input  wire [DATA_W - 1 : 0] vector,
        output wire [DATA_W - 1 : 0] out
);

wire [$clog2(DATA_W): 0] counter;

leading_zero_counter 
#(
        .DATA_W(DATA_W)
) leading_zero_counter_1
(
        .vector(vector),
        .zero_num(counter)
);


assign out = vector << counter;

endmodule