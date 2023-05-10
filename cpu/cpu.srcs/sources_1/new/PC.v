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
input [31:0]address_i, // now PC register
input clk,
input [1:0]branch_s, // branch type
input jump_s, // j
input zero_s, // no need to jump; 1: need to jump (bne || beq)
input block_s, // block signal fro IO
input [25:0]jump_address26, // address get from instruction j || jal
input [31:0]jump_address32, // address get from jr || beq || bne
input jal, // jal signal
output reg [31:0]address_o // output address
);

reg [31:0]PC_reg;
reg [31:0]next_address;
reg [31:0]address0, address1;
    
always@(*)
begin
    PC_reg = address_i;
    address1 = {PC_reg[31:28], jump_address26, 2'b00}; // extend the 26bits address to 32bits
    address0 = PC_reg + 3'b100;// PC + 4
    
    case(branch_s)
        2'b00: begin // no jump or compare
            next_address = address0;
        end
        2'b01: begin // j || jal
            next_address = address1;
        end
        2'b10: begin// compare
            if(zero_s == 1'b0) begin // no need to jump
                next_address = address0;
            end
            else begin
                next_address = jump_address32;
            end
        end
        2'b11: begin // jr
            next_address = jump_address32;
        end
        default: begin
        end
    endcase
end

always@(negedge clk)
begin
    address_o = next_address;
end

endmodule
