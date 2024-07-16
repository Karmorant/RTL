module bit_vector_sum
#(
        parameter DATA_W = 8,
        parameter POS_W  = $clog2(DATA_W)
)
(
        input  wire [DATA_W - 1:0] data,
        output wire [POS_W     :0] sum
);

wire [POS_W:0] tmp [DATA_W:0];


genvar i;
generate for (i = 0; i <= DATA_W; i = i + 1)
begin: loop_1
        if (i == 0) assign tmp[i] = 'h0;
        else begin
                assign tmp[i] = (data[i - 1]) ? (tmp[i - 1] + 'h1) : tmp[i - 1];
        end
end
endgenerate

assign sum = tmp[DATA_W];

endmodule