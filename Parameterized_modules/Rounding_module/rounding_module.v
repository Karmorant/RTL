module rounding_module
#(
        parameter DATA_W = 32
)
(
        input  wire                  sign_bit, 
        input  wire [1          : 0] rouding_mode,
        input  wire [DATA_W - 1 : 0] data,
        output wire [22         : 0] mant,
        output wire                  mant_overfl 
);

wire guard_bit    =  data[DATA_W - 1 - 22       ];
wire rounding_bit =  data[DATA_W - 1 - 22 -1    ];
wire sticky_bit   = |data[DATA_W - 1 - 22 -2 : 0];
wire mant_incr    = rounding_bit & (guard_bit | sticky_bit); 




assign mant_overfl =    (&data[DATA_W - 1 : DATA_W - 1 - 22]) & mant_incr;

assign mant        =    (mant_overfl          ) ? 23'b0                                          :
                        {23{rouding_mode == 1}} & data[DATA_W - 1 : DATA_W - 1 - 22]             |
                        {23{rouding_mode == 2}} & data[DATA_W - 1 : DATA_W - 1 - 22] + ~sign_bit |
                        {23{rouding_mode == 3}} & data[DATA_W - 1 : DATA_W - 1 - 22] + sign_bit  |
                        {23{rouding_mode == 0}} & data[DATA_W - 1 : DATA_W - 1 - 22] + mant_incr ;
endmodule