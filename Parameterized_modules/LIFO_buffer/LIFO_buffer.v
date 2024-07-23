module LIFO_buffer
#(      parameter LIFO_SIZE = 8, 
        parameter DATA_W    = 8
)
(
        input  wire clk,
        input  wire reset,
        input  wire write,
        input  wire read,
        input  wire [DATA_W - 1:0] data_in,
        output wire [DATA_W - 1:0] data_out,
        output wire val,
        output wire full
);

reg [DATA_W         -1:0] buffer [LIFO_SIZE - 1:0];
reg [$clog2(LIFO_SIZE):0] buffer_level;

always @ (posedge clk or posedge reset) begin
        if (reset) begin
                buffer_level <= 0;
        end
        else if (read & !full & !write & val) begin
                        buffer_level <= buffer_level - 1;
                end
        else if (write & !full & !read) begin
                buffer[buffer_level] <= data_in;
                buffer_level <= buffer_level + 1;
        end
        else if(write & read & !full) begin
                if (val) buffer[buffer_level - 1] <= data_in;
                else begin
                        buffer[buffer_level] <= data_in;
                        buffer_level <= buffer_level + 1;
                end
        end
        else if (read & full & !write) begin
                buffer_level <= buffer_level - 1;
        end
        else if (write & full & val & read) begin
                buffer_level <= buffer_level;
                buffer[buffer_level - 1] = data_in;
        end
end

assign full = (buffer_level == LIFO_SIZE);

assign val = (buffer_level != 0);

assign data_out =  buffer[buffer_level - 1]; 
endmodule