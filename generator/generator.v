module generator(
        input  wire clk,
        input  wire reset,
        output reg OUT
);

reg [2:0] counter = 3'b000;


always @(posedge clk) begin
        if (reset) begin
                counter <= 0;
                OUT <= 0;
        end
        else begin
                OUT <= 0;
                if (counter == 4) begin
                        counter <= 0;
                        OUT <= 1;
                end
                else counter = counter + 1;
        end
end


endmodule