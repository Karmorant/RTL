module rounding_module
#(
        parameter MANT_W = 48
)
(
        input  wire                  sign_bit, 
        input  wire [1          : 0] rouding_mode,
        input  wire [MANT_W - 1 : 0] data,
        input  wire [1          : 0] op_NAN,
        output wire [22         : 0] mant,
        output wire                  mant_overfl 
);

wire rounding_bit =  data[MANT_W - 1 - 23       ];
wire guard_bit    =  data[MANT_W - 1 - 23 -1    ];
wire sticky_bit   = |data[MANT_W - 1 - 23 -2 : 0];
wire mant_incr    = guard_bit & (rounding_bit | sticky_bit); 




assign mant_overfl =    (&data[MANT_W - 2 : MANT_W - 1 - 23]) & mant_incr;

assign mant        =    (op_NAN               ) ? {1'b1, data[MANT_W - 2 : MANT_W - 1 - 22]}     :  
                        (mant_overfl          ) ? {1'b1, 23'b0}                                  :
                        {24{rouding_mode == 1}} & data[MANT_W - 2 : MANT_W - 1 - 23]             |
                        {24{rouding_mode == 2}} & data[MANT_W - 2 : MANT_W - 1 - 23] + ~sign_bit |
                        {24{rouding_mode == 3}} & data[MANT_W - 2 : MANT_W - 1 - 23] + sign_bit  |
                        {24{rouding_mode == 0}} & data[MANT_W - 2 : MANT_W - 1 - 23] + mant_incr ;
endmodule