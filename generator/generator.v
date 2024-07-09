module generator(
        input  wire clk,
        input  wire reset,
        output reg OUT
);

reg [2:0] counter;


always @(posedge clk) begin
        if (reset) begin
                counter <= 0;
                OUT <= 0;
        end
        else begin
                if (counter == 4) begin
                        counter <= 0;
                        OUT <= 1;
                end
                else begin
                        counter <= counter + 1;
                        OUT <= 0;
                end
        end
end


endmodule