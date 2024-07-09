module clk_div_6(
        input  wire clk,
        input  wire reset,
        output reg  clk_div_6
);
reg [2:0] counter;




always @(posedge clk) begin
        if (reset) begin
                counter <= 0;
                clk_div_6 <= 1'b0;
                
        end
        else begin
                if (counter == 2) begin
                        counter <= 0;
                        clk_div_6 <= ~clk_div_6;
                end
                else counter <= counter + 1;
                
        end
end
endmodule