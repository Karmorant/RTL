module is_div_3
#(
        parameter SIZE = 8
)
(
        input  wire [SIZE - 1         : 0] digit,
        output wire [$clog2(SIZE) - 1 : 0] out
);



wire [$clog2(SIZE) - 1:0] counter [SIZE : 0];
//wire [$clog2(SIZE) - 1:0] counter[SIZE/2 - 1:0];

 
genvar i;
generate for(i = 0; i < SIZE; i = i + 2)
begin: loop_1
        if (i == 0) assign counter[i] = digit[i];
        else assign counter[i] = counter[i - 2] + digit[i];
end
endgenerate
 
genvar g;
generate for(g = 1; g < SIZE; g = g + 2)
begin: loop_2
        if (g == 1) assign counter[g] = digit[g];
        else assign counter[g] = counter[g - 2] + digit[g];
end
endgenerate

assign out =    (counter[SIZE - 1] > counter[SIZE - 2]) ? counter[SIZE - 1] - counter[SIZE - 2] :
                counter[SIZE - 2] - counter[SIZE - 1];
endmodule