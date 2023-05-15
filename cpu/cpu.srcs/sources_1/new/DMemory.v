`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 10:52:17
// Design Name: 
// Module Name: DMemory
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


module DMemory(
    input clk,
    input MemRead,
    input MemWrite,
    input [31:0]address_i,
    input [31:0]write_data,
    output reg [31:0]read_data
);
    wire neg_clk;
    assign neg_clk = !clk;
    
    RAM ram(
    .clka(neg_clk),
    .wea(MemWrite),
    .addra(address_i[15:2]),
    .dina(write_data),
    .douta(read_data)
    );


endmodule
