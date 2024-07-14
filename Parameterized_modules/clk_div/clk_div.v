module clk_div
#(
        parameter DIV = 2
)
(
        input  wire clk,
        input  wire reset,
        output wor  clk_div
);
reg [$clog2(DIV) - 1:0] counter;




always @(posedge clk) begin
        if (reset) begin
                counter <= 0;
                
        end
        else begin
                if (counter == DIV - 1) begin
                        counter <= 0;
                end
                else counter <= counter + 1;
                
        end
end

genvar g;

generate for (g = 0; g < DIV / 2; g = g + 1)
begin: loop_1
assign clk_div = (counter == g) ? 1 : 0;
end     
endgenerate

endmodule