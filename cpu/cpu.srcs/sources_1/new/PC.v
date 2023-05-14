`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 19:51:11
// Design Name: 
// Module Name: PC
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


module PC(
    input rst,
    input clk,
    input [1:0]branch_s, // branch type
    input zero_s, // no need to jump; 1: need to jump (bne || beq)
    input block_s, // block signal fro IO
    input [25:0]jump_address26, // address get from instruction j || jal
    input [31:0]jump_address32, // address get from jr || beq || bne
    output reg [31:0]address_o // output address
);

reg [31:0] PC_reg = 32'h0000_0000;
reg [31:0] next_address;
reg [31:0] address0, address1;

always@(*)
begin
    if (block_s) begin
        next_address = PC_reg;
    end
    else begin
        case(branch_s)
            2'b00: begin // no jump or compare
                next_address = PC_reg + 3'b100;
            end
            2'b01: begin // j || jal
                next_address = {PC_reg[31:28], jump_address26, 2'b00};
            end
            2'b10: begin// compare
                if(zero_s == 1'b0) begin // no need to jump
                    next_address = PC_reg + 3'b100;
                end
                else begin
                    next_address = jump_address32;
                end
            end
            2'b11: begin // jr
                next_address = jump_address32;
            end
        endcase
    end
end

always@(negedge clk, negedge rst)
begin
    if (~rst) begin
        address_o = 32'h0000_0000;
        PC_reg = 32'h0000_0000;
    end
    else begin
        address_o = next_address;
        PC_reg = next_address;
    end
end

endmodule
