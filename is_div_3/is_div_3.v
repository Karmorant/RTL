module is_div_3(
        input  wire [7:0] digit,
        output wire OUT
);

assign OUT =    ({digit[7]^digit[6], digit[5]^digit[4], digit[3]^digit[2], digit[1]^digit[0]} == 4'b0000) ? 1'b1 :
                ({digit[7]^digit[6], digit[5]^digit[4], digit[3]^digit[2], digit[1]^digit[0]} == 4'b0011) ? 1'b1 :
                ({digit[7]^digit[6], digit[5]^digit[4], digit[3]^digit[2], digit[1]^digit[0]} == 4'b0101) ? 1'b1 :
                ({digit[7]^digit[6], digit[5]^digit[4], digit[3]^digit[2], digit[1]^digit[0]} == 4'b0110) ? 1'b1 :
                ({digit[7]^digit[6], digit[5]^digit[4], digit[3]^digit[2], digit[1]^digit[0]} == 4'b0111) ? 1'b1 : 1'b0;


endmodule