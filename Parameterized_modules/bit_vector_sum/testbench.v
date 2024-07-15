`timescale 1ns/1ps




module testbench;
reg [7:0] data;


bit_vector_sum #(.DATA_W(8)) DUT(
        .data(data)
);


initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);

        #10;
        data = 17;
        #10;
        data = 102;
        #10;
        data = 200;
        #10;
        data = 3;
        #10;
        $finish;
end


endmodule