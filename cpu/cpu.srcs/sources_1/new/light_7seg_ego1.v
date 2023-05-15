`timescale 1ns / 1ps

module light_7seg_ego1
(
    input [4:0] number,
    output reg [7:0] seg_out
);

always @*
    case(number[3:0])
        4'b0000:seg_out = 8'b1111_1100;
        4'b0001:seg_out = 8'b0110_0000;
        4'b0010:seg_out = 8'b1101_1010;
        4'b0011:seg_out = 8'b1111_0010;
        4'b0100:seg_out = 8'b0110_0110;
        4'b0101:seg_out = 8'b1011_0110;
        4'b0110:seg_out = 8'b1011_1110;
        4'b0111:seg_out = 8'b1110_0000;
        4'b1000:seg_out = 8'b1111_1110;
        4'b1001:seg_out = 8'b1110_0110;
        default: seg_out = 8'b0000_0001;
    endcase
endmodule
