module exp_sum
(
        input  wire [7:0] exp_A, 
        input  wire [7:0] exp_B,
        output wire [9:0] exp_res
);



assign exp_res = exp_A + exp_B - 127;
 

endmodule