module clk_div_6(
        input  wire clk,
        input  wire reset,
        output reg  clk_div_2,
        output reg  clk_div_4,
        output reg  clk_div_6
);
reg [2:0] counter;




always @(posedge clk) begin
        if (reset) begin
                counter <= 0;
                {clk_div_2, clk_div_4, clk_div_6} <= 3'b000;
                
                
        end
        else begin
                if (counter == 5) begin
                        counter <= 0;
                        clk_div_6 <= ~clk_div_6;
                end
                else counter = counter + 1;

                clk_div_2 <= ~clk_div_2;
                clk_div_4 <= (clk_div_2) ? ~clk_div_4 : clk_div_4;
                

        end
end
endmodule