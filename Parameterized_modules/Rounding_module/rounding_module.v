module rounding_module
#(
        parameter MANT_W = 24
)
(
        input  wire                  sign_bit, 
        input  wire [1          : 0] rouding_mode,
        input  wire [MANT_W - 1 : 0] data,
        output wire [23         : 0] mant,
        output wire                  mant_overfl 
);

wire guard_bit    =  data[MANT_W - 1 - 23       ];
wire rounding_bit =  data[MANT_W - 1 - 23 -1    ];
wire sticky_bit   = |data[MANT_W - 1 - 23 -2 : 0];
wire mant_incr    = rounding_bit & (guard_bit | sticky_bit); 




assign mant_overfl =    (&data[MANT_W - 1 : MANT_W - 1 - 23]) & mant_incr;

assign mant        =    (mant_overfl          ) ? {1'b1, 23'b0}                                  :
                        {24{rouding_mode == 1}} & data[MANT_W - 1 : MANT_W - 1 - 23]             |
                        {24{rouding_mode == 2}} & data[MANT_W - 1 : MANT_W - 1 - 23] + ~sign_bit |
                        {24{rouding_mode == 3}} & data[MANT_W - 1 : MANT_W - 1 - 23] + sign_bit  |
                        {24{rouding_mode == 0}} & data[MANT_W - 1 : MANT_W - 1 - 23] + mant_incr ;
endmodule