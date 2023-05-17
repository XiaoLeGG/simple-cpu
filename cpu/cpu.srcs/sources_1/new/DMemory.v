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
    input [31:0] address_i,
    input [31:0] write_data,
    output [31:0] read_data,
    input upg_rst_i,
    input upg_clk_i,
    input upg_wen_i,
    input [13:0] upg_adr_i,
    input [31:0] upg_dat_i,
    input upg_done_i
);

    wire kickOff = (upg_rst_i) | (~upg_rst_i & upg_done_i);

    wire neg_clk;
    assign neg_clk = ~clk;
    
    
    RAM ram(
        .clka(kickOff ? neg_clk : upg_clk_i),
        .wea(kickOff ? MemWrite : upg_wen_i),
        .addra(kickOff ? address_i[15:2] : upg_adr_i),
        .dina(kickOff ? write_data : upg_dat_i),
        .douta(read_data)
    );


endmodule
