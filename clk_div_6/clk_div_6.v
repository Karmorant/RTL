module clk_div_6(
        input  wire clk,
        input  wire reset,
        output wire clk_div_6
);
reg [2:0] counter;




always @(posedge clk) begin
        if (reset) begin
                counter <= 0;
                
        end
        else begin
                if (counter == 5) begin
                        counter <= 0;
                end
                else counter <= counter + 1;
                
        end
end

assign clk_div_6 =      {(counter == 3'b000)} & 1 | 
                        {(counter == 3'b001)} & 1 |
                        {(counter == 3'b010)} & 1 ;
endmodule