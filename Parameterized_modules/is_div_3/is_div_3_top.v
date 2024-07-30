module is_div_3_top
#(
        parameter SIZE = 8
)
(
        input  wire [SIZE - 1:0] digit,
        output wire out
);

wire [$clog2(SIZE) - 1 : 0] res [$clog2(SIZE)/2 - 1 : 0];

genvar i;
generate for (i = 0; i < $clog2(SIZE)/2; i = i + 1)
begin: loop
        if (i == 0) begin        
        is_div_3
        #(
                .SIZE(SIZE)
        ) is_div_3_loop
        (
                .digit(digit),
                .out(res[i])
        );
        end
        else begin
                is_div_3
                #(
                        .SIZE($clog2(SIZE))
                ) is_div_3_loop_2
                (
                        .digit(res[i - 1]),
                        .out(res[i])
                );
        end

end
endgenerate

assign out =    (res[0] == 0 || res[0] == 3  ) ? 1 :
                (res[$clog2(SIZE)/2 - 1] == 0) ? 1 :
                (res[0]                      ) ? 0 : 0;

endmodule
