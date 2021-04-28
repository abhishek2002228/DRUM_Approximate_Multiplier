module tb_main_multiplier();
    reg [7:0] A,B;
    wire [15:0] C;

    main_multiplier #(8) m1(A,B,C);

    initial begin
        A = 144;
        B = 187;

        #2

        A = 176;
        B = 194;

        #2
        $finish;
    end

    initial begin
        $dumpfile("main_multiplier.vcd");
		$dumpvars(0,tb_main_multiplier);
    end

endmodule