module tb_core_multiplier();
    reg [3:0] A,B;
    wire [7:0] C;

    fourxfour_wallace_tree m1(A,B,C);

    initial begin
        A = 10;
        B = 7;

        #2

        A = 8;
        B = 14;

        #3
        $finish;
    end

    initial begin
        $dumpfile("core_multiplier.vcd");
		$dumpvars(0,tb_core_multiplier);
    end

endmodule