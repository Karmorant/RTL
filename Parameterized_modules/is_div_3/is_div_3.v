module is_div_3
#(
        parameter SIZE = 8
)
(
        input  wire [SIZE - 1:0] digit,
        output wire out
);


function automatic isdiv3;
        input [SIZE - 1:0] digit_in;
        reg   [$clog2(SIZE):0] counter_even;
        reg   [$clog2(SIZE):0] counter_odd;
        integer i, g;
        begin
                counter_even = 0;
                counter_odd = 0;

                for (i = 0; i < SIZE; i = i + 2) begin
                        counter_even = (digit_in[i]) ? counter_even + 1 : counter_even;
                end
                for (g = 1; g < SIZE; g = g + 2) begin
                        counter_odd = (digit_in[g]) ? counter_odd + 1 : counter_odd;
                end
                if (counter_even > counter_odd) begin
                        if (((counter_even - counter_odd) == 3)) begin
                                isdiv3 = 1;
                        end
                        else if ((counter_even - counter_odd) == 1 || 2) begin
                                isdiv3 = 0;
                        end
                        else begin
                                isdiv3 = isdiv3(counter_even - counter_odd);
                        end
                end
                else if (counter_even < counter_odd) begin
                        if (((counter_odd - counter_even) == 3)) begin
                                isdiv3 = 1;
                        end
                        else if ((counter_odd - counter_even) == 1 || 2) begin
                                isdiv3 = 0;
                        end
                        else begin
                                isdiv3 = isdiv3(counter_odd - counter_even);
                        end
                end
                else begin
                        isdiv3 = 1;
                end
                
        end
endfunction

assign out = isdiv3(digit);

endmodule