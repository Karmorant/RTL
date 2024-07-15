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
        output reg  [DATA_W - 1:0] data_out,
        output reg  val,
        output reg  full
);

reg [LIFO_SIZE      -1:0] buffer [DATA_W - 1:0];
reg [$clog2(LIFO_SIZE):0] buffer_level;
integer i;



always @ (posedge clk or posedge reset) begin
        if (reset) begin
                for (i = 0; i < LIFO_SIZE; i = i + 1) begin
                        buffer[i] <= 0;
                end
                buffer_level <= 0;
                full <= 0;
                val <= 1;
        end
        else if (read & !full & !write) begin
                if (buffer_level == 0)  begin
                        val <= 0;
                        end
                else begin
                        buffer_level <= buffer_level - 1;
                        data_out <= buffer[buffer_level - 1];
                end
        end
        else if (write & !full & !read) begin
                val <= 1;
                buffer[buffer_level] <= data_in;
                buffer_level <= buffer_level + 1;
                if (buffer_level + 1 == LIFO_SIZE) begin
                        full <= 1;
                        val <= 0;
                end
        end
        else if (write & read & !full) begin
                val <= 1;
                data_out <= data_in;
        end
        else if (read & full & !write) begin
                buffer_level <= buffer_level - 1;
                data_out <= buffer[buffer_level - 1];
                full <= 0;
                val <= 1;
        end
        else if (write & full) begin
                data_out <= data_in;
        end
 
end
endmodule