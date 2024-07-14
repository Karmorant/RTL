module generator(
        input  wire clk,
        input  wire reset,
        output wire OUT
);

reg [2:0] counter;


always @(posedge clk) begin
        if (reset) begin
                counter <= 0;
        end
        else begin
                if (counter == 4) begin
                        counter <= 0;
                end
                else counter <= counter + 1;
        end
end
assign OUT = (counter == 4) ? 1 : 0;

endmodule