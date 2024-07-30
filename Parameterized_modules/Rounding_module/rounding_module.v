`define ROUNDING_SIFT 32
`define MANT_START 10

module rounding_module
#(
        parameter DATA_W = 30
)
(
        input  wire [1          : 0] rouding_mode,
        input  wire [DATA_W - 1 : 0] data,
        output wire [22         : 0] mant
);


wire rounding_bit = data[DATA_W - `ROUNDING_SIFT];
wire sticky_bit   = (DATA_W > `ROUNDING_SIFT) ? | data[DATA_W-1-`ROUNDING_SIFT : 0] : 0;

assign mant =   (rouding_mode == 1                               ) ? data[DATA_W-`MANT_START : DATA_W-`ROUNDING_SIFT]        :  // rounding to 0
                (rouding_mode == 2 && !data[DATA_W - 1]          ) ? data[DATA_W-`MANT_START : DATA_W-`ROUNDING_SIFT] + 1'b1 :  // rounding to +INF(+)
                (rouding_mode == 2 &&  data[DATA_W - 1]          ) ? data[DATA_W-`MANT_START : DATA_W-`ROUNDING_SIFT]        :  // rounding to +INF(-)
                (rouding_mode == 3 &&  data[DATA_W - 1]          ) ? data[DATA_W-`MANT_START : DATA_W-`ROUNDING_SIFT] + 1'b1 :  // rounding to -INF(+)
                (rouding_mode == 3 && !data[DATA_W - 1]          ) ? data[DATA_W-`MANT_START : DATA_W-`ROUNDING_SIFT]        :  // rounding to -INF(-)
                (rouding_mode == 0 &&  rounding_bit && sticky_bit) ? data[DATA_W-`MANT_START : DATA_W-`ROUNDING_SIFT] + 1'b1 :  // rounding to nearest even
                                                                     data[DATA_W-`MANT_START : DATA_W-`ROUNDING_SIFT];


endmodule