`include "core_multiplier.v"
`include "leading_one_detector.v"
`include "encoder.v"
`include "shifter.v"

module main_multiplier #(parameter SIZE = 8) (operand1, operand2, product);

    localparam K = 4;

    input [SIZE - 1:0] operand1;
    input [SIZE - 1:0] operand2;
    output [2*SIZE - 1:0] product;

    wire [SIZE - 1:0] lod1, lod2;
    wire [($clog2(SIZE))-1:0] lod1_enc, lod2_enc;
    wire trunc1, trunc2;
    wire [K-1:0] trunc_operand1, trunc_operand2;
    reg [K-1:1] temp_trunc_operand1, temp_trunc_operand2;
    wire [(2*K) - 1:0] small_product;
    wire [3:0] shift_amt; //max shift amount 8

    lod #(SIZE) l1(operand1, lod1);
    lod #(SIZE) l2(operand2, lod2);

    encoder e1(lod1, lod1_enc);
    encoder e2(lod2, lod2_enc);

    assign trunc1 = (lod1_enc > K-1) ? 1'b1 : 1'b0;
    assign trunc2 = (lod2_enc > K-1) ? 1'b1 : 1'b0;

    //assign trunc_operand1[K-1:1] = trunc1 ? operand1[lod1_enc : lod1_enc - K + 2] : operand1[K-1:1];
    //assign trunc_operand2[K-1:1] = trunc2 ? operand2[lod2_enc: lod2_enc - K + 2] : operand2[K-1:1];

    always @(*)
    begin
        case(lod1_enc)
        'd0: temp_trunc_operand1 = operand1[K-1:1];
        'd1: temp_trunc_operand1 = operand1[K-1:1];
        'd2: temp_trunc_operand1 = operand1[K-1:1];
        'd3: temp_trunc_operand1 = operand1[K-1:1];
        'd4: temp_trunc_operand1 = operand1[4:2];
        'd5: temp_trunc_operand1 = operand1[5:3];
        'd6: temp_trunc_operand1 = operand1[6:4];
        'd7: temp_trunc_operand1 = operand1[7:5];
        default: temp_trunc_operand1 = operand1[K-1:1];
        endcase
    end

    always @(*)
    begin
        case(lod2_enc)
        'd0: temp_trunc_operand2 = operand2[K-1:1];
        'd1: temp_trunc_operand2 = operand2[K-1:1];
        'd2: temp_trunc_operand2 = operand2[K-1:1];
        'd3: temp_trunc_operand2 = operand2[K-1:1];
        'd4: temp_trunc_operand2 = operand2[4:2];
        'd5: temp_trunc_operand2 = operand2[5:3];
        'd6: temp_trunc_operand2 = operand2[6:4];
        'd7: temp_trunc_operand2 = operand2[7:5];
        default: temp_trunc_operand2 = operand2[K-1:1];
        endcase
    end


    assign trunc_operand1[K-1:1] = temp_trunc_operand1;
    assign trunc_operand2[K-1:1] = temp_trunc_operand2;
    assign trunc_operand1[0] = trunc1 ? 1'b1 : operand1[0];
    assign trunc_operand2[0] = trunc2 ? 1'b1 : operand2[0];

    fourxfour_wallace_tree m1(trunc_operand1,trunc_operand2,small_product);

    assign shift_amt = trunc1 ? (trunc2 ? (lod1_enc + lod2_enc - 2*K + 2) : (lod1_enc - K + 1) ) : (trunc2 ? (lod2_enc - K + 1) : 0);

    shifter s1(small_product, shift_amt, product);

endmodule