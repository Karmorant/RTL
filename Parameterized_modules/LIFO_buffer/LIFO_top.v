`timescale 1ns/1ns
`define DATAW   16
`define LIFO_S  6

module top();

reg clk, reset;

always #1 clk = ~clk;

initial begin
	clk = 0;
	reset = 0;
	@(posedge clk)
	reset <= 1;
	repeat(3) @(negedge clk);
	reset <= 0;
end

reg [`DATAW-1:0]    datain;
wire[`DATAW-1:0]    dataout;
wire[`DATAW-1:0]    dataout_eth;

reg                 write, read;
wire                val, full;
wire                val_eth, full_eth;

LIFO_buffer
#(
    .DATA_W     (`DATAW),
    .LIFO_SIZE  (`LIFO_S)
)   LIFO_1
(
    .clk        (clk),
    .reset      (reset),
    .write      (write),
    .read       (read),
    .data_in     (datain),
    .data_out    (dataout),
    .val        (val),
    .full       (full)
);

always @(posedge clk)
begin
    datain  <=  $random;
    write   <=  $random%2;
    read    <=  $random%2;
end

LIFO_eth
#(
    .DATA_W     (`DATAW),
    .LIFO_SIZE  (`LIFO_S)
)   LIFO_2
(
    .clk        (clk),
    .reset      (reset),
    .write      (write),
    .read       (read),
    .data_in     (datain),
    .data_out    (dataout_eth),
    .val        (val_eth),
    .full       (full_eth)
);

always @(negedge clk)
begin
    if(val_eth != val)
    begin
        $display ("Error VAL");
        $stop();
    end
    else if (full_eth != full)
    begin
        $display ("Error FULL");
        $stop();
    end else if ( (dataout_eth != dataout) & val)
    begin
        $display ("Error DATA");
        $stop();
    end
end

initial
begin
    $dumpfile("out.vcd");
    $dumpvars(0, top);
    #1000000
    $display ("SUCCESS");
    $finish();
end

endmodule
