module full_adder(A,B,Cin,Sum,Cout);
    input wire A, B, Cin;
    output wire Sum, Cout;

    wire h1_sum, h1_carry, h2_sum, h2_carry;

    half_adder H1(A,B,h1_sum,h1_carry);
    half_adder H2(Cin, h1_sum, h2_sum, h2_carry);

    assign Sum = h2_sum;
    assign Cout = h1_carry | h2_carry;

endmodule