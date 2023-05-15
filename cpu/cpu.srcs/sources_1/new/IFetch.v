`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 20:42:26
// Design Name: 
// Module Name: IFetch
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


module IFetch(
    input [31:0] address_i,
    input clk,
    output [31:0] instruction_o
);

wire [31:0] fetch_ins;
assign instruction_o = fetch_ins;

IMem ram(
    .wea(1'b0),
    .dina(32'h0000_0000),
    .clka(clk),
    .addra(address_i[15:2]),
    .douta(fetch_ins)
);

endmodule
