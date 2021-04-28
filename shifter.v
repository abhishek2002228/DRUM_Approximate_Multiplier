module shifter(in,amt,out);
    input wire [7:0] in;
    input wire [3:0] amt; // 8 is the max shift amt (7 + 7 - 2*(4) + 2)
    output wire [15:0] out;


    assign out = in << amt ;

endmodule