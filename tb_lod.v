module tb_lod();
    reg [7:0] operand;
    wire [7:0] leading_one;

    lod #(8) l1(operand, leading_one);

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