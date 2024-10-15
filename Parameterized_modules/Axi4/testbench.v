`timescale 1ns/1ps


module testbench;
reg                      clk;
reg                      reset;
reg [8          - 1 : 0] s_tdata;
reg                      s_tvalid;
reg                      s_tlast;
reg [32         - 1 : 0] marker;
reg                      m_tready;


initial begin
        clk = 0;
        reset = 1;
        marker = 32'hFFFFFFFF;
        m_tready = 1;
        s_tlast = 0;
        s_tvalid = 0;
end
always #1 clk = ~clk;


Axi4_stream #(.DATA_W(8), .LEN(4)) DUT (
        .clk(clk),
        .reset(reset),
        .s_tdata(s_tdata),
        .s_tvalid(s_tvalid),
        .s_tlast(s_tlast),
        .marker(marker),
        .m_tready(m_tready)
);





initial begin
        $dumpfile("out.vcd");
        $dumpvars(0, testbench);
        #11;
        reset = 0;
        #10;
        s_tvalid = 1;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        m_tready = 0;
        #2;
        #2;
        #2;
        m_tready = 1;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        #2;
        s_tdata = $random;
        s_tlast = 1;
        #2;
        s_tvalid = 0;   
        s_tlast = 0;
        #1000;

        $finish;
end






endmodule