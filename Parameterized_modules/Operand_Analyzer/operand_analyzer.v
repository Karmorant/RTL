module operand_analyzer
#(
        parameter DATA_W = 64
)
(
        input  wire [DATA_W - 1 : 0] digit,
        output wire [7          : 0] exp,
        output wire [DATA_W - 9 : 0] mant,
        output wire                  op_val,
        output wire [1          : 0] NANs,
        output wire                  INF,
        output wire                  ZERO,
        output wire                  DENORM
);

wire NAN;
wire qNAN;
wire sNAN;

assign op_val    = ~(NAN | INF);



assign exp       =           digit[DATA_W - 2     : DATA_W - 2 - 7];
assign mant      = {~DENORM, digit[DATA_W - 1 - 9 : 0             ]};


assign DENORM = ~(|exp) &  (|mant);
assign NAN    =   &exp  &   |mant ;
assign INF    =   &exp  & ~(|mant);
assign ZERO   = ~(|exp) & ~(|mant);

assign {qNAN, sNAN} = {2{NAN &  mant[DATA_W - 9]}} & 2'b10 |
                      {2{NAN & ~mant[DATA_W - 9]}} & 2'b01 |
                                                     2'b00 ;

assign NANs = {qNAN, sNAN};

endmodule