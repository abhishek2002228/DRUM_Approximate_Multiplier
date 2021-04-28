module tb_lod();
    reg [7:0] operand;
    wire [7:0] leading_one;
    wire [2:0] encoded;

    lod #(8) l1(operand, leading_one);
    encoder e1(leading_one, encoded);

    initial begin
        operand = 8'b00100010;

        #2

        operand = 8'b01110000;

        #3
        $finish;
    end

    initial begin
        $dumpfile("lod.vcd");
		$dumpvars(0,tb_lod);
    end
endmodule