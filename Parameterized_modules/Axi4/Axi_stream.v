module Axi4_stream
#(
        parameter DATA_W = 8,
        parameter LEN = 4
)
(
        input  wire                      clk,
        input  wire                      reset,
        input  wire [DATA_W     - 1 : 0] s_tdata,
        input  wire                      s_tvalid,
        input  wire                      s_tlast,
        input  wire [DATA_W*LEN - 1 : 0] marker,
        input  wire                      m_tready,
        output wire                      s_tready,
        output wire [DATA_W     - 1 : 0] m_tdata,
        output wire                      m_tvalid,
        output wire                      m_tlast
);

wire handshake;
wire [DATA_W - 1 : 0] marker_sep [LEN : 1];


reg [DATA_W  + 1 : 0] buff [LEN : 0];
reg [$clog2(LEN) : 0] counter;


assign s_tready      = m_tready;
assign m_tvalid      = ~reset & buff[0][0] | buff[LEN][0];
assign m_tlast       = buff[LEN][1];
assign handshake     = m_tvalid & m_tready;


genvar i;

generate for (i = LEN; i >= 1; i = i - 1)
begin: loop_1
        assign marker_sep[i] = marker[i*DATA_W - 1 : (i - 1)* DATA_W];
end
endgenerate


genvar g;

generate for (g = 0; g <= LEN; g = g + 1) begin: loop_2
        always @(posedge clk)
                if (g == 0)
                        buff[0] <= {s_tdata, s_tlast, s_tvalid};
                else 
                        buff[g] <= buff[g - 1];

end
endgenerate

always @(posedge clk) begin
        if (reset) begin
                counter <= LEN;
        end
        if (buff[LEN][1]) begin
                counter <= LEN;
        end
        if (handshake) begin
                if (counter != 0) begin
                        counter <= counter - 1'b1;
                end
        end
end

assign m_tdata = (handshake && counter != 0) ? marker_sep[counter] : buff[LEN][DATA_W + 1 : 2];

endmodule