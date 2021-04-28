module half_adder(A,B,Sum,Carry);
    input wire A, B;
    output wire Sum, Carry;

    assign Sum = A^B;
    assign Carry = A&B;
endmodule