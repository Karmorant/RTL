module FIFO_buffer
#(
        parameter DATA_W    = 8,
        parameter FIFO_SIZE = 8
)
(
        input  wire                  clk,
        input  wire                  reset,
        input  wire                  write,
        input  wire                  read,
        input  wire [DATA_W - 1 : 0] data_in,
        output wire [DATA_W - 1 : 0] data_out,
        output wire                  val,
        output wire                  full
);

reg [DATA_W            - 1 : 0] buffer [FIFO_SIZE - 1 : 0];
reg [$clog2(FIFO_SIZE) - 1 : 0] read_ptr;
reg [$clog2(FIFO_SIZE) - 1 : 0] write_ptr;
reg [$clog2(FIFO_SIZE)     : 0] counter;

wire read_perm  = read & val;
wire write_perm = write & ~full;
wire rd_wr_perm = read & write & val;

assign val  = (counter !=       'h0);
assign full = (counter == FIFO_SIZE);


always @(posedge clk) begin
        if (reset) 
        counter <= 'h0;
        else begin
                if (full)
                counter <= (rd_wr_perm) ? counter        :
                           (read      ) ? counter - 1'b1 : counter;
                else 
                counter <= (rd_wr_perm) ? counter        :
                           (write     ) ? counter + 1'b1 :
                           (read_perm ) ? counter - 1'b1 : counter; 
                           
        end     
end

always @(posedge clk) begin
        if (reset)
        read_ptr <= 0;
        else begin
                if (read_perm)
                read_ptr <= (read_ptr == FIFO_SIZE - 1) ? 'h0 : read_ptr + 1'b1;
                else if (rd_wr_perm) begin
                        read_ptr <= (read_ptr == write_ptr) ? read_ptr : read_ptr + 1'b1;
                end 
        end
end

always @(posedge clk) begin
        if (reset)
        write_ptr <= 0;
        else begin
                if (write_perm)
                write_ptr <= (write_ptr == FIFO_SIZE - 1) ? 'h0 : write_ptr + 1'b1;
                else if (rd_wr_perm) begin
                        write_ptr <= (read_ptr == write_ptr) ? write_ptr : write_ptr + 1'b1;
                end 
        end
end

always @(posedge clk) begin
        if (write_perm) begin
                buffer[write_ptr] <= data_in;
        end
end

assign data_out = buffer[read_ptr];
endmodule