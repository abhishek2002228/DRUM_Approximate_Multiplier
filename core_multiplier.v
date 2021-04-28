`include "half_adder.v" 
`include "full_adder.v"

module fourxfour_wallace_tree(A,B,C);
    input wire [3:0] A, B;
    output wire [7:0] C;

    wire [3:0] p0, p1, p2, p3; // parttial products, indexed using B subscripts
    wire [4:1] s0, s1, s2; // partial sums, s2 is final sum
    wire [4:1] c0, c1, c2; //partial carries
    wire Cout;

    //partial products
    assign  p0 = A & {4{B[0]}};
    assign  p1 = A & {4{B[1]}};
    assign  p2 = A & {4{B[2]}};
    assign  p3 = A & {4{B[3]}};


    //first stage
    half_adder h1_1(p0[1],p1[0],s0[1],c0[1]);
    full_adder f1_1(p0[2],p1[1],p2[0],s0[2],c0[2]);
    full_adder f1_2(p2[1],p1[2],p0[3],s0[3],c0[3]);
    half_adder h1_2(p2[2],p1[3],s0[4],c0[4]);

    //second stage
    half_adder h2_1(s0[2],c0[1],s1[1],c1[1]);
    full_adder f2_1(s0[3],p3[0],c0[2],s1[2],c1[2]);
    full_adder f2_2(s0[4],p3[1],c0[3],s1[3],c1[3]);
    full_adder f2_3(p2[3],p3[2],c0[4],s1[4],c1[4]);

    //third stage
    half_adder h3_1(c1[1],s1[2],s2[1],c2[1]);
    full_adder f3_1(s1[3],c1[2],c2[1],s2[2],c2[2]);
    full_adder f3_2(s1[4],c1[3],c2[2],s2[3],c2[3]);
    full_adder f3_3(p3[3],c1[4],c2[3],s2[4],Cout);

    //final 8 bit product
    assign C = {Cout, s2[4:1], s1[1], s0[1], p0[0]};

endmodule

