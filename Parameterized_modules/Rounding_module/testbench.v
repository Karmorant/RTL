`timescale 1ns/1ps

module testbench;
reg [31:0] vector;
reg [1:0] rouding_mode;
reg       sign_bit;

rounding_module #(.DATA_W(32)) DUT (
        .data(vector),
        .rouding_mode(rouding_mode),
        .sign_bit(sign_bit)
 );

initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        rouding_mode = 0;
        sign_bit = 0;
        #2;
        repeat (10) begin
                vector = $random;
                #2;
        end

        $finish;
end
endmodule