module rez_former
(
        input  wire          res_sign,
        input  wire [7 :  0] exp_fin,
        input  wire [7 :  0] mant_shift,
        input  wire [23 : 0] mant,
        output wire [31 : 0] res 
);

wire [23 : 0] prev_mant;
assign prev_mant = mant >> mant_shift;


assign res = {res_sign, exp_fin, prev_mant[22:0]};

endmodule