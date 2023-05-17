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
    output [31:0] instruction_o,

    input upg_rst_i,
    input upg_clk_i,
    input upg_wen_i,
    input [13:0] upg_adr_i,
    input [31:0] upg_dat_i,
    input upg_done_i
);

wire [31:0] fetch_ins;
assign instruction_o = fetch_ins;

wire kickOff = (upg_rst_i) | (~upg_rst_i & upg_done_i );

IMem ram(
    .wea(kickOff ? 1'b0 :   upg_wen_i),
    .dina(kickOff ? 32'h0000_0000 : upg_dat_i),
    .clka(kickOff ? clk : upg_clk_i),
    .addra(kickOff ? address_i[15:2] : upg_adr_i),
    .douta(fetch_ins)
);

endmodule
