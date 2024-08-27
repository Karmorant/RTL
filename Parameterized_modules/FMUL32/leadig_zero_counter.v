module leading_zero_counter
#(
        parameter DATA_W = 8
)
(
        input  wire [DATA_W - 1        : 0] vector,
        output wire [7                 : 0] zero_num
);

wire [7 : 0] counter [DATA_W - 1 : 0];

genvar i;
generate for (i = 0; i < DATA_W; i = i + 1)
begin: loop
        if (i == 0) begin
                assign counter[i] = (vector[DATA_W - 1] == 1) ? 0 : DATA_W;
        end
        else begin
                assign counter[i] = ((counter[i - 1] == DATA_W) && (vector[DATA_W - 1 - i] == 1)) ? i : counter[i - 1]; 
        end
end
endgenerate

assign zero_num = counter[DATA_W - 1];

endmodule