`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 10:23:02
// Design Name: 
// Module Name: Sign_Extend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Sign_Extend(
input [15:0]ins15_0,
output reg [31:0]data32
);
reg [15:0]pre16;
always@(*)
begin
    if (ins15_0[15:15] == 1'b1) begin
        data32 = {16'hffff, ins15_0};
    end
    else begin
        data32 = {16'h0000, ins15_0};
    end
end

endmodule
