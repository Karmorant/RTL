module operand_analyzer
#(
        parameter DATA_W = 64
)
(
        input  wire [DATA_W - 1 : 0] digit,
        output wire [DATA_W - 1 : 0] out_digit,
        output wire                  op_val,
        output wire                  NAN,
        output wire                  INF,
        output wire                  ZERO
);


wire [7  : 0] exp;
wire [DATA_W - 1 - 9 : 0] mant;


assign out_digit = digit;
assign exp       = digit[DATA_W - 2     : DATA_W - 2 - 7];
assign mant      = digit[DATA_W - 1 - 9 :              0];

assign op_val    = ~(NAN | INF);

assign NAN  =   &exp  &   |mant;
assign INF  =   &exp  & ~(|mant);
assign ZERO = ~(|exp) & ~(|mant);

endmodule