module master
#(
        parameter PACK_SIZE = 8,
        parameter MARK_SIZE = 8,
        parameter BUFF_SIZE = 8
)
(
        input  wire                     clk,
        input  wire                     reset,
        input  wire                     write,
        input  wire                     ready,
        input  wire [1             : 0] marker_pos,
        input  wire [PACK_SIZE - 1 : 0] buffer_in,
        output wire                     valid,
        output wire [PACK_SIZE - 1 : 0] data_out,
        output wire                     last
);


reg  [$clog2(BUFF_SIZE)               : 0] counter;
reg  [$clog2(MARK_SIZE/PACK_SIZE) + 1 : 0] transmit;
reg                                        read;
wire [MARK_SIZE                   - 1 : 0] marker;
wire [PACK_SIZE                   - 1 : 0] data;
wire                                       handshake;
wire                                       val;

assign valid     = ~reset & val | ((marker_pos == 2'b10) & val                    |
                                   (marker_pos == 2'b01) & (transmit + 1'b1 == 1) );
assign handshake = valid & ready;
assign marker    = {MARK_SIZE{1'b1}};


FIFO_buffer
#(      .DATA_W         (PACK_SIZE),
        .FIFO_SIZE      (BUFF_SIZE)
) FIFO
(
        .clk            (clk      ),
        .reset          (reset    ),
        .write          (write    ),
        .read           (read     ),
        .data_in        (buffer_in),
        .data_out       (data     ),
        .val            (val      )

);


assign last = (counter == BUFF_SIZE - 1);


assign data_out =   {PACK_SIZE{marker_pos == 2'b00                                     }} & data   |
                    {PACK_SIZE{marker_pos == 2'b01 && transmit == (MARK_SIZE/PACK_SIZE)}} & marker |
                    {PACK_SIZE{marker_pos == 2'b01 && transmit != (MARK_SIZE/PACK_SIZE)}} & data   |
                    {PACK_SIZE{marker_pos == 2'b10 && transmit == 0                    }} & marker |
                    {PACK_SIZE{marker_pos == 2'b10 && transmit != 0                    }} & data   ;


always @(posedge clk) begin
        transmit <= (reset                     ) ? {($clog2(MARK_SIZE/PACK_SIZE) + 2){marker_pos == 2'b00                       }} & 0*(MARK_SIZE/PACK_SIZE) |
                                                   {($clog2(MARK_SIZE/PACK_SIZE) + 2){marker_pos == 2'b01 || marker_pos == 2'b10}} & 1*(MARK_SIZE/PACK_SIZE) :
                    (handshake && transmit     ) ? transmit - 1                                                                                              :
                    (handshake && transmit == 0) ? {($clog2(MARK_SIZE/PACK_SIZE) + 2){marker_pos == 2'b00                       }} & 0*(MARK_SIZE/PACK_SIZE) |
                                                   {($clog2(MARK_SIZE/PACK_SIZE) + 2){marker_pos == 2'b01 || marker_pos == 2'b10}} & 1*(MARK_SIZE/PACK_SIZE) :
                                                   transmit                                                                                                  ;

end

always @(posedge clk) begin
        counter <= (reset                     ) ? 'b0            :
                   (counter == BUFF_SIZE - 1  ) ? 'b0            :
                   (handshake && transmit == 0) ? counter + 1'b1 :
                                                  counter        ;

end


always @(posedge clk) begin
        read <= (handshake) ?       {marker_pos == 2'b00                                     }        |
                                    {marker_pos == 2'b01 && transmit != (MARK_SIZE/PACK_SIZE)} & 1'b0 |
                                    {marker_pos == 2'b01 && transmit == (MARK_SIZE/PACK_SIZE)}        |
                                    {marker_pos == 2'b10 && transmit != 0                    } & 1'b0 |
                                    {marker_pos == 2'b10 && transmit == 0                    }        :
                                                                                                 1'b0 ;
end

endmodule