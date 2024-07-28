module rounding_module
#(
        parameter DATA_W = 30
)
(
        input  wire [1          : 0] rouding_mode,
        input  wire [DATA_W - 1 : 0] data,
        output wire [22         : 0] mant
);


wire rounding_bit = data[DATA_W-1-31];
wire sticky_bit   = (DATA_W > 32) ? | data[DATA_W-1-1-31 : 0] : 0;

assign mant =   (rouding_mode == 1                               ) ? data[DATA_W-1-9 : DATA_W-1-31]        :  // rounding to 0
                (rouding_mode == 2 && !data[DATA_W - 1]          ) ? data[DATA_W-1-9 : DATA_W-1-31] + 1'b1 :  // rounding to +INF(+)
                (rouding_mode == 2 &&  data[DATA_W - 1]          ) ? data[DATA_W-1-9 : DATA_W-1-31]        :  // rounding to +INF(-)
                (rouding_mode == 3 &&  data[DATA_W - 1]          ) ? data[DATA_W-1-9 : DATA_W-1-31] + 1'b1 :  // rounding to -INF(+)
                (rouding_mode == 3 && !data[DATA_W - 1]          ) ? data[DATA_W-1-9 : DATA_W-1-31]        :  // rounding to -INF(-)
                (rouding_mode == 0 &&  rounding_bit && sticky_bit) ? data[DATA_W-1-9 : DATA_W-1-31] + 1'b1 :  // rounding to nearest even
                                                                     data[DATA_W-1-9 : DATA_W-1-31];


endmodule