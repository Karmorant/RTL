module generator
#(
        parameter delay = 2
)
(
        input  wire clk,
        input  wire reset,
        output wire OUT
);

reg [$clog2(delay):0] counter;


always @(posedge clk) begin
        if (reset) begin
                counter <= 0;
        end
        else begin
                if (counter == delay - 1) begin
                        counter <= 0;
                end
                else counter <= counter + 1;
        end
end
assign OUT = (counter == delay - 1) ? 1 : 0;

endmodule