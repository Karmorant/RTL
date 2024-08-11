module operand_analyzer
#(
        parameter DATA_W = 64
)
(
        input  wire [DATA_W - 1 : 0] digit,
        output wire [7          : 0] exp,
        output wire [DATA_W - 9 : 0] mant,
        output wire                  op_val,
        output wire                  NAN,
        output wire                  INF,
        output wire                  ZERO
);

assign op_val    = ~(NAN | INF);



assign exp       =           digit[DATA_W - 2     : DATA_W - 2 - 7];
assign mant      = {~DENORM, digit[DATA_W - 1 - 9 : 0             ]};


assign DENORM = ~(|exp) &  (|mant);
assign NAN    =   &exp  &   |mant ;
assign INF    =   &exp  & ~(|mant);
assign ZERO   = ~(|exp) & ~(|mant);

endmodule