module lod #(parameter SIZE = 8)(operand, leading_one);
    input wire [SIZE-1:0] operand;
    output wire [SIZE-1:0] leading_one;

    wire [SIZE-1:0] rev_operand;
    wire [SIZE-1:0] rev_output;

    //reverse operand     
    genvar i;
    generate
        for(i=0; i<SIZE; i=i+1)
            assign rev_operand[i] = operand[SIZE-i-1]; 
    endgenerate

    
    assign rev_output = ((~rev_operand)+1)&rev_operand ;

    genvar j;
    generate
        for(j=0; j<SIZE; j=j+1)
            assign leading_one[j] = rev_output[SIZE-j-1]; 
    endgenerate

endmodule