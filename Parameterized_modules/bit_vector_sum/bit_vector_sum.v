module bit_vector_sum
#(
        parameter DATA_W = 8,
        parameter POS_W  = $clog2(DATA_W)
)
(
        input  wire [DATA_W - 1:0] data,
        output wire [POS_W     :0] sum
);




function [POS_W:0] bit_sum;
        input [DATA_W - 1:0] data_in;
        integer i;
        begin
                bit_sum = 0;
                for (i = 0; i < DATA_W; i = i + 1) begin
                        bit_sum = bit_sum + data_in[i];
                end
        end
endfunction

assign sum = bit_sum(data);

endmodule