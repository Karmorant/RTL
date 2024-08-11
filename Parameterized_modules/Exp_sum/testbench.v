`timescale 1ns/1ps


module testbench;

reg [7:0] exp_A;
reg [7:0] exp_B;



exp_sum DUT (
        .exp_A(exp_A),
        .exp_B(exp_B)
);

initial
begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);


        exp_A = 8'b0011_1110;
        exp_B = 8'b0100_0010;  //-61
        
        #2;

        exp_A = 8'b0011_1110;
        exp_B = 8'b0100_0001;  //-62
        
        #2;
        exp_A = 8'b0011_1110;  //-65
        exp_B = 8'b0100_0000;  //-63
        
        #2;

        exp_A = 8'b0011_1110;
        exp_B = 8'b0011_1111;  //-64
        
        #2;

        exp_A = 8'b0011_1110;  //-65
        exp_B = 8'b0010_1010;  //-85
        
        #2;

        exp_A = 8'b0011_1110;  //-65
        exp_B = 8'b0010_1001;  //-86
        
        #2;

        exp_A = 8'b1111_1110;  //127
        exp_B = 8'b1000_0000;  //1
        
        #2;

        exp_A = 8'b1111_1110;  //127
        exp_B = 8'b1111_1110;  //127
        
        #2;

        exp_A = 8'b1100_0010;  //67
        exp_B = 8'b1011_1011;  //60
        
        #2;

        exp_A = 8'b1111_1111;  //inf
        exp_B = 8'b1111_1111;  //inf
        
        #2;

        exp_A = 8'b1111_1101;  //127
        exp_B = 8'b0000_0001;  //-126
        
        #2;
        $finish;
end

endmodule